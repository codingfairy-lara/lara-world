package com.hr.laraworld.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hr.laraworld.member.model.dto.Member;
import com.hr.laraworld.member.model.service.MemberService;
import com.hr.laraworld.minihompy.model.dto.MiniHompy;
import com.hr.laraworld.minihompy.model.service.MiniHompyService;
import com.hr.laraworld.diary.model.dto.Diary;
import com.hr.laraworld.ilchon.model.dto.Ilchon;
import com.hr.laraworld.ilchon.model.service.IlchonService;
import com.hr.laraworld.member.controller.MemberController;

import lombok.extern.slf4j.Slf4j;

/**
 * Model이란?
 * - view단에서 사용할 데이터를 임시로 보관하는 Map객체
 * - viewName에 대한 처리도 포함할 수 있음.
 * 
 * 1. ModelAndView (일반클래스)
 * 	- view단에 대한 정보가지고 있음. View객체 또는 viewName:String 작성가능
 * 	- addObject 속성추가
 * 
 * 2. ModelMap (인터페이스)
 * 	- view단 처리 별도.
 *  - addAttribute 속성추가
 *  
 * 3. Model (인터페이스)
 * 	- view단 처리 별도.
 *  - addAttribute 속성추가
 * 
 * @ModelAttribute 또는 @SessionAttribute 어노테이션을 통해 저장된 속성 참조가능
 * 
 * - ModelAndView와 RedirectAttributes는 함께 사용하지 말것.
 *
 */
@Slf4j
@Controller
@RequestMapping("/member")
@SessionAttributes({"loginMember"}) // 해당이름으로 model에 저장된 속성은 sessionScope에 저장
public class MemberController {
	
	// private static final Logger log = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MiniHompyService miniHompyService;
	
	@Autowired
	private IlchonService ilchonService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@GetMapping("/memberEnroll.do")
	public void memberEnroll() {} // /member/memberEnroll.do -> member/memberEnroll 
	
	@GetMapping("/memberSearch.do")
	public void memberSearch(Authentication authentication, Model model) {
		// security 인증객체 가져오기
		log.debug("authentication = {}", authentication);
		Member principal = (Member) authentication.getPrincipal();
		String memberId = principal.getMemberId();
		List<Ilchon> ilchonList = ilchonService.getAllIlchonList(memberId);
		model.addAttribute("ilchonList", ilchonList);
	}

	@PostMapping("/memberEnroll.do")
	public String memberEnroll(Model model, Member member, RedirectAttributes redirectAttr) {
		log.trace("memberEnroll 시작!");
		try {
			log.debug("member = {}", member);
			String rawPassword = member.getPassword();
			String encodedPassword = passwordEncoder.encode(rawPassword);
			member.setPassword(encodedPassword);
			log.debug("member = {}", member);
			
			int result = memberService.insertMember(member);
			int result2 = memberService.insertMemberRole(member);
			
			// 미니홈피 생성 로직
			MiniHompy miniHompy = new MiniHompy();
			try {
				miniHompy.setMemberId(member.getMemberId());
				miniHompy.setName(member.getName());
				log.debug("miniHompy = {}", miniHompy);

				int result3 = miniHompyService.insertMiniHompy(miniHompy);
				
				MiniHompy miniHompy_ = miniHompyService.selectMiniHompy(miniHompy.getHompyId());
				log.debug("miniHompy_ = {}", miniHompy_);
				model.addAttribute("miniHompy", miniHompy_);
				
			} catch (Exception e) {
				log.error("미니홈피 생성 오류!", e);
				throw e;
			}
		
		} catch (Exception e) {
			log.error("회원가입오류!", e);
			throw e;
		}
		return "redirect:/#signUp";
	}
	
	@GetMapping("/memberLogin.do")
	public String memberLogin() {
		return "member/memberLogin";
	}
	
	@PostMapping("/loginSuccess.do")
	public String loginSuccess(HttpSession session, Model model) {
		log.debug("loginSuccess 핸들러 호출!");
		
		// 인증객체 - memberId
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		Member loginMember = (Member) authentication.getPrincipal();
		String memberId = loginMember.getMemberId();
		log.debug("memberId = {}", memberId);
		
		
		// 필요한 로그인후처리
		String location = "/";
		
		// 시큐어리티가 지정한 리다이렉트 url 가져오기
		SavedRequest savedRequest = (SavedRequest) session.getAttribute("SPRING_SECURITY_SAVED_REQUEST");
		if(savedRequest != null)
			location = savedRequest.getRedirectUrl();
		
		log.debug("location = {}", location);
		
		return "redirect:" + location;
	}
	
	/**
	 * @SessionAttributes + model을 통해 로그인정보를 관리하는 경우,
	 * SessionStatus객체를 통해 사용완료처리해야 한다.
	 * - session객체를 폐기하지 않고 재사용.
	 * 
	 * @return
	 */
	@PostMapping("/memberLogout.do")
	public String memberLogout(SessionStatus status, HttpServletRequest request, HttpServletResponse response) {
//		Cookie[] cookies = request.getCookies();
//		if (cookies != null) {
//			for (int i = 0; i < cookies.length; i++) {
//				cookies[i].setMaxAge(0);                 //쿠키 유지기간을 0으로함
//				cookies[i].setPath("/"); 
//				response.addCookie(cookies[i]);      //쿠키저장
//			}
//		} // java로 해결 못해서 js로 처리했음 (로그아웃버튼 클릭시 onclick으로 쿠키제거함수 먹임)

		if(!status.isComplete())
			status.setComplete();
		
		return "redirect:/";
	}

//	/**
//	 * security 인증객체 가져오기
//	 */
//	@GetMapping("/memberDetail.do")
//	public void memberDetail(Authentication authentication) {
//		// Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		log.debug("authentication = {}", authentication);
//		Member principal = (Member) authentication.getPrincipal();
//		List<SimpleGrantedAuthority> authorities = (List<SimpleGrantedAuthority>) authentication.getAuthorities();
//	}
//	
	@PostMapping("/memberUpdate.do")
	public String memberUpdate(HttpSession session, Member member, Authentication authentication) {
		log.debug("member = {}", member);
		// 1. db변경
			try { 
			
			// 비지니스로직 실행
			int result = memberService.updateMember(member);
			
		} catch(Exception e) {
			log.error("회원 정보 수정 실패", e);
			throw e;
		}
		
		// 2. security context의 인증객체 갱신
		Member newMember = memberService.selectOneMember(member.getMemberId());

		Authentication newAuthentication = new UsernamePasswordAuthenticationToken(
				newMember,
				authentication.getCredentials(),
				authentication.getAuthorities()
		);
		SecurityContextHolder.getContext().setAuthentication(newAuthentication);
		log.debug("authentication = {}", authentication);
		log.debug("newAuthentication = {}", newAuthentication);
		
		RequestContextHolder.currentRequestAttributes().setAttribute("SPRING_SECURITY_CONTEXT", newAuthentication, RequestAttributes.SCOPE_SESSION);
		session.setAttribute("SPRING_SECURITY_CONTEXT", newAuthentication);
		return "redirect:/";
	}

	/**
	 * - 응답코드
	 * - 응답헤더설정
	 * - 응답메세지바디
	 * 
	 * ResponseEntity객체생성
	 * 1. new 연산자
	 * 2. builder 패턴
	 * 
	 * @param memberId
	 * @return
	 */
	@GetMapping("/checkIdDuplicate3.do")
	public ResponseEntity<Map<String, Object>> checkIdDuplicate3(@RequestParam String memberId) {
		Map<String, Object> map = new HashMap<>();
		Member member = memberService.selectOneMember(memberId);
		boolean available = member == null;
		map.put("memberId", memberId);
		map.put("available", available);
		map.put("hello", "world");
		
//		return ResponseEntity.ok(map); // 200
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		return ResponseEntity
				.status(HttpStatus.OK)
				.headers(headers)
//				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE) // 5.2이전
				.body(map);
					
	}

	@ResponseBody
	@GetMapping("/search.do")
	public ResponseEntity<?> searchMember(@RequestParam String param, @RequestParam String argument){
		log.debug("param = {}", param);
		log.debug("argument = {}", argument);
		List<Member> memberList =  memberService.searchMember(param, argument);
		
		if (memberList == null) {
			return ResponseEntity.notFound().build();
		}
		Map<String, Object> result = new HashMap<>(); //JSON형태로 변환하기 위해 Map객체 생성
		result.put("memberList", memberList);
		
		return ResponseEntity.ok(memberList);
	}
	
	@GetMapping("/ilchon/requestfrm.do")
	public String requestIlchon(RedirectAttributes redirect, Ilchon ilchon) {
		redirect.addFlashAttribute("ilchon", ilchon);
		return "redirect:/ilchon/requestfrm.do";
	}
	
	@GetMapping("/minihompy/visit.do")
	public String mhVisit(@RequestParam String hompyId, Model model) {
		return "redirect:/minihompy/home.do?hompyId=" + hompyId;
	}
	
	
	
}

