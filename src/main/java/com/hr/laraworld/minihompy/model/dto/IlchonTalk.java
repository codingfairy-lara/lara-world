package com.hr.laraworld.minihompy.model.dto;

import java.time.LocalDateTime;

import com.hr.laraworld.ilchon.model.dto.Ilchon;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class IlchonTalk {

	private int no;
	private int hompyId;
	private int writerId;
	private int ilchonNo;
	private String content;
	private LocalDateTime createdAt;
	private int status;
	
	private Ilchon ilchon;
}
