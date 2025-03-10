-- 데이터베이스 관리
SHOW DATABASES;

-- INFORMATION_SCHEMA, PERFORMANCE_SCHEMA, MYSQL 등은 시스템 DB 라서 개발자,DBA 사용하는게 아님
USE mysql;

-- 하나의 DB내 존재하는 테이블들 확인
SHOW TABLES;

-- 테이블의 구조
DESC madang.NewBook;


SELECT * FROM v_orders;

-- 사용자 추가
-- madang 데이터베이스만 접근할 수 있는 사용자 madang 생성
-- 내부접속용
CREATE USER madang@localhost IDENTIFIED BY 'madang';
-- 외부 접속용
CREATE USER madang@'%' IDENTIFIED BY 'madang';

-- DCL: grant, revoke
-- 데이터 삽입, 조회, 수정만 권한 부여
GRANT SELECT, INSERT, UPDATE ON madang.* to madang@localhost with GRANT OPTION;
GRANT SELECT, INSERT, UPDATE ON madang.* to madang@'%' with GRANT OPTION;

-- 사용자 Madang에게 mandangDB를 사용할 수 있는 모든 권한 부여
GRANT ALL PRIVILEGES ON madang.* to madang@localhost with GRANT OPTION;
GRANT ALL PRIVILEGES ON madang.* to madang@'%' with GRANT OPTION;
FLUSH PRIVILEGES;

-- 권한해제
-- madang 사용자의 권한중 select 권한만 제거
REVOKE SELECT ON madang.* from madang@localhost;

REVOKE ALL PRIVILEGES ON madang.* FROM madang@localhost;
REVOKE ALL PRIVILEGES ON madang.* FROM madang@'%';
