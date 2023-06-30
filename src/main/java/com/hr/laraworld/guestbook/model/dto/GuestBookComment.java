package com.hr.laraworld.guestbook.model.dto;

import java.sql.Date;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GuestBookComment {

	private int no;
	private int hompyId;
	private int guestbookNo;
	private int writerId;
	private String memberName;
	private String content;
	private int commentLevel; // 댓글(1), 대댓글(2)
	private Integer commentRef; // 대댓글인 경우만 참조댓글번호 // *Integer : null값 처리가 용이해서 SQL 과 연동할 경우 처리가 용이. 직접적인 산술연산은 불가능
	private LocalDateTime regDate;
	private int status;

}
