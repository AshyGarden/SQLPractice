--숫자함수
--ROUND(반올림), 원하는 반올림 위치를 매개값으로 지정, 음수도 가능
SELECT 
ROUND(3.3145,3), --소수점 3번째 자리까지
ROUND(45.923,0), --소수점 0번째 자리까지
ROUND(45.923,-1) --소수점 -1번째 자리(1의 자리에서) 반올림
FROM dual;

--TRUNC
--정해진 소수점 자리수까지 잘라냄
SELECT
TRUNC(3.3145,3), --소수점 3번째 자리까지 자름
TRUNC(45.923,0), --소수점 0번째 자리까지 자름
TRUNC(45.923,-1) --소수점 -1번째 자리(1의 자리에서)에서 자름
FROM dual;

--ABS(절대값)
SELECT ABS(-34) FROM dual;


--ceil(올림) floor(내림)
SELECT CEIL(3.14),FLOOR(3.14)
FROM dual;

--MOD(나머지)
SELECT 
10/4 ,
--10%4 --오류
MOD(10,4)
FROM dual;

--날짜 함수
SELECT sysdate FROM dual; --현재날짜

SELECT systimestamp FROM dual;--현재날짜 시간정보

--날짜정보도 연상이 가능하다.
SELECT sysdate + 1 FROM dual;

SELECT first_name, sysdate-hire_date 
FROM employees;

SELECT first_name, sysdate-hire_date,
(sysdate - hire_date) /365 AS year
FROM employees;

--날짜 반올림 절차
SELECT ROUND(sysdate) FROM dual;           --하루 기준(절반을 지나면 내일)
SELECT ROUND(sysdate, 'year') FROM dual;   --1년 기준 반올림
SELECT ROUND(sysdate, 'month') FROM dual;  --1달 기준 반올림
SELECT ROUND(sysdate, 'day') FROM dual;    --1주일 기준 반올림(일~토 기준,수요일 오후 12시 기준으로반올림)

SELECT TRUNC(sysdate) FROM dual;           --하루 기준 자름
SELECT TRUNC(sysdate, 'year') FROM dual;   --1년 기준 자름
SELECT TRUNC(sysdate, 'month') FROM dual;  --1달 기준 자름
SELECT TRUNC(sysdate, 'day') FROM dual;    --1주일 기준 자름(일~토 기준,수요일 오후 12시 기준으로반올림)