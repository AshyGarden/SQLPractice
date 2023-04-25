
/*
TRIGGER는 테이블에 부탁된 형태로 
INSERT,UPDATE,DELETE작업이 수행될때
특정코드가 작동되도록 하는 구문
VIEW에는 부착 불가능!

트리거를 만들때 범위지정하고 F5버튼으로 부분실행 해야한다.
그렇지 않으면 하나의 구문으로 인식되어 정상동작하지 않는다.
*/

CREATE TABLE tbl_test(
id NUMBER(10),
text VARCHAR2(20)
);

CREATE OR REPLACE TRIGGER trig_test --괄호,콤마(,)붙이지않음
    AFTER DELETE OR UPDATE --트리거의 발생시점(삭제 or 수정 이후에 동작)
    ON tbl_test -- 트리거를 부착할 테이블
    FOR EACH ROW -- 각 행에 모두 적용(생략가능, 생략시 1번만 실행!)
--DECLARE 생략가능!
BEGIN
    dbms_output.put_line('트리거 발동!'); --실행하고자 하는 코드를 begin~end사이에 넣기
END;


INSERT INTO tbl_test VALUES(1,'김철수'); --TRIGGER동작 x
UPDATE tbl_test SET text = '김뽀삐' WHERE id =1;
DELETE FROM tbl_test WHERE id =1;


