package com.hr.laraworld.profile.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.hr.laraworld.minihompy.model.dto.MiniHompy;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class Profile extends ProfileEntity {

	private Attachment attachment;
	private MiniHompy miniHompy; // 미니홈피 객체

	public Profile(int no, int hompyId, String content, LocalDateTime createdAt) {
		super(no, hompyId, content, createdAt);
	}

}
