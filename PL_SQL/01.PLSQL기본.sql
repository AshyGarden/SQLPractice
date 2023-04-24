
/*
#PL/SQL
오라클에서 제공하는 SQL프로그래밍 기능
일반적인 프로그래밍과는 차이가 있지만 오라클 내부에서 적절할 처리를 위해 적용해 줄 수있는 절차지향적 코드작성방법.
쿼리문의 집합으로 어떠한 동작을 일괄 처리하기 위한 용도
*/

--출력문 활성화
SET SERVEROUTPUT ON; 

DECLARE --변수 선언구간(선언부)
    emp_num NUMBER; --변수선언
BEGIN --코드를 실행하는 시작구간(실행부)
    emp_num := 10; --대입연산자 :=
    DBMS_OUTPUT.put_line(emp_num);
    DBMS_OUTPUT.put_line('hello PLSQL');
END; --PL/SQL이 끝나는 구간(종료부)

--연산자
--일반SQL문의 모든 연산자의 사용이 가능, ** = 제곱
DECLARE
    A NUMBER :=2**2*3**2; --4X9 =36
BEGIN
dbms_output.put_line('a: '||TO_CHAR(A));
END;

/*
-DML문
DDL문은 사용불가, 일반적으로 SQL문의 SELECT등을 사용


*/
--해당 테이블과 같은 타입의 컬럼 변수를 선언하려면
--테이블명.컬럼명%TYPE을 사용->사용자가 타입을 일일히 확인해야하는 번거로움을 방지 가능.
DECLARE                                   
    v_emp_name employees.first_name%TYPE; --사원명 변수(문자열 변수는 길이제약필요)
    v_dep_name departments.department_name%TYPE; --부서명 변수
BEGIN
    SELECT e.first_name, d.department_name
    INTO v_emp_name, v_dep_name
    FROM employees e
    LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id
    WHERE employee_id = 100;
    
    dbms_output.put_line(v_emp_name || '-' || v_dep_name);
END;
