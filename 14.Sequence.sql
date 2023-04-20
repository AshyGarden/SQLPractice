
--Sequence(���������� �����ϴ� ���� ������ִ� ��ü)

--Sequence ����
CREATE SEQUENCE dept3_seq --��ȣ�� ���� ����
    START WITH 1   --���۰�(�⺻���� �����Ҷ� �ּҰ�, �����ҋ� �ִ밪) (,)���� ����
    INCREMENT BY 1 --������(����� ����, ������ ����, �⺻�� 1)
    MAXVALUE 10    -- �ִ밪(�⺻��- ������ �� 1027, ������ �� -1)
    MINVALUE 1     --�ּҰ�(�⺻��- ������ �� 1, ������ �� -1028)
    NOCACHE        -- ĳ�ø޸� ��뿩�� (CACHE)
    NOCYCLE        -- ��ȯ���� (NOCYCLE�� �⺻, ��ȯ��Ű���� CYCLE)
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

--Sequence �����
INSERT INTO dept3
VALUES(dept3_seq.NEXTVAL, 'test', 'test', sysdate);

SELECT * FROM dept3;

--���� Sequence���� Ƚ��(��)
SELECT dept3_seq.CURRVAL FROM dual; 


--Sequence ����
ALTER SEQUENCE dept3_seq MAXVALUE 9999;   --�ִ밪 ����
ALTER SEQUENCE dept3_seq INCREMENT BY 10; --������ ����
ALTER SEQUENCE dept3_seq MINVALUE 0;      --�ּҰ� ����
--Start WITH�� ������ �Ұ���.

SELECT dept3_seq.CURRVAL FROM dual; 

--������ ���� �ٽ� ó������ �ǵ����� ��(���� ���� 10)
ALTER SEQUENCE dept3_seq INCREMENT BY -9;
SELECT dept3_seq.CURRVAL FROM dual; 
ALTER SEQUENCE dept3_seq INCREMENT BY 1;

DROP SEQUENCE dept3_seq;
------------------------------------------------------
/*
- index
index�� primary key, unique ���� ���ǿ��� �ڵ����� �����ǰ�,
��ȸ�� ������ �� �ִ� hint ������ �մϴ�.
index�� ��ȸ�� ������ ������, �������ϰ� ���� �ε����� �����ؼ�
����ϸ� ������ ���� ���ϸ� ����ų �� �ֽ��ϴ�.
���� �ʿ��� ���� index�� ����ϴ� ���� �ٶ����մϴ�.
*/

SELECT * FROM employees WHERE salary = 12008;

--INDEX�߰�
CREATE INDEX emp_salary_idx ON employees(salary);
DROP INDEX emp_salary_idx;

--SEQUENCE+INDEX�� ����ϴ� HINT
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
--�ε��� �̸� ����
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
--������ �ε����� ������ ���Բ� ����.
--INDEX ASC, DESC�� �߰�����

SELECT * FROM 
        (
        SELECT /*INDEX_DESC(tb1_board tb1_board_idx)*/  --�̷��� �����ָ� orderby��� ���ص���
        ROWNUM AS RN, 
        bno, 
        writer
        FROM tbl_board                
         )
WHERE RN >10 AND RN <= 20;

/*
- �ε����� ����Ǵ� ��� 
1. �÷��� WHERE �Ǵ� �������ǿ��� ���� ���Ǵ� ���
2. ���� �������� ���� �����ϴ� ���
3. ���̺��� ������ ���
4. Ÿ�� �÷��� ���� ���� null���� �����ϴ� ���.
5. ���̺��� ���� �����ǰ�, �̹� �ϳ� �̻��� �ε����� ������ �ִ� ��쿡��
 �������� �ʽ��ϴ�.
*/

