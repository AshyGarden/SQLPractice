/*
���ν����� guguProc
������ �� ���޹޾� �ش� �ܼ��� ����ϴ� procedure�� �����ϼ���. 
*/

CREATE PROCEDURE guguProc
IS
BEGIN
    FOR i IN 2..9
    LOOP
        FOR j IN 1..9
        LOOP
         dbms_output.put_line(i|| 'x' || j || '='||i*j);
        END LOOP;
    END LOOP;
END;

EXEC guguProc;
/*
�μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
depts ���̺� 
���� INSERT, UPDATE, DELETE �ϴ� depts_proc �� �̸��� ���ν����� ������.
�׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
*/
CREATE OR REPLACE PROCEDURE depts_proc
    (p_dept_id IN depts.department_id%TYPE, 
    p_dept_name IN depts.department_name%TYPE, 
    p_flag In VARCHAR2 )
IS
    v_flag NUMBER := 1;
BEGIN
    CASE
    WHEN p_flag = 'I' THEN
        INSERT INTO depts (department_id, department_name)
        VALUES(p_dept_id, p_dept_name);
    WHEN p_flag = 'U' THEN
        UPDATE depts
        SET department_name = p_dept_name
        WHERE department_id = p_dept_id;
    WHEN p_flag ='D' THEN
        DELETE FROM depts
        WHERE department_id = p_dept_id; 
    ELSE
        dbms_output.put_line('�߸� �Է��ϼ̽��ϴ�.');      
    END CASE;
    
    IF v_flag =1 THEN
        COMMIT;   
    END IF;   
    
    EXCEPTION WHEN OTHERS THEN 
        dbms_output.put_line('�˼� ���� ���� �߻�');
        ROLLBACK;
END;

EXEC depts_proc(300,'ISNOTNULL','I');
EXEC depts_proc(200,'Break!','U');
EXEC depts_proc(30,'wow','D');
ROLLBACK;

--FM
ALTER TABLE depts ADD CONSTRAINT dept_pk PRIMARY KEY(department_id);
CREATE OR REPLACE depts_proc;


---------------------------------------------------------------------
/*
employee_id�� �Է¹޾� employees�� �����ϸ�,
�ټӳ���� out�ϴ� ���ν����� �ۼ��ϼ���. (�͸��Ͽ��� ���ν����� ����)
���ٸ� exceptionó���ϼ���
*/
CREATE OR REPLACE PROCEDURE hireyears
   (d_emp_id IN employees.employee_id%TYPE,
    d_emp_hd OUT NUMBER)
IS 
    v_result NUMBER;
BEGIN    
    SELECT ROUND((sysdate-hire_date)/365, 0)
    INTO d_emp_hd
    FROM employees
    WHERE employee_id = d_emp_id;
    
EXCEPTION WHEN OTHERS THEN 
        dbms_output.put_line('�˼� ���� ���� �߻�');    
END;

DECLARE
    str NUMBER;
BEGIN
    hireyears(100, str);
    dbms_output.put_line(str);
END;


--FM
CREATE OR REPLACE emp_hire_proc;


/*
���ν����� - new_emp_proc
employees ���̺��� ���� ���̺� emps�� �����մϴ�.
employee_id, last_name, email, hire_date, job_id�� �Է¹޾�
�����ϸ� �̸�, �̸���, �Ի���, ������ update, 
���ٸ� insert�ϴ� merge���� �ۼ��ϼ���

������ �� Ÿ�� ���̺� -> emps
���ս�ų ������ -> ���ν����� ���޹��� employee_id�� dual�� select ������ ��.
���ν����� ���� �޾ƾ��� ��: ���, last_name, email, hire_date, job_id
*/
DROP PROCEDURE new_emp_proc;
CREATE OR REPLACE PROCEDURE new_emp_proc
   (p_emp_id IN  emps.employee_id%TYPE, 
    p_last_name IN emps.last_name%TYPE, 
    p_email IN emps.email%TYPE, 
    p_hire_date IN emps.hire_date%TYPE, 
    p_job_id IN emps.job_id%TYPE) 
IS
BEGIN
    MERGE INTO emps a 
    USING (SELECT p_emp_id AS employee_id FROM dual) b
    ON (a.employee_id = b.employee_id)
    WHEN MATCHED THEN 
        UPDATE SET --������ �Ǵ� department_id�� �����Ǹ� �ȵ�! --���� �ǳʶ�.
            a.last_name = p_last_name, 
            a.email = p_email, 
            a.hire_date = p_hire_date, 
            a.job_id = p_job_id
     WHEN NOT MATCHED THEN 
     INSERT (a.employee_id, a.last_name, a.email,  a.hire_date, a.job_id)
     VALUES (p_emp_id, p_last_name, p_email,  p_hire_date, p_job_id);
END;

EXEC new_emp_proc(100,'kim','abc1234',sysdate,'test');