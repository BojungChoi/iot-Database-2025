-- 쿼리 3-1 : 모든 도서에 도서이름과 가격을 검색하세요.
SELECT bookname, price
  FROM Book;

-- 워크벤치에서 쿼리, 실행할 땐 편함
SELECT *
  FROM Book;
  
-- 3-2: 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
-- 파이썬, C#등 프로그래밍언어로 가져갈땐, 컬럼 이름 컬럼갯수를 모두 파악해야 하기때문에 아래와같이 사용
SELECT bookid,bookname,publisher,price
  FROM Book;
  
-- 3-3 : 도서 테이블의 모든 출판사를 검색하시오.
SELECT *
  FROM Book; -- 테이블을 all로 다불러들여오면, 컬럼을 작성할때 자동완성기능을 사용 할 수있다. (문장의 끝에서 씀)

-- 출판사별로 한번만 출력하면 좋겠음
-- ALL - 전부다, DISTINCT - 중복제거하고 하나만
SELECT DISTINCT publisher
  FROM Book;
  
-- 3-4 : 가격이 20000원 미만인 도서를 검색하시오.
-- > 미만, < 초과, >= 이하, <=이상, != 같지않다, = 같다(프로그래밍 언어와 차이) 
SELECT *
  FROM Book
 WHERE price < 20000 AND publisher = '굿스포츠';
 
 -- 3-5 : 가격이 10000원 이상, 20000원  이하인 도서를 검색하시오.
SELECT *
  FROM Book
 WHERE price >= 10000 AND price <= 20000;
 
SELECT *
  FROM Book
 WHERE price BETWEEN 10000 AND 20000; -- BETWEEN(<=이상,>=이하 포함 하여) 사이
 
 -- 3-6 : 출판사가 '굿스포츠'혹은'대한미디어'인 도서를 검색하시오.
SELECT *
  FROM Book
 WHERE publisher = '굿스포츠' OR publisher = '대한미디어';
 
 SELECT *
  FROM Book
 WHERE publisher IN('굿스포츠', '대한미디어');
 
-- 출판사가 '굿스포츠' 혹은 '대한미디어' 가 아닌 도서를 검색 시 
SELECT *
  FROM Book
 WHERE publisher NOT IN('굿스포츠', '대한미디어');

-- 3-7 : '축구의 역사'를 출간한 출판사를 검색하시오.
SELECT publisher
  FROM Book
 WHERE bookname = '축구의 역사';

SELECT publisher
  FROM Book
 WHERE bookname LIKE '축구의 역사';

-- 와일드 문자 종류
-- % : 갯수와 상관없이 글자가 포함되는 것 ex) %축구%  : 포함하는 문자열 (위치는 상관없이)
-- [^] : 1개의 문자와 불일치 : '[^0-5]%' : 0-5사이 숫자로 시작하지 않는 문자열
-- _ : 특정 위치에 있는 1개의 문자와 일치 '_구%' : 두 번째 위치에 '구'가 들어가는 문자열

-- [] : [] 은 MySQL에서는 사용불가 / Oracle, SQL Server 에서 사용 , 1개 문자와 일치 ex)'[0-5]%' : 0-5 사이 숫자로 시작하는 문자열

 -- 3-8 : 도서이름에 '축구'가 포함된 출판사를 검색하시오.
SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '%축구%';
 
 
-- 3-9 : 도서이름의 왼쪽 두번째 위치에 '구'라는 문자열을 갖는 도서를 검색하시오.

SELECT *
  FROM Book
 WHERE bookname LIKE '_구%';
 
 
-- 추가 : 고객중에서 전화번호가 없는 사람을 검색하시오.
SELECT *
  FROM Customer
 WHERE phone IS NULL; -- phone = null -> 이러면 X 
 
-- 반대로 phone 에서 null 이없는것 모두출력
SELECT *
  FROM Customer
 WHERE phone IS NOT NULL;
 
-- 3-10 : 축구에 관한 도서 중 가격이 20000원 이상인 도서를 검색하시오.
SELECT *
  FROM Book
 WHERE bookname LIKE '%축구%' AND price >= 20000;
 
-- 3-11 : 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오

SELECT *
  FROM Book
 WHERE publisher = '굿스포츠' OR publisher = '대한미디어';
 
-- 3-12 : 도서를 이름순(오름차순)으로 검색하시오.
-- ASC(ending) , DESC(ending)

SELECT *
  FROM Book
 ORDER BY bookname; -- ASC 는 기본이라서 오름차순인경우 안써도 됨.
 
-- 3-13 : 도서를 가격순으로 검색, 가격이같다면 이름순으로 검색.
 
 SELECT *
   FROM Book
  ORDER BY price,bookname; -- 순서 중요
  
-- 3-14 : 도서를 가격(내림차순)으로 검색, 가격이 같은경우 출판사를 오름차순으로 출력

SELECT *
  FROM Book
 -- ORDER BY price DESC, publisher ASC;
 ORDER BY price DESC, publisher;


