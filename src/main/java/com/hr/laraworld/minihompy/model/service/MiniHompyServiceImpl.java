package com.hr.laraworld.minihompy.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.laraworld.minihompy.model.dao.MiniHompyDao;
import com.hr.laraworld.minihompy.model.dto.Count;
import com.hr.laraworld.minihompy.model.dto.IlchonTalk;
import com.hr.laraworld.minihompy.model.dto.MiniHompy;
import com.hr.laraworld.minihompy.model.dto.RecentPosts;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class MiniHompyServiceImpl implements MiniHompyService {

	@Autowired
	private MiniHompyDao miniHompyDao;

	@Override
	public int insertMiniHompy(MiniHompy miniHompy) {
		return miniHompyDao.insertMiniHompy(miniHompy);
	}

	@Override
	public MiniHompy selectMiniHompy(int hompyId) {
		return selectMiniHompy(hompyId, true);
	}

	@Override
	public MiniHompy selectMiniHompy(int hompyId, boolean hasVisited) {
		// 방문자수 증가
		if (!hasVisited)
			miniHompyDao.updateVistCount(hompyId);

		return miniHompyDao.selectMiniHompy1(hompyId);
	}

	@Override
	public MiniHompy selectMiniHompy2(String username) {
		return miniHompyDao.selectMiniHompy2(username);
	}

	@Override
	public int updateVistCount(int hompyId) {
		return miniHompyDao.updateVistCount(hompyId);
	}

	@Override
	public int editTitle(String title, int hompyId) {
		return miniHompyDao.editTitle(title, hompyId);
	}

	@Override
	public int editColor(String color, int hompyId, String param) {
		return miniHompyDao.editColor(color, hompyId, param);
	}

	@Override
	public List<MiniHompy> getHompyList(int hompyId) {
		return miniHompyDao.getHompyList(hompyId);
	}

	@Override
	public Count getCountInfo(int hompyId) {
		return miniHompyDao.getCountInfo(hompyId);
	}

	@Override
	public int enrollIlchontalk(IlchonTalk ilchontalk) {
		//기존에 작성한 일촌평 비공개처리
		miniHompyDao.editPreviousIlchontalk(ilchontalk);
		return miniHompyDao.enrollIlchontalk(ilchontalk);
	}

	@Override
	public List<IlchonTalk> getIlchontalkList(int hompyId) {
		return miniHompyDao.getIlchontalkList(hompyId);
	}

	@Override
	public int deleteIlchontalk(int no) {
		return miniHompyDao.deleteIlchontalk(no);
	}

	@Override
	public int editHompy(String val, int hompyId, String param) {
		return miniHompyDao.editHompy(val, hompyId, param);
	}

	@Override
	public RecentPosts getRecentPosts(int hompyId) {
		return miniHompyDao.getRecentPosts(hompyId);
	}

}
