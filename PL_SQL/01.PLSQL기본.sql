
/*
#PL/SQL
����Ŭ���� �����ϴ� SQL���α׷��� ���
�Ϲ����� ���α׷��ְ��� ���̰� ������ ����Ŭ ���ο��� ������ ó���� ���� ������ �� ���ִ� ���������� �ڵ��ۼ����.
�������� �������� ��� ������ �ϰ� ó���ϱ� ���� �뵵
*/

--��¹� Ȱ��ȭ
SET SERVEROUTPUT ON; 

DECLARE --���� ���𱸰�(�����)
    emp_num NUMBER; --��������
BEGIN --�ڵ带 �����ϴ� ���۱���(�����)
    emp_num := 10; --���Կ����� :=
    DBMS_OUTPUT.put_line(emp_num);
    DBMS_OUTPUT.put_line('hello PLSQL');
END; --PL/SQL�� ������ ����(�����)

--������
--�Ϲ�SQL���� ��� �������� ����� ����, ** = ����
DECLARE
    A NUMBER :=2**2*3**2; --4X9 =36
BEGIN
dbms_output.put_line('a: '||TO_CHAR(A));
END;

/*
-DML��
DDL���� ���Ұ�, �Ϲ������� SQL���� SELECT���� ���


*/
--�ش� ���̺�� ���� Ÿ���� �÷� ������ �����Ϸ���
--���̺��.�÷���%TYPE�� ���->����ڰ� Ÿ���� ������ Ȯ���ؾ��ϴ� ���ŷο��� ���� ����.
DECLARE                                   
    v_emp_name employees.first_name%TYPE; --����� ����(���ڿ� ������ ���������ʿ�)
    v_dep_name departments.department_name%TYPE; --�μ��� ����
BEGIN
    SELECT e.first_name, d.department_name
    INTO v_emp_name, v_dep_name
    FROM employees e
    LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id
    WHERE employee_id = 100;
    
    dbms_output.put_line(v_emp_name || '-' || v_dep_name);
END;
