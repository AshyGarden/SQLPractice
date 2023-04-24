--1. �������� 3���� ����ϴ� �͸��� ���� ��¹� 9���� �����ؼ� ����
DECLARE
    A NUMBER :=3;
    B NUMBER :=1;
BEGIN
for(B=1 B<inc_num.MAXVALUE; i++)
{ B ++;
dbms_output.put_line('result: '||TO_CHAR(A*B))
};
END;

CREATE SEQUENCE inc_num
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9
    MINVALUE 1
    NOCACHE
    NOCYCLE;


--2. employees���̺��� 201�� ����� �̸��� �̸��� �ּ�����ϴ� �͸��ϻ����� ������ ������

DECLARE                                   
    v_emp_name employees.first_name%TYPE; --����� ����(���ڿ� ������ ���������ʿ�)
    v_emp_email employees.email%TYPE; --�μ��� ����
BEGIN
    SELECT first_name, email
    INTO v_emp_name, v_emp_email
    FROM employees e
    WHERE employee_id = 201;
    dbms_output.put_line(v_emp_name || '-' || v_emp_email);
END;


--employees ���̺��� �����ȣ�� ���� ū ����� ã�Ƴ���(MAX�Լ�)
--�� ��ȣ+1������ �Ʒ��� ����� emps���̺� employee_id, last_name, email hire_date, job_id
--SELECT����INSERT ���
DROP TABLE emps;
CREATE TABLE emps AS (SELECT * FROM employees WHERE 1=2);

DECLARE                                   
    v_max_empno employees.employee_id%TYPE;
BEGIN
    SELECT MAX(employee_id)
    INTO v_max_empno
    FROM employees;
      
    INSERT INTO emps
       (employee_id, last_name,  email, hire_date, job_id)
    VALUES
       (v_max_empno+1,'steven','stevenjobs', sysdate, 'CEO');    
END;




/*
�����: steven
�̸���: stevenjobs
�Ի�����: ����
job_id: CEO
*/
