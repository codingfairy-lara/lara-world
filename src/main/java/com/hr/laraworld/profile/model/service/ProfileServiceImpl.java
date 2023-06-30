package com.hr.laraworld.profile.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.laraworld.profile.model.dao.ProfileDao;
import com.hr.laraworld.profile.model.dto.Attachment;
import com.hr.laraworld.profile.model.dto.Profile;

import lombok.extern.slf4j.Slf4j;


@Transactional(rollbackFor = Exception.class)  // 발생하는 모든 예외에 대해 rollback 처리
@Service
@Slf4j
public class ProfileServiceImpl implements ProfileService {

	@Autowired
	private ProfileDao profileDao;

	@Override
	public int insertProfile(Profile profile) {
		// 프로필 등록 - 동시에 채번된 pk를 조회
		int result = profileDao.insertProfile(profile);
		log.debug("profile = {}", profile);
		// 첨부파일 등록
		Attachment attach = profile.getAttachment();
		attach.setProfileNo(profile.getNo()); // fk설정
		result = insertAttachment(attach);

		return result;
	}
	
	@Override
	public int insertAttachment(Attachment attach) {
		return profileDao.insertAttachment(attach);
	}

	@Override
	public Profile selectRecentProfile(int hompyId) {
		return profileDao.selectRecentProfile(hompyId);
	}

	@Override
	public List<Profile> selectProfileHistory(int hompyId) {
		return profileDao.selectProfileHistory(hompyId);
	}

	@Override
	public int deleteProfile(int no) {
		return profileDao.deleteProfile(no);
	}


	
}
