
/*
TRIGGER�� ���̺� ��Ź�� ���·� 
INSERT,UPDATE,DELETE�۾��� ����ɶ�
Ư���ڵ尡 �۵��ǵ��� �ϴ� ����
VIEW���� ���� �Ұ���!

Ʈ���Ÿ� ���鶧 ���������ϰ� F5��ư���� �κн��� �ؾ��Ѵ�.
�׷��� ������ �ϳ��� �������� �νĵǾ� ���������� �ʴ´�.
*/

CREATE TABLE tbl_test(
id NUMBER(10),
text VARCHAR2(20)
);

CREATE OR REPLACE TRIGGER trig_test --��ȣ,�޸�(,)����������
    AFTER DELETE OR UPDATE --Ʈ������ �߻�����(���� or ���� ���Ŀ� ����)
    ON tbl_test -- Ʈ���Ÿ� ������ ���̺�
    FOR EACH ROW -- �� �࿡ ��� ����(��������, ������ 1���� ����!)
--DECLARE ��������!
BEGIN
    dbms_output.put_line('Ʈ���� �ߵ�!'); --�����ϰ��� �ϴ� �ڵ带 begin~end���̿� �ֱ�
END;


INSERT INTO tbl_test VALUES(1,'��ö��'); --TRIGGER���� x
UPDATE tbl_test SET text = '��ǻ�' WHERE id =1;
DELETE FROM tbl_test WHERE id =1;


