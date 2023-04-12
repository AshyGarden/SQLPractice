-- 오라클의 주석입니다.
/*여러줄 
주석*/
/*
--SELECT 컬럼명(여러개가능) FROM 테이블 이름
SELECT * FROM employees; --조회 ->employees안에서 *(모든컬럼)
--키워드=대문자, 식별자=소문자로 작성권장
SELECT
    *
FROM
    employees; --ctrl+ f7로 이렇게 표현 가능
*/
/*
SELECT
    employee_id,
    first_name,
    last_name --특정조건검색
FROM
    employees; --문장이 끝날때는 ; 필수
*/
SELECT
    email,
    phone_number,
    hire_date
FROM
    employees;

--컬럼을 조회하는 위치에서 * / + - 연상이 가능하다.
SELECT
    first_name,
    last_name,
    employee_id,
    salary,
    salary + salary * commission_pct
FROM
    employees;
    
--null값의 확인( 숫자 0, 공백과는 다른 존재)
SELECT
    department_id,
    commission_pct
FROM
    employees;

--alias(컬렴명, 테이블 명의 이름을 변경해서 조회합니다.
SELECT
    first_name AS 이름,
    last_name  AS 성,
    salary     AS 급여
FROM
    employees;
    
--오라클은 홑따옴표로 문자를 표현, 문자열 안에 홑따옴표를 표현하고싶다면
--홑따옴표를 두번연속으로 쓰면 된다.<-중요
--문장을 연결하고 싶다면 ||를 사용.
SELECT
    first_name
    || ' '
    || last_name
    || '''s salary is $'
    || salary
    AS 급여내역
FROM
    employees;
    
--중복행의 제거(DISTINCT)
SELECT department_id FROM employees;
SELECT DISTINCT department_id FROM employees;

--ROWNUM, ROWID
--ROWNUM(쿼리에 의해 반환되는 행 번호 출력) - 게시판 글 삭제시 사용
--ROWID: DB내의 행 주소 반환
SELECT ROWNUM, ROWID, employee_id
from employees;