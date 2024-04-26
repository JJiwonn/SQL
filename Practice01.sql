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
WHERE salary >= 10000 AND salary < 14000
ORDER BY salary DESC;

-- 문제6
SELECT first_name, salary, TO_CHAR(hire_date,'YYYY-MM') hire_date, department_id
FROM employees
WHERE department_id IN (10,90,100);

-- 문제7(S 또는 s 만족하도록 재확인)
SELECT first_name, salary
FROM employees
WHERE UPPER(first_name) LIKE '%S%';

-- 문제8 (문자길이 재확인)
SELECT  department_name
FROM departments
ORDER BY LENGTH(department_name) DESC;

-- 문제9
SELECT UPPER(country_name) country_name
FROM countries
ORDER BY UPPER(country_name);

-- 문제10 (전화번호 형태 재확인)
SELECT first_name, 
    salary, 
    REPLACE(SUBSTR(phone_number,3),'.','-'),
    hire_date
FROM employees
WHERE hire_date <= '13/12/31';
