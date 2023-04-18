--INNER JOIN
--ANSI
SELECT *
FROM info i
INNER JOIN auth a
ON i.auth_id = a.auth_id;

--ORACLE
SELECT *
FROM info i, auth a
WHERE i.auth_id = a.auth_id;

--auth.id�÷��� �׳ɾ��� ��ȣ�ϴٰ� �� (�Ѵ� �����ϱ⶧����)
--�̷����� �÷��� ���̺� �̸��� ���̰ų� ��Ī���Ἥ Ȯ���� �������ֱ�
SELECT 
a.auth_id, i.title ,i.content ,a.name
FROM info i
INNER JOIN auth a
ON i.auth_id = a.auth_id
WHERE a.name =' �̼���';

--OUTER JOIN
SELECT *
FROM info i LEFT OUTER JOIN auth a
ON i.auth_id = a.auth_id;

SELECT *
FROM info i RIGHT JOIN auth a
ON i.auth_id = a.auth_id;

--���� ���̺�� ���� ���̺� �����͸� ��� �о� �ߺ������ʹ� �����Ǵ� �ܺ�����
SELECT *
FROM info i FULL JOIN auth a
ON i.auth_id = a.auth_id;

--CROSS JOIN - JOIN������ �������� �ʴ� JOIN(���� �ʾ�)
--��� �÷��� ���� JOIN����
SELECT * FROM info
CROSS JOIN auth
ORDER BY id ASC;

--������ ���̺� ����-> Ű���� ã�Ƽ� ������ ������ ���
SELECT *
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN locations loc ON d.location_id = loc.location_id;

/*
���̺� ��Ī a,i�� �̿��ؼ� LEFT OUTER JOIN���
info auth
jobĮ���� scientist�� ����� id,title content job�� ���
*/
SELECT i.auth_id, i.title, i.content, a.JOB
FROM info i, auth a
LEFT JOIN a.JOB = 'scientist';

-FM
SELECT i.id, i.title, i.content, a.job
FROM auth a LEFT JOIN info i
ON a.auth_id = i.auth_id
WHERE a.job= 'scientist';

--���������̶� ���� ���̺� ������ ����
--���� ���̺� �÷��� ���� ������ �����ϴ� ���� ��Ī���� �����ö� ���
SELECT
e1.employee_id, e1.first_name, e1.manager_id,
e2.first_name ,e2.employee_id
FROM employees e1
JOIN employees e2
ON e1.manager_id = e2.employee_id;