--����ȯ �Լ� TO_CHAR, TO_NUMBER, TO_DATE
--��¥�� ���ڷ� TO_CHAR(��,����)
SELECT
    sysdate
FROM
    dual;

SELECT
    to_char(sysdate, 'YYYY-MM-DDHH:MI:SS')
FROM
    dual;

SELECT
    to_char(sysdate, 'YYYY-MM-DD DAY PM HH:MI:SS')
FROM
    dual;

SELECT
    to_char(sysdate, 'YY-MM-HH24:MI:SS')
FROM
    dual;
--��� ����ó��
SELECT
    first_name,
    to_char(hire_date, 'YYYY"��" MM"��" DD"��"')
FROM
    employees;

--���ڸ� ���ڷ� TO_CHAR(��, ����)(���� 9�� �ڸ���ǥ��)
SELECT
    to_char(20000, '99999')
FROM
    dual;
--�־��� �ڸ����� ��� ǥ�� �Ҽ� ���ٸ� ��� #���� ǥ���.
SELECT
    to_char(20000, '9999')
FROM
    dual;

SELECT
    to_char(20000.26, '99999.9')
FROM
    dual; --�ݿø��� ó������
SELECT
    to_char(20000, '99,999')
FROM
    dual;

SELECT
    to_char(salary, '99,999') AS salary
FROM
    employees;

SELECT
    to_char(salary, 'L99,999') AS salary --���� �տ� L���̸� ��뱹���� ȭ������� �ٿ���
FROM
    employees;

--���ڸ� ���ڷ� TO_NUMBER(��, ����)
SELECT
    '2000' + 2000
FROM
    dual; --�ڵ� �� ��ȯ(����->����)
SELECT
    TO_NUMBER('2000') + 2000
FROM
    dual; --����� �� ��ȯ
SELECT
    '$3,300' + 2000
FROM
    dual;--����
SELECT
    TO_NUMBER('$3,300', '$9,999') + 2000
FROM
    dual;--������ ����

--���ڸ� ��¥�� ��ȯ�ϴ� �Լ� TO_DATE(��, ����)
SELECT
    TO_DATE('2023-04-13')
FROM
    dual;

SELECT
    sysdate - '2023-04-13'
FROM
    dual; --����(��¥���� ���ڿ�)
SELECT
    sysdate - TO_DATE('2023-04-13')
FROM
    dual;

SELECT
    TO_DATE('2020/12/25', 'YY-MM-DD')
FROM
    dual;

SELECT
    TO_DATE('2020-12-25 12:13:50', 'YY-MM-DD')
FROM
    dual; 
-- �ð��� �ٲٴ� �������� �����ֹǷ� ����(��� ��ȯ�������!)��� ��ȯ�������!
SELECT
    TO_DATE('2020-12-25 12:13:50', 'YY-MM-DD HH:MI:SS')
FROM
    dual;

SELECT
    '20050102'
FROM
    dual;
--����->��¥ ��ȯ->���ڷ� �ٽú�ȯ
SELECT
    to_char(TO_DATE('20050102', 'YYYY/MM/DD'), 'YYYY"��" MM"��" DD"��"') AS dateinfo
FROM
    dual;

--NULL �����Լ� NVL(Į��, ��ȯ�� Ÿ�ٰ�)
SELECT
    NULL
FROM
    dual;

SELECT
    nvl(NULL, 0)
FROM
    dual;

SELECT
    first_name,
    nvl(commission_pct, 0) AS comm_pct
FROM
    employees;

--NULL �����Լ� NVL2(Į��, null�� �ƴ� ��� ��, null�� ����� ��)
SELECT
    nvl2('abc', '�� �ƴ�!', '�� ��')
FROM
    dual;

SELECT
    nvl2(NULL, '�� �ƴ�!', '�� ��')
FROM
    dual;

SELECT
    first_name,
    nvl2(commission_pct, 'true', 'false') AS comm_pct
FROM
    employees;

SELECT
first_name, 
NVL2(commission_pct, salary + (salary * commission_pct),salary) AS real_salary 
FROM employees;

--DECODE(�÷� Ȥ�� ǥ����, �׸�1, ���1, �׸�2, ���2 ...default);
SELECT
DECODE('F','A','A�Դϴ�','B','B�Դϴ�','C','C�Դϴ�','D','D�Դϴ�','�𸣰ڴµ���?')
FROM dual;


SELECT
job_id,
salary,
DECODE(job_id,
'IT_PROG',salary*1.1,
'FT_MGR',salary*1.2,
'AD_VP',salary*1.3,
salary)AS result
FROM employees;

--CASE WHEN THEN END
SELECT 
first_name,
job_id,
salary,
(CASE job_id
WHEN'IT_PROG' THEN salary*1.1
WHEN'FT_MGR' THEN salary*1.2
WHEN'AD_VP' THEN salary*1.3
ELSE salary END)AS result
FROM employees;
/*
���� 1.
�������ڸ� �������� EMPLOYEE���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 17�� �̻���
����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������. 
���� 1) �ټӳ���� ���� ��� ������� ����� �������� �մϴ�*/    
SELECT
employee_id AS �����ȣ,
first_name||' '||last_name AS �����,
hire_date AS �Ի�����,
Round((sysdate - hire_date)/365) AS �ټӳ��
FROM employees
WHERE Round((sysdate - hire_date)/365)>=17 --'�ټӳ��'>17 --����� �ټӳ�� �ȵ�(������� FROM-WHERE-SELECT-ORDER)
ORDER BY Round((sysdate - hire_date)/365) DESC; --����� �ټӳ�� ����
    
--FM
SELECT
employee_id AS �����ȣ,
CONCAT(first_name,last_name) AS �����,
hire_date AS �Ի�����,
TRUNC((sysdate - hire_date)/365) AS �ټӳ��
FROM employees
WHERE (sysdate - hire_date) / 365 >= 17 --'�ټӳ��'>17
ORDER BY �ټӳ�� DESC;
/*
���� 2.
EMPLOYEE ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
100�̶�� �������, 
120�̶�� �����ӡ�
121�̶�� ���븮��
122��� �����塯
�������� ���ӿ��� ���� ����մϴ�.
���� 1) manager_id�� 50�� ������� ������θ� ��ȸ�մϴ�
*/

SELECT 
first_name||' '||last_name AS �����,
manager_id,
(CASE manager_id
WHEN 100 THEN '���'
WHEN 120 THEN '����'
WHEN 121 THEN '�븮'
WHEN 122 THEN '����'
ELSE '�ӿ�' END)AS ����
FROM employees
WHERE department_id =50;

-- DECODE=���������Ұ�, ��Ȯ�� �������ð� �ʿ�
SELECT
salary,
employee_id,
first_name,
DECODE( 
salary,
salary>=4000, 'A',
salary>=3000 AND salary<4000, 'B',
salary>=2000 AND salary<3000, 'C',
salary>=1000 AND salary<2000, 'D',
salary>=0 AND salary<1000, 'E',
'F')AS grade
FROM employees
ORDER BY salary DESC;

SELECT
salary,
employee_id,
first_name,
DECODE( 
TRUNC(salary/3000),
0, 'E',
1, 'D',
2, 'C',
3, 'B',
'A')AS grade
FROM employees
ORDER BY salary DESC;

SELECT
salary,
employee_id,
first_name,
(CASE
WHEN salary BETWEEN 0 AND 999 THEN 'E'
WHEN salary BETWEEN 1000 AND 1999 THEN 'D'
WHEN salary BETWEEN 2000 AND 2999 THEN 'C'
WHEN salary BETWEEN 3000 AND 3999 THEN 'B'
ELSE 'A' END
)AS grade
FROM employees
ORDER BY salary DESC;