/*문제 1.
-EMPLOYEES 테이블과, DEPARTMENTS 테이블은 DEPARTMENT_ID로 연결되어 있습니다.
-EMPLOYEES, DEPARTMENTS 테이블을 엘리어스를 이용해서
각각 INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER 조인 하세요. (달라지는 행의 개수 확인)*/

--Inner
SELECT *
From employees e 
INNER JOIN departments d 
ON e.department_id = d.department_id; --106개

--L-Outer
SELECT *
From employees e 
LEFT OUTER JOIN departments d 
ON e.department_id = d.department_id; --107개

--R-Outer
SELECT *
From employees e 
RIGHT OUTER JOIN departments d 
ON e.department_id = d.department_id; --122개

--Full outer
SELECT *
From employees e 
FULL OUTER JOIN departments d 
ON e.department_id = d.department_id; --123개

/* 문제 2.
-EMPLOYEES, DEPARTMENTS 테이블을 INNER JOIN하세요
조건)employee_id가 200인 사람의 이름, department_id를 출력하세요
조건)이름 컬럼은 first_name과 last_name을 합쳐서 출력합니다.*/
SELECT first_name||' '||last_name AS name, d.department_id
From employees e 
JOIN departments d 
ON e.department_id = d.department_id
WHERE e.employee_id = 200;

/*
문제 3.
-EMPLOYEES, JOBS테이블을 INNER JOIN하세요
조건) 모든 사원의 이름과 직무아이디, 직무 타이틀을 출력하고, 이름 기준으로 오름차순 정렬
HINT) 어떤 컬럼으로 서로 연결되 있는지 확인*/
SELECT first_name||' '||last_name AS name, j.job_id, j.job_title
From employees e INNER JOIN jobs j 
ON e.job_id = j.job_id
ORDER BY e.first_name ASC;

--문제 4.
--JOBS테이블과 JOB_HISTORY테이블을 LEFT_OUTER JOIN 하세요.
SELECT * 
FROM jobs j LEFT OUTER JOIN job_history h
ON j.job_id = h.job_id;

--문제 5.
--Steven King의 부서명을 출력하세요.
SELECT department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id 
WHERE first_name = InitCap('steven') AND last_name = InitCap('king');

--FM
SELECT first_name||' '||last_name AS name, department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id 
WHERE e.first_name = 'Steven' AND e.last_name = 'King';

--문제 6.
--EMPLOYEES 테이블과 DEPARTMENTS 테이블을 Cartesian Product(Cross join)처리하세요
SELECT COUNT(*) FROM employees e CROSS JOIN departments d;

--문제 7.
--EMPLOYEES 테이블과 DEPARTMENTS 테이블의 부서번호를 조인하고 
--SA_MAN 사원만의 사원번호, 이름, 급여, 부서명, 근무지를 출력하세요. (Alias를 사용) 3중조인

SELECT e.employee_id, e.first_name||' '||e.last_name AS name, e.salary, d.department_name, l.city 
FROM employees e, departments d, locations l
WHERE e.job_id LIKE 'SA_MAN' AND e.department_id = d.department_id AND d.location_id = l.location_id;

--FM
SELECT e.employee_id, e.first_name||' '||e.last_name AS name, e.salary, d.department_name, l.city 
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE e.job_id = 'SA_MAN';

--문제 8.
-- employees, jobs 테이블을 조인 지정하고 
--job_title이 'Stock Manager', 'Stock Clerk'인 직원 정보만출력하세요.
SELECT *
FROM employees e JOIN jobs j
On e.job_id = j.job_id
WHERE j.job_title =  'Stock Manager' OR j.job_title = 'Stock Clerk';
--WHERE j.job_title IN('Stock Manager', 'Stock Clerk');

--문제 9.
-- departments 테이블에서 직원이 없는 부서를 찾아 출력하세요. LEFT OUTER JOIN 사용
SELECT d.department_name
FROM departments d
LEFT OUTER JOIN employees e
ON e.department_id = d.department_id 
WHERE e.employee_id IS NULL;

--문제 10. 
--join을 이용해서 사원의 이름과 그 사원의 매니저 이름을 출력하세요힌트) EMPLOYEES 테이블과 EMPLOYEES 테이블을 조인하세요.
SELECT
e1.first_name AS name, e2.first_name AS ManagerName
FROM employees e1
JOIN employees e2
ON e1.manager_id = e2.employee_id
WHERE e1.manager_id Is NOT NULL;

--문제 11. 
--6. EMPLOYEES 테이블에서 left join하여 관리자(매니저)와, 매니저의 이름, 매니저의 급여 까지 출력하세요
--매니저 아이디가 없는 사람은 배제하고 급여는 역순으로 출력하세요
SELECT e1.manager_id, e2.first_name||' '||e2.last_name AS ManagerName, e2.salary
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.employee_id
WHERE e1.manager_id IS NOT NULL
ORDER BY salary DESC;
