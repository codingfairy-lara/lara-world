package com.hr.laraworld.picture.model.dto;

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
public class Picture extends PictureEntity {

	private int attachCount; // 첨부파일 개수
	private List<PictureAttachment> attachments = new ArrayList<>();
	private MiniHompy miniHompy; // 미니홈피 객체

	public Picture(int no, int hompyId, String title, String content, LocalDateTime createdAt, int status, int attachCount) {
		super(no, hompyId, title, content, createdAt, status);
		this.attachCount = attachCount;
	}
	
	public void addAttachment(PictureAttachment attach) {
		this.attachments.add(attach);
	}
	
}
