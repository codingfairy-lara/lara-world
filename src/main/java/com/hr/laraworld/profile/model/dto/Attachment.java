package com.hr.laraworld.profile.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor	
public class Attachment {
	private int no;
	private int profileNo;
	private String originalFilename;
	private String renamedFilename;
	private LocalDateTime createdAt;
}
