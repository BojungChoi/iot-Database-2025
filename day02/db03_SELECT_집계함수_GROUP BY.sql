-- 집계함수 종류

-- SUM : SUM([ALL | DISTINCT]속성이름) ex) SUM(price)
-- AVG : AVG([ALL | DISTINCT]속성이름) ex) AVG(price)
-- COUNT : COUNT({[[ALL | DISTINCT]속성이름]|*}) ex) COUNT(*)
-- MAX : MAX([ALL | DISTINCT]속성이름) ex) MAX(price)
-- MIN : MIN([ALL | DISTINCT]속성이름) ex) MIN(price)

-- 3-15 : 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice)
  FROM Orders;

SELECT SUM(saleprice) AS 총매출 -- AS : 열 이름 부여할때.
  FROM Orders;
  
SELECT SUM(saleprice) 총매출 -- 최근버전은 AS 생략가능
  FROM Orders;

SELECT SUM(saleprice) '총 매출' -- 공백을 넣어야 할 경우 '' 로 지칭
  FROM Orders;
  
-- MySQL 문자열은 '' 홑따옴표 사용 , "" 쌍따옴표 사용불가!!
  
-- 3-16 : 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.

SELECT SUM(saleprice) '총 매출'
  FROM Orders
 WHERE custid = 2;
 
-- 3-17 : 고객이 주문한 도서의 총판매액, 평균값, 최저가, 최고가를 구하시오.

SELECT SUM(saleprice) AS Total		-- 합계
	 , AVG(saleprice) AS Average	-- 평균
     , MIN(saleprice) AS Minimal	-- 최소
     , MAX(saleprice) AS Maximal	-- 최대
     , STD(saleprice) AS StandarV 	-- 표준편차
  FROM Orders;

-- 3-18 : 마당서점의 총 도서 판매 건수를 구하시오.

SELECT COUNT(*) 총판매건수
  FROM Orders;

-- 그룹화 GROUP BY 키워드 사용
-- 3-19 : 고객별로 도서의 총수량과 총판매액을 구하시오.
-- GROUP BY를 사용하면 반드시 집계함수및 GROUP BY 에 포함된 컬럼이 SELECT 안에 포함시켜야.
SELECT custid
	 , COUNT(*) AS 구매도서수량 -- 함수 매개변수로 *, custid
	 , SUM(saleprice) AS 총액
  FROM Orders
 GROUP BY custid;

-- 추가: 3-19의 내용에서 고객별 총액을 내림차순으로 출력하시오.
SELECT custid
	 , COUNT(*) AS 구매도서수량 -- 함수 매개변수로 *, custid
	 , SUM(saleprice) AS 고객별총액
  FROM Orders
 GROUP BY custid
 -- ORDER BY 고객별총액 DESC;
 ORDER BY 3 DESC;
 
 -- 3-20 : 가격이 8000원 이상인 도서를 구매한 고객에 대해 고객별 주문도서의 총 수량을 구하시오,
 -- 단, 2권이상 구매한 고객에 대해서만 한정합니다.
-- COUNT() 등 집계함수는 WHERE절에 넣을 수 없다!!!
-- HAVING절을 사용한다.
-- GROUP BY에 있는 컬럼만 SELECT 안에 사용할 수 있음. 그 외는 사용불가!
 SELECT custid
	  , COUNT(*) AS 총수량
   FROM Orders
  WHERE saleprice >= 8000
  GROUP BY custid
 HAVING 총수량 >= 2; # COUNT(*) 와 별명을 둘다 사용할 수 있다.

-- 추가 : 고객별 구매수량과 구매총액을 출력하고, 전체를 합산하여 통계를 표시하세요.
SELECT custid
	 , COUNT(*) AS 구매도서수량 -- 함수 매개변수로 *, custid
	 , SUM(saleprice) AS 고객별총액
  FROM Orders
 GROUP BY custid
  WITH ROLLUP;

-- JOIN : 두개이상의 테이블을 합쳐서 출력
-- 3-21 : 고객과 고객의 주문의 관한 데이터를 모두 나타내시오.
SELECT *
  FROM Customer
 INNER JOIN Orders
	ON Customer.custid = Orders.custid;
    
-- 추가. 생략형 쿼리
SELECT *
  FROM Customer, Orders
 WHERE Customer.custid = Orders.custid;
 
 -- 중복되거나 필요없는 컬럼은 제거하고 출력
 SELECT Customer.custid
	  , Customer.name
      , Customer.address
      , Orders.orderid
      , Orders.saleprice
      , Orders.orderdate
  FROM Customer, Orders
 WHERE Customer.custid = Orders.custid;
 
 -- 테이블명을 줄여서 별명으로 사용
  SELECT c.custid
	  , c.name
      , c.address
      , o.orderid
      , o.saleprice
      , o.orderdate
  FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid;
 
 -- 필요하면 테이블 조인하면 됨
   SELECT c.custid
	  , c.name
      , c.address
      , o.orderid
      , o.saleprice
      , o.orderdate
      , b.bookname
      , b.publisher
      , b.price
  FROM Customer AS c, Orders AS o, Book AS b
 WHERE c.custid = o.custid
   AND b.bookid = o.bookid;
   
-- 3-22 : 고객과 고객 주문에 관한 고객별로 정렬하여 나타내시오.
-- 고객명으로 정렬
   SELECT c.*
		, o.*
  FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid
 ORDER BY c.name ASC;
 
 -- 3-23 : 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT name, saleprice
  FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid;
 
 -- 3-24 : 고객별로 주문한 모든 도서의 총 판매액을 구하고 고객별로 정렬하시오.
 SELECT name, SUM(saleprice)
   FROM Customer AS c, Orders AS o
  WHERE c.custid = o.custid
  GROUP BY c.name
  ORDER BY c.name;
  
-- 3-26 : 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT c.name 
	 , b.bookname
     , b.price
     , o.saleprice
  FROM Customer AS c, Orders AS o , Book AS b
 WHERE c.custid = o.custid
   AND b.bookid = o. bookid -- JOIN을 위한 조건
   AND b.price = 20000; -- 나머지 조건들...

-- 외부조인 : 조건을 만족하지 않는(일치하지 않는) 데이터도 출력이 필요할 때 사용하는 조인
-- 3-27 : 도서를 구매하지 않은 고객을 포함해 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
-- LEFT OUTER JOIN 또는 RIGHT OUTER JOIN - LEFT랑 RIGHT 는 기준이 되는 테이블 위치
SELECT *
  FROM Customer as c
  LEFT OUTER JOIN Orders AS o -- OUTER를 제외해도 LEFT,RIGHT를 쓴 순간 OUTER가 기본값임. 출력값동일.
    ON c.custid = o.custid;

SELECT *    
  FROM Customer as c
 RIGHT OUTER JOIN Orders AS o
    ON c.custid = o.custid;
    
-- 서브쿼리(부속질의)
SELECT MAX(price) 
  FROM Book;
  
-- 3-28 : 가장 비싼 도서의 이름을 나타내시오.
SELECT Bookname
  FROM Book
 WHERE price = (
SELECT MAX(price) 
  FROM Book  
 );

-- 3-29 : 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
SELECT c.name
  FROM Customer AS c
 WHERE c.custid IN(
			SELECT DISTINCT custid FROM Orders
				);
                
-- 3-30 : 대한 미디어에서 출판한 도서를 구매한 고객의 이름을 나타내시오.
SELECT c.name
  FROM Customer AS c
 WHERE c.custid IN(
					SELECT o.custid
					  FROM Orders AS o
					 WHERE o.bookid IN(
										SELECT b.bookid
										  FROM Book AS b
										 WHERE b.publisher = '대한미디어'
                                         )
					);

-- 3-30은 이러한 방법으로도 표현(JOIN)
SELECT c.name
  FROM Customer AS c, Book AS b, Orders AS o
 WHERE c.custid = o.custid
   AND b.bookid = o.bookid
   AND b.publisher='대한미디어';

-- 3-31 출판사별로 출판사의 평균도서가격보다 비싼 도서를 구하시오
-- 상관 서브쿼리.
SELECT *
  FROM Book AS b1
 WHERE b1.price >(
			 SELECT AVG(b2.price)
			   FROM Book AS b2
			  WHERE b2.publisher = b1.publisher);

SELECT AVG(b2.price)
	   , b2.publisher
  FROM Book AS b2
 WHERE b2.publisher = "대한미디어"
 GROUP BY b2.publisher;
              
              
-- 집합연산
SELECT name
  FROM Customer
UNION -- 두개를 포함해서 나타내는 문자, UNION ALL -> 중복된거까지 함께
SELECT bookname
  FROM Book;
  
-- 타입에 제약이 없음
SELECT name
  FROM Customer
 UNION
SELECT orderdate
  FROM Orders;


-- EXISTS : 상관서브쿼리에서 사용하는 키워드. 상관서브쿼리가 아니라도 사용가능
-- 주문이 있는 고객의 이름과 주소를 나타내시오.
SELECT *
  FROM Customer AS c
 WHERE EXISTS (
				SELECT *
				  FROM Orders AS o
				 WHERE o.custid = c.custid
				 );