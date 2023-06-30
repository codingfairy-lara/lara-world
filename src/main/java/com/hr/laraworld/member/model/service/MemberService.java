package com.hr.laraworld.member.model.service;

import java.util.List;

import com.hr.laraworld.member.model.dto.Member;

public interface MemberService {

	int insertMember(Member member);

	Member selectOneMember(String memberId);

	int updateMember(Member member);

	int insertMemberRole(Member member);

	List<Member> searchMember(String param, String argument);


}
