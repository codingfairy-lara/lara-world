package com.hr.laraworld.diary.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.laraworld.diary.model.dao.DiaryDao;
import com.hr.laraworld.diary.model.dto.Diary;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)  // 발생하는 모든 예외에 대해 rollback 처리
@Service
@Slf4j
public class DiaryServiceImpl implements DiaryService {
	
	@Autowired
	private DiaryDao diaryDao;

	@Override
	public int insertDiary(Diary diary) {
		return diaryDao.insertDiary(diary);
	}

	@Override
	public List<Diary> selectDiaryList(int hompyId) {
		return diaryDao.selectDiaryList(hompyId);
	}

	@Override
	public int deleteDiary(int no) {
		return diaryDao.deleteDiary(no);
	}

	@Override
	public List<Diary> selectDiaryDate(String diaryDate, String memberId) {
		return diaryDao.selectDiaryDate(diaryDate, memberId);
	}

	@Override
	public List<Diary> selectDiaryDate(String diaryDate, int hompyId) {
		return diaryDao.selectDiaryDate2(diaryDate, hompyId);
	}

}
