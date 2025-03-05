-- 7-1 : 계절학기 테이블
DROP TABLE IF EXISTS Summer; -- 기존 테이블이 존재 하면 삭제 

-- 계절학기 테이블 생성
CREATE TABLE Summer(
		 sid INTEGER,
	   class VARCHAR(20),
	   price INTEGER
);

--
SELECT * FROM Summer;


INSERT INTO Summer
VALUES (100, 'JAVA', 20000),
	   (150, 'PYTHON', 15000),
       (200, 'C', 10000),
	   (250, 'JAVA', 20000);
	   
SELECT * FROM Summer;

-- 계절학기 듣는 학생의 학번과 수강과목
SELECT sid
	 , class
  FROM Summer;
  
-- C 강좌 수강료는?
SELECT price
  FROM Summer
 WHERE class LIKE '%C%';

-- 수강료가 가장 비싼 과목은
SELECT DISTINCT(class)
  FROM Summer
WHERE price = (SELECT MAX(price)
				 FROM Summer);
                 
-- 계절학기 학생수와 수강료 총액
SELECT COUNT(*) AS '학생수'
	 , SUM(price) AS '수강료총액'
  FROM Summer;
  
/* 이상현상(Anomaly) */
-- 삭제이상
DELETE FROM Summer
 WHERE sid = 200;
 
/* c++ 강좌를 삽입 */
INSERT INTO Summer
VALUES (NULL, 'C++', 25000);

SELECT COUNT(*)
  FROM Summer;
  
SELECT COUNT(sid)
  FROM Summer;

SELECT COUNT(*) '수강인원'
  FROM Summer
 WHERE sid IS NOT NULL;
 
DELETE FROM Summer
 WHERE class LIKE 'C++';
 
 
/* 수정이상 */

UPDATE Summer
   SET price = 15000
 WHERE class = 'JAVA';
 
SELECT *
  FROM Summer;
  
DELETE FROM Summer;
  
SELECT DISTINCT price 'JAVA 수강료'
  FROM Summer 
 WHERE class LIKE 'JAVA';
 
 
 
 



