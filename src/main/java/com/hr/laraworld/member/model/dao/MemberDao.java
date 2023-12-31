package com.hr.laraworld.member.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hr.laraworld.member.model.dto.Member;

/**
 * 
 * 1. mapper.xml로 연결
 * 2. 추상메소드에 @Insert @Update @Delete @Select를 통해 간단한 쿼리 직접 작성
 *
 */
@Mapper
public interface MemberDao {

	int insertMember(Member member);

	Member selectOneMember(String memberId);

	int updateMember(Member member);

	int insertMemberRole(Member member);

	List<Member> searchById(String memberId);

	List<Member> searchByEmail(String email);

	List<Member> searchMember(@Param("param")String param, @Param("argument") String argument);


}
