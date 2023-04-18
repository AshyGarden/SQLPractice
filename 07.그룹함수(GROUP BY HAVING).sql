--�׷��Լ� AVG, MAX, MIN, SUM, COUNT
SELECT
AVG(salary),
MAX(salary),
MIN(salary),
SUM(salary),
COUNT(salary)
FROM employees;

SELECT COUNT(*) FROM employees; --�� �� �������� ��
SELECT COUNT(first_name) FROM employees;
SELECT COUNT(commission_pct) FROM employees;
SELECT COUNT(manager_id) FROM employees;

--�μ����� �׷�ȭ 
SELECT
department_id,
AVG(salary)
FROM employees
GROUP BY department_id;

--�������� �׷��Լ��� �Ϲ� �÷��� ���ÿ� ��� �Ұ�!
SELECT
department_id,
AVG(salary)
FROM employees;--����

--GROUP BY�� ���� GROUP�� ������ ������ �ٸ� �÷� ��ȸ �Ұ�
SELECT
job_id,       
department_id,
AVG(salary)
FROM employees
GROUP BY department_id;--����

SELECT
job_id,       
department_id,
AVG(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

--GROUP by�� ���� �׷�ȭ�� ������ �ɋ� HAVING�� ���
SELECT      
department_id,
AVG(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) >100000;

SELECT      
job_id,
COUNT(*)
FROM employees
GROUP BY job_id
HAVING COUNT(*) >=5;

--�μ� ���̵� 50�̻�(�׷�ȭ��-where) �׷�ȭ+(�׷�ȭ��-having)�׷� ��������� 5000 �̻� ��ȸ
SELECT                        --����5
department_id,
AVG(salary) As ���
FROM employees                --����1 
WHERE department_id >= 50     --����2
GROUP BY department_id        --����3
HAVING avg(salary) >=5000     --����4
ORDER BY department_id DESC;  --����6

/*


*/


--���� 1. ��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
--1-1��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���
SELECT job_id, COUNT(job_id), salary
FROM employees
GROUP BY job_id, salary   
HAVING avg(salary) >=5000
ORDER BY avg(salary) DESC;

--FM1 1.
SELECT job_id, COUNT(*) AS �����
FROM employees
GROUP BY job_id;

--FM1-1
SELECT 
job_id, 
avg(salary) AS ��տ���
FROM employees
GROUP BY job_id
ORDER BY ��տ��� DESC;

--���� 2. ��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.(TOCHAR�� �̿��ؼ� ������ ��ȯ+�׷�ȭ)
SELECT TO_CHAR(hire_date,'YYYY') AS CrewCount, COUNT(TO_CHAR(hire_date,'YYYY'))
FROM employees
GROUP BY TO_CHAR(hire_date,'YYYY');
--FM2
SELECT 
TO_CHAR(hire_date,'YY') AS CrewCount, 
COUNT(*)
FROM employees
GROUP BY TO_CHAR(hire_date,'YY');

--���� 3. �޿��� 1000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. �� �μ� ��� �޿��� 7000�̻��� �μ��� ���
SELECT department_id, TRUNC(avg(salary),2)
FROM employees 
WHERE salary >= 1000
GROUP BY department_id
HAVING avg(salary)>2000;

--FM3
SELECT 
department_id, TRUNC(avg(salary),2) AS ��ձ޿�
FROM employees 
WHERE salary >= 5000
GROUP BY department_id
HAVING avg(salary)>2000;

--���� 4.
--��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
--department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
--���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
--���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���

SELECT department_id, TRUNC(avg(salary),2), count(department_id),SUM(salary)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
ORDER BY department_id ASC;

--FM4
SELECT 
department_id, 
TRUNC(avg(salary+(salary*commission_pct)) ,2), 
SUM(salary +salary*commission_pct),count(*)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;