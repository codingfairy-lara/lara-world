package com.hr.laraworld.guestbook.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.hr.laraworld.guestbook.model.dto.GuestBook;
import com.hr.laraworld.guestbook.model.dto.GuestBookComment;

public interface GuestBookService {

	int enrollGuestbook(GuestBook guestbook);

	List<GuestBook> selectGuestbookList(int hompyId, RowBounds rowBounds);

	int selectTotalCount(int hompyId);

	int deleteGuestBook(int no);

	int enrollGuestbookComment(GuestBookComment comment);

	List<GuestBookComment> selectCommentList(int _hompyId);

	int deleteComment(int no);

}
