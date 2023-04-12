SELECT * FROM employees;
--where절 비교(데이터 값은 대소문자 비교함!)
SELECT first_name, last_name, job_id
FROM employees
WHERE job_id='IT_PROG'; --소문자로 적으면 안나옴!

SELECT * FROM employees
WHERE last_name='King';

SELECT * FROM employees
WHERE department_id=90;

SELECT * FROM employees
WHERE salary >=15000;

SELECT * FROM employees
WHERE hire_date ='04/01/30';

--데이터 행 제한(BETWEEN, IN, LIKE)
SELECT * FROM employees
WHERE salary BETWEEN 15000 AND 20000;

SELECT * FROM employees
WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';

--in연산자의 사용(특정값들과 비교시 사용)
SELECT * FROM employees
WHERE manager_id IN (100,101,102);

SELECT * FROM employees
WHERE job_id IN ('IT_PROG','AD_VP');

--LIKE 연산자

SELECT first_name, hire_date FROM employees
WHERE hire_date LIKE '03%';--이런 형태와 같다면~(%)

SELECT first_name, hire_date FROM employees
WHERE hire_date LIKE '%15'; --뒤만 15로 끝나면 조회

SELECT first_name, hire_date FROM employees
WHERE hire_date LIKE '%05%'; --05가 들어가있으면 조회

SELECT first_name, hire_date FROM employees
WHERE hire_date LIKE '____05%'; --앞에 4칸 공백후 05들어가있으면 조회

--IS NULL(NULL값을 찾기)
SELECT * FROM employees
WHERE manager_id IS NULL; -- =으로는 안됨 무조건 IS NULL

SELECT * FROM employees
WHERE commission_pct IS NULL; 

SELECT * FROM employees
WHERE commission_pct IS NOT NULL; 

--AND, OR
--AND가 OR보다 연산순서가 빠름.

SELECT * FROM employees
WHERE job_id = 'IT_PROG'
OR job_id = 'FI_MGR'
AND salary >=6000; --이상한 값 출현(and가 먼저 연산!)

SELECT * FROM employees
WHERE (job_id = 'IT_PROG'
OR job_id = 'FI_MGR') --괄호를 이용하여 연산을 보호
AND salary >=6000;

--데이터의 정렬(SELECT구문의 가장 마지막에 배치)
--ASC:ascending(오름차순)
--DESC:descending(내림차순)
SELECT * FROM employees
ORDER BY hire_date ASC;

SELECT * FROM employees
ORDER BY hire_date DESC;

SELECT * FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name ASC;

SELECT * FROM employees --From 1번
WHERE salary>=8000 --정렬 3번
ORDER BY employee_id ASC; --조회2번

SELECT first_name, salary*12 AS pay 
FROM employees
ORDER BY pay ASC;