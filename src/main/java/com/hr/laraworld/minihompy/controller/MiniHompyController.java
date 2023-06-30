package com.hr.laraworld.minihompy.controller;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.stream.Stream;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hr.laraworld.common.HelloSpringUtils;
import com.hr.laraworld.diary.model.dto.Diary;
import com.hr.laraworld.diary.model.service.DiaryService;
import com.hr.laraworld.guestbook.model.dto.GuestBook;
import com.hr.laraworld.guestbook.model.dto.GuestBookComment;
import com.hr.laraworld.guestbook.model.service.GuestBookService;
import com.hr.laraworld.ilchon.model.dto.Ilchon;
import com.hr.laraworld.ilchon.model.service.IlchonService;
import com.hr.laraworld.member.model.dto.Member;
import com.hr.laraworld.minihompy.model.dto.Count;
import com.hr.laraworld.minihompy.model.dto.IlchonTalk;
import com.hr.laraworld.minihompy.model.dto.MiniHompy;
import com.hr.laraworld.minihompy.model.dto.RecentPosts;
import com.hr.laraworld.minihompy.model.service.MiniHompyService;
import com.hr.laraworld.picture.model.dto.Picture;
import com.hr.laraworld.picture.model.dto.PictureComment;
import com.hr.laraworld.picture.model.service.PictureService;
import com.hr.laraworld.profile.model.dto.Profile;
import com.hr.laraworld.profile.model.service.ProfileService;
import com.hr.security.model.service.SecurityService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/minihompy")
public class MiniHompyController {

	@Autowired
	private MiniHompyService miniHompyService;

	@Autowired
	private ProfileService profileService;
	
	@Autowired
	private IlchonService ilchonService;
	
	@Autowired
	private DiaryService diaryService;
	
	@Autowired
	private PictureService pictureService;
	
	@Autowired
	private GuestBookService guestbookService;

	@Autowired
	private SecurityService securityService;

	@GetMapping("/home.do")
	public String mhHome(@RequestParam String hompyId,
			@CookieValue(value = "visit", required = false) Cookie cookieVisit, Model model,
			HttpServletResponse response, Authentication authentication) {
		log.debug("hompyId ={}", hompyId);
		int _hompyId = Integer.parseInt(hompyId);

		boolean hasVisited = visitCookieHandler(cookieVisit, response, _hompyId);
		MiniHompy miniHompy = miniHompyService.selectMiniHompy(_hompyId, hasVisited);
		
		Count count = miniHompyService.getCountInfo(_hompyId);
		log.debug("count ={}", count);
		model.addAttribute("count", count);
		
		if (count.getRcntD() != 0 || count.getRcntP() != 0 || count.getRcntG() != 0) {
			RecentPosts recentPost = miniHompyService.getRecentPosts(_hompyId);
			List<RecentPosts> recentPosts = getRecentPosts(recentPost);
			log.debug("recentPosts ={}", recentPosts);

			model.addAttribute("recentPosts", recentPosts);
		}
		
		List<IlchonTalk> ilchonTalkList = miniHompyService.getIlchontalkList(_hompyId);
		log.debug("ilchonTalkList ={}", ilchonTalkList);
		model.addAttribute("ilchonTalkList", ilchonTalkList);
		
		getIlchonList(model, authentication);
		getHompyInfo(model, _hompyId);
		return "/minihompy/home";
	}

	

	@GetMapping(value = {"common.do"})
	public void mhHome(@RequestParam String hompyId, Model model, Authentication authentication) {
		log.debug("hompyId ={}", hompyId);
		int _hompyId = Integer.parseInt(hompyId);

		getHompyInfo(model, _hompyId);
	}

	@GetMapping("/diary.do")
	public void mhDiary(@RequestParam String hompyId, Model model, Authentication authentication) {
		log.debug("hompyId ={}", hompyId);
		int _hompyId = Integer.parseInt(hompyId);
		getHompyInfo(model, _hompyId);
		getIlchonList(model, authentication);
		
		List<Diary> diaryList = diaryService.selectDiaryList(_hompyId);
		log.debug("diaryList = {}", diaryList);
		
		model.addAttribute("diaryList", diaryList);
	}

	@GetMapping("/picture.do")
	public void mhPicture(@RequestParam(defaultValue = "1") int page, @RequestParam String hompyId, Model model, 
			HttpServletRequest request, Authentication authentication) {
		log.debug("hompyId ={}", hompyId);
		int _hompyId = Integer.parseInt(hompyId);
		getHompyInfo(model, _hompyId);
		getIlchonList(model, authentication);
		
		// 페이징처리 RowBounds
		int totalCount = pictureService.selectTotalCount(_hompyId); 
		int limit = 5; // 한페이지당 조회할 게시글수
		int offset = (page - 1) * limit; // page=1, offset=0 | page=2, offset=10 | page=3, offset=20 | .... 
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		System.out.println(totalCount);
		String url = request.getRequestURI();
		String pagebar = HelloSpringUtils.getPagebar(page, limit, totalCount, url, hompyId);
		System.out.println(pagebar);
				
		List<Picture> pictureList = pictureService.selectPictureList(_hompyId, rowBounds);
		log.debug("pictureList = {}", pictureList);
		List<PictureComment> commentList = pictureService.selectCommentList(_hompyId);
		log.debug("commentList = {}", commentList);
		
		model.addAttribute("pagebar", pagebar);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("pictureList", pictureList);
		model.addAttribute("commentList", commentList);
	}	
	
	@GetMapping("/guestbook.do")
	public void mhGuestbook(@RequestParam(defaultValue = "1") int page, @RequestParam String hompyId, Model model,
			HttpServletRequest request, Authentication authentication) {
		log.debug("hompyId ={}", hompyId);
		int _hompyId = Integer.parseInt(hompyId);
		getHompyInfo(model, _hompyId);
		getIlchonList(model, authentication);
		
		// 페이징처리 RowBounds
		int totalCount = guestbookService.selectTotalCount(_hompyId); 
		int limit = 5; // 한페이지당 조회할 게시글수
		int offset = (page - 1) * limit; // page=1, offset=0 | page=2, offset=10 | page=3, offset=20 | .... 
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		System.out.println(totalCount);
		String url = request.getRequestURI();
		String pagebar = HelloSpringUtils.getPagebar(page, limit, totalCount, url, hompyId);
		System.out.println(pagebar);
		
		List<GuestBook> guestbookList = guestbookService.selectGuestbookList(_hompyId, rowBounds);
		log.debug("guestbookList = {}", guestbookList);
		List<GuestBookComment> commentList = guestbookService.selectCommentList(_hompyId);
		log.debug("commentList = {}", commentList);
		
		model.addAttribute("pagebar", pagebar);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("guestbookList", guestbookList);
		model.addAttribute("commentList", commentList);
	}	
	
	@GetMapping("/setting.do")
	public void mhSetting(@RequestParam String hompyId, Model model, Authentication authentication) {
		log.debug("hompyId ={}", hompyId);
		int _hompyId = Integer.parseInt(hompyId);
		getHompyInfo(model, _hompyId);
		getIlchonList(model, authentication);

	}
	
	@GetMapping("/minihompy/visit.do")
	public String mhVisit(@RequestParam String hompyId, Model model) {
		return "redirect:/minihompy/home.do?hompyId=" + hompyId;
	}
	
	/**
	 * 
	 * 파도타기 기능 (랜덤 미니홈피 방문)
	 * 
	 */
	@GetMapping("/minihompy/visitrd.do")
	public String mhRandomVisit(@RequestParam String hompyId, Model model) {
		log.debug("hompyId ={}", hompyId);
		int _hompyId = Integer.parseInt(hompyId);
		// principal.hompyId를 제외 + 파도타기 공개상태인 모든 hompy List 받아오기
		List<MiniHompy> hompyList = miniHompyService.getHompyList(_hompyId);
		
		// 난수 생성
		Random random = new Random();
        int randomIndex = random.nextInt(hompyList.size());
        MiniHompy minihompy = hompyList.get(randomIndex);
        
        _hompyId = minihompy.getHompyId();
		return "redirect:/minihompy/home.do?hompyId=" + _hompyId;
	}

	@GetMapping("/profile/history.do")
	public String mhProfileHistory(@RequestParam String hompyId, Model model) {
		return "redirect:/profile/history.do?hompyId=" + hompyId;
	}

	@GetMapping("/profile/upload.do")
	public String profileUpload() {
		return "redirect:/profile/upload.do";
	}

	@GetMapping("/diary/upload.do")
	public String diaryUpload() {
		return "redirect:/diary/upload.do";
	}
	
	@GetMapping("/picture/upload.do")
	public String pictureUpload() {
		return "redirect:/picture/upload.do";
	}

	private void getIlchonList(Model model, Authentication authentication) {
		// security 인증객체 가져오기
		log.debug("authentication = {}", authentication);
		Member principal = (Member) authentication.getPrincipal();
		String memberId = principal.getMemberId();
		List<Ilchon> ilchonList = ilchonService.getAllIlchonList(memberId);
		model.addAttribute("ilchonList", ilchonList);
	}
	
	private void getHompyInfo(Model model, int _hompyId) {
		MiniHompy miniHompy = miniHompyService.selectMiniHompy(_hompyId);
		Profile profile = profileService.selectRecentProfile(_hompyId);
		log.debug("miniHompy = {}", miniHompy);

		model.addAttribute("miniHompy", miniHompy);
		model.addAttribute("profile", profile);
	}
	
	/**
	 * @description 새로운 인증 생성
	 * @param currentAuth 현재 auth 정보
	 * @param username    현재 사용자 Id
	 * @return Authentication
	 */
	protected Authentication createNewAuthentication(Authentication currentAuth, String username) {
		UserDetails newPrincipal = securityService.loadUserByUsername(username);
		UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken(newPrincipal,
				currentAuth.getCredentials(), newPrincipal.getAuthorities());
		newAuth.setDetails(currentAuth.getDetails());
		return newAuth;
	}

	/**
	 * 
	 * 방문하지 않은 홈피일 경우, 방문한 미니홈피의 hompyId를 visit 쿠키에 저장하고,
	 * 1시간 이내 방문기록이 있는 홈피를 다시 방문한 경우, 방문자수 중복 카운트를 막기 위해 hasVisited 플래그를 true로 반환
	 * 
	 */
	protected boolean visitCookieHandler(Cookie cookieVisit, HttpServletResponse response, int _hompyId) {
		// visit 쿠키처리 visit="[84][22]..."
		String visitCookieVal = "";
		boolean hasVisited = false;
		if (cookieVisit != null) {
			visitCookieVal = cookieVisit.getValue();
			if (visitCookieVal.contains("[" + _hompyId + "]")) {
				hasVisited = true;
			}
		}

		// 응답쿠키
		if (!hasVisited) {
			Cookie cookie = new Cookie("visit", visitCookieVal + "[" + _hompyId + "]");
			cookie.setMaxAge(60 * 60); // 1시간
			// cookie.setMaxAge(-1);
			// cookie.setPath("/laraworld/minihompy/"); // /laraworld/minihompy/xx~~ 요청시 전송
			cookie.setPath("/");
			response.addCookie(cookie);
		}
		return hasVisited;
	}
	
	@ResponseBody
	@PostMapping("/diary/delete.do")
	public ResponseEntity<?> deletDiary(@RequestParam int no){
		log.debug("no = {}", no);
		return diaryService.deleteDiary(no) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@ResponseBody
	@GetMapping("/diary/date.do")
	public ResponseEntity<?> selectDiaryDate(@RequestParam String diaryDate, @RequestParam int hompyId){
		log.debug("diaryDate = {}", diaryDate);
		log.debug("hompyId = {}", hompyId);
		
		List<Diary> diaryDateList =  diaryService.selectDiaryDate(diaryDate, hompyId);
		
		if (diaryDateList == null) {
			return ResponseEntity.notFound().build();
		}
		
		Map<String, Object> result = new HashMap<>(); //JSON형태로 변환하기 위해 Map객체 생성
		result.put("diaryDateList", diaryDateList);
		
		return ResponseEntity.ok(diaryDateList);
	}
	
	@ResponseBody
	@PostMapping("/guestbook/enroll.do")
	public ResponseEntity<?> enrollGuestbook(GuestBook guestbook){
		log.debug("guestbook = {}", guestbook);
		return guestbookService.enrollGuestbook(guestbook) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@ResponseBody
	@PostMapping("/setting/title.do")
	public ResponseEntity<?> editTitle(@RequestParam String title, @RequestParam int hompyId){
		log.debug("title = {}", title);
		log.debug("hompyId = {}", hompyId);
		return miniHompyService.editTitle(title, hompyId) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@ResponseBody
	@PostMapping("/setting/color.do")
	public ResponseEntity<?> editColor(@RequestParam String color, @RequestParam int hompyId, @RequestParam String param){
		log.debug("color = {}", color);
		log.debug("hompyId = {}", hompyId);
		log.debug("param = {}", param);
		return miniHompyService.editColor(color, hompyId, param) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@ResponseBody
	@PostMapping("/setting/hompy.do")
	public ResponseEntity<?> editHompy(@RequestParam String val, @RequestParam int hompyId, @RequestParam String param){
		log.debug("val = {}", val);
		log.debug("hompyId = {}", hompyId);
		log.debug("param = {}", param);
		return miniHompyService.editHompy(val, hompyId, param) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@ResponseBody
	@PostMapping("/ilchontalk/enroll.do")
	public ResponseEntity<?> enrollIlchontalk(IlchonTalk ilchontalk){
		log.debug("ilchontalk = {}", ilchontalk);
		return miniHompyService.enrollIlchontalk(ilchontalk) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@ResponseBody
	@PostMapping("/ilchontalk/delete.do")
	public ResponseEntity<?> deleteIlchontalk(@RequestParam int no){
		log.debug("no = {}", no);
		return miniHompyService.deleteIlchontalk(no) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/ilchon/requestfrm.do")
	public String requestIlchon(RedirectAttributes redirect, Ilchon ilchon) {
		redirect.addFlashAttribute("ilchon", ilchon);
		return "redirect:/ilchon/requestfrm.do";
	}

	/**
	 * 
	 * 미니홈피 home에서 최근 3일내에 작성된 포스트(다이어리, 사진첩, 방명록) 4개 날짜 역순으로 띄우기
	 * 
	 */
	private List<RecentPosts> getRecentPosts(RecentPosts recentPost) {
		List<RecentPosts> recentPosts = new ArrayList<RecentPosts>();
		if (recentPost.getDiaryList() != null) {
			for(int i = 0; i < recentPost.getDiaryList().size(); i ++) {
				List<Diary> diaryList = recentPost.getDiaryList();
				RecentPosts rp = new RecentPosts();
				rp.setTitle(diaryList.get(i).getContent());
				rp.setCreatedAt(diaryList.get(i).getCreatedAt());
				rp.setStatus(diaryList.get(i).getStatus());
				rp.setCategory("diary");
				recentPosts.add(rp);
			}
		}
		if (recentPost.getPictureList() != null) {
			for(int i = 0; i < recentPost.getPictureList().size(); i ++) {
				List<Picture> pictureList = recentPost.getPictureList();
				RecentPosts rp = new RecentPosts();
				rp.setTitle(pictureList.get(i).getTitle());
				rp.setCreatedAt(pictureList.get(i).getCreatedAt());
				rp.setStatus(pictureList.get(i).getStatus());
				rp.setCategory("picture");
				recentPosts.add(rp);
			}
		}
		if (recentPost.getGuestBookList() != null) {
			for(int i = 0; i < recentPost.getGuestBookList().size(); i ++) {
				List<GuestBook> gbList = recentPost.getGuestBookList();
				RecentPosts rp = new RecentPosts();
				rp.setTitle(gbList.get(i).getMemberName());
				rp.setCreatedAt(gbList.get(i).getCreatedAt());
				rp.setStatus(gbList.get(i).getStatus());
				rp.setCategory("guestBook");
				recentPosts.add(rp);
			}
		}
		
		// 날짜 내림차순 정렬
		recentPosts.sort(Comparator.comparing(RecentPosts::getCreatedAt).reversed());
		
		// 최근 게시물 수가 4개 이상일 경우, 가장 최근의 4개만 남기고 나머지 버리기
		if (recentPosts.size() > 4) {
			recentPosts = recentPosts.subList(0, 4);
		}
		
		return recentPosts;
	}
	
}
