package com.hr.laraworld.profile.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProfileEntity {
	private int no;
	private int hompyId;
	private String content;
	private LocalDateTime createdAt;

}
