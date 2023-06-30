package com.hr.laraworld.diary.model.service;

import java.util.List;

import com.hr.laraworld.diary.model.dto.Diary;

public interface DiaryService {

	int insertDiary(Diary diary);

	List<Diary> selectDiaryList(int hompyId);

	int deleteDiary(int no);

	List<Diary> selectDiaryDate(String diaryDate, String memberId);
	
	List<Diary> selectDiaryDate(String diaryDate, int memberId);

}
