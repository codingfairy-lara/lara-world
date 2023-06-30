package com.hr.laraworld.guestbook.model.dto;

import java.time.LocalDateTime;

import com.hr.laraworld.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GuestBook {

	private int no;
	private int cno; // view단 방명록 카운팅용 넘버
	private int hompyId;
	private int writerId;
	private String memberName;
	private String content;
	private LocalDateTime createdAt;
	private int status;
	private char gender;

}
