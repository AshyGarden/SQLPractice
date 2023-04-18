--형변환 함수 TO_CHAR, TO_NUMBER, TO_DATE
--날짜는 문자로 TO_CHAR(값,형식)
SELECT
    sysdate
FROM
    dual;

SELECT
    to_char(sysdate, 'YYYY-MM-DDHH:MI:SS')
FROM
    dual;

SELECT
    to_char(sysdate, 'YYYY-MM-DD DAY PM HH:MI:SS')
FROM
    dual;

SELECT
    to_char(sysdate, 'YY-MM-HH24:MI:SS')
FROM
    dual;
--모두 문자처리
SELECT
    first_name,
    to_char(hire_date, 'YYYY"년" MM"월" DD"일"')
FROM
    employees;

--숫자를 문자로 TO_CHAR(값, 형식)(숫자 9는 자릿수표현)
SELECT
    to_char(20000, '99999')
FROM
    dual;
--주어진 자리수에 모두 표기 할수 없다면 모두 #으로 표기됨.
SELECT
    to_char(20000, '9999')
FROM
    dual;

SELECT
    to_char(20000.26, '99999.9')
FROM
    dual; --반올림도 처리해줌
SELECT
    to_char(20000, '99,999')
FROM
    dual;

SELECT
    to_char(salary, '99,999') AS salary
FROM
    employees;

SELECT
    to_char(salary, 'L99,999') AS salary --숫자 앞에 L붙이면 사용국가의 화폐단위를 붙여줌
FROM
    employees;

--문자를 숫자로 TO_NUMBER(값, 형식)
SELECT
    '2000' + 2000
FROM
    dual; --자동 형 변환(문자->숫자)
SELECT
    TO_NUMBER('2000') + 2000
FROM
    dual; --명시적 형 변환
SELECT
    '$3,300' + 2000
FROM
    dual;--에러
SELECT
    TO_NUMBER('$3,300', '$9,999') + 2000
FROM
    dual;--형식을 선언

--문자를 날짜로 변환하는 함수 TO_DATE(값, 형식)
SELECT
    TO_DATE('2023-04-13')
FROM
    dual;

SELECT
    sysdate - '2023-04-13'
FROM
    dual; --에러(날짜같은 문자열)
SELECT
    sysdate - TO_DATE('2023-04-13')
FROM
    dual;

SELECT
    TO_DATE('2020/12/25', 'YY-MM-DD')
FROM
    dual;

SELECT
    TO_DATE('2020-12-25 12:13:50', 'YY-MM-DD')
FROM
    dual; 
-- 시간을 바꾸는 형식지정 안해주므로 에러(모두 변환해줘야함!)모두 변환해줘야함!
SELECT
    TO_DATE('2020-12-25 12:13:50', 'YY-MM-DD HH:MI:SS')
FROM
    dual;

SELECT
    '20050102'
FROM
    dual;
--문자->날짜 변환->문자로 다시변환
SELECT
    to_char(TO_DATE('20050102', 'YYYY/MM/DD'), 'YYYY"년" MM"년" DD"일"') AS dateinfo
FROM
    dual;

--NULL 제거함수 NVL(칼럼, 변환할 타겟값)
SELECT
    NULL
FROM
    dual;

SELECT
    nvl(NULL, 0)
FROM
    dual;

SELECT
    first_name,
    nvl(commission_pct, 0) AS comm_pct
FROM
    employees;

--NULL 제거함수 NVL2(칼럼, null이 아닐 경우 값, null일 경우의 값)
SELECT
    nvl2('abc', '널 아님!', '널 임')
FROM
    dual;

SELECT
    nvl2(NULL, '널 아님!', '널 임')
FROM
    dual;

SELECT
    first_name,
    nvl2(commission_pct, 'true', 'false') AS comm_pct
FROM
    employees;

SELECT
first_name, 
NVL2(commission_pct, salary + (salary * commission_pct),salary) AS real_salary 
FROM employees;

--DECODE(컬럼 혹은 표현식, 항목1, 결과1, 항목2, 결과2 ...default);
SELECT
DECODE('F','A','A입니다','B','B입니다','C','C입니다','D','D입니다','모르겠는데요?')
FROM dual;


SELECT
job_id,
salary,
DECODE(job_id,
'IT_PROG',salary*1.1,
'FT_MGR',salary*1.2,
'AD_VP',salary*1.3,
salary)AS result
FROM employees;

--CASE WHEN THEN END
SELECT 
first_name,
job_id,
salary,
(CASE job_id
WHEN'IT_PROG' THEN salary*1.1
WHEN'FT_MGR' THEN salary*1.2
WHEN'AD_VP' THEN salary*1.3
ELSE salary END)AS result
FROM employees;
/*
문제 1.
현재일자를 기준으로 EMPLOYEE테이블의 입사일자(hire_date)를 참조해서 근속년수가 17년 이상인
사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요. 
조건 1) 근속년수가 높은 사원 순서대로 결과가 나오도록 합니다*/    
SELECT
employee_id AS 사원번호,
first_name||' '||last_name AS 사원명,
hire_date AS 입사일자,
Round((sysdate - hire_date)/365) AS 근속년수
FROM employees
WHERE Round((sysdate - hire_date)/365)>=17 --'근속년수'>17 --여기는 근속년수 안됨(진행순서 FROM-WHERE-SELECT-ORDER)
ORDER BY Round((sysdate - hire_date)/365) DESC; --여기는 근속년수 가능
    
--FM
SELECT
employee_id AS 사원번호,
CONCAT(first_name,last_name) AS 사원명,
hire_date AS 입사일자,
TRUNC((sysdate - hire_date)/365) AS 근속년수
FROM employees
WHERE (sysdate - hire_date) / 365 >= 17 --'근속년수'>17
ORDER BY 근속년수 DESC;
/*
문제 2.
EMPLOYEE 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
100이라면 ‘사원’, 
120이라면 ‘주임’
121이라면 ‘대리’
122라면 ‘과장’
나머지는 ‘임원’ 으로 출력합니다.
조건 1) manager_id가 50인 사람들을 대상으로만 조회합니다
*/

SELECT 
first_name||' '||last_name AS 사원명,
manager_id,
(CASE manager_id
WHEN 100 THEN '사원'
WHEN 120 THEN '주임'
WHEN 121 THEN '대리'
WHEN 122 THEN '과장'
ELSE '임원' END)AS 직급
FROM employees
WHERE department_id =50;

-- DECODE=범위지정불가, 정확한 기준제시가 필요
SELECT
salary,
employee_id,
first_name,
DECODE( 
salary,
salary>=4000, 'A',
salary>=3000 AND salary<4000, 'B',
salary>=2000 AND salary<3000, 'C',
salary>=1000 AND salary<2000, 'D',
salary>=0 AND salary<1000, 'E',
'F')AS grade
FROM employees
ORDER BY salary DESC;

SELECT
salary,
employee_id,
first_name,
DECODE( 
TRUNC(salary/3000),
0, 'E',
1, 'D',
2, 'C',
3, 'B',
'A')AS grade
FROM employees
ORDER BY salary DESC;

SELECT
salary,
employee_id,
first_name,
(CASE
WHEN salary BETWEEN 0 AND 999 THEN 'E'
WHEN salary BETWEEN 1000 AND 1999 THEN 'D'
WHEN salary BETWEEN 2000 AND 2999 THEN 'C'
WHEN salary BETWEEN 3000 AND 3999 THEN 'B'
ELSE 'A' END
)AS grade
FROM employees
ORDER BY salary DESC;