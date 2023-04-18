--lower(�ҹ���), initcap(�� �ձ��ڸ� �빮��), upper(�빮��)
SELECT
    'abcDEF' AS origin,
    lower('abcDEF'),
    upper('abcDEF')
FROM
    dual; --dual ���̺� 
    /*
dual�̶�� ���̺��� sys(�ְ������)�� �ҽ��ϰ��ִ� ����Ŭ ǥ�� ���̺�
���� �� �࿡ �� �÷��� ����ִ� dummy���̺� �̴�.
�Ͻ����� ��� �����̳� ��¥ ���� �ַ� ���
��� ����ڰ� ���ٰ���
*/

SELECT
    last_name,
    lower(last_name),
    initcap(last_name),
    upper(last_name)
FROM
    employees;

SELECT
    last_name
FROM
    employees
WHERE
    lower(last_name) = 'austin'; --�ҹ��ڷ� ��!

--length(����), instr(����ã�� - ������ 0 ��ȯ, ������ �ε����� ��ȯ)

SELECT
    'abcDEF',
    length('abcDEF'),
    instr('abcDEF', 'a')
FROM
    dual;

SELECT
    first_name,
    length(first_name),
    instr(first_name, 'a')
FROM
    employees;

--substr(���ڿ� �ڸ���), concat(���ڿ���- ������ 2��) 1���ͽ���
SELECT
    'abcdef' AS ex,
    substr('abcdef', 1, 4),
    concat('abcdef', 'ghi')
FROM
    dual;

SELECT
    first_name,
    substr(first_name, 1, 3),
    concat(first_name, last_name)
FROM
    employees;

--LPAD(����), RPAD(����) ���� ���ڿ��� ä���
SELECT
    lpad('abc', 10, '*'),
    rpad('abc', 10, '*')
FROM
    dual;

--LTRIM() ����, RTRIM() ������, TRIM() ���� --��������
--LTRIM(param1, param2) ->param2�� ���� param1���� ã�Ƽ� ����(���ʺ���)
SELECT
    ltrim('javascript_java', 'java')
FROM
    dual;
--RTRIM(param1, param2) ->param2�� ���� param1���� ã�Ƽ� ����(�����ʺ���)
SELECT
    rtrim('javascript_java', 'java')
FROM
    dual;

SELECT
    TRIM('    java    ')
FROM
    dual; --TRIM() ���� --��������

--replace('����','������ �ܾ�','��ü�� �ܾ�') ���ڱ�ü
SELECT
    replace('My Dream is a President', 'President', 'Programmer')
FROM
    dual;

SELECT
    replace('My Dream is a President', ' ', '') --������ ���¹��ڿ�= ������ ����ڴ�.
FROM
    dual;

SELECT
    replace(replace('My Dream is a President', 'President', 'Programmer'),
            ' ',
            '')
FROM
    dual;

SELECT
    replace(concat('hello ', 'world?'),
            '?',
            '!')
FROM
    dual;
/*
���� 1.
EMPLOYEES ���̺� ���� �̸�, �Ի����� �÷����� �����ؼ� �̸������� �������� ��� �մϴ�.
���� 1) �̸� �÷��� first_name, last_name�� �ٿ��� ����մϴ�.
���� 2) �Ի����� �÷��� xx/xx/xx�� ����Ǿ� �ֽ��ϴ�. xxxxxx���·� �����ؼ� ����մϴ�
*/
SELECT
    first_name
    || ' '
    || last_name AS name,
    replace(hire_date, '/', '')
FROM
    employees
ORDER BY
    name ASC;
/*
���� 2.
EMPLOYEES ���̺� ���� phone_numbe�÷��� ###.###.####���·� ����Ǿ� �ִ�
���⼭ ó�� �� �ڸ� ���� ��� 
���� ������ȣ (02)�� �ٿ� ��ȭ ��ȣ�� ����ϵ��� ������ �ۼ��ϼ���*/
SELECT
    replace(phone_number,substr(phone_number, 1, 3),'02')
FROM
    employees;
--FM
SELECT CONCAT('(02)',substr(phone_number, 5, length(phone_number)))
FROM employees;

/*
���� 3. 
EMPLOYEES ���̺��� JOB_ID�� it_prog�� ����� �̸�(first_name)�� �޿�(salary)�� ����ϼ���.
���� 1) ���ϱ� ���� ���� �ҹ��ڷ� �Է��ؾ� �մϴ�.(��Ʈ : lower �̿�)
���� 2) �̸��� �� 3���ڱ��� ����ϰ� �������� *�� ����մϴ�. 
�� ���� �� ��Ī�� name�Դϴ�.(��Ʈ : rpad�� substr �Ǵ� substr �׸��� length �̿�)
���� 3) �޿��� ��ü 10�ڸ��� ����ϵ� ������ �ڸ��� *�� ����մϴ�. 
�� ���� �� ��Ī�� salary�Դϴ�.(��Ʈ : lpad �̿�)
*/
SELECT rpad(lower(first_name),substr(first_name, 4),'*'),
       rpad(salary, 4, '*')
FROM employees
WHERE job_id = 'IT_PROG';

--FM
SELECT
    rpad(substr(first_name, 1, 3),length(first_name),'*') AS name,
    lpad(salary, 10, '#') AS salary
FROM employees
WHERE lower(job_id) = 'it_prog';
