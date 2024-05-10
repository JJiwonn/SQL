DESC author;

DESC book;

SELECT * FROM author;

SELECT * FROM user_objects WHERE OBJECT_TYPE = 'SEQUENCE';

DELETE FROM author;
COMMIT;

SELECT * FROM author;

-- LIST
SELECT author_id, author_name, author_desc FROM author;

-- TABLE
CREATE TABLE PHONE_BOOK (
    id NUMBER(10) PRIMARY KEY,
    name VARCHAR2(10),
    hp VARCHAR2(20),
    tel VARCHAR2(20)
);
DESC PHONE_BOOK;
SELECT * FROM PHONE_BOOK;
CREATE SEQUENCE seq_phone_book;
SELECT * FROM user_objects WHERE OBJECT_TYPE = 'SEQUENCE';
COMMIT;
