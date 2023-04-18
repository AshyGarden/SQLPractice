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

--auth.id컬럼을 그냥쓰면 모호하다고 뜸 (둘다 존재하기때문에)
--이럴떄는 컬럼에 테이블 이름을 붙이거나 별칭을써서 확실히 지목해주기
SELECT 
a.auth_id, i.title ,i.content ,a.name
FROM info i
INNER JOIN auth a
ON i.auth_id = a.auth_id
WHERE a.name =' 이순신';

--OUTER JOIN
SELECT *
FROM info i LEFT OUTER JOIN auth a
ON i.auth_id = a.auth_id;

SELECT *
FROM info i RIGHT JOIN auth a
ON i.auth_id = a.auth_id;

--좌측 테이블과 우측 테이블 데이터를 모두 읽어 중복데이터는 삭제되는 외부조인
SELECT *
FROM info i FULL JOIN auth a
ON i.auth_id = a.auth_id;

--CROSS JOIN - JOIN조건을 설정하지 않는 JOIN(거의 않씀)
--모든 컬럼에 대해 JOIN진행
SELECT * FROM info
CROSS JOIN auth
ORDER BY id ASC;

--여러개 테이블 조인-> 키값만 찾아서 구문을 연결해 사용
SELECT *
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN locations loc ON d.location_id = loc.location_id;

/*
테이블 별칭 a,i를 이용해서 LEFT OUTER JOIN사용
info auth
job칼럼이 scientist인 사람의 id,title content job을 출력
*/
SELECT i.auth_id, i.title, i.content, a.JOB
FROM info i, auth a
LEFT JOIN a.JOB = 'scientist';

-FM
SELECT i.id, i.title, i.content, a.job
FROM auth a LEFT JOIN info i
ON a.auth_id = i.auth_id
WHERE a.job= 'scientist';

--셀프조인이란 동일 테이블 사이의 조인
--동일 테이블 컬럼을 통해 기존에 존재하는 값을 매칭시켜 가져올때 사용
SELECT
e1.employee_id, e1.first_name, e1.manager_id,
e2.first_name ,e2.employee_id
FROM employees e1
JOIN employees e2
ON e1.manager_id = e2.employee_id;