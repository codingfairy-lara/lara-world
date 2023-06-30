--===============================
-- 관리자계정
--===============================
-- lara 계정 생성
alter session set "_oracle_script" = true;

create user lara identified by fiigo1324AAA
default tablespace users;

alter user lara quota unlimited on users;

grant connect, resource to lara;


--===============================
-- lara 계정
--===============================

-- 회원 테이블
create table member (
    member_id varchar2(50),
    password varchar2(300) not null,
    name varchar2(256) not null,
    gender char(1),
    birthday date,
    email varchar2(256),
    phone char(11) not null,
    created_at date default sysdate,
    enabled number default 1,
    constraint pk_member_id primary key(member_id),
    constraint ck_member_enabled check(enabled in (1, 0)),
    constraint uq_member_email unique(email),
    constraint ck_member_gender check(gender in ('M', 'F'))
);

-- 권한테이블 생성
create table authority(
    member_id varchar2(20),
    auth varchar2(50),
    constraint pk_authority primary key(member_id, auth),
    constraint fk_authority_member_id foreign key(member_id) 
                                    references member(member_id)
                                    on delete cascade
);

-- remember-me 관련테이블 persistent_logins
create table persistent_logins (
    username varchar2(64) not null,
    series varchar2(64) primary key,
    token varchar2(64) not null, -- username, password, expiry time 등을 hashing한 값
    last_used timestamp not null
);

-- 미니홈피 테이블 persistent_logins
CREATE TABLE minihompy (
	hompy_id	number		NOT NULL,
	member_id	varchar2(50)		NOT NULL,
	title	varchar2(50)	DEFAULT '님의 미니홈피',
	visit_total	number	DEFAULT 0,
	visit_today	number	DEFAULT 0,
	emotion	varchar2(50),
	background	varchar2(100),
	index_color	varchar2(100),
	font	varchar2(100),
	diary	number	DEFAULT 1,
	picture	number	DEFAULT 1,
	guestbook	number	DEFAULT 1,
	ilchon_talk	number	DEFAULT 1
);

ALTER TABLE minihompy ADD CONSTRAINT PK_MINIHOMPY PRIMARY KEY (hompy_id);
ALTER TABLE minihompy ADD CONSTRAINT FK_member_TO_minihompy_1 FOREIGN KEY (member_id) REFERENCES member (member_id);

create sequence seq_minihompy_id;

-- 프로필 테이블
create table profiles (
    no number,
    hompy_id number,
    content varchar2(5000),
    created_at date default sysdate,
    constraint pk_profile_no primary key(no),
    constraint fk_profile_hompy_id foreign key(hompy_id) references minihompy(hompy_id)
                                                                on delete set null
);
create sequence seq_profile_no;

-- 프로필 첨부파일 테이블
create table profile_attachment(
    no number,
    profile_no number not null,
    original_filename varchar2(256) not null,
    renamed_filename varchar2(256) not null,
    created_at date default sysdate,
    constraint pk_profile_attachment_no primary key(no),
    constraint fk_profile_attachment_profile_no foreign key(profile_no) references profiles(no) on delete cascade
);
create sequence seq_profile_attachment_no;

-- 다이어리 테이블
create table diary (
    no number,
    hompy_id number,
    content varchar2(5000),
    created_at date default sysdate,
    status number default 1,
    diary_date date,
    constraint pk_diary_no primary key(no),
    constraint fk_diary_hompy_id foreign key(hompy_id) references minihompy(hompy_id)
                                                                on delete set null
);
create sequence seq_diary_no;

-- 사진 테이블
create table picture (
    no number,
    hompy_id number,
    title varchar2(2000),
    content varchar2(5000),
    created_at date default sysdate,
    status number default 1,
    constraint pk_picture_no primary key(no),
    constraint fk_picture_hompy_id foreign key(hompy_id) references minihompy(hompy_id)
                                                                on delete set null
);
create sequence seq_picture_no;

-- 사진 첨부파일 테이블
create table picture_attachment(
    no number,
    picture_no number not null,
    original_filename varchar2(256) not null,
    renamed_filename varchar2(256) not null,
    created_at date default sysdate,
    constraint pk_picture_attachment_no primary key(no),
    constraint fk_picture_attachment_picture_no foreign key(picture_no) references picture(no) on delete cascade
);
create sequence seq_picture_attachment_no;

-- 사진 댓글 테이블
create table picture_comment (
    no number,
    picture_no number,                      -- 게시글 no
    hompy_id number,
    writer_id number,
    member_name varchar2(256),
    content varchar2(2000),
    comment_level number default 1,         -- 댓글(1), 대댓글(2)
    comment_ref number default null,        -- 댓글인 경우 null, 대댓글인 경우 부모댓글의 no
    reg_date date default CURRENT_DATE,
    status number default 1,
    constraint pk_picture_comment_no primary key(no),
    constraint fk_picture_comment_hompy_id foreign key(hompy_id) references minihompy(hompy_id) on delete set null,
    constraint fk_picture_comment_writer_id foreign key(writer_id) references minihompy(hompy_id) on delete set null,
    constraint fk_picture_comment_no foreign key(picture_no) references picture(no) on delete cascade,
    constraint fk_picture_comment_ref foreign key(comment_ref) references picture_comment(no) on delete cascade
);

create sequence seq_picture_comment_no;


-- 방명록 테이블
create table guest_book (
    no number,
    hompy_id number,
    writer_id number,
    content varchar2(5000),
    created_at date default CURRENT_DATE,
    status number default 1,
    member_name varchar2(256),
    constraint pk_guest_book_no primary key(no),
    constraint fk_guest_book_hompy_id foreign key(hompy_id) references minihompy(hompy_id)
        on delete set null,
    constraint fk_guest_book_writer_id foreign key(writer_id) references minihompy(hompy_id)
        on delete set null
);
create sequence seq_guest_book_no;


-- 방명록 댓글 테이블
create table guest_book_comment (
    no number,
    guest_book_no number,             -- 게시글 no
    hompy_id number,
    writer_id number,
    member_name varchar2(256),
    content varchar2(2000),
    comment_level number default 1,   -- 댓글(1), 대댓글(2)
    comment_ref number,               -- 댓글인 경우 null, 대댓글인 경우 부모댓글의 no
    reg_date date default CURRENT_DATE,
    status number default 1,
    constraint pk_guest_book_comment_no primary key(no),
    constraint fk_guest_book_comment_hompy_id foreign key(hompy_id) references minihompy(hompy_id) on delete set null,
    constraint fk_guest_book_comment_writer_id foreign key(writer_id) references minihompy(hompy_id) on delete set null,
    constraint fk_guest_book_comment_no foreign key(guest_book_no) references guest_book(no) on delete cascade,
    constraint fk_guest_book_comment_ref foreign key(comment_ref) references guest_book_comment(no) on delete cascade
);
create sequence seq_guest_book_comment_no;

-- 일촌 테이블
create table ilchon (
    no number,
    member_id1 varchar2(50),
    member_id2 varchar2(50),
    hompy_id1 number,
    hompy_id2 number,
    ilchon_name1 varchar2(100) default '일촌',
    ilchon_name2 varchar2(100) default '일촌',
    status number default 0,
    msg varchar2(2000)  default '우리 일촌할까요?',
    constraint pk_ilchon_no primary key(no),
    constraint fk_ilchon_member_id1 foreign key(member_id1) references member(member_id) on delete cascade,
    constraint fk_ilchon_member_id2 foreign key(member_id2) references member(member_id) on delete cascade,
    constraint fk_ilchon_hompy_id1 foreign key(hompy_id1) references minihompy(hompy_id) on delete cascade,
    constraint fk_ilchon_hompy_id2 foreign key(hompy_id2) references minihompy(hompy_id) on delete cascade
);
create sequence seq_ilchon_no;

-- 일촌평 테이블
create table ilchon_talk (
    no number,
    hompy_id number,
    writer_id number,
    ilchon_no number,
    content varchar2(5000),
    created_at date default CURRENT_DATE,
    constraint pk_ilchon_talk_no primary key(no),
    constraint fk_ilchon_talk_hompy_id foreign key(hompy_id) references minihompy(hompy_id)
        on delete set null,
    constraint fk_ilchon_talk_writer_id foreign key(writer_id) references minihompy(hompy_id)
        on delete set null,
    constraint fk_ilchon_talk_ilchon_no foreign key(ilchon_no) references ilchon(no)
        on delete set null
);
create sequence seq_ilchon_talk_no;


--  ====================

select * from member;
select * from authority;
select * from minihompy;
select * from profiles;
select * from profile_attachment;
select * from diary;
select * from picture;
select * from picture_attachment;
select * from picture_comment;
select * from guest_book;
select * from guest_book_comment;
select * from ilchon;
select * from ilchon_talk;

		select
			m.*,
            h.hompy_id hompy_id,
            h.email_privacy
		from
			member m 
                left join
                minihompy h
                    on m.member_id = h.member_id
		where
			(m.email LIKE '%'||'1234@java.com'||'%')
			and
			(h.email_privacy = 1);

SELECT * FROM diary where hompy_id=81 and (CURRENT_DATE - created_at < 3) and status between 0 and 3 order by created_at desc;
        
		select
			m.*,
            h.hompy_id hompy_id
		from
			member m 
                left join
                minihompy h
                    on m.member_id = h.member_id
		where
			m.member_id = 'aadd';

		select
		    t.*,
		    i.*
		from
		    ilchon_talk t
                left join
		    (select
                i.*,
                m1.name as name1,
                m2.name as name2,
                m1.gender as gender
            from
                ilchon i
                    left join member m1
                        on i.MEMBER_ID1 = m1.MEMBER_ID
                    left join member m2
                        on i.MEMBER_ID2 = m2.MEMBER_ID) i
                on t.ilchon_no = i.no
		where
		    t.hompy_id = 2
		    and
		    t.rowid in (select max(rowid) from ilchon_talk group by no)
		order by
		    t.no desc;

select
    i.*,
    m1.name as name1,
    m2.name as name2,
    m1.gender as gender
from
    ilchon i
        left join member m1
            on i.MEMBER_ID1 = m1.MEMBER_ID
        left join member m2
            on i.MEMBER_ID2 = m2.MEMBER_ID;

		SELECT 
			(SELECT COUNT(*) FROM diary where hompy_id=2 and status > 0) cnt_d,
			(SELECT COUNT(*) FROM diary where hompy_id=2 and (CURRENT_DATE - created_at < 3) and status > 0) rcnt_d,
			(SELECT COUNT(*) FROM picture where hompy_id=2 and status > 0) cnt_p, 
			(SELECT COUNT(*) FROM picture where hompy_id=2 and (CURRENT_DATE - created_at < 3) and status > 0) rcnt_p, 
			(SELECT COUNT(*) FROM guest_book where hompy_id=2 and status > 0) cnt_g,
			(SELECT COUNT(*) FROM guest_book where hompy_id=2 and (CURRENT_DATE - created_at < 3) and status > 0) rcnt_g
		FROM DUAL;


		select
		    i.*,
		    m1.name as name1,
		    m2.name as name2,
		    m1.gender as gender
		from
		    ilchon i
		        left join member m1
		            on i.MEMBER_ID1 = m1.MEMBER_ID
		        left join member m2
		            on i.MEMBER_ID2 = m2.MEMBER_ID
		where
			(MEMBER_ID1 = 'test'
			or
		    MEMBER_ID2 = 'test')
		    and
		    status = 1
		order by 
		    name1 desc;

select
    i.*,
    m1.name as name1,
    m2.name as name2,
    m1.gender as gender
from
    ilchon i
        left join member m1
            on i.MEMBER_ID1 = m1.MEMBER_ID
        left join member m2
            on i.MEMBER_ID2 = m2.MEMBER_ID
where
    MEMBER_ID1 = 'test'
    and
    status = 0
order by 
    i.no desc;

		select
		    i.*,
		    m1.name as name1,
		    m2.name as name2,
		    m1.gender as gender
		from
		    ilchon i
		        left join member m1
		            on i.MEMBER_ID1 = m1.MEMBER_ID
		        left join member m2
		            on i.MEMBER_ID2 = m2.MEMBER_ID
		where
		    no = 8;

select
    a.*,
    m.*
from
    minihompy a
        left join member m
            on a.MEMBER_ID = m.MEMBER_ID
where
    hompy_id = 81;

insert into 
    guest_book (no, hompy_id, member_id, content) 
values (
    seq_guest_book_no.nextval,
    81,
    'honggd',
    '방명록 작성 테스트
    안녕하세요~'
);

select
    ROWNUM as cno,
    A.*
from
    (SELECT 
        *
    FROM
        guest_book
    where
        hompy_id = 81
    ORDER BY
        no) A
order by
    cno desc;

select
    b.*,
    (select count(*) from picture_attachment where picture_no = b.no) attach_count,
    a.*,
    a.no attach_no,
    m.*
from
    picture b 
        left join picture_attachment a
            on b.no = a.picture_no
         left join minihompy m
            on b.hompy_id = m.hompy_id	
where
    m.hompy_id = 81
order by 
    b.no desc;


update minihompy set visit_total = visit_total + 1
     , visit_today = visit_today + 1
WHERE hompy_id = 81;

update minihompy set 
    visit_today = 0;

select * from profiles where hompy_id = 81 and no = (SELECT max(no) FROM profiles);
select * from profile_attachment where no = (SELECT max(no) FROM profiles);

select
    b.*
from
    diary b 
        left join minihompy a
            on b.hompy_id = a.hompy_id
         left join member m
            on a.member_id = m.member_id	
where
    m.member_id = 'test'
    and
    b.diary_Date = to_date('2023-5-9','rr/mm/dd');

select
    b.*,
    a.*,
    a.no attach_no,
    m.*
from
    profiles b 
        left join profile_attachment a
            on b.no = a.profile_no
         left join minihompy m
            on b.hompy_id = m.hompy_id	
where
    m.hompy_id = 81
    and
    b.no = (SELECT max(b.no) FROM profiles b);
    
select
    b.*,
    a.*,
    a.no attach_no,
    m.*
from
    profiles b 
        left join profile_attachment a
            on b.no = a.profile_no
         left join minihompy m
            on b.hompy_id = m.hompy_id	
where
    m.hompy_id = 81
order by 
    b.no desc;

select * from diary where hompy_id = 81 order by diary_date desc;
select * from diary where diary_Date = to_date('2023-5-2','rr/mm/dd');

insert into authority values ('hera', 'ROLE_USER');
insert into authority values ('hera', 'ROLE_ADMIN');
DELETE FROM member WHERE member_id = 'tete';

insert into minihompy (hompy_id, member_id, title, visit_total, visit_today, diary, picture, guestbook, ilchon_talk)
    values (seq_minihompy_id.nextval, 'hera123', DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
    
insert into diary values (seq_diary_no.nextval, 81,'다이어리 테스트2222222', default, default, null);
insert into diary values (seq_diary_no.nextval, 81,'다이어리 테스트1231231231', default, default, to_date(sysdate,'rr/mm/dd'));