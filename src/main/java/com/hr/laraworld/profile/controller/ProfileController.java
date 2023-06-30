package com.hr.laraworld.profile.controller;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hr.laraworld.common.HelloSpringUtils;
import com.hr.laraworld.profile.model.dto.Attachment;
import com.hr.laraworld.profile.model.dto.Profile;
import com.hr.laraworld.profile.model.service.ProfileService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/profile")
@Slf4j
public class ProfileController {
	
	@Autowired
	private ProfileService profileService;

	// ServletContext : application객체의 타입. DI. 스프링과 관계없는 servlet spec의 객체
	@Autowired
	private ServletContext application;

	@Autowired
	private ResourceLoader resourceLoader;

	@GetMapping("/upload.do")
	public void profileUpload() {
	}
	
	@GetMapping("/history.do")
	public void profileHistory(@RequestParam String hompyId, Model model) {
		log.debug("hompyId ={}", hompyId);
		int _hompyId = Integer.parseInt(hompyId);

		List<Profile> profileHistory = profileService.selectProfileHistory(_hompyId);
		log.debug("profileHistory = {}", profileHistory);
		model.addAttribute("profileHistory", profileHistory);
	}

	@PostMapping("/enroll.do")
	public String profileEnroll(
			Profile profile,
			@RequestParam("upload_file") MultipartFile upFile, 
			RedirectAttributes redirectAttr) {

		String saveDirectory = application.getRealPath("/resources/upload/profile");
		log.debug("saveDirectory = {}", saveDirectory);

		// 첨부파일 저장(서버컴퓨터) 및 Attachment객체 만들기
//		for (MultipartFile upFile : upFiles) {
			log.debug("upFile = {}", upFile);
			log.debug("upFile = {}", upFile.getOriginalFilename());
			log.debug("upFile = {}", upFile.getSize());

//			if (upFile.getSize() > 0) {
				// 1. 저장
				String renamedFilename = HelloSpringUtils.renameMultipartFile(upFile);
				String originalFilename = upFile.getOriginalFilename();
				File destFile = new File(saveDirectory, renamedFilename);
				try {
					upFile.transferTo(destFile);
				} catch (IllegalStateException | IOException e) {
					log.error(e.getMessage(), e);
				}

				// 2. attach객체생성 및 Profile에 추가
				Attachment attach = new Attachment();
				attach.setRenamedFilename(renamedFilename);
				attach.setOriginalFilename(originalFilename);
				profile.setAttachment(attach);
//			}
//		}

		log.debug("profile = {}", profile);
		int result = profileService.insertProfile(profile);

		redirectAttr.addFlashAttribute("msg", "프로필을 성공적으로 저장했습니다.");

		return "redirect:/profile/upload.do";
	}

	@ResponseBody
	@GetMapping("/images/{filename}")
	public ResponseEntity<Resource> showImage(@PathVariable String filename) throws
	MalformedURLException {
		String path = application.getRealPath("/resources/upload/profile/");
		String folder = "";
		Resource resource = new FileSystemResource(path + folder + filename);
		log.debug("resource = {}", resource);
		if(!resource.exists()) 
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		HttpHeaders header = new HttpHeaders();
		Path filePath = null;
		try{
			filePath = Paths.get(path + folder + filename);
			header.add("Content-type", Files.probeContentType(filePath));
		}catch(IOException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
	 }

	@ResponseBody
	@PostMapping("/delete.do")
	public ResponseEntity<?> deleteProfile(@RequestParam int no){
		log.debug("no = {}", no);
//		int no_ = Integer.parseInt(no);
		return profileService.deleteProfile(no) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
