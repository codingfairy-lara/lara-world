package com.hr.laraworld.guestbook.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hr.laraworld.guestbook.model.dto.GuestBookComment;
import com.hr.laraworld.guestbook.model.service.GuestBookService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/guestbook")
public class GuestBookController {

	@Autowired
	private GuestBookService guestBookService;

	@ResponseBody
	@PostMapping("/delete.do")
	public ResponseEntity<?> deleteGuestBook(@RequestParam int no){
		log.debug("no = {}", no);
		return guestBookService.deleteGuestBook(no) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@ResponseBody
	@PostMapping("comment/delete.do")
	public ResponseEntity<?> deleteComment(@RequestParam int no){
		log.debug("no = {}", no);
		return guestBookService.deleteComment(no) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping("/comment/enroll.do")
	public ResponseEntity<?> enrollGuestbookComment(GuestBookComment comment){
		log.debug("comment = {}", comment);
		return guestBookService.enrollGuestbookComment(comment) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
}
