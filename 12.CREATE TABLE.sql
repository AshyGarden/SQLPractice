/*
-NUMBER(2) -> 정수를 2자리까지 저장할수있는 숫자형 타입.
-NUMBER(5,2) -> 정수부, 실수부를 합친 총 자리수가 5, 소수점 2자리까지 저장할수있는 숫자형 타입.
-NUMBER ->괄호 생략시 (38, 0)으로 자동 지정

VARCHAR2(byte) -> 괄호안에 들어올 문자열의 최대 길이를 지정 (4000byte까지)
-CLOB -> 대용량 텍스트 데이터 타입 (최대 4GB)
-BLOB -> 이진형 대용량 객체(이미지, 파일 저장시 사용)
-DATE -> BC4712년 1월 1일 ~AD9999년 12월 31일까지 지정 가능
-시, 분, 초 지정가능
*/

--테이블 생성
CREATE TABLE dept2(
dept_no NUMBER(2),
dept_name VARCHAR2(14),
loca VARCHAR2(15),
dept_date DATE,
dept_bonus NUMBER(10)
);

DESC dept2;
SELECT * FROM dept2;

INSERT INTO dept2
VALUES(40, '영업부', '서울', sysdate, 2000000);

INSERT INTO dept2
VALUES(400, '경영지원', '서울', sysdate, 2000000);

--칼럼 추가
ALTER TABLE dept2
ADD (dept_count NUMBER(3));

--열이름 변경
ALTER TABLE dept2
RENAME COLUMN dept_count TO emp_count;

--열 속성 수정
--변경하고자 하는 컬럼에 데이터가 이미 존재한다면 그에 맞는 타입으로 변경해줘여한다.
ALTER TABLE dept2
MODIFY (emp_count NUMBER(4));

ALTER TABLE dept2
MODIFY (dept_name VARCHAR2(20));

--속성의 데이터 타입은 변경 불가! (맞지 않는 타입으로는 변경불가!)
ALTER TABLE dept2
MODIFY (dept_name NUMBER(20));

ALTER TABLE dept2
DROP COLUMN emp_count;

--테이블 이름 변경
ALTER TABLE dept2
RENAME TO dept3;

--테이블 데이터 전부 삭제(구조는 남기고 내부 데이터만 모두삭제)
TRUNCATE TABLE dept3;

--테이블 자체를 삭제
DROP TABLE dept3;


