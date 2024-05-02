-- 현재 사용자에게 부여된 ROLE의 확인
SELECT * FROM USER_ROLE_PRIVS;

-- CONNECT와 RESOURCE 역할은 어떤 권한으로 구성되어 있는가?
-- sysdba로 진행
-- cmd
-- sqlplus sys/oracle as sysdba
-- DESC role_sys privs;
-- CONNECT롤에는 어떤 권한이 포함되어 있는가?
-- SELECT privilege FROM role_sys privs WHERE role='CONNECT';
-- RESOURCE롤에는 어떤 권한이 포함되어 있는가?
-- SELECT privilege FROM role_sys privs WHERE role='RESOURCE';

ALTER SESSION SET "_ORACLE_SCRIPT" = true;
CREATE USER himedia IDENTIFIED BY himedia;
GRANT CONNECT, RESOURCE TO himedia; 
ALTER USER himedia DEFAULT TABLESPACE USERS
    QUOTA unlimited on USERS;
GRANT select ON employees To himedia;
SELECT * FROM hr.employees;
SELECT * FROM hr.departments;

SELECT * FROM tabs;
CREATE TABLE book (
    book_id NUMBER(5),
    title VARCHAR2(50),
    author VARCHAR2(10),
    pub_date DATE DEFAULT SYSDATE
);

DESC book;

CREATE TABLE emp_it AS (
    SELECT * FROM hr.employees WHERE job_id LIKE 'IT_%'
);
SELECT * FROM tabs;

-- author 테이블 생성
CREATE TABLE author(
    author_id NUMBER(10),
    author_name VARCHAR2(100) NOT NULL,
    author_desc VARCHAR2(500),
    PRIMARY KEY (author_id)
);

DESC author;

-- book 테이블의 author 컬럼 삭제
-- 나중에 author_id 컬럼을 추가하고 -> author.author_id와 참조 연결할 예정
ALTER TABLE book DROP COLUMN author;
DESC book;

-- book 테이블의 author 컬럼 추가
-- author.author_id와 참조하는 컬럼이기에 author.author_id 컬럼과 같은 형태여야 한다
ALTER TABLE book ADD (author_id NUMBER(10));
DESC book;

-- book 테이블의 book_id도 author 테이블의 PK와 같은 테이터타입 (NUMBER(10))으로 변경
ALTER TABLE book MODIFY (book_id NUMBER(10));
DESC book;

-- book 테이블의 book_id 컬럼에 PRIMARY KEY 제약조건을 부여
ALTER TABLE book
ADD CONSTRAINT pk_book_id PRIMARY KEY (book_id);
DESC book;

-- book 테이블의 author_id 컬럼과 author 테이블의 author_id를 FK로 연결
ALTER TABLE book
ADD CONSTRAINT fk_author_id 
    FOREIGN KEY (author_id)
        REFERENCES author(author_id);
DESC book;

-- DICTIONARY

-- USER_ : 현재 로그인된 사용자에게 허용된 뷰
-- ALL_  : 모든 사용자 뷰
-- DBA_  : DBA에게 허용된 뷰

-- 모든 DICTIONARY 확인
SELECT * FROM DICTIONARY;         -- 1,098

-- 사용자 스키마 객체 : USER_OBJECTS
SELECT * FROM USER_OBJECTS;
-- 사용자 스키마의 이름과 타입 정보 출력
SELECT OBJECT_NAME, OBJECT_TYPE FROM USER_OBJECTS;

-- 제약조건의 확인
SELECT * FROM USER_CONSTRAINTS;
SELECT CONSTRAINT_NAME,
        CONSTRAINT_TYPE,
        SEARCH_CONDITION,
        TABLE_NAME
FROM USER_CONSTRAINTS;

-- BOOK 테이블에 적용된 제약조건의 확인
SELECT CONSTRAINT_NAME,
        CONSTRAINT_TYPE,
        SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='BOOK';

TRUNCATE TABLE author;

-- INSERT : 테이블에 새 레코드(튜플) 추가
-- 제공된 컬럼 목록의 순서와 타입, 값 목록의 순서와 타입이 일치해야 함
-- 컬럼 목록을 제공하지 않으면 테이블 생성시 정의된 컬럼의 순서와 타입을 따른다

-- 컬럼 목록이 제시되지 않았을 때
INSERT INTO author
VALUES(1, '박경리', '토지 작가');

SELECT * FROM author;

-- 컬럼 목록을 제시했을 때
-- 제시한 컬럼의 순서와 타입대로 값 목록을 제공해야 함
INSERT INTO author(author_id, author_name)
VALUES(2, '김영하');

SELECT * FROM author;

-- 컬럼 목록을 제공했을 때,
-- 테이블 생성시 정의된 컬럼의 순서와 상관없이 데이터 제공 가능
INSERT INTO author(author_name, author_id, author_desc)
VALUES('류츠신', 3, '삼체 작가');

SELECT * FROM author;
--DESC author;

-- 반영 취소 방법
ROLLBACK;

SELECT * FROM author; -- 반영취소됐는지 확인

INSERT INTO author
VALUES(1, '박경리', '토지 작가');
INSERT INTO author(author_id, author_name)
VALUES(2, '김영하');
INSERT INTO author(author_name, author_id, author_desc)
VALUES('류츠신', 3, '삼체 작가');

SELECT * FROM author;

-- 변경사항 반영하는 방법
COMMIT;

SELECT * FROM author;

--UPDATE
-- 특정 레코드의 컬럼 값을 변경한다
-- WHERE 절이 없으면 모든 레코드가 변경된다
-- 가급적 WHERE 절로 변경하고자 하는 레코드를 지정하도록 한다
UPDATE author
SET author_desc = '알쓸신잡 출연';

SELECT * FROM author;

ROLLBACK;

SELECT * FROM author;

UPDATE author
SET author_desc = '알쓸신잡 출연'
WHERE author_name = '김영하';

SELECT * FROM author;

-- DELETE
-- 테이블로부터 특정 레코드를 삭제
-- WHERE 절이 없으면 모든 레코드를 삭제하니 주의해야한다

-- 연습
-- hr.employees 테이블을 기반으로 department_id 10, 20, 30인 직원들만 새테이블 emp123으로 생성하자
CREATE TABLE emp123 AS 
        (SELECT * FROM hr.employees
            WHERE department_id IN(10, 20, 30));
            
DESC emp123;

SELECT first_name, salary, department_id FROM emp123;

-- department_id가 30인 직원들의 급여를 10% 인상
UPDATE emp123
SET salary = salary + salary * 0.1
WHERE department_id = 30;

SELECT * FROM emp123;

-- Job_id가 MK로 시작하는 직원들의 이름을 삭제
DELETE FROM emp123
WHERE job_id LIKE 'MK_%';

SELECT * FROM emp123;

DELETE FROM emp123; -- WHERE절이 생략된 DELETE문은 모든 레코드를 삭제하니 주의하자
SELECT * FROM emp123;

ROLLBACK;
SELECT * FROM emp123;

---------------------
-- TRANSACTION
---------------------

-- 트랜잯션 테스트 테이블
CREATE TABLE t_test(
    log_text VARCHAR2(100)
);

-- 첫번째 DML이 수행된 시점에서 Transaction
INSERT INTO t_test VALUES('트랜잭션 시작');
SELECT * FROM t_test;
INSERT INTO t_test VALUES('데이터 INSERT');
SELECT * FROM t_test;

SAVEPOINT sp1; -- 세이브 포인트 설정

INSERT INTO t_test VALUES('데이터 2 INSERT');

SELECT * FROM t_test;

SAVEPOINT sp2; -- 세이브 포인트 설정

UPDATE t_test SET log_text = '업데이트';

SELECT * FROM t_test;

ROLLBACK TO sp2;  -- sp2로 귀환

SELECT * FROM t_test;

INSERT INTO t_test VALUES('데이터 3 INSERT');

SELECT * FROM t_test;

-- 반영 : COMMIT or 취소 : ROLLBACK
-- 명시적으로 Transaction 종료상황이 됨
COMMIT;
SELECT * FROM t_test;

ROLLBACK;