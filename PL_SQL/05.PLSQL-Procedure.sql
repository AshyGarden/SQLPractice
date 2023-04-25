
--���ν���(Procedure) -> void�ż���� ����
--Ư���� ������ ó���ϰ� ������� ��ȯ���� �ʴ� �ڵ嵢�(����)
--������ ���ν����� ���� ���� �����ϴ� ����� ����.

DROP PROCEDURE p_test;

--�Ű��� ���� ���ν���
Create PROCEDURE p_test
IS --�����
    v_msg VARCHAR2(30) := 'HELLO PROCEDURE!';
BEGIN --�����
    dbms_output.put_line(v_msg);
END;


--���ν��� ȣ�⹮
EXEC p_test;

--IN �Է°��� ���޹޴� �Ķ����
CREATE PROCEDURE my_new_procedure
    (p_job_id IN jobs.job_id%TYPE, 
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE,
    p_max_sal IN jobs.max_salary%TYPE)
IS

BEGIN
    INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
    VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    COMMIT;
END;

EXEC my_new_procedure('JOB1','test job1',7777,9999);

DELETE FROM jobs
WHERE job_id = 'JOB1';
SELECT * FROM jobs;

--job_id�� Ȯ���ؼ� �̹� �����ϴ� �����Ͷ�� ����, ���ٸ� ���Ӱ� �߰�.
CREATE OR REPLACE PROCEDURE my_new_procedure --���� ���ν��� ���� �ణ ����
    (p_job_id IN jobs.job_id%TYPE, 
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE,
    p_max_sal IN jobs.max_salary%TYPE)
IS
    v_cnt NUMBER :=0;
BEGIN
    --���� job_id�� �ִ��� üũ
    --�����Ѵٸ� 1, �������� �ʴ´ٸ� 0->v_cnt�� ����.
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt=0 THEN --���ٸ� INSERT
        INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE --�ִٸ� UPDATE
        UPDATE jobs
        SET job_title = p_job_title,
        min_salary = p_min_sal,
        max_salary = p_max_sal
        WHERE job_id = p_job_id;
    END IF;
END;

EXEC my_new_procedure('JOB3','test job1',7777,9999);
EXEC my_new_procedure('JOB1','test job3',7788,9988);

--�Ű���(�μ�)�� ����Ʈ ��(�⺻��) ����
CREATE OR REPLACE PROCEDURE my_new_procedure --���� ���ν��� ���� �ణ ����
    (p_job_id IN jobs.job_id%TYPE, 
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE := 0,
    p_max_sal IN jobs.max_salary%TYPE := 1000) --�⺻�� ����
IS
    v_cnt NUMBER :=0;
BEGIN
    --���� job_id�� �ִ��� üũ
    --�����Ѵٸ� 1, �������� �ʴ´ٸ� 0->v_cnt�� ����.
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt=0 THEN --���ٸ� INSERT
        INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE --�ִٸ� UPDATE
        UPDATE jobs
        SET job_title = p_job_title,
        min_salary = p_min_sal,
        max_salary = p_max_sal
        WHERE job_id = p_job_id;
    END IF;
END;

EXEC my_new_procedure('JOB5','test job5');

SELECT * FROM jobs;
-----------------------------------------------------------------------------

-- OUT, IN OUT �Ű����� ���.
-- OUT������ ����ϸ� PROCEDURE �ٱ����� ���� ����.
--OUT�� �ƿ��ؼ� ���� ���� �ٱ��͸� ��Ͽ��� �����ؾ���!
CREATE OR REPLACE PROCEDURE my_new_procedure 
    (p_job_id IN jobs.job_id%TYPE, 
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE := 0,
    p_max_sal IN jobs.max_salary%TYPE := 1000, 
    p_result OUT VARCHAR2) --procedure�� ������ ���� ��µ�.
IS
    v_cnt NUMBER :=0;
    v_result VARCHAR2(100) := '���� ��� INSERTó�� �Ǿ����ϴ�.';
BEGIN
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    IF v_cnt=0 THEN 
        INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE --������ �����ϴ� �����Ͷ�� ����� ����.
        SELECT
            p_job_id  ||'�� �ִ� ����:' ||max_salary ||'�� �ּҿ���:' ||min_salary
        INTO 
            v_result
        FROM jobs
        WHERE job_id = p_job_id;
    END IF;
    
    --OUT �Ű������� ����� �Ҵ�.
    p_result := v_result;
    COMMIT;
END;

DECLARE
    str VARCHAR2(100);
BEGIN
   my_new_procedure('JOB1','test_job1', 2000, 8000 ,str); --str ������ v_result ������� �Ҵ�
   dbms_output.put_line(str);
  
   my_new_procedure('JOB2','test_job21', 3000, 18000 ,str); 
   --str ������ v_result ������� �Ҵ�
   dbms_output.put_line(str);
END; 

----------------------------------------------
--IN, OUT ����ó��
CREATE OR REPLACE PROCEDURE my_param_test_proc
(p_var1 IN VARCHAR2,    --���� �޴� �뵵�θ� ��밡��, ��ȯ�Ұ�
p_var2 OUT VARCHAR2,    --���ν����� ������������ ���� �Ҵ��� �ȵ�. �����߸� OUT�� ����
p_var3 IN OUT VARCHAR2) --IN, OUT�� �Ѵ� ������!
IS

BEGIN
     dbms_output.put_line('p_var1: '||p_var1); --�翬�� ��
     dbms_output.put_line('p_var2: '||p_var2); --���� ���޵��� ����(����)
     dbms_output.put_line('p_var3: '||p_var3); --IN�Ǽ����� ����(���� ���޵�.
     
     --p_var1 :='���1'; --IN������ ���� �����Ҽ� ����!(�� �Ҵ�Ұ�!)
     p_var2 :='���2';
     p_var3 :='���3';
END;

DROP PROCEDURE my_param_test_proc;

DECLARE
v_var1 VARCHAR2(10) := 'value1';
v_var2 VARCHAR2(10) := 'value2';
v_var3 VARCHAR2(10) := 'value3';
BEGIN
    my_param_test_proc(v_var1, v_var2, v_var3);
    
    dbms_output.put_line('v_var1: ' || v_var1);
    dbms_output.put_line('v_var2: ' || v_var2);
    dbms_output.put_line('v_var3: ' || v_var3);
END;

-------------------------------------------------------------------------
--return
CREATE OR REPLACE PROCEDURE my_new_procedure 
    (p_job_id IN jobs.job_id%TYPE, 
    p_result OUT VARCHAR2) --procedure�� ������ ���� ��µ�.
IS
    v_cnt NUMBER :=0;
    v_result VARCHAR2(100) := '���� ��� INSERTó�� �Ǿ����ϴ�.';
BEGIN
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    IF v_cnt=0 THEN 
        dbms_output.put_line(p_job_id  || '�� ���̺� �������� �ʽ��ϴ�.');
        return; --���ν��� ���� ����
    END IF;
    
    SELECT
    p_job_id  ||'�� �ִ� ����:' ||max_salary ||'�� �ּҿ���:' ||min_salary
    INTO 
         v_result
    FROM jobs
    WHERE job_id = p_job_id;
       
    --OUT �Ű������� ����� �Ҵ�.
    p_result := v_result;
    COMMIT;
END;

DECLARE
    str VARCHAR2(100);
BEGIN
   my_new_procedure('JOB3' ,str); --str ������ v_result ������� �Ҵ�
   dbms_output.put_line(str);
END; 


--����ó��
/*
OTHERS �ڸ��� ������ Ÿ���� �ۼ��� �ݴϴ�.
ACCESS_INTO_NULL->��ü �ʱ�ȭ�� �Ǿ����� ���� ���¿��� ���
NO_DATA_FOUND _> SELECT INTO�� �����Ͱ� �� �ǵ� ���� ��
ERROR_DIVIDE _> 0���� ������
VALUE_ERROR ->��ġ �Ǵ� �� ����
INVALID_NUMBERS -> ���ڸ� ���ڷ� ��ȯ�� ������ ���
*/
DECLARE
    v_num NUMBER := 0;
BEGIN
    v_num :=10/0;
EXCEPTION 
    WHEN ZERO_DIVIDE THEN --OTHER ->JAVA�� EXCPETION�� ���
    dbms_output.put_line('0���� ������ �����ϴ�.');
    dbms_output.put_line('SQL ERROR CODE: ' || SQLCODE);
    dbms_output.put_line('SQL ERROR MSG: ' || SQLERRM);
    WHEN OTHERS THEN 
        dbms_output.put_line('�˼� ���� ���� �߻�');
END;

DECLARE
    v_num NUMBER := 0;
BEGIN
    v_num :=10/0;
EXCEPTION WHEN OTHERS THEN --OTHER ->JAVA�� EXCPETION�� ���
    dbms_output.put_line('0���� ������ �����ϴ�.');
    dbms_output.put_line('SQL ERROR CODE: ' || SQLCODE);
    dbms_output.put_line('SQL ERROR MSG: ' || SQLERRM);
END;