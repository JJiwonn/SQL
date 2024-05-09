DESC author;
DESC book;

SELECT * FROM author;

SELECT * FROM user_objects WHERE OBJECT_TYPE = 'SEQUENCE';

DELETE FROM author;
COMMIT;

SELECT * FROM author;

-- LIST
SELECT author_id, author_name, author_desc FROM author;