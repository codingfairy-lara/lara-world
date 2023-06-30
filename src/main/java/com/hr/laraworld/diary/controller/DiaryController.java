package com.hr.laraworld.diary.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hr.laraworld.diary.model.dto.Diary;
import com.hr.laraworld.diary.model.service.DiaryService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/diary")
public class DiaryController {

	@Autowired
	private DiaryService diaryService;
	
	@GetMapping("/upload.do")
	public void diaryUpload() {}
	
	@PostMapping("/enroll.do")
	public String diaryEnroll(
			Diary diary,
			RedirectAttributes redirectAttr) {
		
		if(diary.getDiaryDate() == null)
			diary.setDiaryDate(LocalDateTime.now().toLocalDate());
		
		log.debug("diary ={}", diary);
		int result = diaryService.insertDiary(diary);

		if (result == 1) {
			redirectAttr.addFlashAttribute("msg", "다이어리 작성이 완료되었습니다.");
			return "redirect:/diary/upload.do";
		} else {
			redirectAttr.addFlashAttribute("msg", "다이어리 작성중 오류가 발생했습니다.");
			return "redirect:/diary/upload.do";
		}
	}
	

	
}
