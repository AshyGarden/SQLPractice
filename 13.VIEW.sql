
/*
VIEW�� �������� �ڷḸ �������� ����ϴ� ���� ���̺��� �����̴�.
VIEW�� �⺻���̺�� ������ ���� ���̺��̱� ������ �ʿ��� �÷��� �����صθ� ������ �������� 
VIEW�� �������̺�� ���������Ͱ� ���������� ����� ���´� �ƴϴ�.
VIEW�� ���ؼ� �����Ϳ� �����ϸ� ���������ʹ� �����ϰ� ��ȣ�ɼ� �ִ�.
*/

SELECT * FROM user_sys_privs; --�������� Ȯ��

--�ܼ� VIEW
--VIEW�� �÷��̸��� �Լ����� ����ǥ������ ���Ұ�.
SELECT 
       employee_id,
       first_name||' '||last_name AS name,
       job_id,
       salary
FROM employees
WHERE department_id = 60;


--VIEW����
CREATE VIEW view_emp AS{
SELECT 
       employee_id,
       first_name||' '||last_name , --ERROR �÷����� �ʹ� ��������!
       job_id,
       salary
FROM employees
WHERE department_id = 60
};

CREATE VIEW view_emp AS(
SELECT 
       employee_id,
       first_name|| ' ' ||last_name AS name, --Alias
       job_id,
       salary
FROM employees
WHERE department_id = 60
);

--���� ��
--���� ���̺��� �����Ͽ� �ʿ��� �����͸� �����ϰ� ���� Ȯ���� ���� ���
CREATE VIEW view_emp_dept_jobs AS(
SELECT 
       e.employee_id,
       e.first_name|| ' ' ||e.last_name AS name, --Alias
       d.department_name,
       j.job_title
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
LEFT JOIN jobs j
ON e.job_id = j.job_id
) ORDER BY employee_id ASC;

SELECT * FROM view_emp_dept_jobs;

--���� ����(CREATE OR REPLACE VIEW)
--���� �̸����� �ش籸���� ���� �����Ͱ� ����Ǹ鼭 ���Ӱ� ����
CREATE OR REPLACE VIEW view_emp_dept_jobs AS(
SELECT 
       e.employee_id,
       e.first_name|| ' ' ||e.last_name AS name, --Alias
       d.department_name,
       j.job_title,
       e.salary --�߰�
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
LEFT JOIN jobs j
ON e.job_id = j.job_id
) ORDER BY e.employee_id ASC;

SELECT
    job_title,
    AVG(salary)
FROM view_emp_dept_jobs
GROUP BY job_title
ORDER BY AVG(salary) DESC; -- SQL ������ Ȯ���� ª����.

-- �� ����
DROP VIEW view_emp;

/*
VIEW�� INSERT�� �Ͼ�°�� ���� ���̺��� �ݿ��ؾ���
VIEW��INSERT, UPDATE, DELETE�� ���� ������ ����
���� ���̺��� NT NULL�ΰ�� VIEW���� INSERT �Ұ���!
VIEW���� ����ϴ� �÷��� ������ ��쿡�� �ȵ�.*/

-- �� ��° �÷��� 'name'�� ����(virtual column)�̱� ������ INSERT �� �˴ϴ�.
INSERT INTO view_emp_dept_jobs
VALUES(300, 'test', 'test', 'test', 10000);

-- JOIN�� ���� ��� �� ���� ������ �� �����ϴ�.
INSERT INTO view_emp_dept_jobs
(employee_id, department_name, job_title, salary)
VALUES(300, 'test', 'test', 10000);

-- ���� ���̺��� null�� ������� �ʴ� �÷� ������ �� �� �����ϴ�.
INSERT INTO view_emp
(employee_id, job_id, salary)
VALUES(300, 'test', 10000);

-- WITH CHECK OPTION -> ���� ���� �÷�
-- ���ǿ� ���Ǿ��� �÷����� �並 ���ؼ� ������ �� ���� ���ִ� Ű����
CREATE OR REPLACE VIEW view_emp_test AS(
SELECT
    employee_id,
    first_name,
    last_name,
    email,
    hire_date,
    job_id,
    department_id
FROM employees
WHERE department_id = 60
)WITH CHECK OPTION CONSTRAINT view_emp_test_ck; -- üũ�ɼ� �̸�

SELECT * FROM view_emp_test;

UPDATE view_emp_test
SET department_id = 60
WHERE employee_id = 105;

-- �б� ���� VIEW -> WITH READ ONLY ������ ���� ->SELECT�� ���!
CREATE OR REPLACE VIEW view_emp_test AS(
SELECT
    employee_id,
    first_name,
    last_name,
    email,
    hire_date,
    job_id,
    department_id
FROM employees
WHERE department_id = 60
) WITH READ ONLY; --�б� ����VIEW

UPDATE view_emp_test 
SET job_id = 'test'
WHERE employee_id = 105;
--���: cannot perform a DML operation on a read-only view


