package com.hr.laraworld.minihompy.model.dto;

import com.hr.laraworld.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MiniHompy {

	private int hompyId;
	@NonNull
	private String memberId;
	private String title;
	private int visitTotal;
	private int visitToday;
	private String roomColor;
	private String background;
	private String borderColor;
	private String indexColor;
	private int miniroom;
	private int diary;
	private int picture;
	private int guestbook;
	private int ilchonTalk;
	private int emailPrivacy;
	private int birthdayPrivacy;
	private int guestbookAccess;
	private int wave;
	private String name;

	private Member member; 
	
}
