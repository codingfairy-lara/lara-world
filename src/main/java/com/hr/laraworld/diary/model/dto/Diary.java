package com.hr.laraworld.diary.model.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Diary {
	
	@NonNull
	private int no;
	@NonNull
	private int hompyId;
	private String content;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm") // @JsonFormat을 이용해서 날짜 응답 형식을 커스터마이징할 수 있다. 2022-03-05 16:07
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime createdAt;
	private int status;
	@JsonFormat(pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate diaryDate; // 1999-09-09 사용자요청처리
	

}
