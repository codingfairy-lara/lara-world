package com.hr.laraworld.minihompy.model.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import com.hr.laraworld.diary.model.dto.Diary;
import com.hr.laraworld.guestbook.model.dto.GuestBook;
import com.hr.laraworld.picture.model.dto.Picture;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RecentPosts {

	private String title;
	private LocalDateTime createdAt;
	private String category;
	private int status;
	private List<Diary> diaryList;
	private List<Picture> pictureList;
	private List<GuestBook> guestBookList;


}
