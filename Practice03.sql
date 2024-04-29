--문제01
-- Simple Join
SELECT emp.employee_id,
        emp.first_name,
        emp.last_name,
        dept.department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id
ORDER BY dept.department_name ASC, emp.employee_id DESC;

-- ANSI Join
-- ANSI는 JOIN의 의도를 명확하게 하고, 조인 조건과 SELECTION 조건을 분리하는 효과가 있다
SELECT emp.employee_id,
        emp.first_name,
        emp.last_name,
        dept.department_name
FROM employees emp  -- 중심테이블
    JOIN departments dept
        ON emp.department_id = dept.department_id -- 조인 조건
ORDER BY dept.department_name ASC, emp.employee_id DESC;

-- 문제02
-- Simple Join
SELECT emp.employee_id 사번,
    emp.first_name 이름,
    emp.salary 급여,
    dept.department_name 부서명,
    j.job_title 현재업무
FROM employees emp, departments dept, jobs j
WHERE emp.department_id = dept.department_id AND
    emp.job_id = j.job_id
ORDER BY emp.employee_id ASC;

-- ANSI JOIN
SELECT emp.employee_id 사번,
    emp.first_name 이름,
    emp.salary 급여,
    dept.department_name 부서명,
    j.job_title 현재업무
FROM employees emp -- 중심 테이블
    JOIN departments dept
    ON emp.department_id = dept.department_id -- emp 테이블과 dept 테이블을 join하는 조건
    JOIN jobs j
    ON emp.job_id = j.job_id
ORDER BY emp.employee_id ASC;

-- 문제02-1
-- SELECT * FROM employees WHERE department_id IS NULL; NULL포함된 테이블을 확인할 때 사용
-- Simple Join
SELECT emp.employee_id 사번,
    emp.first_name 이름,
    emp.salary 급여,
    dept.department_name 부서명,
    j.job_title 현재업무
FROM employees emp, departments dept, jobs j
WHERE emp.department_id = dept.department_id (+) -- NULL이 포함된 테이블쪽에 (+)붙이기
AND   emp.job_id = j.job_id
ORDER BY emp.employee_id ASC;

-- ANSI JOIN
SELECT emp.employee_id 사번,
    emp.first_name 이름,
    emp.salary 급여,
    dept.department_name 부서명,
    j.job_title 현재업무
FROM employees emp -- 중심 테이블
    LEFT OUTER JOIN departments dept
        ON emp.department_id = dept.department_id  -- emp 테이블과 dept 테이블을 join하는 조건
    JOIN jobs j
        ON emp.job_id = j.job_id
ORDER BY emp.employee_id ASC;

-- 문제03
-- ANSI JOIN
SELECT loc.location_id,
        loc.city,
        dept.department_name,
        dept.department_id
FROM locations loc
    JOIN departments dept
        ON loc.location_id = dept.location_id
ORDER BY loc.location_id ASC;


-- 문제03-1
SELECT loc.location_id,
        loc.city,
        dept.department_name,
        dept.department_id
FROM locations loc
    LEFT OUTER JOIN departments dept
        ON loc.location_id = dept.location_id
ORDER BY loc.location_id ASC;

-- 문제04
-- ANSI JOIN
SELECT reg.region_name,
        con.country_name
FROM regions reg        -- 중심 테이블
    JOIN countries con
        ON reg.region_id = con.region_id
ORDER BY reg.region_name ASC, con.country_name DESC;

-- 문제 05
-- SELF JOIN
SELECT emp.employee_id 사번,
        emp.first_name 이름,
        emp.hire_date 채용일,
        man.first_name 매니저이름,
        man.hire_date 매니저입사일
FROM employees emp
    JOIN employees man
        ON emp.manager_id = man.employee_id -- JOIN 조건
WHERE emp.hire_date < man.hire_date; -- SELECTION 조건

-- 문제 06
-- ANSI JOIN
SELECT 
        con.country_name,
        con.country_id,
        loc.city,
        loc.location_id,
        dept.department_name,
        dept.department_id
FROM countries con        -- 중심 테이블
    JOIN locations loc
        ON con.country_id = loc.country_id
    JOIN departments dept
        ON loc.location_id = dept.location_id
ORDER BY con.country_name ASC;

-- 문제 07
-- ANSI JOIN
SELECT emp.employee_id,
    emp.first_name||' '|| last_name 이름,
    jh.job_id,
    jh.start_date,
    jh.end_date
FROM employees emp
 JOIN job_history jh
  ON emp.employee_id = jh.employee_id  -- JOIN 조건
WHERE jh.job_id = 'AC_ACCOUNT';


-- 문제 08
-- ANSI JOIN
SELECT dept.department_id,
       dept.department_name,
       man.first_name,
       loc.city,
       con.country_name,
       reg.region_name
FROM departments dept
    JOIN employees man ON dept.manager_id = man.employee_id
    JOIN locations loc ON dept.location_id = loc.location_id
    JOIN countries con ON loc.country_id = con.country_id
    JOIN regions reg ON con.region_id = reg.region_id
ORDER BY dept.department_id;

-- 문제 09
-- ANSI JOIN
SELECT emp.employee_id,
       emp.first_name,
       dept.department_name,
       man.first_name
FROM employees emp
    LEFT OUTER JOIN departments dept
        ON emp.department_id = dept.department_id
    JOIN employees man
        ON emp.manager_id = man.employee_id;