--1. 구구단중 3단을 출력하는 익명블록 생성 출력문 9개를 복사해서 선언
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


--2. employees테이블에서 201번 사원의 이름과 이메일 주소출력하는 익명블록생성후 변수에 담아출력

DECLARE                                   
    v_emp_name employees.first_name%TYPE; --사원명 변수(문자열 변수는 길이제약필요)
    v_emp_email employees.email%TYPE; --부서명 변수
BEGIN
    SELECT first_name, email
    INTO v_emp_name, v_emp_email
    FROM employees e
    WHERE employee_id = 201;
    dbms_output.put_line(v_emp_name || '-' || v_emp_email);
END;


--employees 테이블에서 사원번호가 제일 큰 사원을 찾아낸뒤(MAX함수)
--이 번호+1번으로 아래의 사원을 emps테이블에 employee_id, last_name, email hire_date, job_id
--SELECT이후INSERT 사용
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
사원명: steven
이메일: stevenjobs
입사일자: 오늘
job_id: CEO
*/
