/*
--서브쿼리
서브쿼리 사용방법은 () 안에 명시함
서브쿼리절의 리턴행이 1줄이하여야함. --단일행 서브쿼리
서브쿼리 절에는 비교할 대상이 반드시 하나는 들어가야함.
해석시에는 서브쿼리절부터 먼저 해석하면된다.*/

--- 'Nancy의 급여보다 급여가 많은 사람을 검색하는 문장.
SELECT salary
FROM employees
WHERE first_name = initcap('nancy'); --Nancy의 급여를 출력

SELECT * FROM employees
WHERE salary > 12008;


SELECT * FROM employees                      --3. 그 사람의 급여를 출력
WHERE salary > (SELECT salary FROM employees --2. 다른사람이 Nancy의 급여보다 크다면 
WHERE first_name = INITCAP('nancy'));        --1. Nancy의 급여
    
    
--employee_id가 103번인 사람과 job_id가 동일한 사람을 검색하는 문장.
SELECT * FROM employees
WHERE job_id = (SELECT job_id FROM employees WHERE employee_id=103);
    
--다음 문장을 서브쿼리가 리턴하는 행이 여러개라서 단일행 연산자를 사용할수 없다.
--이럴땐 다중행 연산자를 사용해야한다.
SELECT * FROM employees
WHERE job_id = (SELECT job_id 
                FROM employees 
                WHERE job_id='IT_PROG'); --error

--다중행 연산자
--IN: 목록에 어떤값과 같은지 확인 
SELECT * FROM employees
WHERE job_id IN (SELECT job_id 
                FROM employees 
                WHERE job_id='IT_PROG');
                
--first_name이 David인 사람중 가장 작은 값보다 급여가 큰 사람을 조회.
SELECT salary FROM employees WHERE first_name = INITCAP('david');

--ANY: 값을 서브쿼리에 의해 리턴된 각각의 값과 비교.
--조건중 하나라도 만족하면 출력
SELECT * FROM employees
WHERE salary > ANY (SELECT salary 
                  FROM employees 
                  WHERE first_name = INITCAP('david'));

--ALL: 값을 서브쿼리에 의해 리턴된 값과 모두 비교해서, 모두 만족해야함!
SELECT * FROM employees
WHERE salary > ALL (SELECT salary 
                  FROM employees 
                  WHERE first_name = INITCAP('david'));
-------------------------------------------------------------------
--스칼라 서브쿼리
--SELECT 구문에 서브쿼리가 오는것. 
--LEFT OUTERJOIN과 유사한 결과가 나옴.

SELECT e.first_name, d.department_name
FROM employees e
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
ORDER BY first_name ASC;

SELECT e.first_name,( 
       SELECT department_name
       FROM departments d
       WHERE d.department_id = e.department_id
       ) AS department_name
FROM employees e
ORDER BY first_name ASC;

/*
스칼라 서브쿼리가 JOIN보다 좋은 경우
함수처럼 한 레코드당 정확히 1개의 값만을 리턴할 때

JOIN이 스칼라 서브쿼리보다 좋은 경우
조회할 데이터가 대용량인 경우
해당 데이터가 수정 삭제가 빈번할 경우
*/

--각 부서의 매니저 이름
--LEFT OUTER JOIN
SELECT d.*, e.first_name
FROM departments d
LEFT OUTER JOIN employees e
ON d.manager_id = e.employee_id
ORDER BY d.manager_id ASC;

--Scalar SubQuery
SELECT d.*,(SELECT first_name
            FROM employees e
            WHERE e.employee_id = d.manager_id
            ) AS Manager_name
FROM departments d
ORDER BY d.manager_id ASC;

--LEFT OUTER JOIN

--각 부서별 사원 수 뽑기
--Scalar SubQuery
SELECT d.*, ( SELECT COUNT(*)
              FROM employees e
              WHERE e.department_id = d.department_id --조건 필요!
              GROUP BY department_id
              ) AS  사원수
FROM departments d ;
-----------------------------------------------------------------
--INLINE VIEW(FROM 구문에 서브쿼리가 오는것)
--순번을 정해놓은 조회자료를 범위를 지정해서 가지고 오는 경우.
SELECT ROWNUM AS RN, employee_id, first_name, salary
FROM employees
ORDER BY salary DESC;
--salary로 정렬을 진행하면서 바로 ROWNUM을 붙이면정렬이 제대로 되지 않는다.
--이유: ROWNUM이 먼저붙고, 정렬이 진행되기 때문이다. (ORDERBY는 항상 마지막 진행)
--해결: 정렬이 미리 진행된 자료에 ROWNUM을 붙여서 다시 조회하는것이 좋음.

SELECT ROWNUM AS RN, tb1.*
FROM (SELECT employee_id, first_name, salary 
      FROM employees
      ORDER BY salary DESC) tb1; --가상의 테이블
     
      
SELECT ROWNUM AS RN, tb1.*
FROM (SELECT employee_id, first_name, salary 
      FROM employees
      ORDER BY salary DESC) tb1 --가상의 테이블
WHERE RN >10 and RN<20; --error
--ROWNUM을 붙이고 나서 범위를 지정해서 조회하려고하는데, 범위지정 불가능, 지목도 불가능
--이유: WHERE절부터 먼저 실행하소 나서 ROWNUM이 SELECT되기 때문.
--해결: ROWNUM까지 붙여놓고 다시한번 자료를 SELECT해서 범위를 지정해야 함.
SELECT * FROM( SELECT ROWNUM AS RN, tb1.*
               FROM (SELECT employee_id, first_name, salary 
                     FROM employees
                     ORDER BY salary DESC
                     ) tb1
              )
WHERE RN >10 and RN<20; 
/*
가장 안쪽 SELECT 절에서 필요한 테이블 형식(인라인 뷰를 생성.)
바깥쪽 SELECT절에서 ROWNUM을 붙여서 다시 조회.
가장 바깥쪽 SELECT절에서는 이미 붙어있는 ROWNUM의 범위를 지정해서 조회

SQL실행순서
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
*/

SELECT * 
         FROM(
         SELECT To_CHAR(TO_DATE(test, 'YY/MM/DD'), 'MMDD') AS mm, name
              FROM(
              SELECT '홍길동' AS name, '20230418' AS test FROM dual UNION ALL
              SELECT '김철수','20230301' FROM dual UNION ALL
              SELECT '박영희','230201' FROM dual UNION ALL
              SELECT '김뽀삐','20230501' FROM dual UNION ALL
              SELECT '박뚜띠','230601' FROM dual UNION ALL
              SELECT '김테스트','20230701' FROM dual
              )
          )
WHERE mm='0418';
