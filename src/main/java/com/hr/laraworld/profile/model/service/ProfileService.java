package com.hr.laraworld.profile.model.service;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.hr.laraworld.profile.model.dto.Attachment;
import com.hr.laraworld.profile.model.dto.Profile;

public interface ProfileService {

	int insertProfile(Profile profile);

	int insertAttachment(Attachment attach);

	Profile selectRecentProfile(int _hompyId);

	List<Profile> selectProfileHistory(int hompyId);

	int deleteProfile(int no);
	
}
