-- 문제01
SELECT manager_id as haveMngCnt
FROM employees;

-- 문제02
SELECT MAX(salary) 최고임금, MIN(salary) 최저임금
FROM employees;

-- 문제03
SELECT hire_date
FROM employees;

-- 문제04
SELECT department_id, AVG(salary), MAX(salary), MIN(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id DESC;

-- 문제05
SELECT job_id, ROUND(AVG(salary)), MAX(salary), MIN(salary)
FROM employees
GROUP BY job_id
ORDER BY MIN(salary)DESC, ROUND(AVG(salary));

-- 문제06
SELECT TO_CHAR(MIN(hire_date), 'YYYY-MM-DD day')
FROM employees;

-- 문제07
SELECT department_id,
    AVG(salary), MIN(salary),
    AVG(salary) - MIN(salary)
FROM employees
   GROUP BY department_id
   HAVING  AVG(salary) - MIN(salary) < 2000  -- 집계 함수 이후의 조건 점검은 반드시 HAVING절에서 해야한다
ORDER BY AVG(salary) - MIN(salary) DESC;

-- 문제08
SELECT job_id,
        MAX(salary) - MIN(salary) diff
FROM employees
GROUP BY job_id
ORDER BY diff DESC;

-- 문제09
SELECT manager_id,
      ROUND(AVG(salary)), MIN(salary), MAX(salary)
FROM employees
WHERE hire_date > '15/01/01'  -- 집계 함수 실행 이전의 조건 처리
GROUP BY manager_id
HAVING AVG(salary) >=5000     -- 집계 함수 실행 이후의 조건 처리 
ORDER BY AVG(salary)DESC;

-- 문제10
SELECT employee_id,
        salary,
        -- 입사일 기준 구분
        CASE WHEN hire_date <= '12/12/31' THEN '창립멤버'
             WHEN hire_date >= '13/01/01' AND hire_date <= '13/12/31' THEN '13년입사'
             WHEN hire_date >= '14/01/01' AND hire_date <= '14/12/31' THEN '14년입사'
             ELSE '상장이후입사'
        END optDate,
        hire_date
FROM employees
ORDER BY hire_date ASC;