-- 행번호
-- 4-11 : 고객 목록에서 고객번호, 이름, 전화번호를 앞 2명만 출력하시오.
SET @seq := 0; -- 변수 선언 SET시작하고 @를 붙임. 값할당이 =이 아니고 :=

SELECT (@seq := @seq + 1) AS '행번호'
	 , custid
	 , name
     , phone
  FROM Customer
 WHERE @seq < 2;
 
-- 다른방법
SELECT custid 행번호
	 , name
     , phone
  FROM Customer LIMIT 2; -- 순차적 일부데이터 추출에는 훨씬 탁월
  
-- 특정 범위 추출 OFFSET(3번째) 다음행부터 LIMIT(2개)를 추출
SELECT custid
	 , name
     , phone
  FROM Customer LIMIT 2 OFFSET 3;
