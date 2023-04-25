
--프로시저(Procedure) -> void매서드와 유사
--특정한 로직을 처리하고 결과값을 반환하지 않는 코드덩어리(쿼리)
--하지만 프로시저를 통해 값을 리턴하는 방법도 있음.

DROP PROCEDURE p_test;

--매개값 없는 프로시저
Create PROCEDURE p_test
IS --선언부
    v_msg VARCHAR2(30) := 'HELLO PROCEDURE!';
BEGIN --실행부
    dbms_output.put_line(v_msg);
END;


--프로시저 호출문
EXEC p_test;

--IN 입력값을 전달받는 파라미터
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

--job_id를 확인해서 이미 존재하는 데이터라면 수정, 없다면 새롭게 추가.
CREATE OR REPLACE PROCEDURE my_new_procedure --기존 프로시저 구조 약간 수정
    (p_job_id IN jobs.job_id%TYPE, 
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE,
    p_max_sal IN jobs.max_salary%TYPE)
IS
    v_cnt NUMBER :=0;
BEGIN
    --동일 job_id가 있는지 체크
    --존재한다면 1, 존재하지 않는다면 0->v_cnt에 저장.
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt=0 THEN --없다면 INSERT
        INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE --있다면 UPDATE
        UPDATE jobs
        SET job_title = p_job_title,
        min_salary = p_min_sal,
        max_salary = p_max_sal
        WHERE job_id = p_job_id;
    END IF;
END;

EXEC my_new_procedure('JOB3','test job1',7777,9999);
EXEC my_new_procedure('JOB1','test job3',7788,9988);

--매개값(인수)의 디폴트 값(기본값) 설정
CREATE OR REPLACE PROCEDURE my_new_procedure --기존 프로시저 구조 약간 수정
    (p_job_id IN jobs.job_id%TYPE, 
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE := 0,
    p_max_sal IN jobs.max_salary%TYPE := 1000) --기본값 설정
IS
    v_cnt NUMBER :=0;
BEGIN
    --동일 job_id가 있는지 체크
    --존재한다면 1, 존재하지 않는다면 0->v_cnt에 저장.
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt=0 THEN --없다면 INSERT
        INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE --있다면 UPDATE
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

-- OUT, IN OUT 매개변수 사용.
-- OUT변수를 사용하면 PROCEDURE 바깥으로 값을 보냄.
--OUT을 아용해서 보낸 값은 바깥익명 블록에서 실행해야함!
CREATE OR REPLACE PROCEDURE my_new_procedure 
    (p_job_id IN jobs.job_id%TYPE, 
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE := 0,
    p_max_sal IN jobs.max_salary%TYPE := 1000, 
    p_result OUT VARCHAR2) --procedure가 끝날떄 값이 출력됨.
IS
    v_cnt NUMBER :=0;
    v_result VARCHAR2(100) := '값이 없어서 INSERT처리 되었습니다.';
BEGIN
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    IF v_cnt=0 THEN 
        INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE --기존에 존재하는 데이터라면 결과를 추출.
        SELECT
            p_job_id  ||'의 최대 연봉:' ||max_salary ||'의 최소연봉:' ||min_salary
        INTO 
            v_result
        FROM jobs
        WHERE job_id = p_job_id;
    END IF;
    
    --OUT 매개변수에 결과를 할당.
    p_result := v_result;
    COMMIT;
END;

DECLARE
    str VARCHAR2(100);
BEGIN
   my_new_procedure('JOB1','test_job1', 2000, 8000 ,str); --str 변수에 v_result 결과값을 할당
   dbms_output.put_line(str);
  
   my_new_procedure('JOB2','test_job21', 3000, 18000 ,str); 
   --str 변수에 v_result 결과값을 할당
   dbms_output.put_line(str);
END; 

----------------------------------------------
--IN, OUT 동시처리
CREATE OR REPLACE PROCEDURE my_param_test_proc
(p_var1 IN VARCHAR2,    --값을 받는 용도로만 사용가능, 반환불가
p_var2 OUT VARCHAR2,    --프로시저가 끝나기전까지 값의 할당이 안됨. 끝나야만 OUT이 가능
p_var3 IN OUT VARCHAR2) --IN, OUT이 둘다 가능함!
IS

BEGIN
     dbms_output.put_line('p_var1: '||p_var1); --당연히 됨
     dbms_output.put_line('p_var2: '||p_var2); --값이 전달되지 않음(공백)
     dbms_output.put_line('p_var3: '||p_var3); --IN의성질도 가짐(값이 전달됨.
     
     --p_var1 :='결과1'; --IN변수는 값에 대입할수 없음!(값 할당불가!)
     p_var2 :='결과2';
     p_var3 :='결과3';
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
    p_result OUT VARCHAR2) --procedure가 끝날떄 값이 출력됨.
IS
    v_cnt NUMBER :=0;
    v_result VARCHAR2(100) := '값이 없어서 INSERT처리 되었습니다.';
BEGIN
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    IF v_cnt=0 THEN 
        dbms_output.put_line(p_job_id  || '는 테이블에 존재하지 않습니다.');
        return; --프로시저 강제 종료
    END IF;
    
    SELECT
    p_job_id  ||'의 최대 연봉:' ||max_salary ||'의 최소연봉:' ||min_salary
    INTO 
         v_result
    FROM jobs
    WHERE job_id = p_job_id;
       
    --OUT 매개변수에 결과를 할당.
    p_result := v_result;
    COMMIT;
END;

DECLARE
    str VARCHAR2(100);
BEGIN
   my_new_procedure('JOB3' ,str); --str 변수에 v_result 결과값을 할당
   dbms_output.put_line(str);
END; 


--예외처리
/*
OTHERS 자리에 예외의 타입을 작성해 줍니다.
ACCESS_INTO_NULL->객체 초기화가 되어있지 않은 상태에서 사용
NO_DATA_FOUND _> SELECT INTO시 데이터가 한 건도 없을 때
ERROR_DIVIDE _> 0으로 나눌때
VALUE_ERROR ->수치 또는 값 오류
INVALID_NUMBERS -> 문자를 숫자로 변환시 실패한 경우
*/
DECLARE
    v_num NUMBER := 0;
BEGIN
    v_num :=10/0;
EXCEPTION 
    WHEN ZERO_DIVIDE THEN --OTHER ->JAVA의 EXCPETION과 비슷
    dbms_output.put_line('0으로 나눌수 없습니다.');
    dbms_output.put_line('SQL ERROR CODE: ' || SQLCODE);
    dbms_output.put_line('SQL ERROR MSG: ' || SQLERRM);
    WHEN OTHERS THEN 
        dbms_output.put_line('알수 없는 예외 발생');
END;

DECLARE
    v_num NUMBER := 0;
BEGIN
    v_num :=10/0;
EXCEPTION WHEN OTHERS THEN --OTHER ->JAVA의 EXCPETION과 비슷
    dbms_output.put_line('0으로 나눌수 없습니다.');
    dbms_output.put_line('SQL ERROR CODE: ' || SQLCODE);
    dbms_output.put_line('SQL ERROR MSG: ' || SQLERRM);
END;