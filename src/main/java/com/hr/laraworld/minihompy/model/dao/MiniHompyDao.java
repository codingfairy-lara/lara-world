package com.hr.laraworld.minihompy.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hr.laraworld.minihompy.model.dto.Count;
import com.hr.laraworld.minihompy.model.dto.IlchonTalk;
import com.hr.laraworld.minihompy.model.dto.MiniHompy;
import com.hr.laraworld.minihompy.model.dto.RecentPosts;

@Mapper
public interface MiniHompyDao {

	public int insertMiniHompy(MiniHompy miniHompy);

	public MiniHompy selectMiniHompy1(int hompyId);

	public MiniHompy selectMiniHompy2(String username);

	public int updateVistCount(int hompyId);

	public int editTitle(@Param("title")String title, @Param("hompyId") int hompyId);
	// -> spring에서는 DTO 객체로 받지 않고 2개 이상의 파라미터 변수를 디비에 넣을 시 , @Param 어노테이션을 Mapper에 붙여 주면 된다.

	public int editColor(@Param("color")String color, @Param("hompyId") int hompyId, @Param("param") String param);

	public List<MiniHompy> getHompyList(int hompyId);

	public Count getCountInfo(int hompyId);

	public int enrollIlchontalk(IlchonTalk ilchontalk);

	public List<IlchonTalk> getIlchontalkList(int hompyId);

	public void editPreviousIlchontalk(IlchonTalk ilchontalk);

	public int deleteIlchontalk(int no);

	public int editHompy(@Param("val")String val, @Param("hompyId") int hompyId, @Param("param") String param);

	public RecentPosts getRecentPosts(int hompyId);


}
