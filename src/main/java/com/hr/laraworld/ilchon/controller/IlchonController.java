package com.hr.laraworld.ilchon.controller;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.hr.laraworld.diary.model.dto.Diary;
import com.hr.laraworld.guestbook.model.dto.GuestBook;
import com.hr.laraworld.ilchon.model.dto.Ilchon;
import com.hr.laraworld.ilchon.model.service.IlchonService;
import com.hr.laraworld.member.model.dto.Member;
import com.hr.laraworld.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/ilchon")
@Slf4j
public class IlchonController {
	
	@Autowired
	private MemberService memberService;

	@Autowired
	private IlchonService ilchonService;
	
	@GetMapping("/list.do")
	public void ilchonPage(Authentication authentication, Model model) {
		// security 인증객체 가져오기
		log.debug("authentication = {}", authentication);
		Member principal = (Member) authentication.getPrincipal();
		String memberId = principal.getMemberId();
		List<Ilchon> ilchonRequests = ilchonService.getIlchonRequests(memberId);
		List<Ilchon> editRequests = ilchonService.getEditRequests(memberId);
		List<Ilchon> ilchonList = ilchonService.getIlchonList(memberId);
		
		model.addAttribute("ilchonRequests", ilchonRequests);
		model.addAttribute("editRequests", editRequests);
		model.addAttribute("ilchonList", ilchonList);
	}
	
	@GetMapping("/minihompy/visit.do")
	public String mhVisit(@RequestParam String hompyId, Model model) {
		return "redirect:/minihompy/home.do?hompyId=" + hompyId;
	}
	
	@GetMapping("/requestfrm.do")
	public String requestIlchonFrm(HttpServletRequest request, Model model) {
		Map<String, ?> flashMap =RequestContextUtils.getInputFlashMap(request);
	    if(flashMap!=null) {
	    	Ilchon ilchon =(Ilchon)flashMap.get("ilchon");
	        model.addAttribute("ilchon", ilchon);
	    }

		return "ilchon/requestfrm";
	}
	
	@GetMapping("/request.do")
	public void showIlchonRequest(String requestNo, Model model) {
		log.debug("requestNo ={}", requestNo);
		if (requestNo == null) {
			requestNo = (String) model.getAttribute("requestNo");
		}
		int no = Integer.parseInt(requestNo);
		Ilchon request = ilchonService.showIlchonRequest(no);
		model.addAttribute("request", request);
	}
	
	@GetMapping("/editfrm.do")
	public void IlchonEditFrm(String requestNo, Model model) {
		log.debug("requestNo ={}", requestNo);
		if (requestNo == null) {
			requestNo = (String) model.getAttribute("requestNo");
		}
		int no = Integer.parseInt(requestNo);
		Ilchon ilchon = ilchonService.showIlchonRequest(no);
		model.addAttribute("ilchon", ilchon);
	}
	
	@PostMapping("/enroll.do")
	public String enrollIlchon(
			Ilchon ilchon,
			RedirectAttributes redirectAttr) {
		
		log.debug("ilchon ={}", ilchon);
		int result = ilchonService.enrollIlchon(ilchon);

		if (result == 1) {
			redirectAttr.addFlashAttribute("msg", "일촌 신청이 완료되었습니다.");
			return "redirect:/ilchon/requestfrm.do";
		} else {
			redirectAttr.addFlashAttribute("msg", "일촌 신청 중 오류가 발생했습니다.");
			redirectAttr.addFlashAttribute("ilchon", ilchon);
			return "redirect:/ilchon/requestfrm.do";
		}
	}
	
	@PostMapping("/accept.do")
	public String acceptIlchonRequest(
			Ilchon ilchon,
			RedirectAttributes redirectAttr) {
		log.debug("ilchon ={}", ilchon);
		String requestNo = Integer.toString(ilchon.getNo());
		int result = 0;
		if(ilchon.getStatus() == 0) { // 일촌 신청일 경우
			result = ilchonService.acceptIlchonRequest(ilchon);
			
			if (result == 1) { 
				redirectAttr.addFlashAttribute("msg", "일촌 신청이 수락되었습니다.");
				redirectAttr.addFlashAttribute("requestNo", requestNo);
				return "redirect:/ilchon/request.do";
			} 
		} else if (ilchon.getStatus() == 2) { // 일촌명 변경 신청일 경우
			result = ilchonService.acceptEditRequest(ilchon);
			
			if (result == 1) {
				redirectAttr.addFlashAttribute("msg", "일촌명 변경 요청이 수락되었습니다.");
				redirectAttr.addFlashAttribute("requestNo", requestNo);
				return "redirect:/ilchon/request.do";
			} 
		}

		redirectAttr.addFlashAttribute("msg", "일촌 신청 수락중 오류가 발생했습니다.");
		redirectAttr.addFlashAttribute("requestNo", requestNo);
		redirectAttr.addFlashAttribute("ilchon", ilchon);
		return "redirect:/ilchon/request.do";
	}
	
	@PostMapping("/edit.do")
	public String editIlchonName(
			Ilchon ilchon,
			RedirectAttributes redirectAttr) {
		log.debug("ilchon ={}", ilchon);
		String requestNo = Integer.toString(ilchon.getNo());
		int result = ilchonService.editIlchonName(ilchon);
		
		if (result == 1) {
			redirectAttr.addFlashAttribute("msg", "일촌명 변경 요청이 완료되었습니다.");
			redirectAttr.addFlashAttribute("requestNo", requestNo);
			return "redirect:/ilchon/editfrm.do";
		} else {
			redirectAttr.addFlashAttribute("msg", "일촌명 변경 요청중 오류가 발생했습니다.");
			redirectAttr.addFlashAttribute("requestNo", requestNo);
			redirectAttr.addFlashAttribute("ilchon", ilchon);
			return "redirect:/ilchon/editfrm.do";
		}
	}
	
	@ResponseBody
	@PostMapping("/delete.do")
	public ResponseEntity<?> deleteIlchon(@RequestParam String no){
		log.debug("no = {}", no);
		return ilchonService.deleteIlchon(no) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	

}
