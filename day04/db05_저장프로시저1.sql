-- 저장 프로시저1
-- Book 테이블에 하나의 row를 추가하는 프로시저
DELIMITER $$

CREATE PROCEDURE InsertBook(
	IN myBookId			INTEGER,
    IN mybookName		VARCHAR(40),
    IN myPublisher		VARCHAR(40),
    IN myPrice			INTEGER
)
BEGIN
	INSERT INTO Book (bookid, bookname, publisher, price)
    VALUES (myBookId, mybookName, myPublisher, myPrice);
END $$

-- 프로시저 호출
CALL InsertBook(30, '스포츠과학', '마당과학서적', 25000);

SELECT * FROM Book;

-- 프로시저 삭제
DROP PROCEDURE InsertBook;
