--문제1
SELECT first_name ||' '|| last_name 이름,
    salary 월급, phone_number 전화번호, hire_date 입사일
FROM employees
ORDER BY hire_date;

-- 문제2
SELECT job_title, max_salary
FROM jobs
ORDER BY max_salary DESC;

-- 문제3 
SELECT first_name, manager_id, commission_pct, salary
FROM employees
WHERE manager_id IS NOT NULL AND commission_pct IS NULL AND salary >3000;

-- 문제4
SELECT job_title, max_salary
FROM jobs
WHERE max_salary >=10000
ORDER BY max_salary DESC;

-- 문제5
SELECT first_name, salary ,NVL(commission_pct,0)
FROM employees
WHERE salary BETWEEN 10000 AND 14000
ORDER BY salary DESC;

-- 문제6
SELECT first_name, salary, TO_CHAR(hire_date,'YYYY-MM'), department_id
FROM employees
WHERE department_id IN (10,90,100);

-- 문제7
SELECT first_name, salary
FROM employees
WHERE first_name LIKE '%s%';

-- 문제8
SELECT department_id, department_name, manager_id, location_id
FROM departments;

-- 문제9

-- 문제10 (전화번호 형태 재확인)
SELECT first_name, salary, phone_number, hire_date
FROM employees
WHERE hire_date > '13/12/31';
