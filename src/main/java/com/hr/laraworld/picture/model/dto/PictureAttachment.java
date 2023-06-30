package com.hr.laraworld.picture.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor	
public class PictureAttachment {
	private int no;
	private int pictureNo;
	private String originalFilename;
	private String renamedFilename;
	private LocalDateTime createdAt;
}
