--����� ����Ȯ��
SELECT * FROM all_users;

--���� ���� ���
CREATE USER user1 IDENTIFIED BY user1; -- ERROR
--insufficient privileges

CREATE USER user1 IDENTIFIED BY user1;

/*
DCL (DATA CONTROL LANGUAGE)
GRANT (���� �ο�)
REVOKE (���� ȸ��)
*/


/*
CREATE USER -> �����ͺ��̽� ���� ���� ����
CREATE SESSION -> �����ͺ��̽� ���� ����
CREATE TABLE -> ���̺� ���� ����
CREATE VIEW -> �� ���� ����
CREATE SEQUENCE -> ������ ���� ����
ALTER ANY TABLE -> ��� ���̺� ������ �� �ִ� ����
INSERT ANY TABLE -> ��� ���̺��� �����͸� �����ϴ� ����.
SELECT ANY TABLE...

SELECT ON [���̺� �̸�] TO [���� �̸�] -> Ư�� ���̺� ��ȸ�� �� �ִ� ����.
INSERT ON....
UPDATE ON....

- �����ڿ� ���ϴ� ������ �ο��ϴ� ����.
RESOURCE, CONNECT, DBA TO [���� �̸�]
*/

GRANT CREATE SESSION TO user1;
GRANT SELECT ON hr.employees To user1;
GRANT CREATE TABLE TO user1;

GRANT CONNECT, RESOURCE TO user1;
REVOKE CONNECT, RESOURCE FROM user1;

--����� ��������
--DROP USER[�����̸�] CASCADE;
--CASCADE ������ ->���̺��̳� �������� �����س��� �����̶�� ������ �����������
DROP USER user1 CASCADE; 

/*
���̺� �����̽��� �����ͺ��̽� ��ü �� ���� �����Ͱ� ����Ǵ� �����Դϴ�.
���̺� �����̽��� �����ϸ� ������ ��ο� ���� ���Ϸ� ������ �뷮��ŭ��
������ ������ �ǰ�, �����Ͱ� ���������� ����˴ϴ�.
�翬�� ���̺� �����̽��� �뷮�� �ʰ��Ѵٸ� ���α׷��� ������������ �����մϴ�.
*/

SELECT * FROM dba_tablespaces;

CREATE USER test1 IDENTIFIED BY test1;
GRANT CREATE SESSION TO test1;
GRANT CONNECT, RESOURCE TO test1;

--USER_TABLESPACE���̺� �����̽��� �⺻ ��� �������� ����.
ALTER USER test1 DEFAULT TABLESPACE user_tablespace
QUOTA UNLIMITED ON user_tablespace;

--tablespace �� ��ü ��ü�� ����
DROP TABLESPACE user_tablespace INCLUDING CONTENTS; --�� DBF������ ���´�!

--������ ���ϱ��� 1���� �����ϴ� ��
DROP TABLESPACE user_tablespace INCLUDING CONTENTS AND DATAFILES;