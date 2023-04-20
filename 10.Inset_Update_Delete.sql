--insert
--���̺� ���� Ȯ��
DESC departments; --Describe

--INSERT 1��° ��� = ��� �����͸� �� ���� �����ϱ�
INSERT INTO departments
VALUES(290, '������',100, 2300); 
--�÷��� ���� �������� ������ ������� ��.

SELECT * FROM departments;
ROLLBACK; --���� ������ �ٽ� �ڷ� �ǵ�����

INSERT INTO departments
VALUES(290, '������'); 

--2��° ��� (���� �÷��� �����ϰ� ����, NOT NULLȮ��!)
INSERT INTO departments
       (department_id, department_name)
VALUES
       (290, '������'); 
       
INSERT INTO departments
       (department_id, location_id)
VALUES
       (280, 1700);
       
INSERT INTO departments
       (department_id, department_name, location_id)
VALUES
       (280,'������', 1700);       
       
       
--�纻 ���̺� ����(CTAS)
--�纻 ���̺� ������ �׳� �����ϸ� ��ȸ�� �����͸� �����Ѵ�.
--�׷��� WHERE���� (1=2) FALSE���� �����ϸ�=>���̺� ������ �����ϰ� �����ʹ� �������� �ʴ´�.
CREATE TABLE managers AS 
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE 1=2);

SELECT * FROM managers;
DROP TABLE managers;

--INSERT(��������)
INSERT INTO managers
(SELECT employee_id, first_name, job_id, hire_date
FROM employees);

--UPDATE
CREATE TABLE emps AS (SELECT *FROM employees);
SELECT * FROM emps;

/*
CTAS�� ����ϸ�, ���̺� ���������� NOT NULL����� ������� �ʴ´�!
���������� ���� ��Ģ�� ��Ű�� �����͸� �����ϰ� 
�׷��� ���� �͵��� DB�� ����Ǵ� ���� �����ϴ� �������� ���
*/
--UPDATE�� ������ �� ����� �� �������־���Ѵ�.
--�������� ������ ���� ����� ���̺� ��ü�� ����ȴ�.
UPDATE emps SET salary = 3000; --�� ���̺��� ����
SELECT * FROM emps;
ROLLBACK;

UPDATE emps SET salary = 3000 
WHERE employee_id =100;

UPDATE emps SET salary = salary + salary * 0.1
WHERE employee_id =100;
/*
UPDATE myboard SET hit = hit +1
WHERE board_id = 30; --�Խ��� ��ȸ�� ���� ����
*/

UPDATE emps SET 
phone_number = '010.1234.5678', manager_id = 102
WHERE employee_id =100;

--UPDATE(��������)
UPDATE emps
    SET (job_id, salary, manager_id) = 
   (SELECT job_id, salary, manager_id
    FROM emps
    WHERE employee_id = 100) --100���� job_id, salary, manager_id�� ��ȸ
WHERE employee_id = 101; --101�����Ե� �װ��� ����!

SELECT * FROM emps;
ROLLBACK;

--DELETE
DELETE FROM emps
WHERE employee_id = 103;

--�纻 ���̺� ����
CREATE TABLE depts AS (SELECT * FROM departments);
SELECT * FROM depts;

--DELETE(��������)
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM depts
                       WHERE department_id = 100);
                       
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM depts
                       WHERE department_name = 'IT');
                       

