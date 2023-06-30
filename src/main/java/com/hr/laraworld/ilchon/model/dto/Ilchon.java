package com.hr.laraworld.ilchon.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Ilchon {

	private int no;
	private String memberId1;
	private String memberId2;
	private String ilchonName1;
	private String ilchonName2;
	private int hompyId1;
	private int hompyId2;
	private String name1;
	private String name2;
	private int status;
	private String msg;
	private char gender;
	private String newName1;
	private String newName2;

}
