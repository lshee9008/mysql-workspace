 
/*------------------------------------------------------------
문제
-------------------------------------------------------------*/
-- 1) 모든사원에게는 상관(Manager)이 있다. 하지만 employees테이블에 유일하게 상관이
--   없는 로우가 있는데 그 사원(CEO)의 manager_id컬럼값이 NULL이다. 상관이 없는 사원을
--   출력하되 manager_id컬럼값 NULL 대신 CEO로 출력하시오.
SELECT * FROM employees


SELECT first_name, ifnull(cast(manager_id AS char(3)), 'CEO')
FROM employees
WHERE manager_id IS NULL
   

-- 2) 가장최근에 입사한 사원의 입사일과 가장오래된 사원의 입사일을 구하시오.
SELECT max(hire_Date) , min(hire_date)
FROM employees
   
 
-- 3) 부서별로 커미션을 받는 사원의 수를 구하시오.
SELECT * FROM department

SELECT d.department_name, count(commission_pct)
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id 
-- AND e.commission_pct IS NOT NULL
GROUP BY d.department_name
    
   
-- 4) 부서별 최대급여가 10000이상인 부서만 출력하시오.   
SELECT d.department_name, max(e.salary)
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id 
GROUP BY d.department_name
HAVING max(e.salary) >= 10000



 
-- 5) employees 테이블에서 직종이 'IT_PROG'인 사원들의 급여평균을 구하는 SELECT문장을 기술하시오.
SELECT * FROM employees;
SELECT * FROM departments 

  SELECT AVG(salary)
  FROM employees
  GROUP BY job_id 
  HAVING job_id = 'IT_PROG'

-- 6) employees 테이블에서 직종이 'FI_ACCOUNT' 또는 'AC_ACCOUNT' 인 사원들 중 최대급여를 구하는 SELECT문장을 기술하시오.   
  SELECT max(salary)
  FROM employees 
  GROUP BY job_id 
  HAVING job_id = 'FI_ACCOUNT' OR job_id = 'AC_ACCOUNT';

-- 7) employees 테이블에서 50부서의 최소급여를 출력하는 SELECT문장을 기술하시오.
SELECT min(salary)
FROM employees 
GROUP BY department_id 
HAVING department_id = 50
   
    
-- 8) employees 테이블에서 아래의 결과처럼 입사인원을 출력하는 SELECT문장을 기술하시오.
--   <출력:  2001		   2002		       2003
 --  	     4              0                4   >
-- ?????????????????
  SELECT
    SUM(CASE WHEN YEAR(hire_date) = 2001 THEN 1 ELSE 0 END) AS `2001`,
    SUM(CASE WHEN YEAR(hire_date) = 2002 THEN 1 ELSE 0 END) AS `2002`,
    SUM(CASE WHEN YEAR(hire_date) = 2003 THEN 1 ELSE 0 END) AS `2003`
FROM employees;
  
    
   
-- 9) employees 테이블에서 각 부서별 인원이 10명 이상인 부서의 부서코드,
--  인원수, 급여의 합을 구하는 SELECT문장을 기술하시오.
SELECT d.department_id, d.department_name, COUNT(*) AS 인원수, SUM(e.salary) AS 급여합
FROM employees e INNER JOIN departments d 
ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(*) >= 10;
  
   
  
-- 10) employees 테이블에서 이름(first_name)의 세번째 자리가 'e'인 직원을 검색하시오.
SELECT first_name
FROM employees
WHERE first_name LIKE '__e%';
  

  
  