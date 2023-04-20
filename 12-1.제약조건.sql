
-- 테이블 생성과 제약조건
-- 테이블 열레벨 제약조건 (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: 테이블의 고유 식별 컬럼입니다. (주요 키)
-- UNIQUE: 유일한 값을 갖게 하는 컬럼 (중복값 방지)
-- NOT NULL: null을 허용하지 않음.
-- FOREIGN KEY: 참조하는 테이블의 PRIMARY KEY를 저장하는 컬럼
-- CHECK: 정의된 형식만 저장되도록 허용.

CREATE TABLE dept2(
dept_no NUMBER(2) CONSTRAINT dept2_dno_pk PRIMARY KEY, --기본키
dept_name VARCHAR2(14) NOT NULL CONSTRAINT dept2_dname_uk UNIQUE, --후보키
loca NUMBER(4) CONSTRAINT dept2_loca_fk REFERENCES locations(location_id), --
dept_bonus NUMBER(10) CONSTRAINT dept2_dbonus_ck check(dept_bonus>0), --커스텀 규칙
dept_gender VARCHAR2(1) CONSTRAINT dept2_dgen_ck check(dept_gender IN('M', 'F'))
);
---   ==
CREATE TABLE dept2(
  dept_no NUMBER(2), 
  dept_name VARCHAR2(14) NOT NULL , 
  loca NUMBER(4),
  dept_bonus NUMBER(10),
  dept_gender VARCHAR2(1),

  CONSTRAINT dept2_dno_pk PRIMARY KEY(dept_no), 
  CONSTRAINT dept2_dname_uk UNIQUE(dept_name), 
  CONSTRAINT dept2_loca_fk FOREIGN KEY(loca) REFERENCES locations(location_id),
  CONSTRAINT dept2_dbonus_ck check(dept_bonus>0), 
  CONSTRAINT dept2_dgen_ck check(dept_gender IN('M', 'F'))
);

INSERT INTO dept2
VALUES(10, 'gg', 40000, sysdate, 2000000);

INSERT INTO dept2
VALUES(20, 'gg', 40000, sysdate, 2000000);

UPDATE dept2
SET loca = 4000
WHERE loca = 1800;


DROP TABLE dept2;





ALTER TABLE dept2 DROP CONSTRAINT dept_no_pk;
SELECT * FROM user_constraints;






------------------------------------------------------------------------------
CREATE TABLE members(
m_name VARCHAR2(3) NOT NULL, 
m_num NUMBER(1) CONSTRAINT members_mno_pk PRIMARY KEY, --기본키
reg_date DATE NOT NULL CONSTRAINT members_regdate_uk UNIQUE,
gender VARCHAR2(1) CONSTRAINT members_gen_ck check(gender IN('M', 'F')),
loca NUMBER(4) CONSTRAINT members_loca_fk REFERENCES locations(location_id)
);

INSERT INTO members
VALUES('AAA', 1, '20180701', 'M', 1800);
INSERT INTO members
VALUES('BBB', 2, '20180702', 'F', 1900);
INSERT INTO members
VALUES('CCC', 3, '20180703', 'M', 2000);
INSERT INTO members
VALUES('DDD', 4, sysdate, 'M', 2100);


SELECT m_name, m_num, l.street_address, l.location_id
FROM members m
JOIN locations l
ON m.loca = l.location_id
ORDER BY m_num ASC;