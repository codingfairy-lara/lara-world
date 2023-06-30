package com.hr.laraworld.diary.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hr.laraworld.diary.model.dto.Diary;

@Mapper
public interface DiaryDao {

	int insertDiary(Diary diary);

	List<Diary> selectDiaryList(int hompyId);

	int deleteDiary(int no);

	List<Diary> selectDiaryDate(@Param("diaryDate")String diaryDate, @Param("memberId") String memberId); 
	
	List<Diary> selectDiaryDate2(@Param("diaryDate")String diaryDate, @Param("hompyId") int hompyId); 
	// Parameter 'diaryDate' not found. Available parameters are [arg1, arg0, param1, param2]
	// -> spring에서는 DTO 객체로 받지 않고 2개 이상의 파라미터 변수를 디비에 넣을 시 , @Param 어노테이션을 Mapper에 붙여 주면 된다.

}
