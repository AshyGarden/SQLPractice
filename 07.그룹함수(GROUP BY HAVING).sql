--그룹함수 AVG, MAX, MIN, SUM, COUNT
SELECT
AVG(salary),
MAX(salary),
MIN(salary),
SUM(salary),
COUNT(salary)
FROM employees;

SELECT COUNT(*) FROM employees; --총 행 데이터의 수
SELECT COUNT(first_name) FROM employees;
SELECT COUNT(commission_pct) FROM employees;
SELECT COUNT(manager_id) FROM employees;

--부서별로 그룹화 
SELECT
department_id,
AVG(salary)
FROM employees
GROUP BY department_id;

--주의할점 그룹함수는 일반 컬럼과 동시에 출력 불가!
SELECT
department_id,
AVG(salary)
FROM employees;--에러

--GROUP BY절 사용시 GROUP에 묶이지 않으면 다른 컬럼 조회 불가
SELECT
job_id,       
department_id,
AVG(salary)
FROM employees
GROUP BY department_id;--에러

SELECT
job_id,       
department_id,
AVG(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

--GROUP by를 통해 그룹화시 조건을 걸떄 HAVING을 사용
SELECT      
department_id,
AVG(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) >100000;

SELECT      
job_id,
COUNT(*)
FROM employees
GROUP BY job_id
HAVING COUNT(*) >=5;

--부서 아이디가 50이상(그룹화전-where) 그룹화+(그룹화후-having)그룹 월급평균이 5000 이상만 조회
SELECT                        --실행5
department_id,
AVG(salary) As 평균
FROM employees                --실행1 
WHERE department_id >= 50     --실행2
GROUP BY department_id        --실행3
HAVING avg(salary) >=5000     --실행4
ORDER BY department_id DESC;  --실행6

/*


*/


--문제 1. 사원 테이블에서 JOB_ID별 사원 수를 구하세요.
--1-1사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요
SELECT job_id, COUNT(job_id), salary
FROM employees
GROUP BY job_id, salary   
HAVING avg(salary) >=5000
ORDER BY avg(salary) DESC;

--FM1 1.
SELECT job_id, COUNT(*) AS 사원수
FROM employees
GROUP BY job_id;

--FM1-1
SELECT 
job_id, 
avg(salary) AS 평균월급
FROM employees
GROUP BY job_id
ORDER BY 평균월급 DESC;

--문제 2. 사원 테이블에서 입사 년도 별 사원 수를 구하세요.(TOCHAR를 이용해서 연도만 반환+그룹화)
SELECT TO_CHAR(hire_date,'YYYY') AS CrewCount, COUNT(TO_CHAR(hire_date,'YYYY'))
FROM employees
GROUP BY TO_CHAR(hire_date,'YYYY');
--FM2
SELECT 
TO_CHAR(hire_date,'YY') AS CrewCount, 
COUNT(*)
FROM employees
GROUP BY TO_CHAR(hire_date,'YY');

--문제 3. 급여가 1000 이상인 사원들의 부서별 평균 급여를 출력하세요. 단 부서 평균 급여가 7000이상인 부서만 출력
SELECT department_id, TRUNC(avg(salary),2)
FROM employees 
WHERE salary >= 1000
GROUP BY department_id
HAVING avg(salary)>2000;

--FM3
SELECT 
department_id, TRUNC(avg(salary),2) AS 평균급여
FROM employees 
WHERE salary >= 5000
GROUP BY department_id
HAVING avg(salary)>2000;

--문제 4.
--사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
--department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
--조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
--조건 2) 평균은 소수 2째 자리에서 절삭 하세요

SELECT department_id, TRUNC(avg(salary),2), count(department_id),SUM(salary)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
ORDER BY department_id ASC;

--FM4
SELECT 
department_id, 
TRUNC(avg(salary+(salary*commission_pct)) ,2), 
SUM(salary +salary*commission_pct),count(*)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;