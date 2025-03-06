-- 기존테이블삭제
DROP TABLE IF EXISTS NewBook;

-- 테이블생성
CREATE TABLE NewBook(
	bookid INTEGER AUTO_INCREMENT PRIMARY KEY,
    bookname VARCHAR(100),
    publisher VARCHAR(100),
    price INTEGER
);

-- 500만건 더미데이터 생성
SET SESSION cte_max_recursion_depth = 5000000;

-- 더미데이터 생성
INSERT INTO NewBook (bookname, publisher, price)
  WITH RECURSIVE cte(n) AS
(
	SELECT 1
    UNION ALL
    SELECT  n+1 FROM cte WHERE n < 5000000
)
SELECT CONCAT('Book', lpad(n, 7, '0')) -- Book5000000
	 , concat('Comp', lpad(n, 7, '0')) -- Comp5000000
     , floor(3000 + rand() * 30000) as price -- 책가격 랜덤 3000 ~ 33000원
  FROM cte;
  
-- 데이터 확인
SELECT count(*) FROM NewBook;

SELECT * FROM NewBook
 WHERE price between 20000 and 25000;
 
 
-- 가격을 7개 정도 검색할 수 있는 쿼리 작성
SELECT * FROM NewBook
 WHERE price in(1234,4651,2465,46600,33000,2600,5450);

-- 인덱스 생성
CREATE INDEX idx_book ON NewBook(price);
 
 
	