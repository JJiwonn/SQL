-- 본인의 이름 주석으로 작성  예)홍길동
-- 여기에 본인의 이름을 작성해 주세요
-- 김지원




-- 데이터베이스 초기화를 위해 기존의 테이블과 시퀀스를 모두 삭제
-- 초기화를 위해 테이블(2개)과 시퀀스(2개)를 모두 삭제합니다.
SELECT * FROM USER_SEQUENCES;
DROP SEQUENCE SEQ_AUTHOR_ID;
DROP SEQUENCE SEQ_BOOK_ID;

SELECT * FROM ALL_TABLES;
DROP TABLE AUTHOR;
DROP TABLE BOOK;


-- 시퀀스 생성 쿼리문 2개
-- 테이블 t_author와 t_book에서 사용할 PK를 위한 시퀀스 생성
CREATE SEQUENCE seq_author_id
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 1000000;
    
CREATE SEQUENCE seq_book_id
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 1000000;

-- 테이블 생성 쿼리문 2개
/*
컬럼명은 문제 이미지를 참고합니다.
각각의 테이블의 pk 컬럼은 시퀀스 객체를 이용하여 입력합니다
author_id 는 pk, fk 관계입니다.
*/

CREATE TABLE t_author (
    author_id NUMBER PRIMARY KEY,
    author_name VARCHAR2(100),
    author_desc VARCHAR2(500)
);

CREATE TABLE t_book (
    book_id NUMBER PRIMARY KEY,
    book_title VARCHAR2(500),
    pubs VARCHAR2(500),
    pubs_date DATE NULL,
    author_id NUMBER,
    FOREIGN KEY (author_id) REFERENCES t_author(author_id)
);


-- t_author테이블 데이터 입력 쿼리문 6개
-- 문제 이미지의 결과가 나오도록 데이터를 입력합니다.
INSERT INTO t_author (author_id, author_name, author_desc) 
VALUES (seq_author_id.NEXTVAL, '이문열', '경북 영양');

INSERT INTO t_author (author_id, author_name, author_desc)
VALUES (seq_author_id.NEXTVAL, '박경리', '경상남도 통영');

INSERT INTO t_author (author_id, author_name, author_desc) 
VALUES (seq_author_id.NEXTVAL, '유시민', '17대 국회의원');

INSERT INTO t_author (author_id, author_name, author_desc) 
VALUES (seq_author_id.NEXTVAL, '강풀', '온라인 만화가 1세대');

INSERT INTO t_author (author_id, author_name, author_desc) 
VALUES (seq_author_id.NEXTVAL, '김영하', '알쓸신잡');

INSERT INTO t_author (author_id, author_name, author_desc) 
VALUES (seq_author_id.NEXTVAL, '류츠신', '휴고상 수상 SF 작가');

SELECT * FROM t_author;



-- book테이블의 데이터 입력 쿼리문 9개
-- 문제 이미지의 결과가 나오도록 데이터를 입력합니다.

INSERT INTO t_book (book_id, book_title, pubs, pubs_date, author_id)
VALUES (seq_book_id.NEXTVAL, '우리들의 일그러진 영웅', '다림' , TO_DATE('1998-02-22', 'YYYY-MM-DD'), 1);

INSERT INTO t_book (book_id, book_title, pubs, pubs_date, author_id) 
VALUES (seq_book_id.NEXTVAL, '삼국지', '민음사' , TO_DATE('2002-03-01', 'YYYY-MM-DD'), 1);

INSERT INTO t_book (book_id, book_title, pubs, pubs_date, author_id) 
VALUES (seq_book_id.NEXTVAL, '토지', '마로니에북스' , TO_DATE('2012-08-15', 'YYYY-MM-DD'), 2);

INSERT INTO t_book (book_id, book_title, pubs, pubs_date, author_id) 
VALUES (seq_book_id.NEXTVAL, '유시민의 글쓰기 특강', '생각의길' , TO_DATE('2015-04-01', 'YYYY-MM-DD'), 3);

INSERT INTO t_book (book_id, book_title, pubs, pubs_date, author_id) 
VALUES (seq_book_id.NEXTVAL, '순정만화', '재미주의' , TO_DATE('2011-08-03', 'YYYY-MM-DD'), 4);

INSERT INTO t_book (book_id, book_title, pubs, pubs_date, author_id) 
VALUES (seq_book_id.NEXTVAL, '오직두사람', '문학동네' , TO_DATE('2017-05-04', 'YYYY-MM-DD'), 5);

INSERT INTO t_book (book_id, book_title, pubs, pubs_date, author_id) 
VALUES (seq_book_id.NEXTVAL, '26년', '재미주의' , TO_DATE('2012-02-04', 'YYYY-MM-DD'), 4);

INSERT INTO t_book (book_id, book_title, pubs, pubs_date, author_id) 
VALUES (seq_book_id.NEXTVAL, '삼체', '자음과모음' , TO_DATE('2020-07-06', 'YYYY-MM-DD'), 6);

INSERT INTO t_book (book_id, book_title, pubs, pubs_date, author_id) 
VALUES (seq_book_id.NEXTVAL, 'AI 시대의 히치하이커', NULL, 9);

SELECT * FROM t_book;

-- 현재 작성된 두 개의 테이블에 대한 SELECT 권한을 hr에게 부여
-- 현재 작성된 두 개의 테이블을 조회할 수 있도록 권한을 hr 계정에게 부여합니다

GRANT SELECT ON t_author TO hr;
GRANT SELECT ON t_book TO hr;




-- 아래의 조건에 맞는 책목록 리스트 쿼리문 1개
/*
(1)등록된 모든 책이 출력되어야 합니다.(9권)
(2)출판일은 ‘1998년 02월 02일’ 형태로 보여야 합니다.
(3)정렬은 책 제목을 내림차순으로 정렬합니다.
*/

/* 안녕하세요 강사님 
    제가 할수있는만큼 최대한으로 해봤습니다!
    많이 부족하고 엉망진창이지만 잘 부탁드립니다...!
    앞으로 남은 수업도 더 열심히 듣겠습니다!
    감사합니다! */



-- [산출물]
/*
- 아래 2개의 산출물을 이름.zip 파일로 압축해서 제출합니다.
- book_test.sql
- book_list.jpg
*/

-- 수고하셨습니다
