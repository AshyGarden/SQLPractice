--�����Լ�
--ROUND(�ݿø�), ���ϴ� �ݿø� ��ġ�� �Ű������� ����, ������ ����
SELECT 
ROUND(3.3145,3), --�Ҽ��� 3��° �ڸ�����
ROUND(45.923,0), --�Ҽ��� 0��° �ڸ�����
ROUND(45.923,-1) --�Ҽ��� -1��° �ڸ�(1�� �ڸ�����) �ݿø�
FROM dual;

--TRUNC
--������ �Ҽ��� �ڸ������� �߶�
SELECT
TRUNC(3.3145,3), --�Ҽ��� 3��° �ڸ����� �ڸ�
TRUNC(45.923,0), --�Ҽ��� 0��° �ڸ����� �ڸ�
TRUNC(45.923,-1) --�Ҽ��� -1��° �ڸ�(1�� �ڸ�����)���� �ڸ�
FROM dual;

--ABS(���밪)
SELECT ABS(-34) FROM dual;


--ceil(�ø�) floor(����)
SELECT CEIL(3.14),FLOOR(3.14)
FROM dual;

--MOD(������)
SELECT 
10/4 ,
--10%4 --����
MOD(10,4)
FROM dual;

--��¥ �Լ�
SELECT sysdate FROM dual; --���糯¥

SELECT systimestamp FROM dual;--���糯¥ �ð�����

--��¥������ ������ �����ϴ�.
SELECT sysdate + 1 FROM dual;

SELECT first_name, sysdate-hire_date 
FROM employees;

SELECT first_name, sysdate-hire_date,
(sysdate - hire_date) /365 AS year
FROM employees;

--��¥ �ݿø� ����
SELECT ROUND(sysdate) FROM dual;           --�Ϸ� ����(������ ������ ����)
SELECT ROUND(sysdate, 'year') FROM dual;   --1�� ���� �ݿø�
SELECT ROUND(sysdate, 'month') FROM dual;  --1�� ���� �ݿø�
SELECT ROUND(sysdate, 'day') FROM dual;    --1���� ���� �ݿø�(��~�� ����,������ ���� 12�� �������ιݿø�)

SELECT TRUNC(sysdate) FROM dual;           --�Ϸ� ���� �ڸ�
SELECT TRUNC(sysdate, 'year') FROM dual;   --1�� ���� �ڸ�
SELECT TRUNC(sysdate, 'month') FROM dual;  --1�� ���� �ڸ�
SELECT TRUNC(sysdate, 'day') FROM dual;    --1���� ���� �ڸ�(��~�� ����,������ ���� 12�� �������ιݿø�)