/*
-NUMBER(2) -> ������ 2�ڸ����� �����Ҽ��ִ� ������ Ÿ��.
-NUMBER(5,2) -> ������, �Ǽ��θ� ��ģ �� �ڸ����� 5, �Ҽ��� 2�ڸ����� �����Ҽ��ִ� ������ Ÿ��.
-NUMBER ->��ȣ ������ (38, 0)���� �ڵ� ����

VARCHAR2(byte) -> ��ȣ�ȿ� ���� ���ڿ��� �ִ� ���̸� ���� (4000byte����)
-CLOB -> ��뷮 �ؽ�Ʈ ������ Ÿ�� (�ִ� 4GB)
-BLOB -> ������ ��뷮 ��ü(�̹���, ���� ����� ���)
-DATE -> BC4712�� 1�� 1�� ~AD9999�� 12�� 31�ϱ��� ���� ����
-��, ��, �� ��������
*/

--���̺� ����
CREATE TABLE dept2(
dept_no NUMBER(2),
dept_name VARCHAR2(14),
loca VARCHAR2(15),
dept_date DATE,
dept_bonus NUMBER(10)
);

DESC dept2;
SELECT * FROM dept2;

INSERT INTO dept2
VALUES(40, '������', '����', sysdate, 2000000);

INSERT INTO dept2
VALUES(400, '�濵����', '����', sysdate, 2000000);

--Į�� �߰�
ALTER TABLE dept2
ADD (dept_count NUMBER(3));

--���̸� ����
ALTER TABLE dept2
RENAME COLUMN dept_count TO emp_count;

--�� �Ӽ� ����
--�����ϰ��� �ϴ� �÷��� �����Ͱ� �̹� �����Ѵٸ� �׿� �´� Ÿ������ �������࿩�Ѵ�.
ALTER TABLE dept2
MODIFY (emp_count NUMBER(4));

ALTER TABLE dept2
MODIFY (dept_name VARCHAR2(20));

--�Ӽ��� ������ Ÿ���� ���� �Ұ�! (���� �ʴ� Ÿ�����δ� ����Ұ�!)
ALTER TABLE dept2
MODIFY (dept_name NUMBER(20));

ALTER TABLE dept2
DROP COLUMN emp_count;

--���̺� �̸� ����
ALTER TABLE dept2
RENAME TO dept3;

--���̺� ������ ���� ����(������ ����� ���� �����͸� ��λ���)
TRUNCATE TABLE dept3;

--���̺� ��ü�� ����
DROP TABLE dept3;


