package com.hr.laraworld.picture.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.hr.laraworld.picture.model.dto.Picture;
import com.hr.laraworld.picture.model.dto.PictureAttachment;
import com.hr.laraworld.picture.model.dto.PictureComment;

@Mapper
public interface PictureDao {

	int insertPicture(Picture picture);

	int insertAttachment(PictureAttachment attach);

	List<Picture> selectPictureList(int hompyId, RowBounds rowBounds);

	int deletePicture(int no);

	int enrollPictureComment(PictureComment comment);

	int selectTotalCount(int hompyId);

	List<PictureComment> selectCommentList(int hompyId);

	int deleteComment(int no);

}
