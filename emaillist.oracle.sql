DROP TABLE emaillist;
DROP SEQUENCE seq_emaillist_pk;
-- 테이블 생성
CREATE TABLE emaillist (
    no number primary key,
    last_name varchar2(20),
    first_name varchar2(20),
    email varchar2(128),
    created_at date DEFAULT sysdate);
    
-- 시퀀스 생성
CREATE SEQUENCE seq_emaillist_pk 
    start with 1
    increment by 1;
    
-- 데이터 입력
INSERT INTO emaillist
VALUES (
    seq_emaillist_pk.nextval,
    '남',
    '승균',
    'skyun.nam@gmail.com',
    sysdate);
    
commit;

SELECT * FROM emaillist ORDER BY created_at DESC;

INSERT INTO emaillist (no, last_name, first_name, email)
VALUES (seq_emaillist_pk.nextval, ?, ?, ?);