/*
 VARCHAR, TEXT타입의 데이터 대소문자 구분을 안한다.
 대소문자를 구분할려면 VARBINARY타입을 사용해야 한다.
*/

-- SELECT 입력순서
/*
SELECT column_name, column_name, column_name
FROM table_name
WHERE column_name='value'
GROUP BY column_name
HAVING column_name='value'
ORDER BY column_name ASC(DESC);
오름차순 ASC(생략가능)
내림차순 DESC
*/

-- SELECT 해석순서
/*
FROM table_name
WHERE column_name='value'
GROUP BY column_name
HAVING column_name='value'
SELECT column_name, column_name, column_name
ORDER BY column_name ASC(DESC);
*/

-- employees테이블에서 salary이 3000미만일때
-- first_name, salary을 출력하라.

SELECT first_name, salary
FROM employees
WHERE SALARY < 3000;

-- employees테이블에서 first_name컬럼의 값이 'David'일때
-- first_name, salary을 출력하라.
SELECT first_name, salary
FROM employees
WHERE first_name = 'David'; # WEHERE 절에서는 == 가 아니라 =로 함.

SELECT first_name, salary
FROM employees
WHERE first_name != 'David';

SELECT first_name, salary
FROM employees
WHERE first_name <> 'David';


-- &&(AND), ||(OR)
-- employees테이블에서 salary이 3000, 9000, 17000일때
-- first_name, hire_date, salary을 출력하라.
SELECT first_name, hire_date, salary
FROM employees
WHERE salary = 3000 OR salary = 9000 OR salary = 17000;


SELECT first_name, hire_date, salary
FROM employees
WHERE salary IN(3000, 9000, 17000);


-- 현재 사용중인 데이터베이스 확인
SELECT DATABASE();

-- employees테이블에서 salary이 3000이상 5000이하일때
-- first_name, hire_date, salary을 출력하라.
SELECT first_name, hire_date, salary
FROM employees
WHERE salary >= 3000 AND salary <= 5000;

SELECT first_name, hire_date, salary
FROM employees
WHERE salary BETWEEN 3000 AND 5000;

-- employees테이블에서 job_id가 'IT_PROG'이 아닐때
-- first_name, hire_date, salary, job_id을 출력하라.


-- employees테이블에서 job_id가 'IT_PROG'이 아닐때
-- first_name, hire_date, salary, job_id을 출력하라.

SELECT first_name, hire_date, salary, job_id
FROM employees
WHERE job_id != 'IT_PROG';

SELECT first_name, hire_date, salary, job_id
FROM employees
WHERE job_id <> 'IT_PROG';

SELECT first_name, hire_date, salary, job_id
FROM employees
WHERE NOT(job_id = 'IT_PROG');

-- employees테이블에서 salary이 3000, 9000, 17000 아닐때
-- first_name, hire_date, salary을 출력하라.

SELECT first_name, hire_date, salary
FROM employees
WHERE NOT(salary=3000 OR salary=9000 OR salary=17000);

SELECT first_name, hire_date, salary
FROM employees
WHERE salary NOT IN(3000, 9000, 17000);

-- employees테이블에서 commission_pct이 null일때
-- first_name, salary, commission_pct을 출력하라.
SELECT first_name, salary, commission_pct
FROM employees
WHERE commission_pct = NULL;

SELECT first_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NULL;

SELECT first_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

-- employees테이블에서 first_name에 'der'이 포함이 될때
-- first_name, salary, email을 출력하라.
SELECT first_name, salary, email
FROM employees
WHERE first_name LIKE '%der%';

-- employees테이블에서 first_name의 값중 'A'로 시작하고 
-- 두번째 문자는 임의 문자이며 'exander'로 끝날때
-- first_name, salary, email을 출력하라.

SELECT first_name, salary, email
FROM employees
WHERE first_name LIKE 'A_exander';



/*
 WHERE절에서 사용된 연산자 3가지 종류
 1 비교연산자 : = > >= < <= != <> 
 2 SQL연산자 : BETWEEN a AND b,  IN, LIKE, IS NULL
 3 논리연산자 : AND, OR, NOT
 
 우선순위
 1 괄호()
 2 NOT연산자
 3 비교연산자, SQL연산자
 4 AND
 5 OR
  */

  -- employees테이블에서 job_id을 오름차순으로 
  -- first_name, email, job_id을 출력하시오. 

SELECT first_name, email, job_id
FROM employees
ORDER BY job_id ASC;


 -- employees테이블에서 가장 최근 입사 순으로 
  -- first_name, salary, hire_date을 출력하시오. 

SELECT first_name, email, job_id
FROM employees
ORDER BY hire_date DESC;

-- employees테이블에서 가장 최근 입사 순, 급여는 낮은순 으로
-- first_name, salary, hire_date을 출력하시오.
SELECT first_name, salary, hire_date
FROM employees
ORDER BY hire_date DESC, salary ASC;


-- employees테이블에서 업무(job_id)이 'FI_ACCOUNT'인 사원들의 
-- 급여(salary)가 높은순으로 first_name, job_id, salary을 출력하시오. 

SELECT first_name, job_id, salary
FROM employees
WHERE job_id = 'FI_ACCOUNT'
ORDER BY salary DESC;

/* /////////////////////////////////////
////--문제--
////////////////////////////////////// */
-- 1) employees테이블에서 급여가 17000이하인 사원의 사원번호, 사원명(first_name), 급여를 출력하시오.
SELECT job_id, first_name, salary
FROM employees
WHERE salary <= 17000;

SELECT *
FROM employees

-- 2) employees테이블에서 2005년 1월 1일 이후에 입사한 사원을 출력하시오.
SELECT first_name
FROM employees
WHERE HIRE_DATE >= '2017-01-01';
  

-- 3) employees테이블에서 급여가 5000이상이고 업무(job_id)이 'IT_PROG'이 사원의 사원명(first_name), 급여, 
--   업무을 출력하시오.
SELECT first_name, salary, job_id
FROM employees
WHERE salary >= 500 AND job_id = 'IT_PROG';
 

-- 4) employees테이블에서 부서번호가 10, 40, 50 인 사원의 사원명(first_name), 부서번호, 이메일(email)을 출력하시오.
SELECT first_name, department_id, email
FROM employees
WHERE department_id = 10 OR department_id = 40 OR department_id = 50;


-- 5) employees테이블에서 사원명(first_name)이 even이 포함된 사원명, 급여, 입사일을 출력하시오.
SELECT first_name, salary, hire_date
FROM employees
WHERE first_name LIKE '%even%';

-- 6) employees테이블에서 사원명(first_name)이 teve앞뒤에 문자가 하나씩 있는 사원명, 급여, 입사일을 출력하시오.
SELECT first_name, salary, hire_date
FROM employees
WHERE first_name LIKE '%teve%';

-- 7) employees테이블에서 급여가 17000이하이고 커미션이 null이 아닐때의 사원명(first_name), 급여, 
--  커미션을 출력하시오.
SELECT first_name, salary, commission_id
FROM employees
WHERE salary >= 17000 AND commission_id IS NOT NULL;
  
-- 8) 2005년도에 입사한 사원의 사원명(first_name),입사일을 출력하시오.
-- ??????????????????
SELECT first_name, hire_date
FROM employees
-- WHERE dayofyear(hire_date) = '2005';


-- 9) 커미션 지급 대상인 사원의 사원명(first_name), 커미션을 출력하시오.
 

-- 10) 사번이 206인 사원의 이름(first_name)과 급여를 출력하시오.
 

-- 11) 급여가 3000이 넘는 업무(job_id),급여(salary)를 출력하시오.
 

-- 12)'ST_MAN'업무을 제외한 사원들의 사원명(first_name)과 업무(job_id)을 출력하시오.
-- !=, <>,  not
  



-- 13) 업무이 'PU_CLERK' 인 사원 중에서 급여가 2800 이상인 사원명(first_name),업무(job_id),급여(salary)을 출력하시오.


-- 14) commission을 받는 사원명(first_name)을 출력하시오.


-- 15) 20번 부서와 30번 부서에 속한 사원의 사원명(fist_name), 부서를 출력하시오.

   

 
-- 16) 급여가 많은 사원부터 출력하되 급여가 같은 경우 사원명(first_name) 순서대로 출력하시오.


-- 17) 업무이 'MAN' 끝나는 사원의 사원명(first_name), 급여(salary), 업무(job_id)을 출력하시오.

