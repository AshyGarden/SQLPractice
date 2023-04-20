
/*
VIEW는 제한적인 자료만 보기위해 사용하는 가상 테이블의 개념이다.
VIEW는 기본테이블로 유도된 가상 테이블이기 때문에 필요한 컬럼만 저장해두면 관리가 용이해짐 
VIEW는 가상테이블로 실제데이터가 물리적으로 저장된 형태는 아니다.
VIEW를 통해서 데이터에 접근하면 원본데이터는 안전하게 보호될수 있다.
*/

SELECT * FROM user_sys_privs; --유저권한 확인

--단순 VIEW
--VIEW의 컬럼이름은 함수같은 가상표현식을 사용불가.
SELECT 
       employee_id,
       first_name||' '||last_name AS name,
       job_id,
       salary
FROM employees
WHERE department_id = 60;


--VIEW생성
CREATE VIEW view_emp AS{
SELECT 
       employee_id,
       first_name||' '||last_name , --ERROR 컬럼명이 너무 지저분함!
       job_id,
       salary
FROM employees
WHERE department_id = 60
};

CREATE VIEW view_emp AS(
SELECT 
       employee_id,
       first_name|| ' ' ||last_name AS name, --Alias
       job_id,
       salary
FROM employees
WHERE department_id = 60
);

--복합 뷰
--여러 테이블을 조인하여 필요한 데이터만 저장하고 빠른 확인을 위해 사용
CREATE VIEW view_emp_dept_jobs AS(
SELECT 
       e.employee_id,
       e.first_name|| ' ' ||e.last_name AS name, --Alias
       d.department_name,
       j.job_title
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
LEFT JOIN jobs j
ON e.job_id = j.job_id
) ORDER BY employee_id ASC;

SELECT * FROM view_emp_dept_jobs;

--뷰의 수정(CREATE OR REPLACE VIEW)
--동일 이름으로 해당구문을 사용시 데이터가 변경되면서 새롭게 생성
CREATE OR REPLACE VIEW view_emp_dept_jobs AS(
SELECT 
       e.employee_id,
       e.first_name|| ' ' ||e.last_name AS name, --Alias
       d.department_name,
       j.job_title,
       e.salary --추가
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
LEFT JOIN jobs j
ON e.job_id = j.job_id
) ORDER BY e.employee_id ASC;

SELECT
    job_title,
    AVG(salary)
FROM view_emp_dept_jobs
GROUP BY job_title
ORDER BY AVG(salary) DESC; -- SQL 구문이 확실히 짧아짐.

-- 뷰 삭제
DROP VIEW view_emp;

/*
VIEW에 INSERT가 일어나는경우 실제 테이블에도 반영해야함
VIEW의INSERT, UPDATE, DELETE는 많은 제약이 따름
원본 테이블이 NT NULL인경우 VIEW에서 INSERT 불가능!
VIEW에서 사용하는 컬럼이 가상일 경우에도 안됨.*/

-- 두 번째 컬럼인 'name'은 가상열(virtual column)이기 때문에 INSERT 안 됩니다.
INSERT INTO view_emp_dept_jobs
VALUES(300, 'test', 'test', 'test', 10000);

-- JOIN된 뷰의 경우 한 번에 수정할 수 없습니다.
INSERT INTO view_emp_dept_jobs
(employee_id, department_name, job_title, salary)
VALUES(300, 'test', 'test', 10000);

-- 원본 테이블의 null을 허용하지 않는 컬럼 때문에 들어갈 수 없습니다.
INSERT INTO view_emp
(employee_id, job_id, salary)
VALUES(300, 'test', 10000);

-- WITH CHECK OPTION -> 조건 제약 컬럼
-- 조건에 사용되어진 컬럼값은 뷰를 통해서 변경할 수 없게 해주는 키워드
CREATE OR REPLACE VIEW view_emp_test AS(
SELECT
    employee_id,
    first_name,
    last_name,
    email,
    hire_date,
    job_id,
    department_id
FROM employees
WHERE department_id = 60
)WITH CHECK OPTION CONSTRAINT view_emp_test_ck; -- 체크옵션 이름

SELECT * FROM view_emp_test;

UPDATE view_emp_test
SET department_id = 60
WHERE employee_id = 105;

-- 읽기 전용 VIEW -> WITH READ ONLY 연산을 막음 ->SELECT만 허용!
CREATE OR REPLACE VIEW view_emp_test AS(
SELECT
    employee_id,
    first_name,
    last_name,
    email,
    hire_date,
    job_id,
    department_id
FROM employees
WHERE department_id = 60
) WITH READ ONLY; --읽기 전용VIEW

UPDATE view_emp_test 
SET job_id = 'test'
WHERE employee_id = 105;
--결과: cannot perform a DML operation on a read-only view


