--insert
--테이블 구조 확인
DESC departments; --Describe

--INSERT 1번째 방법 = 모든 데이터를 한 번에 저장하기
INSERT INTO departments
VALUES(290, '영업부',100, 2300); 
--컬럼을 따로 지정하지 않으면 순서대로 들어감.

SELECT * FROM departments;
ROLLBACK; --실행 시점을 다시 뒤로 되돌리기

INSERT INTO departments
VALUES(290, '영업부'); 

--2번째 방법 (직접 컬럼을 지정하고 저장, NOT NULL확인!)
INSERT INTO departments
       (department_id, department_name)
VALUES
       (290, '영업부'); 
       
INSERT INTO departments
       (department_id, location_id)
VALUES
       (280, 1700);
       
INSERT INTO departments
       (department_id, department_name, location_id)
VALUES
       (280,'개발자', 1700);       
       
       
--사본 테이블 생성(CTAS)
--사본 테이블 생성시 그냥 생성하면 조회된 데이터를 복사한다.
--그러나 WHERE절에 (1=2) FALSE값을 지정하면=>테이블 구조만 복사하고 데이터는 복사하지 않는다.
CREATE TABLE managers AS 
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE 1=2);

SELECT * FROM managers;
DROP TABLE managers;

--INSERT(서브쿼리)
INSERT INTO managers
(SELECT employee_id, first_name, job_id, hire_date
FROM employees);

--UPDATE
CREATE TABLE emps AS (SELECT *FROM employees);
SELECT * FROM emps;

/*
CTAS를 사용하면, 테이블 제약조건이 NOT NULL말고는 복사되지 않는다!
제약조건은 업무 규칙을 지키는 데이터만 저장하고 
그렇지 않은 것들이 DB에 저장되는 것을 방지하는 목적으로 사용
*/
--UPDATE를 진행할 때 대상을 잘 지목해주어야한다.
--지목하지 않으면 수정 대상이 테이블 전체로 지목된다.
UPDATE emps SET salary = 3000; --전 테이블이 변경
SELECT * FROM emps;
ROLLBACK;

UPDATE emps SET salary = 3000 
WHERE employee_id =100;

UPDATE emps SET salary = salary + salary * 0.1
WHERE employee_id =100;
/*
UPDATE myboard SET hit = hit +1
WHERE board_id = 30; --게시판 조회수 증가 로직
*/

UPDATE emps SET 
phone_number = '010.1234.5678', manager_id = 102
WHERE employee_id =100;

--UPDATE(서브쿼리)
UPDATE emps
    SET (job_id, salary, manager_id) = 
   (SELECT job_id, salary, manager_id
    FROM emps
    WHERE employee_id = 100) --100번의 job_id, salary, manager_id를 조회
WHERE employee_id = 101; --101번에게도 그것을 적용!

SELECT * FROM emps;
ROLLBACK;

--DELETE
DELETE FROM emps
WHERE employee_id = 103;

--사본 테이블 생성
CREATE TABLE depts AS (SELECT * FROM departments);
SELECT * FROM depts;

--DELETE(서브쿼리)
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM depts
                       WHERE department_id = 100);
                       
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM depts
                       WHERE department_name = 'IT');
                       

