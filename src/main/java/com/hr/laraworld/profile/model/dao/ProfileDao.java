package com.hr.laraworld.profile.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hr.laraworld.profile.model.dto.Attachment;
import com.hr.laraworld.profile.model.dto.Profile;

@Mapper
public interface ProfileDao {

	int insertProfile(Profile profile);

	int insertAttachment(Attachment attach);

	Profile selectRecentProfile(int hompyId);

	List<Profile> selectProfileHistory(int hompyId);

	int deleteProfile(int no);

}
