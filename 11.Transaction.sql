SELECT * FROM emps;

INSERT INTO emps
(employee_id, last_name, email,hire_date, job_id)
VALUES
(303, 'kim', 'abc123@naver.com', sysdate, 1800);

--�������� ��� ������ ��������� ���(���), ���� Ŀ�� �ܰ�� ȸ��(���ư���) �� Ʈ����� ����
ROLLBACK;

--���̺�����Ʈ
--�ѹ��� ����Ʈ�� ���� �̸��� �ٿ��� ����
--ANSIǥ�ع����� �ƴ� ORACLE���� ����! = �������� ����.
SAVEPOINT insert_kim;
ROLLBACK TO SAVEPOINT insert_kim;

--�������� ��� ������ ��������� ���������� �����ϸ鼭 Ʈ����� ����
--Ŀ�� ���Ŀ��� ��� ����� ����ϴ��� �ǵ���������.
COMMIT;

--����Ŀ�Կ��� Ȯ��
SHOW AUTOCOMMIT; --����Ŀ�� ���� Ȯ��
SET AUTOCOMMIT ON; -- ����Ŀ�� ON
SET AUTOCOMMIT OFF; -- ����Ŀ�� OFF

DELETE FROM emps WHERE employee_id =303;