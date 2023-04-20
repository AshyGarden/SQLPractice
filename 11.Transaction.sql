SELECT * FROM emps;

INSERT INTO emps
(employee_id, last_name, email,hire_date, job_id)
VALUES
(303, 'kim', 'abc123@naver.com', sysdate, 1800);

--보류중인 모든 데이터 변경사항을 취소(폐기), 직전 커밋 단계로 회귀(돌아가기) 및 트랜잭션 종료
ROLLBACK;

--세이브포인트
--롤백할 포인트를 직접 이름을 붙여서 생성
--ANSI표준문법이 아닌 ORACLE만의 문법! = 권장하지 않음.
SAVEPOINT insert_kim;
ROLLBACK TO SAVEPOINT insert_kim;

--보류중인 모든 데이터 변경사항을 영구적으로 적용하면서 트랜잭션 종료
--커밋 이후에는 어떠한 방법을 사용하더라도 되돌릴수없다.
COMMIT;

--오토커밋여부 확인
SHOW AUTOCOMMIT; --오토커밋 여부 확인
SET AUTOCOMMIT ON; -- 오토커밋 ON
SET AUTOCOMMIT OFF; -- 오토커밋 OFF

DELETE FROM emps WHERE employee_id =303;