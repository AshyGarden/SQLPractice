/*
프로시저명 guguProc
구구단 을 전달받아 해당 단수를 출력하는 procedure을 생성하세요. 
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
부서번호, 부서명, 작업 flag(I: insert, U:update, D:delete)을 매개변수로 받아 
depts 테이블에 
각각 INSERT, UPDATE, DELETE 하는 depts_proc 란 이름의 프로시저를 만들어보자.
그리고 정상종료라면 commit, 예외라면 롤백 처리하도록 처리하세요.
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
        dbms_output.put_line('잘못 입력하셨습니다.');      
    END CASE;
    
    IF v_flag =1 THEN
        COMMIT;   
    END IF;   
    
    EXCEPTION WHEN OTHERS THEN 
        dbms_output.put_line('알수 없는 예외 발생');
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
employee_id를 입력받아 employees에 존재하면,
근속년수를 out하는 프로시저를 작성하세요. (익명블록에서 프로시저를 실행)
없다면 exception처리하세요
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
        dbms_output.put_line('알수 없는 예외 발생');    
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
프로시저명 - new_emp_proc
employees 테이블의 복사 테이블 emps를 생성합니다.
employee_id, last_name, email, hire_date, job_id를 입력받아
존재하면 이름, 이메일, 입사일, 직업을 update, 
없다면 insert하는 merge문을 작성하세요

머지를 할 타겟 테이블 -> emps
병합시킬 데이터 -> 프로시저로 전달받은 employee_id를 dual에 select 때려서 비교.
프로시저가 전달 받아야할 값: 사번, last_name, email, hire_date, job_id
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
        UPDATE SET --기준이 되는 department_id는 수정되면 안됨! --따라서 건너뜀.
            a.last_name = p_last_name, 
            a.email = p_email, 
            a.hire_date = p_hire_date, 
            a.job_id = p_job_id
     WHEN NOT MATCHED THEN 
     INSERT (a.employee_id, a.last_name, a.email,  a.hire_date, a.job_id)
     VALUES (p_emp_id, p_last_name, p_email,  p_hire_date, p_job_id);
END;

EXEC new_emp_proc(100,'kim','abc1234',sysdate,'test');