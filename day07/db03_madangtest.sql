-- SELECT , INSERT, UPDATE 만 권한을 준 madang으로 테스트
insert into Bank values ('손흥민', 30000000);

select * from Bank;

update Bank Set
	balance = balance + 300000;
    
delete from Bank where name = '손흥민';