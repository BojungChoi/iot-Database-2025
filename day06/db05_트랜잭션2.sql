-- 트랜잭션
START TRANSACTION;
INSERT INTO Book VALUES (99, '데이터베이스', '한빛', 25000);

SELECT Bookname AS 'bookname1' FROM Book WHERE bookid = 99;
-- 저장포인트 
SAVEPOINT a;

UPDATE Book SET bookname = '데이터베이스 개론' WHERE bookid = 99;
 
SELECT Bookname AS 'bookname2' FROM Book WHERE bookid = 99;
SAVEPOINT b;

UPDATE Book SET bookname = '데이터베이스 개론 및 실습' WHERE bookid = 99;
 
SELECT Bookname AS 'bookname3' FROM Book WHERE bookid = 99;
ROLLBACK TO b;

SELECT Bookname AS 'bookname4' FROM Book WHERE bookid = 99;
ROLLBACK TO a;

SELECT Bookname AS 'bookname5' FROM Book WHERE bookid = 99;
COMMIT;

-- START TRASACTION 에서 COMMIT ,ROLLBACK(ROLLBACK TO 아님!) 까지는 트랜잭션이 살아있음
-- SAVEPOINT는 트랜잭션 상에서 이동가능

START TRANSACTION;
UPDATE Book SET bookname = '데이터베이스 개론 및 실습2' WHERE bookid = 99;

SELECT Bookname AS 'bookname6' FROM Book WHERE bookid = 99;
ROLLBACK;

SELECT Bookname AS 'bookname7' FROM Book WHERE bookid = 99;

DELETE FROM Book WHERE bookid = 99;
COMMIT;