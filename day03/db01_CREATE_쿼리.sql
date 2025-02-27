-- 데이터베이스 생성
CREATE DATABASE sample;

-- DB생성(CharSet, Collation 지정)
CREATE DATABASE sample2
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- DB 변경
ALTER DATABASE sample
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- 데이터베이스 삭제
-- 운영DB에서 실행하면 퇴사각
DROP DATABASE sample;

-- 테이블 생성
-- 3-34 NewBook 테이블 생성하시오. 정수형은 Integer 사용, 문자형은 가변형인 Varchar 를 사용하시오.

-- 기본키를 설정합니다. 방법)1
-- 기본키 두개 이상인경우 아래와같이 작성.
CREATE TABLE NewBook (
	bookId 		INTEGER,
    bookname	VARCHAR(255),
    publisher	VARCHAR(50),
    price		INTEGER,
    PRIMARY KEY		(bookid,publisher)
);

-- 기본키작성 방법2) , 기본키가 하나면 컬럼 하나에 작성 가능. BUT 기본키가 2개이상인경우에는
-- 컬럼에 PRIMARY KEY 두군데 이상 작성 불가.
CREATE TABLE NewBook (
	bookId 		INTEGER PRIMARY KEY,
    bookname	VARCHAR(255),
    publisher	VARCHAR(50),
    price		INTEGER
);

DROP TABLE NewBook;

-- 테이블 생성시, 제약조건을 추가가능
-- 조건1)bookname은 NULL을 가질 수 없고, publisher는 같은값이 있으면 안된다.
-- 조건2)price는 값이 입력되지 않는 경우 기본값인 만원을 넣는다.
-- 조건3)최소가격은 1000원이상으로한다.
CREATE TABLE NewBook(
	bookId		INTEGER ,
    bookName 	VARCHAR(255) NOT NULL,
    publisher	VARCHAR(50) UNIQUE,
    price		INTEGER		DEFAULT 10000 CHECK (price >= 10000),
    PRIMARY KEY		(bookId)
);

-- 3-35 아래 속성의 NewCustomer 테이블을 생성하시오
-- custid - INTEGER, 기본키
-- name - VARCHAR(100) NOT NULL
-- address - VARCHAR(255) NOT NULL
-- phone - VARCHAR(30) NOT NULL
CREATE TABLE NewCustomer(
	custid		INTEGER PRIMARY KEY,
    name		VARCHAR(100) NOT NULL,
    address		VARCHAR(255) NOT NULL,
    phone		VARCHAR(30) NOT NULL
);


-- 3-36 다음과 같은 속성의 NewOrders를 생성하시오.
-- orderis - INTEGER, PRIMARY KEY
-- bookid - INTEGER, NOT NULL, FORIEGNKEY (NewBook booid)
-- custid - INTEGER, NOT NULL, FK(NewCustomer custid)
-- saleprice - INTEGER
-- orderdate - date
CREATE TABLE NewOrders(
	orderid 	INTEGER ,
    bookid		INTEGER NOT NULL,
    custid  	INTEGER NOT NULL,
    saleprice 	INTEGER,
    orderdate	DATE,
    PRIMARY KEY (orderid),
    FOREIGN KEY (bookid) REFERENCES NewBook(bookid) ON DELETE CASCADE,
    FOREIGN KEY (custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE
);

-- ALTER
-- 3-37 NewBook 테이블에서 VARCHAR(13)의 isbn 속성을 추가하시오.
ALTER TABLE NewBook ADD isbn VARCHAR(13);

-- 3-38 NewBook에 isbn 데이터타입을 INTEGER로 변경하시오.
ALTER TABLE NewBook MODIFY isbn INTEGER;

-- 3-38 NewBook에 publisher 의 제약사항을 NOT NULL로 변경합니다.
ALTER TABLE NewBook MODIFY publisher VARCHAR(100) NOT NULL;

-- DROP(조심, 조심)
-- 3-42 NewBook 테이블 삭제하시오.
-- 관계에서 부모테이블은 자식테이블을 지우기전에 삭제 할 수 없음!!
DROP TABLE NewBook;
DROP TABLE NewOrders;
