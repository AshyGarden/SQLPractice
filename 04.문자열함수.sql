--lower(소문자), initcap(맨 앞글자만 대문자), upper(대문자)
SELECT
    'abcDEF' AS origin,
    lower('abcDEF'),
    upper('abcDEF')
FROM
    dual; --dual 테이블 
    /*
dual이라는 테이블은 sys(최고관리자)가 소슈하고있는 오라클 표준 테이블
오직 한 행에 한 컬럼만 담고있는 dummy테이블 이다.
일시적인 산술 연산이나 날짜 연산등에 주로 사용
모든 사용자가 접근가능
*/

SELECT
    last_name,
    lower(last_name),
    initcap(last_name),
    upper(last_name)
FROM
    employees;

SELECT
    last_name
FROM
    employees
WHERE
    lower(last_name) = 'austin'; --소문자로 비교!

--length(갈아), instr(문자찾기 - 없으면 0 반환, 있으면 인덱스값 반환)

SELECT
    'abcDEF',
    length('abcDEF'),
    instr('abcDEF', 'a')
FROM
    dual;

SELECT
    first_name,
    length(first_name),
    instr(first_name, 'a')
FROM
    employees;

--substr(문자열 자르기), concat(문자연결- 무조건 2개) 1부터시작
SELECT
    'abcdef' AS ex,
    substr('abcdef', 1, 4),
    concat('abcdef', 'ghi')
FROM
    dual;

SELECT
    first_name,
    substr(first_name, 1, 3),
    concat(first_name, last_name)
FROM
    employees;

--LPAD(좌측), RPAD(우측) 지정 문자열로 채우기
SELECT
    lpad('abc', 10, '*'),
    rpad('abc', 10, '*')
FROM
    dual;

--LTRIM() 왼쪽, RTRIM() 오른쪽, TRIM() 양쪽 --공백제거
--LTRIM(param1, param2) ->param2의 값을 param1에서 찾아서 제거(왼쪽부터)
SELECT
    ltrim('javascript_java', 'java')
FROM
    dual;
--RTRIM(param1, param2) ->param2의 값을 param1에서 찾아서 제거(오른쪽부터)
SELECT
    rtrim('javascript_java', 'java')
FROM
    dual;

SELECT
    TRIM('    java    ')
FROM
    dual; --TRIM() 양쪽 --공백제거

--replace('문장','제거할 단어','대체할 단어') 문자교체
SELECT
    replace('My Dream is a President', 'President', 'Programmer')
FROM
    dual;

SELECT
    replace('My Dream is a President', ' ', '') --공백을 없는문자열= 공백을 지우겠다.
FROM
    dual;

SELECT
    replace(replace('My Dream is a President', 'President', 'Programmer'),
            ' ',
            '')
FROM
    dual;

SELECT
    replace(concat('hello ', 'world?'),
            '?',
            '!')
FROM
    dual;
/*
문제 1.
EMPLOYEES 테이블 에서 이름, 입사일자 컬럼으로 변경해서 이름순으로 오름차순 출력 합니다.
조건 1) 이름 컬럼은 first_name, last_name을 붙여서 출력합니다.
조건 2) 입사일자 컬럼은 xx/xx/xx로 저장되어 있습니다. xxxxxx형태로 변경해서 출력합니다
*/
SELECT
    first_name
    || ' '
    || last_name AS name,
    replace(hire_date, '/', '')
FROM
    employees
ORDER BY
    name ASC;
/*
문제 2.
EMPLOYEES 테이블 에서 phone_numbe컬럼은 ###.###.####형태로 저장되어 있다
여기서 처음 세 자리 숫자 대신 
서울 지역변호 (02)를 붙여 전화 번호를 출력하도록 쿼리를 작성하세요*/
SELECT
    replace(phone_number,substr(phone_number, 1, 3),'02')
FROM
    employees;
--FM
SELECT CONCAT('(02)',substr(phone_number, 5, length(phone_number)))
FROM employees;

/*
문제 3. 
EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요.
조건 1) 비교하기 위한 값은 소문자로 입력해야 합니다.(힌트 : lower 이용)
조건 2) 이름은 앞 3문자까지 출력하고 나머지는 *로 출력합니다. 
이 열의 열 별칭은 name입니다.(힌트 : rpad와 substr 또는 substr 그리고 length 이용)
조건 3) 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다. 
이 열의 열 별칭은 salary입니다.(힌트 : lpad 이용)
*/
SELECT rpad(lower(first_name),substr(first_name, 4),'*'),
       rpad(salary, 4, '*')
FROM employees
WHERE job_id = 'IT_PROG';

--FM
SELECT
    rpad(substr(first_name, 1, 3),length(first_name),'*') AS name,
    lpad(salary, 10, '#') AS salary
FROM employees
WHERE lower(job_id) = 'it_prog';
