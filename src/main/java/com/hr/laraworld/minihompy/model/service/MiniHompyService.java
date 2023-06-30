package com.hr.laraworld.minihompy.model.service;

import java.util.List;

import com.hr.laraworld.minihompy.model.dto.Count;
import com.hr.laraworld.minihompy.model.dto.IlchonTalk;
import com.hr.laraworld.minihompy.model.dto.MiniHompy;
import com.hr.laraworld.minihompy.model.dto.RecentPosts;

public interface MiniHompyService{

	int insertMiniHompy(MiniHompy miniHompy);

	MiniHompy selectMiniHompy(int hompyId);
	
	MiniHompy selectMiniHompy(int hompyId, boolean hasVisited);
	
	MiniHompy selectMiniHompy2(String hompyId);
	
	int updateVistCount(int hompyId);

	int editTitle(String title, int hompyId);

	int editColor(String color, int hompyId, String param);

	List<MiniHompy> getHompyList(int hompyId);

	Count getCountInfo(int hompyId);

	int enrollIlchontalk(IlchonTalk ilchontalk);

	List<IlchonTalk> getIlchontalkList(int hompyId);

	int deleteIlchontalk(int no);

	int editHompy(String val, int hompyId, String param);

	RecentPosts getRecentPosts(int hompyId);
	
}
