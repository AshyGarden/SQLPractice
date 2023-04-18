--조인이란? 
--서로 다른 테이블 간에 설정된 관계가 결합하여 
--1개 이상의 테이블에서 데이터를 조회하기위해 사용 

--SELECT 컬럼리스트 FROM 조인대사잉되는 테이블 1개이상 WHERE 조인조건 ->오라클 조인 표준


--employees 테이블 부서id와 일치하는 department테이블 부서id를 찾아서 
--SELECT이하에 있는 컬럼들을 출력하는 쿼리문

--ORACLE문법
SELECT
    first_name,
    last_name,
    hire_date,
    salary,
    job_id,
    department_name, 
--department_id--모호함(아이디컬럼이 양쪽에 모두있음)
    e.department_id--지정해줘야함
FROM
    employees   e,
    departments d --FROM에선 AS생략가능
WHERE
    e.department_id = d.department_id; --조인조건(조인조건인지 일반조건인지 헷갈림)


--ANSI문법(추천)
SELECT
    first_name,
    last_name,
    hire_date,
    salary,
    job_id,
    department_name,
    e.department_id
FROM
         employees e --테이블
    INNER JOIN departments d --조인할 테이블
     ON e.department_id = d.department_id;--조인조건

/*
각각의 테이블에 독립적으로 존재하는 컬럼의 경우에는 테이블 이름 생략가능
그러나 해석의 명확성을 위해 테이블 이름 작성해서 소속을 알려주는 것을 권장.
테이블 이름이 너무길면 ALIAS작성
두테이블 모두 가지고 있는 컬럼의 경우 반드시 명시!
*/

--3개의 테이블을 이용한 내부조인(INNER JOIN)
--내부조인: 두 테이블 모두에서 일치하는 값을 가진 행만 반환(조간에 안맞으면 가져오지 않음)
SELECT
    e.first_name,
    e.last_name,
    e.department_id,
    d.department_name,
    j.job_title
FROM
    employees   e,
    departments d,
    jobs        j
WHERE
        e.department_id = d.department_id
    AND e.job_id = j.job_id;

SELECT
e.first_name, e.last_name,
d.department_id, d.department_name,
j.job_title,
loc.city
FROM
employees e,
departments d,
jobs j,
locations loc
WHERE
e.department_id = d.department_id  --실행3
AND
e.job_id = j.job_id                --실행4
AND
d.location_id = loc.location_id    --실행2
AND
loc.state_province = 'California'; --실행1

/*
1.loc테이블의 province = = 'California'조건에 부합하는 값을 대상으로
2.location_id값과 같은 값을 가지는 데이터를 departments에서 찾아서 조인
3.위 결과와 동일한 department_id를 가진 employees테이블의 데이터를 찾아서 조인
4.위 결과와 jobs테이블을 비교하여 조인하고 최종 결과를 출력.
*/

--외부조인 (OUTER JOIN)
/*상호테이블간에 일치되는 값으로 연결되는 내부조인과는 다르게
어느한 테이블에 공통값이 없더라도 해당 row들이 조회 결과에 모두 포함되는 조인
*/
SELECT
    first_name, last_name,
    hire_date, salary,
    job_id, department_name, e.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id(+); --기준테이블(+가 붙지 않은 employees)

SELECT
    first_name, last_name,
    hire_date, salary,
    job_id, department_name, e.department_id
FROM employees e, departments d, locations loc
WHERE e.department_id = d.department_id(+)
AND d.location_id = loc.location_id;
/*
employees테이블에는 존재하고 departments테이블에는 존재하지않아도 
(+)가 붙지않은 테이블을 기준으로하여 departments테이블이 조인에  참여하라는 의미를 붙이기위해 기호추가
외부조인 사용했더라도 이후 내부조인 사용시 내부 조인이 우선인식됨.
*/

--외부 조인 진행시 모든조건에 \(+)fmf qnxdudi dhlqnwhdlsdl dbwlehla
--일반 조건에도 (+)를 붙이지 않으면 외부조인이 풀리는 현상이 발생(데이터 누락됨)
SELECT
e.employee_id, e.first_name,
e.department_id, 
j.start_date,
j.end_date,
j.job_id
FROM employees e, job_history j
WHERE e.employee_id = j.employee_id(+)
AND j.department_id(+) = 80;