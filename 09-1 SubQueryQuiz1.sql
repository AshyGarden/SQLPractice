
/*
���� 1.

1-1. EMPLOYEES ���̺��� ��� ������� ��ձ޿����� 
���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)                                        */
SELECT * FROM employees                      
WHERE salary > (SELECT AVG(salary) 
FROM employees);   -- 1-1

--1-2. EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
SELECT COUNT(*) FROM employees                      
WHERE salary > (SELECT AVG(salary) 
FROM employees);

--1-3. EMPLOYEES ���̺��� job_id�� IT_PROG�� ������� ��ձ޿����� 
--     ���� ������� �����͸� ����ϼ���
SELECT * FROM employees                      
WHERE salary > (SELECT AVG(salary) 
                FROM employees e
                WHERE e.job_id = 'IT_PROG'); --1-3


/*���� 2.
-DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id��
EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.   */
SELECT * FROM employees e
WHERE department_id IN
( SELECT department_id
  FROM departments d
 WHERE manager_id = 100);

/*_���� 3.
-EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
-EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.*/
SELECT * FROM employees
WHERE manager_id >
ALL( SELECT manager_id
     FROM employees
     WHERE first_name = 'Pat'); --3-1
     
     
SELECT * FROM employees e
WHERE e.manager_id IN
(SELECT manager_id
 FROM employees
 WHERE first_name = 'James'); --3-2


/*���� 4.
-EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�,
41~50��° �������� �� ��ȣ, �̸��� ����ϼ���*/
SELECT * FROM( SELECT ROWNUM AS RN, tb1.first_name
               FROM (SELECT *
                     FROM employees
                     ORDER BY first_name DESC
                     ) tb1
              )
WHERE RN >40 and RN<=50; 

/*���� 5.
-EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 
31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, �Ի����� ����ϼ���.*/
SELECT * FROM( SELECT ROWNUM AS RN, tb1.*
               FROM (SELECT employee_id, 
                            first_name, 
                            phone_number, 
                            hire_date
                     FROM employees
                     ORDER BY hire_date ASC
                     ) tb1
              )
WHERE RN >30 and RN<=40; 
/*
���� 6.
employees���̺� departments���̺��� left �����ϼ���
����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
����) �������̵� ���� �������� ����                                      */
SELECT e.employee_id, 
       e.first_name||' '||e.last_name AS name, 
       d.department_id, d.department_name
FROM employees e
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.employee_id ASC;

/* ���� 7.
���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���*/
SELECT e.employee_id, 
       e.first_name||' '||e.last_name AS name, 
       e.department_id,( 
       SELECT department_name
       FROM departments d
       WHERE d.department_id = e.department_id
       ) AS department_name
FROM employees e
ORDER BY employee_id ASC;

/*���� 8.
departments���̺� locations���̺��� left �����ϼ���
����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
����) �μ����̵� ���� �������� ����*/
SELECT d.department_id, d.department_name, d.manager_id, d.location_id, 
       l.street_address, l.postal_code, l.city  
FROM departments d
LEFT OUTER JOIN locations l
ON d.location_id = l.location_id
ORDER BY d.department_id ASC;

/*���� 9.
���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���*/
SELECT d.department_id, d.department_name, d.manager_id, d.location_id,
       (SELECT l.street_address
       FROM locations l
       WHERE l.location_id = d.location_id) AS street_address,
       (SELECT l.postal_code
       FROM locations l
       WHERE l.location_id = d.location_id) AS postal_code,    
       (SELECT l.city
       FROM locations l
       WHERE l.location_id = d.location_id) AS city     
FROM departments d 
ORDER BY d.department_id ASC;

/*���� 10.
locations���̺� countries ���̺��� left �����ϼ���
����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
����) country_name���� �������� ����*/ 
SELECT l.location_id, l.street_address, l.city, 
       c.country_id, c.country_name
FROM locations l LEFT OUTER JOIN countries c
ON l.country_id = c.country_id
ORDER BY c.country_name ASC;

/*���� 11.
���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���*/
SELECT l.location_id, 
       l.street_address, 
       l.city,
       (SELECT country_id
       FROM countries c
       WHERE l.country_id = c.country_id) AS country_id,
       (SELECT country_name
       FROM countries c
       WHERE l.country_id = c.country_id) AS country_name
FROM locations l
ORDER BY country_name ASC;

/*���� 12. 
employees���̺�, departments���̺��� left���� 
hire_date�� �������� �������� 1-10��° �����͸� ����մϴ�
����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, �μ����̵�, �μ��̸� �� ����մϴ�.
����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.*/
SELECT * FROM( SELECT ROWNUM AS RN, tb1.*
               FROM (SELECT e.employee_id, 
                            e.first_name, 
                            e.phone_number, 
                            e.hire_date,
                            e.department_id,
                            d.department_name
                     FROM employees e 
                     LEFT OUTER JOIN departments d
                     ON e.department_id = d.department_id
                     ORDER BY hire_date ASC
                     ) tb1
              )
WHERE RN<=10; 

--FM
SELECT * FROM (SELECT ROWNUM AS RN, a.* FROM
(SELECT e.employee_id, e.first_name,  e.phone_number, 
       e.hire_date, e.department_id, d.department_name
FROM employees e LEFT JOIN departments d
on e.department_id = d.department_id
ORDER BY hire_date ASC) a
)WHERE RN<=10; 

/*���� 13. 
--EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���.*/
SELECT e.last_name, e.job_id, e.department_id, 
       ( SELECT department_name
       FROM departments d
       WHERE d.department_id = e.department_id
       ) AS department_name
FROM employees e
WHERE job_id = 'SA_MAN';



/*���� 14
--DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
--�ο��� ���� �������� �����ϼ���.
--����� ���� �μ��� ������� ���� �ʽ��ϴ�.*/
SELECT * FROM( SELECT department_id, department_name, manager_id, 
                      (SELECT COUNT(e.department_id) 
                       FROM employees e
                       WHERE e.department_id = d.department_id) AS PersonNumbers
                       FROM departments d)
          WHERE PersonNumbers >all 0
ORDER BY PersonNumbers DESC;

--FM
SELECT d.department_id, department_name, manager_id, a.total
FROM departments d
JOIN (SELECT department_id, COUNT(*) AS total
FROM employees
GROUP BY department_id) a
ON d.department_id = a.department_id
ORDER BY a.total DESC;

/*���� 15
--�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���.
--�μ��� ����� ������ 0���� ����ϼ���.*/
SELECT d.*, l.street_address, l.postal_code,
       NVL((SELECT ROUND(AVG(salary),2)
       FROM employees e
       WHERE e.department_id = d.department_id
       GROUP BY e.department_id),0) AS AverageSalary
FROM departments d
LEFT OUTER JOIN locations l
ON l.location_id = d.location_id;
--ORDER BY d.department_id ASC;

--FM
SELECT d.*, l.street_address, l.postal_code, NVL(tb1.result, 0)
FROM departments d
JOIN locations l
ON d.location_id = l.location_id
LEFT OUTER JOIN
(SELECT department_id, TRUNC(AVG(salary)) As Result
FROM employees
GROUP BY department_id
) tb1
ON d.department_id = tb1.department_id;


���� 16
-���� 15 ����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
����ϼ���.
SELECT * FROM( SELECT ROWNUM AS RN, tb1.* 
FROM ( SELECT d.*, l.street_address, l.postal_code,
       NVL((SELECT ROUND(AVG(salary),2)
       FROM employees e
       WHERE e.department_id = d.department_id
       GROUP BY e.department_id),0) AS AverageSalary
       FROM departments d
       LEFT OUTER JOIN locations l
       ON l.location_id = d.location_id
       ORDER BY d.department_id DESC)tb1
       )
WHERE RN<=10; 

--FM
SELECT * FROM( 
SELECT ROWNUM AS RN, tb2.* 
FROM (SELECT d.*, l.street_address, l.postal_code, NVL(tb1.result, 0)
FROM departments d
JOIN locations l
ON d.location_id = l.location_id
LEFT OUTER JOIN
    (SELECT department_id, TRUNC(AVG(salary)) As Result
     FROM employees
     GROUP BY department_id
     ) tb1
ON d.department_id = tb1.department_id
ORDER BY d.department_id DESC
) tb2
)WHERE RN<=10; 