package com.hr.laraworld.picture.controller;

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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hr.laraworld.common.HelloSpringUtils;
import com.hr.laraworld.picture.model.dto.Picture;
import com.hr.laraworld.picture.model.dto.PictureAttachment;
import com.hr.laraworld.picture.model.dto.PictureComment;
import com.hr.laraworld.picture.model.service.PictureService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/picture")
@Slf4j
public class PictureController {
	
	@Autowired
	private PictureService pictureService;

	// ServletContext : application객체의 타입. DI. 스프링과 관계없는 servlet spec의 객체
	@Autowired
	private ServletContext application;

	@Autowired
	private ResourceLoader resourceLoader;

	@GetMapping("/upload.do")
	public void pictureUpload() {
	}
	
	@PostMapping("/enroll.do")
	public String pictureEnroll(
			Picture picture, 
			@RequestParam("upFiles") List<MultipartFile> upFiles, 
			RedirectAttributes redirectAttr) {
		
		
		// ServletContext : application객체의 타입. DI. 스프링과 관계없는 servlet spec의 객체
		String saveDirectory = application.getRealPath("/resources/upload/picture");
		log.debug("saveDirectory = {}", saveDirectory);
		
		// 첨부파일 저장(서버컴퓨터) 및 Attachment객체 만들기
		for(MultipartFile upFile : upFiles) {
			log.debug("upFile = {}", upFile);
			log.debug("upFile = {}", upFile.getOriginalFilename());
			log.debug("upFile = {}", upFile.getSize());	
			
			if(upFile.getSize() > 0) {
				// 1. 저장 
				String renamedFilename = HelloSpringUtils.renameMultipartFile(upFile);
				String originalFilename = upFile.getOriginalFilename();
				File destFile = new File(saveDirectory, renamedFilename);
				try {
					upFile.transferTo(destFile);
				} catch (IllegalStateException | IOException e) {
					log.error(e.getMessage(), e);
				}
				
				// 2. attach객체생성 및 Picture에 추가
				PictureAttachment attach = new PictureAttachment();
				attach.setRenamedFilename(renamedFilename);
				attach.setOriginalFilename(originalFilename);
				picture.addAttachment(attach);
			}
		}
		
		log.debug("picture = {}", picture);
		int result = pictureService.insertPicture(picture);
		
		redirectAttr.addFlashAttribute("msg", "사진첩 게시물을 성공적으로 작성했습니다.");
		
		return "redirect:/picture/upload.do";
	}
	

	@ResponseBody
	@GetMapping("/images/{filename}")
	public ResponseEntity<Resource> showImage(@PathVariable String filename) throws
	MalformedURLException {
		// 파일 저장 경로 가져오기
		String path = application.getRealPath("/resources/upload/picture/");
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
	public ResponseEntity<?> deletePicture(@RequestParam int no){
		log.debug("no = {}", no);
		return pictureService.deletePicture(no) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@ResponseBody
	@PostMapping("/comment/enroll.do")
	public ResponseEntity<?> enrollPictureComment(PictureComment comment){
		log.debug("comment = {}", comment);
		return pictureService.enrollPictureComment(comment) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@ResponseBody
	@PostMapping("/comment/delete.do")
	public ResponseEntity<?> deleteComment(@RequestParam int no){
		log.debug("no = {}", no);
		return pictureService.deleteComment(no) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
