package com.hr.laraworld.guestbook.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.hr.laraworld.guestbook.model.dto.GuestBook;
import com.hr.laraworld.guestbook.model.dto.GuestBookComment;

@Mapper
public interface GuestBookDao {

	int enrollGuestbook(GuestBook guestbook);

	List<GuestBook> selectGuestbookList(int hompyId, RowBounds rowBounds);

	int selectTotalCount(int hompyId);

	int deleteGuestBook(int no);

	int enrollGuestbookComment(GuestBookComment comment);

	List<GuestBookComment> selectCommentList(int hompyId);

	int deleteComment(int no);

}
