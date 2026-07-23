/*==========================================================
SQL의 분류

1 DML(Data Manipulation Language 데이터 조작어) : 
  데이터는 검색, 추가, 수정, 삭제,병합해주는 명령어들이다.
  (select, insert, update, delete,merge)
2 DDL(Data Definition Language 데이터 정의어 ) : 
  테이블의 구조를 정의, 변경해주는 명령어들이다.
  (create, drop, alter, truncate)
3 DCL(Data Control Language 데이터 제어어) : 
  사용자의 권한을 부여,제거해주는 명령어들이다.(grant ,revoke)
4 TCL(Transaction Control Language 트랜잭션 처리어) : 
  트랜잭션 설정,취소을 처리해주는 명령어들이다
  (commit, rollback, savepoint)
==========================================================*/


/*===============================
https://dev.mysql.com/doc/refman/8.4/en/data-types.html
테이블 구조 정의
CREATE TABLE table_name(
  column_name datatype,
  column_name datatype
);

자료형(datatype)
varchar - 가변길이 문자를 저장
char - 고정길이 문자를 저장
int-정수저장
decimal(m,n)- 실수저장
date - 날짜 저장
===============================*/

SELECT DATABASE();

CREATE TABLE student(
	name varchar(20),
	age int,
	avg decimal(5, 2),
	hire date
);

SELECT * FROM student;

-- 테이블 구조 확인(Describe)
DESC student;

INSERT INTO student(name, age, avg, hire)
VALUES('홍길동', 30, 97.85, curdate()); -- curdate() -> current date?

SELECT * FROM student;

INSERT INTO student(name, age, avg, hire)
VALUES('김민재', 28, 80.2, sysdate())

SELECT * FROM student;

INSERT INTO student(name, age, avg, hire)
VALUES('이수리', 18, 75.3, curdate())
SELECT * FROM student;

INSERT INTO student(name, age)
VALUES('세기둥', 18);
SELECT * FROM student;

INSERT INTO student(name, age, avg, hire)
VALUES('흰둥이', 15, null, null)
SELECT * FROM student;

INSERT INTO student(name, age, avg, hire)
VALUES('박차고 나온 세상에abcdefghijklndkwfnfw', 30, 97.2, curdete());

INSERT INTO student(name, age, avg, hire)
VALUES('이정재', 20, 1525.98, curdate())

INSERT INTO student(name, age, avg, hire)
VALUES('차영주', 25, 352.9825, curdate());

/*====================================
ALTER 
 객체(테이블)의 구조를 변경해주는 명령어이다.
======================================*/
-- 생성 : CREATE TABLE,  CREATE VIEW, CREATE INDEX
-- 수정 : ALTER TABLE, ALTER VIEW, ALTER INDEX, ALTER USER


-- 테이블에 컬럼을 추가한다.
ALTER TABLE student
ADD loc varchar(30);

DESC student;

-- 테이블의 컬럼명을 수정한다.
ALTER TABLE student
RENAME COLUMN avg TO jumsu; -- 기존 컬럼명 TO 새로운 컬럼

DESC student;

ALTER TABLE student
MODIFY name varchar(10);

DESC student;

INSERT INTO student(name, age, jumsu, hire)
VALUES('박차고 나온 세상에', 30, 97.2, curdate());
SELECT * FROM student;

ALTER TABLE student
MODIFY name varchar(3);

DESC student;




-- 테이블명을 변경
ALTER TABLE student
RENAME TO members;

DESC students;

DESC members;


/*=======================================
테이블의 내용을 수정하는 명령어이다.
UPDATE 테이블명 
SET 컬럼1=값1, 컬럼2=값2
WHERE 컬럼=값;
=========================================*/

UPDATE members
SET age = 50
WHERE name = '홍길동';

SELECT * FROM members;

/*=============================================
테이블의 내용을 삭제하는 명령어이다.
DELETE
DELETE FROM table_name WHERE column_name = value;
===============================================*/

DELETE FROM members
WHERE name = '흰둥이';

SELECT * FROM members;

/*===============================================
무결성 제약조건
   무결성이 데이터베이스 내에 있는 데이터의 정확성 유지를 의미한다면
   제약조건은 바람직하지 않는 데이터가 저장되는 것을 방지하는 것을 말한다.
   무결성 제약조건 6종류 : not null, unique, primary key, foreign key, check, default
    not null : null를 허용하지 않는다.
    unique : 중복된 값을 허용하지 않는다. 항상 유일한값이다.
    primary key : not null + unique
    foreign key : 참조되는 테이블의 컬럼의 값이 존재하면 허용된다.
    check : 저장 가능한 데이터값의 범위나 조건을 지정하여 설정한 값만을 허용한다.
	default : 기본값을 설정한다.
    =====================================================*/


CREATE TABLE dept1(
	code varchar(10) PRIMARY KEY; -- not null, unique
	
);

CREATE TABLE emp1(
	id varchar(10) PRIMARY KEY,
	name varchar(20) NOT NULL,
	loc varchar(10),
	salary int DEFAULT 3000
);

SHOW tables;

-- mywork 데이터베이스에 성된 table 확인
SELECT * FROM information_schema.tables
WHERE table_schema='myxedb';


-- mywork 데이터베이스에 성된 constraint 확인
SELECT * FROM information_schema.table_constraints 
WHERE table_schema='myxedb';

SELECT * FROM emp1;

INSERT INTO emp1
VALUES('a001', '홍길동', '지역', 5000);

SELECT * FROM emp1;

INSERT INTO emp1(id, name, loc)
VALUES('a002', '김민재', '서울');


SELECT * FROM emp1;

-- mywork 데이터베이스에 성된 constraint 확인
SELECT * FROM information_schema.table_constraints 
WHERE table_schema='myxedb';

CREATE TABLE dept1(
     code varchar(10) primary key);


CREATE TABLE emp2(
      id varchar(10),
      name varchar(20) not null,
      loc varchar(10) ,
      salary int default 3000,
      code varchar(10), 
      constraint emp2_id_pk primary key(id),
      constraint emp2_code_fk  foreign key(code) references dept1(code)  -- dept1 의 pk 참조
    );

DESC dept1;
DESC emp2;


-- mywork 데이터베이스에 성된 constraint 확인
SELECT * FROM information_schema.table_constraints 
WHERE table_schema='myxedb';

INSERT INTO dept1
VALUES('p001');

SELECT * FROM dept1;

SELECT * FROM emp2;

INSERT INTO emp2
VALUES('a001', '김연아', '서울', 5000, 'p001');

SELECT * FROM emp2;


-- code는 foreign key로 제약조건이 설정되어 있으므로 null이 가능하다.
INSERT INTO emp2(id, name, loc, salary)
VALUES('a002', '이수영', '경기', 8000); -- fk null값 허

SELECT * FROM emp2;

INSERT INTO emp2(id, name, loc, salary, code)
VALUES ('a003', '진영구', '제주', 6000, 'k001');

-- SQL ERROR [1062] [23000]: Duplicate entry 'a002' for key 'emp2.PRIMARY'
INSERT INTO emp2(id, name, loc)
VALUES('a002', '마이상', '대전')

INSERT INTO emp2(id, name, loc)
VALUES('a004', '홍길동', '대구')

SELECT * FROM emp2;

INSERT INTO emp2(id, name, loc)
VALUES('a005', '홍길동', '부산');

SELECT * FROM emp2;

-- name 컬럼의 제약조건 nout null 이기 때문에 중복된 값 가능하다.
INSERT INTO emp2(id, name, loc)
VALUES('a005', '홍길동', '부산');

SELECT * FROM emp2;

-- name 컬럼의 제약조건은 not null 이기 때문에 null 값을 저장할 수 없다.
INSERT INTO emp2(id, loc)
VALUES('a006', '전주');

-- emp2테이블에 gen 컬럼을 추가한다.
   ALTER TABLE emp2
   ADD gen char(1) check(gen IN('m','w'));


INSERT INTO emp2
    VALUES('a006', '전진구', '수원', 5000, 'p001', 'm');


SELECT * FROM emp2;

/*=================================================
제약조건 삭제
 ALTER TABLE table_name
  DROP constraint constraint_name
======================================================*/ 
-- Foreign Key 제약조건 삭제
ALTER TABLE emp2
DROP constraint emp2_code_fk;

-- mywork 데이터베이스에 성된 constraint 확인
SELECT * FROM information_schema.table_constraints 
WHERE table_schema='myxedb' AND table_name='emp2';

-- check 제약조건 삭제
ALTER TABLE emp2
DROP CONSTRAINT emp2_chk_1;

-- myxedb 데이터베이스에 생성된 constraint 확인
SELECT * FROM information_schema.table_constraints 
WHERE table_schema='myxedb' AND table_name='emp2';

-- primary key 제약조건 삭제
ALTER TABLE emp2
DROP PRIMARY KEY;

-- myxedb 데이터베이스에 생성된 constraint 확인
SELECT * FROM information_schema.table_constraints 
WHERE table_schema='myxedb' AND table_name='emp2';

 -- salary컬럼에 설정된 default을 확인한다.
 DESC emp2;


-- default 제약조건 삭제  (salary int default 3000)
 ALTER TABLE emp2
 ALTER salary DROP default;


-- name 컬럼에 not null 삭제
ALTER TABLE emp2
MODIFY COLUMN name varchar(20);

 /*=======================================================================
제약조건 추가
  ALTER TABLE table_name
       ADD constraint constraint_name constraint_type(column_name)
=========================================================================*/

-- emp2테이블의 code컬럼에 foreign key 제약조건 추가
 ALTER TABLE emp2
 ADD CONSTRAINT emp2_code_fk foreign key(code) references dept1(code);

-- emp2테이블의 gen컬럼에 check 제약조건 추가
ALTER TABLE emp2
ADD CONSTRAINT emp2_gen_chk check(gen IN('m','w'));

 -- emp2테이블의 id컬럼에 primary key 제약조건 추가 
ALTER TABLE emp2
ADD CONSTRAINT emp2_id_pk primary key(id);

-- emp2테이블의 name컬럼에 not null 제약조건 추가 
 ALTER TABLE emp2
 MODIFY COLUMN name varchar(20) not null;

-- name 컬럼에 not null 제약조건 추가된 거 확인
DESC emp2;

 /*=========================================================
부모키가 수정,삭제가 되면 참조되는 키도 수정,삭제가 되도록 cascade을 설정한다.
수정 : ON UPDATE CASCADE
삭제 : ON DELETE CASCADE
==========================================================*/
CREATE TABLE dept2(
  code varchar(10),
  dname varchar(20)
  );

INSERT INTO dept2
VALUES('p001', 'visit');

INSERT INTO dept2
VALUES('p002','hello');

ALTER TABLE dept2
ADD CONSTRAINT primary key(code);

SELECT * FROM dept2;

DROP TABLE IF EXISTS emp3;


CREATE TABLE emp3(
	id varchar(10) PRIMARY KEY,
	name varchar(20) NOT NULL,
	code varchar(10),
	CONSTRAINT emp3_code_fk FOREIGN key(code) REFERENCES dept2(code)
	ON DELETE CASCADE 
	ON UPDATE CASCADE
);


SELECT * FROM emp3;
SELECT * FROM dept2;

INSERT  INTO emp3
VALUES('a001', '홍길동', 'p001');
 
SELECT * FROM emp3;
  
INSERT INTO emp3
VALUES('a002','김민재', null);
  
SELECT * FROM emp3;
  
INSERT INTO emp3
VALUES('a003', '진영구', 'p002');
  
SELECT * FROM emp3;


UPDATE dept2
SET code = 'm001'
WHERE code = 'p001';

SELECT * FROM dept2;
SELECT * FROM emp3;

DELETE FROM dept2
WHERE code = 'p002';

SELECT * FROM dept2;
SELECT * FROM emp3;

INSERT INTO dept2 
VALUES('p002', 'hello');

SELECT * FROM dept2;

COMMIT;

INSERT INTO dept2
VALUES('p003', 'hello3');

SAVEPOINT  t1;

INSERT INTO dept2
VALUES('p004', 'hello4');

SAVEPOINT  t2;

INSERT INTO dept2
VALUES('p005', 'hello5');

SELECT * FROM dept2;

ROLLBACK TO t2;

SELECT * FROM dept2;

COMMIT;











