----alter system set deferred_segment_creation = FALSE;

ALTER TABLE member_detail
    DROP
        CONSTRAINT FK_member_TO_member_detail
        CASCADE;

ALTER TABLE board
    DROP
        CONSTRAINT FK_member_TO_board
        CASCADE;

ALTER TABLE board
    DROP
        CONSTRAINT FK_board_list_TO_board
        CASCADE;

ALTER TABLE reboard
    DROP
        CONSTRAINT FK_board_TO_reboard
        CASCADE;

ALTER TABLE album
    DROP
        CONSTRAINT FK_board_TO_album
        CASCADE;

ALTER TABLE bbs
    DROP
        CONSTRAINT FK_board_TO_bbs
        CASCADE;

ALTER TABLE memo
    DROP
        CONSTRAINT FK_board_TO_memo
        CASCADE;

ALTER TABLE board_list
    DROP
        CONSTRAINT FK_board_type_TO_board_list
        CASCADE;

ALTER TABLE board_list
    DROP
        CONSTRAINT FK_category_list_TO_board_list
        CASCADE;

ALTER TABLE poll_answer
    DROP
        CONSTRAINT FK_pl_question_TO_pl_answr
        CASCADE;

ALTER TABLE sweet_hate
    DROP
        CONSTRAINT FK_board_TO_sweet_hate
        CASCADE;

ALTER TABLE member
    DROP
        PRIMARY KEY
        CASCADE
        KEEP INDEX;

ALTER TABLE board
    DROP
        PRIMARY KEY
        CASCADE
        KEEP INDEX;

ALTER TABLE reboard
    DROP
        PRIMARY KEY
        CASCADE
        KEEP INDEX;

ALTER TABLE album
    DROP
        PRIMARY KEY
        CASCADE
        KEEP INDEX;

ALTER TABLE bbs
    DROP
        PRIMARY KEY
        CASCADE
        KEEP INDEX;

ALTER TABLE memo
    DROP
        PRIMARY KEY
        CASCADE
        KEEP INDEX;

ALTER TABLE board_list
    DROP
        PRIMARY KEY
        CASCADE
        KEEP INDEX;

ALTER TABLE category_list
    DROP
        PRIMARY KEY
        CASCADE
        KEEP INDEX;

ALTER TABLE board_type
    DROP
        PRIMARY KEY
        CASCADE
        KEEP INDEX;

ALTER TABLE searchword
    DROP
        PRIMARY KEY
        CASCADE
        KEEP INDEX;

ALTER TABLE poll_question
    DROP
        PRIMARY KEY
        CASCADE
        KEEP INDEX;

ALTER TABLE sweet_hate
    DROP
        PRIMARY KEY
        CASCADE
        KEEP INDEX;

DROP INDEX member;

DROP INDEX PK_board;

DROP INDEX PK_reboard;

DROP INDEX PK_album;

DROP INDEX PK_bbs;

DROP INDEX PK_memo;

DROP INDEX PK_board_list;

DROP INDEX PK_category_list;

DROP INDEX PK_board_type;

DROP INDEX PK_searchword;

DROP INDEX PK_poll_question;

DROP INDEX PK_sweet_hate;

/* 회원 */
DROP TABLE member 
    CASCADE CONSTRAINTS;

/* 회원상세 */
DROP TABLE member_detail 
    CASCADE CONSTRAINTS;

/* 기본형게시판 */
DROP TABLE board 
    CASCADE CONSTRAINTS;

/* 답변형게시판 */
DROP TABLE reboard 
    CASCADE CONSTRAINTS;

/* 앨범형게시판 */
DROP TABLE album 
    CASCADE CONSTRAINTS;

/* 자료형게시판 */
DROP TABLE bbs 
    CASCADE CONSTRAINTS;

/* 댓글 */
DROP TABLE memo 
    CASCADE CONSTRAINTS;

/* 게시판목록 */
DROP TABLE board_list 
    CASCADE CONSTRAINTS;

/* 카테고리 */
DROP TABLE category_list 
    CASCADE CONSTRAINTS;

/* 게시판형식 */
DROP TABLE board_type 
    CASCADE CONSTRAINTS;

/* 검색어 */
DROP TABLE searchword 
    CASCADE CONSTRAINTS;

/* 폴질문 */
DROP TABLE poll_question 
    CASCADE CONSTRAINTS;

/* 폴답변 */
DROP TABLE poll_answer 
    CASCADE CONSTRAINTS;

/* 좋아요싫어요 */
DROP TABLE sweet_hate 
    CASCADE CONSTRAINTS;
    
DROP SEQUENCE board_list_seq;

DROP SEQUENCE category_list_seq;

DROP SEQUENCE board_type_seq;

DROP SEQUENCE board_seq;

DROP SEQUENCE reboard_rseq;

DROP SEQUENCE album_aseq;

DROP SEQUENCE bbs_bseq;

DROP SEQUENCE memo_mseq;

DROP SEQUENCE search_sseq;

DROP SEQUENCE poll_pseq;

DROP SEQUENCE sweet_hate_seq;

/* 회원 */
CREATE TABLE member (
    userid VARCHAR2(16) NOT NULL, /* 아이디 */
    username VARCHAR2(20) NOT NULL, /* 이름 */
    userpwd VARCHAR2(20) NOT NULL, /* 비밀번호 */
    emailid VARCHAR2(16), /* 이메일아이디 */
    emaildomain VARCHAR2(30), /* 이메일도메인 */
    profile VARCHAR2(30), /* 프로필사진 */
    joindate DATE DEFAULT sysdate, /* 가입일 */
    role NUMBER(3) DEFAULT 1 /* 상태 */
);

COMMENT ON TABLE member IS '회원';

COMMENT ON COLUMN member.userid IS '아이디';

COMMENT ON COLUMN member.username IS '이름';

COMMENT ON COLUMN member.userpwd IS '비밀번호';

COMMENT ON COLUMN member.emailid IS '이메일아이디';

COMMENT ON COLUMN member.emaildomain IS '이메일도메인';

COMMENT ON COLUMN member.profile IS '프로필사진';

COMMENT ON COLUMN member.joindate IS '가입일';

COMMENT ON COLUMN member.role IS '0 : 관리자, 1 : 일반회원, 2 : 블라인드회원';

CREATE UNIQUE INDEX member
    ON member (
        userid ASC
    );

ALTER TABLE member
    ADD
        CONSTRAINT member
        PRIMARY KEY (
            userid
        );

/* 회원상세 */
CREATE TABLE member_detail (
    userid VARCHAR2(16), /* 아이디 */
    tel1 VARCHAR2(3), /* 전화번호1 */
    tel2 VARCHAR2(4), /* 전화번호2 */
    tel3 VARCHAR2(4), /* 전화번호3 */
    zipcode VARCHAR2(5), /* 도로명우편번호 */
    address VARCHAR2(100), /* 도로명주소 */
    address_detail VARCHAR2(100) /* 도로명상세주소 */
);

COMMENT ON TABLE member_detail IS '회원상세';

COMMENT ON COLUMN member_detail.userid IS '아이디';

COMMENT ON COLUMN member_detail.tel1 IS '전화번호1';

COMMENT ON COLUMN member_detail.tel2 IS '전화번호2';

COMMENT ON COLUMN member_detail.tel3 IS '전화번호3';

COMMENT ON COLUMN member_detail.zipcode IS '도로명우편번호';

COMMENT ON COLUMN member_detail.address IS '도로명주소';

COMMENT ON COLUMN member_detail.address_detail IS '도로명상세주소';

CREATE SEQUENCE board_type_seq start with 1 INCREMENT BY 1;

/* 게시판형식 */
CREATE TABLE board_type (
    btype NUMBER NOT NULL, /* 게시판형식번호 */
    btype_name VARCHAR2(20) /* 게시판형식 */
);

COMMENT ON TABLE board_type IS '게시판형식';

COMMENT ON COLUMN board_type.btype IS '게시판형식번호';

COMMENT ON COLUMN board_type.btype_name IS '게시판형식';

CREATE UNIQUE INDEX PK_board_type
    ON board_type (
        btype ASC
    );

ALTER TABLE board_type
    ADD
        CONSTRAINT PK_board_type
        PRIMARY KEY (
            btype
        );

INSERT INTO BOARD_TYPE (BTYPE, BTYPE_NAME)
VALUES (BOARD_TYPE_SEQ.NEXTVAL, '공지사항');

INSERT INTO BOARD_TYPE (BTYPE, BTYPE_NAME)
VALUES (BOARD_TYPE_SEQ.NEXTVAL, '방명록');

INSERT INTO BOARD_TYPE (BTYPE, BTYPE_NAME)
VALUES (BOARD_TYPE_SEQ.NEXTVAL, '한줄메모');

INSERT INTO BOARD_TYPE (BTYPE, BTYPE_NAME)
VALUES (BOARD_TYPE_SEQ.NEXTVAL, '일반게시판');

INSERT INTO BOARD_TYPE (BTYPE, BTYPE_NAME)
VALUES (BOARD_TYPE_SEQ.NEXTVAL, '답변형게시판');

INSERT INTO BOARD_TYPE (BTYPE, BTYPE_NAME)
VALUES (BOARD_TYPE_SEQ.NEXTVAL, '앨범형게시판');

INSERT INTO BOARD_TYPE (BTYPE, BTYPE_NAME)
VALUES (BOARD_TYPE_SEQ.NEXTVAL, '자료실');

COMMIT;

CREATE SEQUENCE category_list_seq start with 1 INCREMENT BY 1;

/* 카테고리 */
CREATE TABLE category_list (
    ccode NUMBER NOT NULL, /* 카테고리번호 */
    cname VARCHAR2(30) /* 카테고리이름 */
);

COMMENT ON TABLE category_list IS '카테고리';

COMMENT ON COLUMN category_list.ccode IS '카테고리번호';

COMMENT ON COLUMN category_list.cname IS '카테고리이름';

CREATE UNIQUE INDEX PK_category_list
    ON category_list (
        ccode ASC
    );

ALTER TABLE category_list
    ADD
        CONSTRAINT PK_category_list
        PRIMARY KEY (
            ccode
        );
    
INSERT INTO CATEGORY_LIST (CCODE, CNAME)
VALUES(CATEGORY_LIST_SEQ.NEXTVAL, '갤럭시S9');

INSERT INTO CATEGORY_LIST (CCODE, CNAME)
VALUES(CATEGORY_LIST_SEQ.NEXTVAL, '갤럭시NOTE8');

INSERT INTO CATEGORY_LIST (CCODE, CNAME)
VALUES(CATEGORY_LIST_SEQ.NEXTVAL, '아이폰8Plus'); 

COMMIT;

CREATE SEQUENCE board_list_seq start with 1 INCREMENT BY 1;

/* 게시판목록 */
CREATE TABLE board_list (
    bcode NUMBER NOT NULL, /* 게시판번호 */
    bname VARCHAR2(30), /* 게시판이름 */
    ccode NUMBER, /* 카테고리번호 */
    btype NUMBER /* 게시판형식 */
);

COMMENT ON TABLE board_list IS '게시판목록';

COMMENT ON COLUMN board_list.bcode IS '게시판번호';

COMMENT ON COLUMN board_list.bname IS '게시판이름';

COMMENT ON COLUMN board_list.ccode IS '카테고리번호';

COMMENT ON COLUMN board_list.btype IS '게시판형식';

CREATE UNIQUE INDEX PK_board_list
    ON board_list (
        bcode ASC
    );

ALTER TABLE board_list
    ADD
        CONSTRAINT PK_board_list
        PRIMARY KEY (
            bcode
        );

INSERT INTO BOARD_LIST (BCODE, BNAME, BTYPE, CCODE)
VALUES (BOARD_LIST_SEQ.NEXTVAL, '[갤럭시S9] 공지사항', 1, 1);

INSERT INTO BOARD_LIST (BCODE, BNAME, BTYPE, CCODE)
VALUES (BOARD_LIST_SEQ.NEXTVAL, '[갤럭시S9] 일반게시판', 4, 1);

INSERT INTO BOARD_LIST (BCODE, BNAME, BTYPE, CCODE)
VALUES (BOARD_LIST_SEQ.NEXTVAL, '[갤럭시S9] 묻고답하기', 5, 1);

INSERT INTO BOARD_LIST (BCODE, BNAME, BTYPE, CCODE)
VALUES (BOARD_LIST_SEQ.NEXTVAL, '[갤럭시S9] 자랑하기', 6, 1);

INSERT INTO BOARD_LIST (BCODE, BNAME, BTYPE, CCODE)
VALUES (BOARD_LIST_SEQ.NEXTVAL, '[갤럭시S9] 자료실', 7, 1);

INSERT INTO BOARD_LIST (BCODE, BNAME, BTYPE, CCODE)
VALUES (BOARD_LIST_SEQ.NEXTVAL, '[갤럭시NOTE8] 공지사항', 1, 2);

INSERT INTO BOARD_LIST (BCODE, BNAME, BTYPE, CCODE)
VALUES (BOARD_LIST_SEQ.NEXTVAL, '[갤럭시NOTE8] 한줄메모', 3, 2);

INSERT INTO BOARD_LIST (BCODE, BNAME, BTYPE, CCODE)
VALUES (BOARD_LIST_SEQ.NEXTVAL, '[갤럭시NOTE8] 자유게시판', 4, 2);

INSERT INTO BOARD_LIST (BCODE, BNAME, BTYPE, CCODE)
VALUES (BOARD_LIST_SEQ.NEXTVAL, '[갤럭시NOTE8] 궁구미게시판', 5, 2);

INSERT INTO BOARD_LIST (BCODE, BNAME, BTYPE, CCODE)
VALUES (BOARD_LIST_SEQ.NEXTVAL, '[갤럭시NOTE8] 사진자랑', 6, 2);

INSERT INTO BOARD_LIST (BCODE, BNAME, BTYPE, CCODE)
VALUES (BOARD_LIST_SEQ.NEXTVAL, '[갤럭시NOTE8] 어플공유', 7, 2);

INSERT INTO BOARD_LIST (BCODE, BNAME, BTYPE, CCODE)
VALUES (BOARD_LIST_SEQ.NEXTVAL, '[아이폰8Plus] 한줄이면대', 3, 3);

INSERT INTO BOARD_LIST (BCODE, BNAME, BTYPE, CCODE)
VALUES (BOARD_LIST_SEQ.NEXTVAL, '[아이폰8Plus] QNA', 5, 3);

INSERT INTO BOARD_LIST (BCODE, BNAME, BTYPE, CCODE)
VALUES (BOARD_LIST_SEQ.NEXTVAL, '[아이폰8Plus] 폰인증', 6, 3);

INSERT INTO BOARD_LIST (BCODE, BNAME, BTYPE, CCODE)
VALUES (BOARD_LIST_SEQ.NEXTVAL, '[아이폰8Plus] 앱공유', 7, 3);

COMMIT; 

CREATE SEQUENCE board_seq start with 1 INCREMENT BY 1;

/* 기본형게시판 */
CREATE TABLE board (
    seq NUMBER NOT NULL, /* 글번호 */
    userid VARCHAR2(16), /* 아이디 */
    username VARCHAR2(20), /* 이름 */
    email VARCHAR2(50), /* 이메일 */
    subject VARCHAR2(100), /* 제목 */
    content CLOB, /* 내용 */
    hit NUMBER, /* 조회수 */
    logtime DATE DEFAULT sysdate, /* 글작성시간 */
    bcode NUMBER /* 게시판번호 */
);

COMMENT ON TABLE board IS '기본형게시판';

COMMENT ON COLUMN board.seq IS '글번호';

COMMENT ON COLUMN board.userid IS '아이디';

COMMENT ON COLUMN board.username IS '이름';

COMMENT ON COLUMN board.email IS '이메일';

COMMENT ON COLUMN board.subject IS '제목';

COMMENT ON COLUMN board.content IS '내용';

COMMENT ON COLUMN board.hit IS '조회수';

COMMENT ON COLUMN board.logtime IS '글작성시간';

COMMENT ON COLUMN board.bcode IS '게시판번호';

CREATE UNIQUE INDEX PK_board
    ON board (
        seq ASC
    );

ALTER TABLE board
    ADD
        CONSTRAINT PK_board
        PRIMARY KEY (
            seq
        );

CREATE SEQUENCE reboard_rseq start with 1 INCREMENT BY 1;

/* 답변형게시판 */
CREATE TABLE reboard (
    rseq NUMBER NOT NULL, /* 일련번호 */
    seq NUMBER, /* 글번호 */
    gcode NUMBER, /* 그룹번호 */
    depth NUMBER, /* 들여쓰기 */
    step NUMBER, /* 답글정렬 */
    pseq NUMBER, /* 원글번호 */
    reply NUMBER /* 답글갯수 */
);

COMMENT ON TABLE reboard IS '답변형게시판';

COMMENT ON COLUMN reboard.rseq IS '일련번호';

COMMENT ON COLUMN reboard.seq IS '글번호';

COMMENT ON COLUMN reboard.gcode IS '그룹번호';

COMMENT ON COLUMN reboard.depth IS '들여쓰기';

COMMENT ON COLUMN reboard.step IS '답글정렬';

COMMENT ON COLUMN reboard.pseq IS '원글번호';

COMMENT ON COLUMN reboard.reply IS '답글갯수';

CREATE UNIQUE INDEX PK_reboard
    ON reboard (
        rseq ASC
    );

ALTER TABLE reboard
    ADD
        CONSTRAINT PK_reboard
        PRIMARY KEY (
            rseq
        );

CREATE SEQUENCE album_aseq start with 1 INCREMENT BY 1;

/* 앨범형게시판 */
CREATE TABLE album (
    aseq NUMBER NOT NULL, /* 일련번호 */
    seq NUMBER, /* 글번호 */
    savefolder VARCHAR2(8), /* 저장폴더 */
    originalpicture VARCHAR2(100), /* 원본사진이름 */
    savepicture VARCHAR2(100), /* 저장사진이름 */
    picturemode NUMBER(1) DEFAULT 0 /* 사진타입 */
);

COMMENT ON TABLE album IS '앨범형게시판';

COMMENT ON COLUMN album.aseq IS '일련번호';

COMMENT ON COLUMN album.seq IS '글번호';

COMMENT ON COLUMN album.savefolder IS '저장폴더';

COMMENT ON COLUMN album.originalpicture IS '원본사진이름';

COMMENT ON COLUMN album.savepicture IS '저장사진이름';

COMMENT ON COLUMN album.picturemode IS '사진타입';

CREATE UNIQUE INDEX PK_album
    ON album (
        aseq ASC
    );

ALTER TABLE album
    ADD
        CONSTRAINT PK_album
        PRIMARY KEY (
            aseq
        );

CREATE SEQUENCE bbs_bseq start with 1 INCREMENT BY 1;

/* 자료형게시판 */
CREATE TABLE bbs (
    bseq NUMBER NOT NULL, /* 일련번호 */
    seq NUMBER, /* 글번호 */
    savefolder VARCHAR2(8), /* 저장폴더 */
    originalfile VARCHAR2(100), /* 원본파일이름 */
    savefile VARCHAR2(100), /* 저장파일이름 */
    filesize NUMBER /* 파일크기 */
);

COMMENT ON TABLE bbs IS '자료형게시판';

COMMENT ON COLUMN bbs.bseq IS '일련번호';

COMMENT ON COLUMN bbs.seq IS '글번호';

COMMENT ON COLUMN bbs.savefolder IS '저장폴더';

COMMENT ON COLUMN bbs.originalfile IS '원본파일이름';

COMMENT ON COLUMN bbs.savefile IS '저장파일이름';

COMMENT ON COLUMN bbs.filesize IS '파일크기';

CREATE UNIQUE INDEX PK_bbs
    ON bbs (
        bseq ASC
    );

ALTER TABLE bbs
    ADD
        CONSTRAINT PK_bbs
        PRIMARY KEY (
            bseq
        );

CREATE SEQUENCE memo_mseq start with 1 INCREMENT BY 1;

/* 댓글 */
CREATE TABLE memo (
    mseq NUMBER NOT NULL, /* 일련번호 */
    seq NUMBER, /* 글번호 */
    userid VARCHAR2(16), /* 작성자아이디 */
    mcontent VARCHAR2(200), /* 글내용 */
    mlogtime DATE DEFAULT sysdate, /* 작성시간 */
    ipaddress VARCHAR2(15) /* 작성자아이피 */
);

COMMENT ON TABLE memo IS '댓글';

COMMENT ON COLUMN memo.mseq IS '일련번호';

COMMENT ON COLUMN memo.seq IS '글번호';

COMMENT ON COLUMN memo.userid IS '작성자아이디';

COMMENT ON COLUMN memo.mcontent IS '글내용';

COMMENT ON COLUMN memo.mlogtime IS '작성시간';

COMMENT ON COLUMN memo.ipaddress IS '작성자아이피';

CREATE UNIQUE INDEX PK_memo
    ON memo (
        mseq ASC
    );

ALTER TABLE memo
    ADD
        CONSTRAINT PK_memo
        PRIMARY KEY (
            mseq
        );

CREATE SEQUENCE search_sseq start with 1 INCREMENT BY 1;

/* 검색어 */
CREATE TABLE searchword (
    sseq NUMBER NOT NULL, /* 일련번호 */
    keyword VARCHAR2(30), /* 검색어 */
    hit NUMBER /* 검색수 */
);

COMMENT ON TABLE searchword IS '검색어';

COMMENT ON COLUMN searchword.sseq IS '일련번호';

COMMENT ON COLUMN searchword.keyword IS '검색어';

COMMENT ON COLUMN searchword.hit IS '검색수';

CREATE UNIQUE INDEX PK_searchword
    ON searchword (
        sseq ASC
    );

ALTER TABLE searchword
    ADD
        CONSTRAINT PK_searchword
        PRIMARY KEY (
            sseq
        );

CREATE SEQUENCE poll_pseq start with 1 INCREMENT BY 1;

/* 폴질문 */
CREATE TABLE poll_question (
    pseq NUMBER NOT NULL, /* 폴번호 */
    question VARCHAR2(100), /* 질문 */
    startdate DATE, /* 시작일 */
    enddate DATE, /* 종료일 */
    chart VARCHAR2(20) /* 차트형식 */
);

COMMENT ON TABLE poll_question IS '폴질문';

COMMENT ON COLUMN poll_question.pseq IS '폴번호';

COMMENT ON COLUMN poll_question.question IS '질문';

COMMENT ON COLUMN poll_question.startdate IS '시작일';

COMMENT ON COLUMN poll_question.enddate IS '종료일';

COMMENT ON COLUMN poll_question.chart IS '차트형식';

CREATE UNIQUE INDEX PK_poll_question
    ON poll_question (
        pseq ASC
    );

ALTER TABLE poll_question
    ADD
        CONSTRAINT PK_poll_question
        PRIMARY KEY (
            pseq
        );

/* 폴답변 */
CREATE TABLE poll_answer (
    pseq NUMBER, /* 폴번호 */
    paseq NUMBER, /* 답변번호 */
    answer VARCHAR2(100), /* 답변 */
    pollcount NUMBER /* 투표수 */
);

COMMENT ON TABLE poll_answer IS '폴답변';

COMMENT ON COLUMN poll_answer.pseq IS '폴번호';

COMMENT ON COLUMN poll_answer.paseq IS '답변번호';

COMMENT ON COLUMN poll_answer.answer IS '답변';

COMMENT ON COLUMN poll_answer.pollcount IS '투표수';

CREATE SEQUENCE sweet_hate_seq start with 1 INCREMENT BY 1;

/* 좋아요싫어요 */
CREATE TABLE sweet_hate (
    board_sh_seq NUMBER NOT NULL, /* 일련번호 */
    seq NUMBER, /* 글번호 */
    mseq NUMBER, /* 댓글번호 */
    userid VARCHAR2(16), /* 사용자아이디 */
    flag CHAR(1) /* 좋아요싫어요 */
);

COMMENT ON TABLE sweet_hate IS '좋아요싫어요';

COMMENT ON COLUMN sweet_hate.board_sh_seq IS '일련번호';

COMMENT ON COLUMN sweet_hate.seq IS '글번호';

COMMENT ON COLUMN sweet_hate.mseq IS '댓글번호';

COMMENT ON COLUMN sweet_hate.userid IS '사용자아이디';

COMMENT ON COLUMN sweet_hate.flag IS '좋아요싫어요';

CREATE UNIQUE INDEX PK_sweet_hate
    ON sweet_hate (
        board_sh_seq ASC
    );

ALTER TABLE sweet_hate
    ADD
        CONSTRAINT PK_sweet_hate
        PRIMARY KEY (
            board_sh_seq
        );

ALTER TABLE member_detail
    ADD
        CONSTRAINT FK_member_TO_member_detail
        FOREIGN KEY (
            userid
        )
        REFERENCES member (
            userid
        );

ALTER TABLE board
    ADD
        CONSTRAINT FK_member_TO_board
        FOREIGN KEY (
            userid
        )
        REFERENCES member (
            userid
        );

ALTER TABLE board
    ADD
        CONSTRAINT FK_board_list_TO_board
        FOREIGN KEY (
            bcode
        )
        REFERENCES board_list (
            bcode
        );

ALTER TABLE reboard
    ADD
        CONSTRAINT FK_board_TO_reboard
        FOREIGN KEY (
            seq
        )
        REFERENCES board (
            seq
        );

ALTER TABLE album
    ADD
        CONSTRAINT FK_board_TO_album
        FOREIGN KEY (
            seq
        )
        REFERENCES board (
            seq
        );

ALTER TABLE bbs
    ADD
        CONSTRAINT FK_board_TO_bbs
        FOREIGN KEY (
            seq
        )
        REFERENCES board (
            seq
        );

ALTER TABLE memo
    ADD
        CONSTRAINT FK_board_TO_memo
        FOREIGN KEY (
            seq
        )
        REFERENCES board (
            seq
        );

ALTER TABLE board_list
    ADD
        CONSTRAINT FK_board_type_TO_board_list
        FOREIGN KEY (
            btype
        )
        REFERENCES board_type (
            btype
        );

ALTER TABLE board_list
    ADD
        CONSTRAINT FK_category_list_TO_board_list
        FOREIGN KEY (
            ccode
        )
        REFERENCES category_list (
            ccode
        );

ALTER TABLE poll_answer
    ADD
        CONSTRAINT FK_pl_question_TO_pl_answr
        FOREIGN KEY (
            pseq
        )
        REFERENCES poll_question (
            pseq
        );

ALTER TABLE sweet_hate
    ADD
        CONSTRAINT FK_board_TO_sweet_hate
        FOREIGN KEY (
            seq
        )
        REFERENCES board (
            seq
        );
