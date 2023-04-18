/*���� 1.
-EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
-EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ�
���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ��)*/

--Inner
SELECT *
From employees e 
INNER JOIN departments d 
ON e.department_id = d.department_id; --106��

--L-Outer
SELECT *
From employees e 
LEFT OUTER JOIN departments d 
ON e.department_id = d.department_id; --107��

--R-Outer
SELECT *
From employees e 
RIGHT OUTER JOIN departments d 
ON e.department_id = d.department_id; --122��

--Full outer
SELECT *
From employees e 
FULL OUTER JOIN departments d 
ON e.department_id = d.department_id; --123��

/* ���� 2.
-EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�.*/
SELECT first_name||' '||last_name AS name, d.department_id
From employees e 
JOIN departments d 
ON e.department_id = d.department_id
WHERE e.employee_id = 200;

/*
���� 3.
-EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
HINT) � �÷����� ���� ����� �ִ��� Ȯ��*/
SELECT first_name||' '||last_name AS name, j.job_id, j.job_title
From employees e INNER JOIN jobs j 
ON e.job_id = j.job_id
ORDER BY e.first_name ASC;

--���� 4.
--JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
SELECT * 
FROM jobs j LEFT OUTER JOIN job_history h
ON j.job_id = h.job_id;

--���� 5.
--Steven King�� �μ����� ����ϼ���.
SELECT department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id 
WHERE first_name = InitCap('steven') AND last_name = InitCap('king');

--FM
SELECT first_name||' '||last_name AS name, department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id 
WHERE e.first_name = 'Steven' AND e.last_name = 'King';

--���� 6.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
SELECT COUNT(*) FROM employees e CROSS JOIN departments d;

--���� 7.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� 
--SA_MAN ������� �����ȣ, �̸�, �޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���) 3������

SELECT e.employee_id, e.first_name||' '||e.last_name AS name, e.salary, d.department_name, l.city 
FROM employees e, departments d, locations l
WHERE e.job_id LIKE 'SA_MAN' AND e.department_id = d.department_id AND d.location_id = l.location_id;

--FM
SELECT e.employee_id, e.first_name||' '||e.last_name AS name, e.salary, d.department_name, l.city 
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE e.job_id = 'SA_MAN';

--���� 8.
-- employees, jobs ���̺��� ���� �����ϰ� 
--job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ����������ϼ���.
SELECT *
FROM employees e JOIN jobs j
On e.job_id = j.job_id
WHERE j.job_title =  'Stock Manager' OR j.job_title = 'Stock Clerk';
--WHERE j.job_title IN('Stock Manager', 'Stock Clerk');

--���� 9.
-- departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
SELECT d.department_name
FROM departments d
LEFT OUTER JOIN employees e
ON e.department_id = d.department_id 
WHERE e.employee_id IS NULL;

--���� 10. 
--join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ�����Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
SELECT
e1.first_name AS name, e2.first_name AS ManagerName
FROM employees e1
JOIN employees e2
ON e1.manager_id = e2.employee_id
WHERE e1.manager_id Is NOT NULL;

--���� 11. 
--6. EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
--�Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���
SELECT e1.manager_id, e2.first_name||' '||e2.last_name AS ManagerName, e2.salary
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.employee_id
WHERE e1.manager_id IS NOT NULL
ORDER BY salary DESC;
