--���տ�����
--UNION(�ߺ����� �������� ������), UNION(�ߺ����� ������� ������), INTERSECT(������), MINUS(������)
--�� �Ʒ� column������ ��Ȯ�� ��ġ�ؾ���!
SELECT
employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%';

SELECT employee_id, first_name
FROM employees
WHERE department_id =20;

--UNION����
SELECT
employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION --�ߺ��Ǵ� 201���� Michael�� �����ʹ� 1���� ���
SELECT employee_id, first_name
FROM employees
WHERE department_id =20;

SELECT
employee_id, TO_CHAR(salary)--�Ǳ�� ������, ��������� ���ϴ� ���� ������ �������� ����
FROM employees
WHERE hire_date LIKE '04%'
UNION 
SELECT employee_id, first_name
FROM employees
WHERE department_id =20;

--UNION ALL����
SELECT
employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION ALL --�ߺ��Ǵ� 201���� Michael�� ������ 2�� ��� ���
SELECT employee_id, first_name
FROM employees
WHERE department_id =20;

--MINUS����
SELECT employee_id, first_name
FROM employees
WHERE department_id =20
MINUS --�ߺ��Ǵ� 201���� Michael�� �����͸� ������ Pat�� ���
SELECT
employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%';
