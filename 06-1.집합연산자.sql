--집합연산자
--UNION(중복값을 제거한후 합쳐줌), UNION(중복값을 허용한후 합쳐줌), INTERSECT(교집합), MINUS(차집합)
--위 아래 column갯수가 정확히 일치해야함!
SELECT
employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%';

SELECT employee_id, first_name
FROM employees
WHERE department_id =20;

--UNION예시
SELECT
employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION --중복되는 201번의 Michael의 데이터는 1번만 출력
SELECT employee_id, first_name
FROM employees
WHERE department_id =20;

SELECT
employee_id, TO_CHAR(salary)--되기는 하지만, 결론적으로 원하는 값만 나오지 않을수도 있음
FROM employees
WHERE hire_date LIKE '04%'
UNION 
SELECT employee_id, first_name
FROM employees
WHERE department_id =20;

--UNION ALL예시
SELECT
employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION ALL --중복되는 201번의 Michael의 데이터 2번 모두 출력
SELECT employee_id, first_name
FROM employees
WHERE department_id =20;

--MINUS예시
SELECT employee_id, first_name
FROM employees
WHERE department_id =20
MINUS --중복되는 201번의 Michael의 데이터를 제외한 Pat만 출력
SELECT
employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%';
