package com.hr.laraworld.picture.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PictureEntity {
	private int no;
	private int hompyId;
	private String title;
	private String content;
	private LocalDateTime createdAt;
	private int status;

}
