package com.hr.laraworld.member.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hr.laraworld.member.model.dao.MemberDao;
import com.hr.laraworld.member.model.dto.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	
	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}
	
	@Override
	public Member selectOneMember(String memberId) {
		return memberDao.selectOneMember(memberId);
	}

	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

	@Override
	public int insertMemberRole(Member member) {
		return memberDao.insertMemberRole(member);
	}

	@Override
	public List<Member> searchMember(String param, String argument) {
		return memberDao.searchMember(param, argument);
	}


}
