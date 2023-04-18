--�����̶�? 
--���� �ٸ� ���̺� ���� ������ ���谡 �����Ͽ� 
--1�� �̻��� ���̺��� �����͸� ��ȸ�ϱ����� ��� 

--SELECT �÷�����Ʈ FROM ���δ���׵Ǵ� ���̺� 1���̻� WHERE �������� ->����Ŭ ���� ǥ��


--employees ���̺� �μ�id�� ��ġ�ϴ� department���̺� �μ�id�� ã�Ƽ� 
--SELECT���Ͽ� �ִ� �÷����� ����ϴ� ������

--ORACLE����
SELECT
    first_name,
    last_name,
    hire_date,
    salary,
    job_id,
    department_name, 
--department_id--��ȣ��(���̵��÷��� ���ʿ� �������)
    e.department_id--�����������
FROM
    employees   e,
    departments d --FROM���� AS��������
WHERE
    e.department_id = d.department_id; --��������(������������ �Ϲ��������� �򰥸�)


--ANSI����(��õ)
SELECT
    first_name,
    last_name,
    hire_date,
    salary,
    job_id,
    department_name,
    e.department_id
FROM
         employees e --���̺�
    INNER JOIN departments d --������ ���̺�
     ON e.department_id = d.department_id;--��������

/*
������ ���̺� ���������� �����ϴ� �÷��� ��쿡�� ���̺� �̸� ��������
�׷��� �ؼ��� ��Ȯ���� ���� ���̺� �̸� �ۼ��ؼ� �Ҽ��� �˷��ִ� ���� ����.
���̺� �̸��� �ʹ���� ALIAS�ۼ�
�����̺� ��� ������ �ִ� �÷��� ��� �ݵ�� ���!
*/

--3���� ���̺��� �̿��� ��������(INNER JOIN)
--��������: �� ���̺� ��ο��� ��ġ�ϴ� ���� ���� �ุ ��ȯ(������ �ȸ����� �������� ����)
SELECT
    e.first_name,
    e.last_name,
    e.department_id,
    d.department_name,
    j.job_title
FROM
    employees   e,
    departments d,
    jobs        j
WHERE
        e.department_id = d.department_id
    AND e.job_id = j.job_id;

SELECT
e.first_name, e.last_name,
d.department_id, d.department_name,
j.job_title,
loc.city
FROM
employees e,
departments d,
jobs j,
locations loc
WHERE
e.department_id = d.department_id  --����3
AND
e.job_id = j.job_id                --����4
AND
d.location_id = loc.location_id    --����2
AND
loc.state_province = 'California'; --����1

/*
1.loc���̺��� province = = 'California'���ǿ� �����ϴ� ���� �������
2.location_id���� ���� ���� ������ �����͸� departments���� ã�Ƽ� ����
3.�� ����� ������ department_id�� ���� employees���̺��� �����͸� ã�Ƽ� ����
4.�� ����� jobs���̺��� ���Ͽ� �����ϰ� ���� ����� ���.
*/

--�ܺ����� (OUTER JOIN)
/*��ȣ���̺��� ��ġ�Ǵ� ������ ����Ǵ� �������ΰ��� �ٸ���
����� ���̺� ���밪�� ������ �ش� row���� ��ȸ ����� ��� ���ԵǴ� ����
*/
SELECT
    first_name, last_name,
    hire_date, salary,
    job_id, department_name, e.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id(+); --�������̺�(+�� ���� ���� employees)

SELECT
    first_name, last_name,
    hire_date, salary,
    job_id, department_name, e.department_id
FROM employees e, departments d, locations loc
WHERE e.department_id = d.department_id(+)
AND d.location_id = loc.location_id;
/*
employees���̺��� �����ϰ� departments���̺��� ���������ʾƵ� 
(+)�� �������� ���̺��� ���������Ͽ� departments���̺��� ���ο�  �����϶�� �ǹ̸� ���̱����� ��ȣ�߰�
�ܺ����� ����ߴ��� ���� �������� ���� ���� ������ �켱�νĵ�.
*/

--�ܺ� ���� ����� ������ǿ� \(+)fmf qnxdudi dhlqnwhdlsdl dbwlehla
--�Ϲ� ���ǿ��� (+)�� ������ ������ �ܺ������� Ǯ���� ������ �߻�(������ ������)
SELECT
e.employee_id, e.first_name,
e.department_id, 
j.start_date,
j.end_date,
j.job_id
FROM employees e, job_history j
WHERE e.employee_id = j.employee_id(+)
AND j.department_id(+) = 80;