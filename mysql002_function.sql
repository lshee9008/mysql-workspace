-- 현재 사용중인 데이터베이스 확인
SELECT DATABASE();

/*=====================================================
SQL(structured query language)함수
1. 단일행함수 : 행 하나당 하나의 결과를 출력한다
              (문자함수, 숫자함수, 날짜함수, 변환함수, 일반함수)
2. 복수행함수 : 행 여러개당 하나의 결과를 출력한다
               (합계, 평균, 최대, 최소, 갯수)  
====================================================== 
*/

SELECT 3 + 1;
SELECT sysdate(), now();

/*
데이터 형식 변환함수 : cast()와 convert()는 형식만 다를뿐 거의 비슷하다.
cast(expression AS 데이터형식 [(길이)])
convert( expression, 데이터형식 [(길이)])
데이터 형식 중에서 가능한 것은 binary, char, date, datetime, decimal, json, 
signed integer, time, unsigned integer등이다.
*/

SELECT cast('253' AS UNSIGNED INTEGER) + CAST('12' AS UNSIGNED INTEGER);  -- 265
SELECT convert('253' , UNSIGNED INTEGER) + convert('12', UNSIGNED INTEGER); -- 265
SELECT concat(cast(253 AS char(3)) , cast(12 AS char(3)));   -- 25312
SELECT cast('2024/02/13' AS date);  -- 2024-02-13
SELECT cast('2024$02$13' AS date);  -- 2024-02-13
SELECT cast('2024%02%13' AS date);  -- 2024-02-13


-- cast()나 convert()함수를 사용하지 않고도 형이 변환되는 경우
SELECT '100' + '200';  -- 300
SELECT concat('100', '200');  -- 100200
SELECT concat(100, '200');  -- 100200
SELECT concat(100, 200);  -- 100200
SELECT 1 > '2mega';  -- 정수인 2로 변환해서 비교한 결과 0을 리턴
SELECT 3 > '2mega';  -- 정수인 2로 변환해서 비교한 결과 1을 리턴
SELECT 0 = 'mega2';  -- 문자는 0으로 변환되어 비교한 결과 1을 리턴



/*-----------------------------------
문자함수
https://dev.mysql.com/doc/refman/8.4/en/string-functions.html
-------------------------------------*/
-- 모든 문자를 대문자로 변경해주는 함수이다.
SELECT upper('korea'); -- KOREA
SELECT ucase('korea'); -- KOREA

-- employees테이블 first_name에서 대소문자 구분없이
-- 'Ja'가 포함이 된 first_name, salary을 출력하라.

SELECT first_name, lower(first_name), last_name, lower(last_name)
FROM employees
WHERE upper(first_name) LIKE upper('%Ja%');


-- 문자의 길이를 리턴해주는 함수이다.
SELECT char_length('korea');   -- 5
SELECT length('korea');        -- 5 (byte)
SELECT bit_length('korea');    -- 40 (bit)

SELECT char_length('한국'); -- 2
SELECT length('한국');      -- 6 (byte)
SELECT bit_length('한국');  -- 48(bit)

CREATE TABLE user1(
	nation varchar(5)
);

SELECT nation, char_length(nation), length(nation)
FROM user1; 

INSERT INTO user1(nation)
VALUES('korea')

SELECT nation, char_length(nation), length(nation)
FROM user1; 

INSERT INTO user1(nation)
VALUES('대한민국');

SELECT nation, char_length(nation), length(nation)
FROM user1; 

/* SQL Error [1406] [22001]: Data truncation: Data too long for column 'nation' at row 1 
INSERT INTO user1(nation)
VALUES('south korea');
*/

-- 특정 문자의 인덱스를 추출해주는 함수이다.
SELECT instr('korea', 'or');
SELECT instr('한국자', '자바');

-- 주어진 문자열에서 왼쪽으로 특정문자를 채우는 함수이다.
SELECT lpad('korea', 8, '*');   -- ***korea

-- 주어진 문자열에서 오른쪽으로 특정문자를 채우는 함수이다.
SELECT rpad('korea', 8, '*'); -- korea***

-- 주어진 문자열에서 왼쪽의 특정문자를 삭제하는 함수이다.
SELECT ltrim(' korea'); -- korea

-- 주어진 문자열에서 오른쪽의 특정문자를 삭제하는 함수이다.
SELECT rtrim('korea '); -- korea

-- 주어진 문자열에서 양쪽 특정문자를 삭제하는 함수이다.
SELECT length(trim('  korea  '));  -- 5

SELECT trim(LEADING '*' FROM '**korea**');  -- korea**
SELECT trim(TRAILING '*' FROM '**korea**'); -- **korea
SELECT trim(BOTH '*' FROM '**korea**');     -- korea

-- 주어진 문자의 아스키 코드값을 구하는 함수이다.
SELECT ascii('A');  -- 65

-- 주어진 아스키 코드값의 문자를 구하는 함수이다.
SELECT char(65); -- A

-- 주어진 문자를 연결하는 함수이다.
-- concat(문자열1,문자열2,...)
SELECT concat('java', 'jsp');  -- javajsp

-- concat_ws(구분자,문자열1,문자열2,...)
SELECT concat_ws('/','2024', '01','01'); -- 2024/01/01

-- 숫자를 소수점 아래 자릿수까지 표현한다. 또한 1000단위마다 콤마(,)를 표시해 준다.
-- format(숫자, 소수점 자릿수) 
SELECT format(1253.535, 2); -- 1,253,54
SELECT format(1253.535, 0); -- 1,254

-- 2진수, 16진수, 8진수의 값을 반환
--  bin(숫자), hex(숫자),  oct(숫자)
SELECT bin(31), hex(31), oct(31);  -- 11111, 1F, 37

-- 왼쪽 또는 오른쪽에서 문자열의 길이만큼 반환한다.
-- left(문자열,길이),   right(문자열, 길이)
SELECT left('abcdefghi', 3), right('abcdefghi',3); -- abc	ghi

-- 문자열을 횟수만큼 반복한다. 
-- repeat(문자열, 횟수) 
SELECT repeat('korea', 2); -- koreakorea

-- 문자열에서 원래 문자열을 찾아서 바꿀 문자열로 바꾼다.
-- replace(문자열, 원래문자열, 바꿀문자열) 
SELECT replace('database mysql', 'database', '데이터베이스'); -- 데이터베이스 mysql

-- 문자열의 순서를 거꾸로 만든다. 
-- reverse(문자열) 
SELECT reverse('mysql');  -- lqsym

-- 특정범위의 문자를 추출해 주는 함수이다.
-- substr('문자', 시작위치, 갯수)
-- substr = substring = mid
SELECT substr('oracle test', 1, 4);     -- orac 
SELECT substring('oracle test', 1, 4);  -- orac 
SELECT mid('oracle test', 1, 4);        -- orac

SELECT substr('oracle test', -3, 4);   -- est
SELECT substr('오라클 테스트', 3, 4);  -- 클 테스
SELECT substr('오라클 테스트', -3, 4);  -- 테스트

-- 문자열에서 구분자가 왼쪽부터 횟수 번째 나오면 그 이후의 오른쪽은 버린다. 횟수가 음수면 오른쪽부터 세고 왼쪽은 버린다. 
-- substring_index(문자열, 구분자, 횟수) 
SELECT substring_index('cafe.naver.com', '.', 2);   -- cafe.naver
SELECT substring_index('cafe.naver.com', '.', -2);  -- naver.com


/*----------------------------
https://dev.mysql.com/doc/refman/8.4/en/numeric-functions.html
 숫자함수
-------------------------------*/
-- 3.55을 소수점 1의 자리까지 구하시오(반올림)
SELECT round(3.55, 1);  -- 3.6
SELECT round(42523.55, -1);  -- 42520
SELECT round(42523.55, 0); -- 42524

-- ceil = ceiling
-- 256.78을 무조건 올림한다.(올림)
SELECT ceil(256.78);    -- 257
SELECT ceiling(256.78);  -- 257

-- 289.78에서 소수이하는 무조건 버린다.(버림)
SELECT floor(289.78); -- 289

-- 2의 3승(거듭제곱)
SELECT power(2,3); -- 8

-- 25의 제곱근
SELECT sqrt(25); -- 5

-- 숫자를 원래 진수에서 변환할 진수로 계산한다.
-- conv(숫자, 원래진수, 변환할 진수) 
SELECT conv('AA', 16, 2), conv(100, 10, 8); -- 10101010	144

-- mod(숫자1, 숫자2) :   숫자1를 숫자2로 나눈 나머지
-- mod(숫자1,숫자2) = 숫자1 % 숫자2 = 숫자1 mod 숫자2
SELECT mod(16,5), 16%5, 16 mod 5;  -- 1 1 1

-- rand( )는 0이상 1미만의 실수를 구한다. 
-- 만약 'm<=임의의 정수 <n' 를 구하고 싶다면 floor(m+(rand() * (n-m))을 사용한다.
SELECT rand();
SELECT  floor(1 + rand() * (7-1));

--  pi()  원주율
SELECT PI(); -- 3.141593

-- 숫자가 양수, 0, 음수인지를 구한다. 결과는 1, 0, -1 셋 중에 하나를 반환한다. 
-- sign(숫자)
SELECT sign(10), sign(0), sign(-10); -- 1	0	-1

-- 숫자를 소수점을 기준으로 정수 위치까지 구하고 나머지는 버린다.
-- truncate(숫자, 정수)
SELECT truncate(12345.52545, 2), truncate(12345.52345, -2); -- '12345.52', '12300'



/* ====================================================== */
/*---------------------------
https://dev.mysql.com/doc/refman/8.4/en/date-and-time-functions.html

날짜함수
------------------------------*/

-- 현재 시스템에서 제공해주는 오늘의 날짜 및 시간 구하는 함수
-- 2024-02-13 17:20:09	2024-02-13 17:20:09	2024-02-13	17:20:09
SELECT sysdate(), now(), curdate(), curtime();

-- 2024-02-13	2024-02-13	2024-02-13
SELECT curdate(), current_date(), current_date;

-- 17:38:09	17:38:09	17:38:09
SELECT curtime(), current_time(), current_time;

-- 2024-02-13 17:40:49	2024-02-13 17:40:49	2024-02-13 17:40:49	2024-02-13 17:40:49	2024-02-13 17:40:49
SELECT now(), localtime, localtime(), localtimestamp, localtimestamp();

-- 날짜를 기준으로 차이를 더하거나 뺀 날짜를 구한다.
-- adddate(날짜, 차이), subdate(날짜, 차이) 
SELECT adddate('2024-03-01', INTERVAL 31 DAY);  -- 2024-04-01
SELECT adddate('2024-03-01', INTERVAL 1 MONTH); -- 2024-04-01

SELECT subdate('2024-04-01', INTERVAL 31 DAY);  -- 2024-03-01
SELECT subdate('2024-04-01', INTERVAL 1 MONTH); -- 2024-03-01






-- 날짜/시간을 기준으로 더하거나 뺀 결과를 구한다. 
-- addtime(날짜/시간, 시간), subtime(날짜/시간, 시간)
SELECT addtime('2024-03-01 10:10:10', '1:1:1');  -- 2024-03-01 11:11:11
SELECT addtime('10:10:10', '1:1:1');            -- 11:11:11

SELECT subtime('2024-03-01 11:11:11', '1:1:1');  -- 2024-03-01 10:10:10
SELECT subtime('11:11:11', '1:1:1');             --  10:10:10

-- 날짜 또는 시간에서 연, 월, 일, 시, 분, 초, 밀리초를 구한다.
-- year(날짜), month(날짜), day(날짜)
-- hour(시간), minute(시간),  second(시간), microsecond(시간)
-- day() = dayofmonth()
SELECT year(curdate()), month(curdate()), day(curdate());  -- 2024	2	13
SELECT hour(curtime()), minute(curtime()), second(curtime()), microsecond(curtime()); -- 17	53	41	0

-- 날짜와 시간을 구한다.
-- date(), time()
SELECT date(now()), time(now());  -- 2024-02-13	17:57:00

-- 날짜와 시간 차이를 구할때 사용한다.
-- datediff(날짜1, 날짜2), timediff(날짜1 또는 시간1, 날짜2 또는 시간2)
--  날짜1에서 날짜2을 뺀다.
SELECT datediff('2024-03-02', '2024-03-01');  -- 1
SELECT TIMEDIFF('10:10:10', '10:10:9');  -- 00:00:01

-- 현재 요일과 월이름 그리고 일년 중 몇 일이 지났는지를 반환한다.
-- dayofweek(날짜), monthname(날짜), dayofyear(날짜)
-- 요일(1:일, 2:월 ~ 7:토)
-- 3	February	44
SELECT dayofweek(curdate()), monthname(curdate()), dayofyear(curdate());
-- SELECT SUBSTR(_UTF8'일월화수목금토', DAYOFWEEK(curdate()), 1 ); -- 화

-- 주어진 날짜의 마지막 날짜를 구한다. 즉 월의 마지막일이다.
-- last_day(날짜)
SELECT last_day(curdate());  -- 2024-02-29

-- 연도에서 정수만큼 지난 날짜를 구한다.
-- makedate(연도, 정수)
SELECT makedate(2024, 10);  -- 2024-01-10

-- 시,분,초를 이용해서 '시:분:초'의  Time형식을 만든다.
-- maketime(10,15,1)
SELECT maketime(10,15,1);  -- 10:15:01

-- period_add() 는 연월에서 개월만큼의 개월이 지난 연월을 구한다.
-- 연월은 YYYY 또는 YYYYMM 형식을 사용한다.
-- period_diff( )는 연월1-연월2의 개월수를 구한다.
SELECT period_add(202401, 11), period_diff(202401, 202312); -- 202412	1

-- 날짜가 4분기 중에서 몇 분기인지를 구한다.
-- quarter(날짜)
SELECT quarter(curdate());  --  1

-- 시간을 초 단위로 구한다.
-- time_to_sec(시간)
SELECT time_to_sec('0:1:10');  -- 70


/*===================================================================
특수 변환 작업
=====================================================================*/

-- 1. 숫자 -> 문자
-- 첫번째 인자값을 두번째 인자값의 형식으로 변환해주는 함수
SELECT FORMAT(2532, 2); --   2,532.00

SELECT lpad(FORMAT(2532, 2),10,'0'); -- 002,532.00

-- 통화 기호를 붙인다.
SELECT CONCAT('₩', FORMAT(2532, 2)); -- ₩2,532.00  

-- 2. 날짜 -> 문자
-- https://dev.mysql.com/doc/refman/8.4/en/date-and-time-functions.html
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d %h:%i:%s %W'); -- 2024-02-14 09:46:32 Wednesday
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s %a'); -- 2024-02-14 09:46:21 Wed

-- 3. 문자 -> 날짜
-- str_to_date(문자열, format)
SELECT STR_TO_DATE('05/09/28','%m/%d/%y'); -- 2028-05-09


-- ----------------------------------------------------
SELECT first_name, hire_date
FROM employees;

-- hire_date(입사일)을 이용해서 
-- '홍길동님은 2003년 1월 3일에 입사했습니다'로
-- 출력하는 query를 작성하시오.

SELECT CONCAT(first_name, '님은 ', DATE_FORMAT(hire_date, '%Y년 %c월 %e일에 입사했습니다.'))
FROM employees;

/*====================================================================
일반함수
ifnull(컬럼, 대체값) : 첫번째 인자값이 null이면 0으로 대체해서 출력한다.
if(컬럼, 대체1, 대체2) : 컬럼의 값이 null아니면 대체1로, null이면 대체2로 출력한다. 
nullif(표현식1, 표현식2 ) : 표현식1과 표현식2가 같으면 NULL, 다르면 표현식1로 출력한다.

--대체할 값이 숫자이면 두번째 인자값에 숫자를 지정한다.
--대체할 값이 문자이면 두번째 인자값에 문자를 지정한다.
--대체할 값이 날짜이면 두번째 인자값에 날짜를 지정한다. 
=======================================================================*/

SELECT *
FROM employees

SELECT commission_pct, ifnull(commission_pct, 0)
FROM employees;

SELECT first_name, manager_id, ifnull(cast(manager_id AS char(3)), 'CEO')
FROM employees;

SELECT commission_pct, if(commission_pct, 1, 0)
FROM employees;

SELECT commission_pct, nullif(commission_pct, 0.4)
FROM employees;


/*================================
case when 조건1 then 결과1
     when 조건2 then 결과2
     when 조건3 then 결과3
     else 결과n
end AS alias;
자바에서 if-else와 비슷한 의미
==================================*/
-- department_id이 10이면 'ACCOUNTING', 20이면 'RESEARCH', 
--                30이면 'SALES', 40이면 'OPERATIONS', 'OTHERS'

SELECT *
FROM employees


-- dayofweek() : 1 일요일...7 토요일
-- 입사일을 이용해서 한글로 요일을 출력하시오.
SELECT first_name, hire_date,
    CASE dayofweek(hire_date)
        WHEN 1 THEN '일요일'
        WHEN 2 THEN '월요일'
        WHEN 3 THEN '화요일'
        WHEN 4 THEN '수요일'
        WHEN 5 THEN '목요일'
        WHEN 6 THEN '금요일'
        WHEN 7 THEN '토요일'
    END AS '요일'
FROM employees;



-- 직급이 'PR_REP' 인 사원은 5%, 'SA_MAN'인 사원은 10%, 
-- 'AC_MGR'인 사원은 15%, 'PU_CLERK' 인 사원은 20% 를 인상 
SELECT job_id, salary,
	CASE job_id
		WHEN 'PR_REP' THEN salary * 1.05
		WHEN 'SA_MAN' THEN salary * 1.1
		WHEN 'AC_MGR' THEN salary * 1.15
		WHEN 'PU_CLEARK' THEN salary * 1.2
		ELSE salary
	END AS newsal
FROM employees;


-- 입사일에서 월이 1-3이면 '1사분기', 4-6이면 '2사분기', 
--              7-9이면 '3사분기', 10-12이면 '4사분기'
-- 로 처리를 하고 사원명(first_name), 
-- 입사일(hire_date), 분기로 출력하시오.

SELECT job_id, 
	CASE 
		WHEN MONTH(hire_date) <= 3 THEN '1사분기'
		WHEN MONTH(hire_date) <= 6 THEN '2사분기'
		WHEN MONTH(hire_date) <= 9 THEN '3사분기'
		WHEN MONTH(hire_date) <= 12 THEN '4사분기'
	END AS '분기'
FROM employees;

/*=================================================
집계함수(Aggregate Function), 그룹함수(Group Function)
https://dev.mysql.com/doc/refman/8.0/en/aggregate-functions.html#function_max
===================================================*/

-- max(컬럼) : 최대값
SELECT max(salary)
FROM employees

-- min(컬럼) : 최소값
SELECT min(salary)
FROM employees

SELECT count(COMMISSION_PCT) -- null 값이 아닌 개수만 반환해줌
FROM employees

SELECT count(*) -- null값 상관 없이 개수 반환
FROM employees;

-- sum(컬럼) : 합계
SELECT sum(salary)
FROM employees;

-- avg(컬럼) : 평균
SELECT avg(salary)
FROM employees;

-- 집계함수와 단순컬럼은 출력되는 레코드수가 다르기 떄문에 함께 사용할 수 없다.
-- SQL Error [1140] [42000]: In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'myxedb.employees.FIRST_NAME'; this is incompatible with sql_mode=only_full_group_by
SELECT first_name, count(*)
FROM employees;

-- 집계함수와 단순컬럼을 사용하기 위해서는 단순컬럼을 그룹화 해야 한다. (GROUP BY)
SELECT department_id, count(*)
FROM employees
GROUP BY department_id;


-- 50 이하인 부서에 대해서 NULL이 아닌 부서별의 직원수를 출력하시오.
SELECT department_id, count(*) AS '직원수'
FROM employees
GROUP BY department_id
HAVING department_id <= 50 AND department_id IS NOT NULL;

-- 업무별(job_id) 급여합계를 출력하시오.
SELECT job_id, sum(salary)
FROM employees
GROUP BY job_id;

-- 부서별 최소급여, 최대급여가 같지 않을때만  
-- 부서, 부서최소급여, 부서최대급여을 부서별 오름차순으로 출력하시오.
SELECT department_id, MIN(salary), MAX(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) != MAX(salary)
ORDER BY department_id ASC;


/*--------------------------
시스템 함수
----------------------------*/
 -- 현재 사용자와 현재 선택된 데이터베이스
 -- user() = current_user() = dsession_user()
 -- datebase() = schema()
SELECT user(), database();  -- root@localhost	myxedb

-- select문에서 조회된 행의 개수를 구함
-- found_rows()
SELECT * FROM employees;
SELECT found_rows();

 -- 바로 앞의 INSERT, UPDATE, DELETE문에서 입력, 수정, 삭제된 행의 갯수를 구함
 -- CREATE, DROP문은 0을 반환하고, SELECT문은 -1을 반환한다.
 -- row_count()
DELETE FROM employees 
WHERE 1=0;
SELECT row_count();

-- 현재 MySQL의 버전을 구한다.
SELECT version();


/*=======================================================
join : 여러개의 테이블에서 원하는 테이블을 추출해주는 쿼리문이다.
모든 제품에서 공통적으로 사용되는 표준(ANSI) join이 있다.
========================================================*/

-- 1. cross조인 = carteian product(카티션 곱) 조인 : 
--   테이블 행의 갯수만큼 출력해주는 조인이다.
SELECT * FROM employees; -- department_id 존재
SELECT * FROM departments; -- department_id 존재

SELECT count(*) FROM employees;
SELECT count(*) FROM departments;

SELECT 107 * 27;


SELECT 
FROM employees CROSS JOIN departments








