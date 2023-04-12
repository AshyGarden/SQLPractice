-- ����Ŭ�� �ּ��Դϴ�.
/*������ 
�ּ�*/
/*
--SELECT �÷���(����������) FROM ���̺� �̸�
SELECT * FROM employees; --��ȸ ->employees�ȿ��� *(����÷�)
--Ű����=�빮��, �ĺ���=�ҹ��ڷ� �ۼ�����
SELECT
    *
FROM
    employees; --ctrl+ f7�� �̷��� ǥ�� ����
*/
/*
SELECT
    employee_id,
    first_name,
    last_name --Ư�����ǰ˻�
FROM
    employees; --������ �������� ; �ʼ�
*/
SELECT
    email,
    phone_number,
    hire_date
FROM
    employees;

--�÷��� ��ȸ�ϴ� ��ġ���� * / + - ������ �����ϴ�.
SELECT
    first_name,
    last_name,
    employee_id,
    salary,
    salary + salary * commission_pct
FROM
    employees;
    
--null���� Ȯ��( ���� 0, ������� �ٸ� ����)
SELECT
    department_id,
    commission_pct
FROM
    employees;

--alias(�÷Ÿ�, ���̺� ���� �̸��� �����ؼ� ��ȸ�մϴ�.
SELECT
    first_name AS �̸�,
    last_name  AS ��,
    salary     AS �޿�
FROM
    employees;
    
--����Ŭ�� Ȭ����ǥ�� ���ڸ� ǥ��, ���ڿ� �ȿ� Ȭ����ǥ�� ǥ���ϰ�ʹٸ�
--Ȭ����ǥ�� �ι��������� ���� �ȴ�.<-�߿�
--������ �����ϰ� �ʹٸ� ||�� ���.
SELECT
    first_name
    || ' '
    || last_name
    || '''s salary is $'
    || salary
    AS �޿�����
FROM
    employees;
    
--�ߺ����� ����(DISTINCT)
SELECT department_id FROM employees;
SELECT DISTINCT department_id FROM employees;

--ROWNUM, ROWID
--ROWNUM(������ ���� ��ȯ�Ǵ� �� ��ȣ ���) - �Խ��� �� ������ ���
--ROWID: DB���� �� �ּ� ��ȯ
SELECT ROWNUM, ROWID, employee_id
from employees;