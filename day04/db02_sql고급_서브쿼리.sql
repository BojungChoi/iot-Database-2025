-- 서브쿼리 고급
-- 4-12 : Orders 테이블 평균 주문금액 이하의 주문에 대해 주문번호와 금액을 나타내시오.
-- 집계함수는 GROUP BY 가 없어도 테이블 전체를 집계할 수 있음
SELECT orderid AS 주문번호
	 , saleprice AS 세일금액
  FROM Orders
 WHERE saleprice <= (SELECT AVG(saleprice)
					   FROM Orders);

-- 4-14 : 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice) AS '총판매액'
  FROM Orders
 WHERE custid IN (SELECT custid
					FROM Customer
				   WHERE address LIKE '%대한민국%');
  
-- 4-15 : 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의
-- 주문번호와 판매금액을 보이시오.
-- 비교연산자만 쓰면 서브쿼리의 값이 단일값이 되어야 함 (제약사항!)
SELECT orderid,saleprice
  FROM Orders
 WHERE saleprice > (SELECT MAX(saleprice)
					  FROM Orders
					 WHERE custid = 3);

-- ALL|SOME|ANY를 쓰면 서브쿼리의 값이 단일값이 아니어도 상관없음
-- ALL - 서브쿼리 내 결과의 모든 값보다 비교연산이 일치하는 값을 찾는 것
-- SOME|ANY - 서브쿼리 내 결과의 각각의 값과 비교연산이 일치하는 값을 찾는 것
SELECT *
  FROM Orders
 WHERE saleprice >  ALL (SELECT saleprice
					  FROM Orders
					 WHERE custid = 3);
                     
-- 4-19 : EXISTS 연산자를 사용해 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.
-- EXISTS는 유일하게 서브쿼리에 * 을 쓸 수 있는 방법(원래 서브쿼리에는 *을 안씀..)
SELECT SUM(saleprice) as '총판매액'
  FROM Orders AS o
 WHERE EXISTS (SELECT *
				 FROM Customer
				WHERE address LIKE '%대한민국%'
				  AND custid = o.custid);
                  
-- 추가 . 최신방법(서브쿼리에 두 가지 컬럼을 비교하는 법) - 튜플(Python과 동일)
-- 2010년 중반이후부터 사용 예상
SELECT *
  FROM Orders
 WHERE (custid, orderid) IN (SELECT custid, orderid
							   FROM Orders
							  WHERE custid = 2);


-- SELECT 서브쿼리
-- 4-17 : 고객별 판매액을 나타내시오.(고객이름과 고객별 판매액을 출력할것)
SELECT *
  FROM Orders;