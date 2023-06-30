package com.hr.laraworld.guestbook.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.laraworld.guestbook.model.dao.GuestBookDao;
import com.hr.laraworld.guestbook.model.dto.GuestBook;
import com.hr.laraworld.guestbook.model.dto.GuestBookComment;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class GuestBookServiceImpl implements GuestBookService {

	@Autowired
	private GuestBookDao guestBookDao;

	@Override
	public int enrollGuestbook(GuestBook guestbook) {
		return guestBookDao.enrollGuestbook(guestbook);
	}

	@Override
	public List<GuestBook> selectGuestbookList(int hompyId, RowBounds rowBounds) {
		return guestBookDao.selectGuestbookList(hompyId, rowBounds);
	}

	@Override
	public int selectTotalCount(int hompyId) {
		return guestBookDao.selectTotalCount(hompyId);
	}

	@Override
	public int deleteGuestBook(int no) {
		return guestBookDao.deleteGuestBook(no);
	}

	@Override
	public int enrollGuestbookComment(GuestBookComment comment) {
		return guestBookDao.enrollGuestbookComment(comment);
	}

	@Override
	public List<GuestBookComment> selectCommentList(int hompyId) {
		return guestBookDao.selectCommentList(hompyId);
	}

	@Override
	public int deleteComment(int no) {
		return guestBookDao.deleteComment(no);
	}

	
	
	
	
}
