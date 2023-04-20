
--Sequence(순차적으로 증가하는 값을 만들어주는 객체)

--Sequence 생성
CREATE SEQUENCE dept3_seq --괄호를 열지 않음
    START WITH 1   --시작값(기본값은 증가할때 최소값, 감소할떄 최대값) (,)찍지 않음
    INCREMENT BY 1 --증가값(양수면 증가, 음수면 감소, 기본값 1)
    MAXVALUE 10    -- 최대값(기본값- 증가할 때 1027, 감소할 때 -1)
    MINVALUE 1     --최소값(기본값- 증가일 때 1, 감소일 때 -1028)
    NOCACHE        -- 캐시메모리 사용여부 (CACHE)
    NOCYCLE        -- 순환여부 (NOCYCLE이 기본, 순환시키려면 CYCLE)
;  


DROP TABLE dept3;
CREATE TABLE dept3(
dept_no NUMBER(2) PRIMARY KEY,
dept_name VARCHAR2(14),
loca VARCHAR2(13),
dept_date DATE
);

INSERT INTO dept3
VALUES(1, 'test', 'test', sysdate);
INSERT INTO dept3
VALUES(2, 'test', 'test', sysdate);
INSERT INTO dept3
VALUES(3, 'test', 'test', sysdate);
--INSERT INTO dept3
--VALUES(3, 'test', 'test', sysdate);

--Sequence 사용방법
INSERT INTO dept3
VALUES(dept3_seq.NEXTVAL, 'test', 'test', sysdate);

SELECT * FROM dept3;

--현재 Sequence진행 횟수(값)
SELECT dept3_seq.CURRVAL FROM dual; 


--Sequence 수정
ALTER SEQUENCE dept3_seq MAXVALUE 9999;   --최대값 증가
ALTER SEQUENCE dept3_seq INCREMENT BY 10; --증감값 변경
ALTER SEQUENCE dept3_seq MINVALUE 0;      --최소값 변경
--Start WITH는 수정이 불가능.

SELECT dept3_seq.CURRVAL FROM dual; 

--시퀀스 값을 다시 처음으로 되돌리는 법(현재 증감 10)
ALTER SEQUENCE dept3_seq INCREMENT BY -9;
SELECT dept3_seq.CURRVAL FROM dual; 
ALTER SEQUENCE dept3_seq INCREMENT BY 1;

DROP SEQUENCE dept3_seq;
------------------------------------------------------
/*
- index
index는 primary key, unique 제약 조건에서 자동으로 생성되고,
조회를 빠르게 해 주는 hint 역할을 합니다.
index는 조회를 빠르게 하지만, 무작위하게 많은 인덱스를 생성해서
사용하면 오히려 성능 부하를 일으킬 수 있습니다.
정말 필요할 때만 index를 사용하는 것이 바람직합니다.
*/

SELECT * FROM employees WHERE salary = 12008;

--INDEX추가
CREATE INDEX emp_salary_idx ON employees(salary);
DROP INDEX emp_salary_idx;

--SEQUENCE+INDEX를 사용하는 HINT
CREATE SEQUENCE board_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE TABLE tbl_board(
    bno NUMBER(10) PRIMARY KEY,
    writer VARCHAR2(20)
);

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'test');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'admin');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'hong');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'kim');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'test');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'test');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'admin');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'hong');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'kim');

SELECT * FROM tbl_board;

COMMIT;
--인덱스 이름 변경
ALTER INDEX SYS_C007060
RENAME TO tb1_board_idx;


SELECT * FROM 
        (SELECT 
         ROWNUM AS RN, 
         a *
         FROM(
                SELECT *
                FROM tbl_board
                ORDER BY bno DESC
            ) a
         )
WHERE RN <=10 AND RN <= 20;
                
--INDEX(table_name index_name)
--지정된 인덱스를 강제로 쓰게끔 지정.
--INDEX ASC, DESC를 추가가능

SELECT * FROM 
        (
        SELECT /*INDEX_DESC(tb1_board tb1_board_idx)*/  --이렇게 적어주면 orderby사용 안해도됨
        ROWNUM AS RN, 
        bno, 
        writer
        FROM tbl_board                
         )
WHERE RN >10 AND RN <= 20;

/*
- 인덱스가 권장되는 경우 
1. 컬럼이 WHERE 또는 조인조건에서 자주 사용되는 경우
2. 열이 광범위한 값을 포함하는 경우
3. 테이블이 대형인 경우
4. 타겟 컬럼이 많은 수의 null값을 포함하는 경우.
5. 테이블이 자주 수정되고, 이미 하나 이상의 인덱스를 가지고 있는 경우에는
 권장하지 않습니다.
*/

