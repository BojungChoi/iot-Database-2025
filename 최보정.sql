-- 문제1. 회원 테이블에서 이메일, 모바일, 이름, 주소 순으로 나오도록 검색하시오.(결과는 아래와 동일하게 나와야 하며, 전체 행의 개수는 31개입니다)

SELECT Email, Mobile, Names, Addr
  FROM membertbl;
  
  
-- 문제2. 함수를 사용하여 아래와 같은 결과가 나오도록 쿼리를 작성하시오.(전채 행의 개수는 59개입니다)

SELECT * FROM bookrentalshop.bookstbl;

SELECT Names AS 도서명
	 , Author AS 저자
     , ISBN
     , price AS 정가
  FROM bookstbl
 ORDER BY ISBN ;
	
-- 문제3. 다음과 같은 결과가 나오도록 SQL 문을 작성하시오.(책을 한번도 빌린적이 없는 회원을 뜻합니다. 18명이 나옵니다.)
SELECT * FROM membertbl;
SELECT * FROM rentaltbl;

SELECT A.Names 비대여자명, A.Levels 등급, A.Addr 주소, B.rentalDate 대여일
  FROM membertbl A
  LEFT JOIN rentaltbl B
    ON A.Idx = B.memberIdx
 WHERE rentaldate IS  NULL
 ORDER BY A.Levels , A.Names;

-- 문제4. 다음과 같은 결과가 나오도록 SQL 문을 작성하시오.

SELECT * FROM divtbl;
SELECT * FROM bookstbl;

SELECT  IFNULL(A.Names, '--합계--') AS 장르, CONCAT(FORMAT(SUM(B.Price), 0), '원') AS '총합계금액'
  FROM divtbl AS A
  JOIN bookstbl AS B
    ON A.Division = B.Division
    GROUP BY A.Names
	WITH ROLLUP;

  


