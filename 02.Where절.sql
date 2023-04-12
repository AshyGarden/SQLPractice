SELECT * FROM employees;
--where�� ��(������ ���� ��ҹ��� ����!)
SELECT first_name, last_name, job_id
FROM employees
WHERE job_id='IT_PROG'; --�ҹ��ڷ� ������ �ȳ���!

SELECT * FROM employees
WHERE last_name='King';

SELECT * FROM employees
WHERE department_id=90;

SELECT * FROM employees
WHERE salary >=15000;

SELECT * FROM employees
WHERE hire_date ='04/01/30';

--������ �� ����(BETWEEN, IN, LIKE)
SELECT * FROM employees
WHERE salary BETWEEN 15000 AND 20000;

SELECT * FROM employees
WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';

--in�������� ���(Ư������� �񱳽� ���)
SELECT * FROM employees
WHERE manager_id IN (100,101,102);

SELECT * FROM employees
WHERE job_id IN ('IT_PROG','AD_VP');

--LIKE ������

SELECT first_name, hire_date FROM employees
WHERE hire_date LIKE '03%';--�̷� ���¿� ���ٸ�~(%)

SELECT first_name, hire_date FROM employees
WHERE hire_date LIKE '%15'; --�ڸ� 15�� ������ ��ȸ

SELECT first_name, hire_date FROM employees
WHERE hire_date LIKE '%05%'; --05�� �������� ��ȸ

SELECT first_name, hire_date FROM employees
WHERE hire_date LIKE '____05%'; --�տ� 4ĭ ������ 05�������� ��ȸ

--IS NULL(NULL���� ã��)
SELECT * FROM employees
WHERE manager_id IS NULL; -- =���δ� �ȵ� ������ IS NULL

SELECT * FROM employees
WHERE commission_pct IS NULL; 

SELECT * FROM employees
WHERE commission_pct IS NOT NULL; 

--AND, OR
--AND�� OR���� ��������� ����.

SELECT * FROM employees
WHERE job_id = 'IT_PROG'
OR job_id = 'FI_MGR'
AND salary >=6000; --�̻��� �� ����(and�� ���� ����!)

SELECT * FROM employees
WHERE (job_id = 'IT_PROG'
OR job_id = 'FI_MGR') --��ȣ�� �̿��Ͽ� ������ ��ȣ
AND salary >=6000;

--�������� ����(SELECT������ ���� �������� ��ġ)
--ASC:ascending(��������)
--DESC:descending(��������)
SELECT * FROM employees
ORDER BY hire_date ASC;

SELECT * FROM employees
ORDER BY hire_date DESC;

SELECT * FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name ASC;

SELECT * FROM employees --From 1��
WHERE salary>=8000 --���� 3��
ORDER BY employee_id ASC; --��ȸ2��

SELECT first_name, salary*12 AS pay 
FROM employees
ORDER BY pay ASC;