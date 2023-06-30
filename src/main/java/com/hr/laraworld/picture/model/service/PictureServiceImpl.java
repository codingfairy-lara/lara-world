package com.hr.laraworld.picture.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.laraworld.picture.model.dao.PictureDao;
import com.hr.laraworld.picture.model.dto.Picture;
import com.hr.laraworld.picture.model.dto.PictureAttachment;
import com.hr.laraworld.picture.model.dto.PictureComment;
import com.hr.laraworld.profile.model.dto.Attachment;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)  // 발생하는 모든 예외에 대해 rollback 처리
@Service
@Slf4j
public class PictureServiceImpl implements PictureService {

	@Autowired
	private PictureDao pictureDao;

	@Override
	public int insertPicture(Picture picture) {
		
		// 사진 게시물 등록 - 동시에 채번된 pk를 조회
		int result = pictureDao.insertPicture(picture);
		log.debug("picture = {}", picture);
		// 첨부파일 등록
		List<PictureAttachment> attachments = picture.getAttachments();
		if(attachments.size() > 0) {
			for(PictureAttachment attach : attachments) {
				attach.setPictureNo(picture.getNo()); // fk설정
				result = insertAttachment(attach);
			}
		}
		return result;

	}

	@Override
	public int insertAttachment(PictureAttachment attach) {
		return pictureDao.insertAttachment(attach);
	}

	@Override
	public List<Picture> selectPictureList(int hompyId, RowBounds rowBounds) {
		return pictureDao.selectPictureList(hompyId, rowBounds);
	}

	@Override
	public int deletePicture(int no) {
		return pictureDao.deletePicture(no);
	}

	@Override
	public int enrollPictureComment(PictureComment comment) {
		return pictureDao.enrollPictureComment(comment);
	}

	@Override
	public int selectTotalCount(int hompyId) {
		return pictureDao.selectTotalCount(hompyId);
	}

	@Override
	public List<PictureComment> selectCommentList(int hompyId) {
		return pictureDao.selectCommentList(hompyId);
	}

	@Override
	public int deleteComment(int no) {
		return pictureDao.deleteComment(no);
	}

}
