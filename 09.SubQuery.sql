/*
--��������
�������� ������� () �ȿ� �����
������������ �������� 1�����Ͽ�����. --������ ��������
�������� ������ ���� ����� �ݵ�� �ϳ��� ������.
�ؼ��ÿ��� �������������� ���� �ؼ��ϸ�ȴ�.*/

--- 'Nancy�� �޿����� �޿��� ���� ����� �˻��ϴ� ����.
SELECT salary
FROM employees
WHERE first_name = initcap('nancy'); --Nancy�� �޿��� ���

SELECT * FROM employees
WHERE salary > 12008;


SELECT * FROM employees                      --3. �� ����� �޿��� ���
WHERE salary > (SELECT salary FROM employees --2. �ٸ������ Nancy�� �޿����� ũ�ٸ� 
WHERE first_name = INITCAP('nancy'));        --1. Nancy�� �޿�
    
    
--employee_id�� 103���� ����� job_id�� ������ ����� �˻��ϴ� ����.
SELECT * FROM employees
WHERE job_id = (SELECT job_id FROM employees WHERE employee_id=103);
    
--���� ������ ���������� �����ϴ� ���� �������� ������ �����ڸ� ����Ҽ� ����.
--�̷��� ������ �����ڸ� ����ؾ��Ѵ�.
SELECT * FROM employees
WHERE job_id = (SELECT job_id 
                FROM employees 
                WHERE job_id='IT_PROG'); --error

--������ ������
--IN: ��Ͽ� ����� ������ Ȯ�� 
SELECT * FROM employees
WHERE job_id IN (SELECT job_id 
                FROM employees 
                WHERE job_id='IT_PROG');
                
--first_name�� David�� ����� ���� ���� ������ �޿��� ū ����� ��ȸ.
SELECT salary FROM employees WHERE first_name = INITCAP('david');

--ANY: ���� ���������� ���� ���ϵ� ������ ���� ��.
--������ �ϳ��� �����ϸ� ���
SELECT * FROM employees
WHERE salary > ANY (SELECT salary 
                  FROM employees 
                  WHERE first_name = INITCAP('david'));

--ALL: ���� ���������� ���� ���ϵ� ���� ��� ���ؼ�, ��� �����ؾ���!
SELECT * FROM employees
WHERE salary > ALL (SELECT salary 
                  FROM employees 
                  WHERE first_name = INITCAP('david'));
-------------------------------------------------------------------
--��Į�� ��������
--SELECT ������ ���������� ���°�. 
--LEFT OUTERJOIN�� ������ ����� ����.

SELECT e.first_name, d.department_name
FROM employees e
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
ORDER BY first_name ASC;

SELECT e.first_name,( 
       SELECT department_name
       FROM departments d
       WHERE d.department_id = e.department_id
       ) AS department_name
FROM employees e
ORDER BY first_name ASC;

/*
��Į�� ���������� JOIN���� ���� ���
�Լ�ó�� �� ���ڵ�� ��Ȯ�� 1���� ������ ������ ��

JOIN�� ��Į�� ������������ ���� ���
��ȸ�� �����Ͱ� ��뷮�� ���
�ش� �����Ͱ� ���� ������ ����� ���
*/

--�� �μ��� �Ŵ��� �̸�
--LEFT OUTER JOIN
SELECT d.*, e.first_name
FROM departments d
LEFT OUTER JOIN employees e
ON d.manager_id = e.employee_id
ORDER BY d.manager_id ASC;

--Scalar SubQuery
SELECT d.*,(SELECT first_name
            FROM employees e
            WHERE e.employee_id = d.manager_id
            ) AS Manager_name
FROM departments d
ORDER BY d.manager_id ASC;

--LEFT OUTER JOIN

--�� �μ��� ��� �� �̱�
--Scalar SubQuery
SELECT d.*, ( SELECT COUNT(*)
              FROM employees e
              WHERE e.department_id = d.department_id --���� �ʿ�!
              GROUP BY department_id
              ) AS  �����
FROM departments d ;
-----------------------------------------------------------------
--INLINE VIEW(FROM ������ ���������� ���°�)
--������ ���س��� ��ȸ�ڷḦ ������ �����ؼ� ������ ���� ���.
SELECT ROWNUM AS RN, employee_id, first_name, salary
FROM employees
ORDER BY salary DESC;
--salary�� ������ �����ϸ鼭 �ٷ� ROWNUM�� ���̸������� ����� ���� �ʴ´�.
--����: ROWNUM�� �����ٰ�, ������ ����Ǳ� �����̴�. (ORDERBY�� �׻� ������ ����)
--�ذ�: ������ �̸� ����� �ڷῡ ROWNUM�� �ٿ��� �ٽ� ��ȸ�ϴ°��� ����.

SELECT ROWNUM AS RN, tb1.*
FROM (SELECT employee_id, first_name, salary 
      FROM employees
      ORDER BY salary DESC) tb1; --������ ���̺�
     
      
SELECT ROWNUM AS RN, tb1.*
FROM (SELECT employee_id, first_name, salary 
      FROM employees
      ORDER BY salary DESC) tb1 --������ ���̺�
WHERE RN >10 and RN<20; --error
--ROWNUM�� ���̰� ���� ������ �����ؼ� ��ȸ�Ϸ����ϴµ�, �������� �Ұ���, ���� �Ұ���
--����: WHERE������ ���� �����ϼ� ���� ROWNUM�� SELECT�Ǳ� ����.
--�ذ�: ROWNUM���� �ٿ����� �ٽ��ѹ� �ڷḦ SELECT�ؼ� ������ �����ؾ� ��.
SELECT * FROM( SELECT ROWNUM AS RN, tb1.*
               FROM (SELECT employee_id, first_name, salary 
                     FROM employees
                     ORDER BY salary DESC
                     ) tb1
              )
WHERE RN >10 and RN<20; 
/*
���� ���� SELECT ������ �ʿ��� ���̺� ����(�ζ��� �並 ����.)
�ٱ��� SELECT������ ROWNUM�� �ٿ��� �ٽ� ��ȸ.
���� �ٱ��� SELECT�������� �̹� �پ��ִ� ROWNUM�� ������ �����ؼ� ��ȸ

SQL�������
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
*/

SELECT * 
         FROM(
         SELECT To_CHAR(TO_DATE(test, 'YY/MM/DD'), 'MMDD') AS mm, name
              FROM(
              SELECT 'ȫ�浿' AS name, '20230418' AS test FROM dual UNION ALL
              SELECT '��ö��','20230301' FROM dual UNION ALL
              SELECT '�ڿ���','230201' FROM dual UNION ALL
              SELECT '��ǻ�','20230501' FROM dual UNION ALL
              SELECT '�ڶѶ�','230601' FROM dual UNION ALL
              SELECT '���׽�Ʈ','20230701' FROM dual
              )
          )
WHERE mm='0418';
