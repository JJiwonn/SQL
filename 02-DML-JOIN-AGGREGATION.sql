-------------
-- JOIN
-------------

-- employees와 departments
DESC employees;
DESC departments;

-- 카티전 프로덕트
SELECT *
FROM employees, departments;

-- INNER JOIN, EQUI-JOIN
SELECT *
FROM employees, departments
WHERE employees.department_id = departments.department_id;

-- alias를 이용한 원하는 필드의 Projection
----------------------------
-- Simple Join or Equi-Join
----------------------------
SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id; --department_id가 null인 직원은 JOIN에서 배제

SELECT * FROM employees
WHERE department_id IS NULL;

SELECT emp.first_name,
    dept.department_name
FROM employees emp JOIN departments dept USING(department_id);

----------------------
--Theta Join
----------------------

-- Join조건이 = 아닌 다른 조건들

-- 급여가 직군 평균 급여보다 낮은 직원들 목록
SELECT
    emp.employee_id,
    emp.first_name,
    emp.salary,
    emp.job_id,
    j.job_id,
    j.job_title
FROM employees emp JOIN jobs j ON emp.job_id = j.job_id
WHERE emp.salary <= (j.min_salary + j.max_salary) / 2;

-------------------
-- OUTER JOIN
-------------------

-- 조건을 만족하는 짝이 어벗는 튜플도 NULL을 포함해서 결과 출력에 참여시킨다.
-- 모든 결과를 표현한 테이블이 어느 쪽에 위치하는가에 따라서 LEFT, RIGHT, FULL OUTER JOIN으로 구분한다.
-- ORACLE SQL의 경우 NULL이 출력되는 쪽에 (+)를 붙인다

-------------------
-- LEFT OUTER JOIN
-------------------
-- LEFT 테이블의 모든 레코드가 출력 결과에 참여
    
-- ORACLE SQL
SELECT emp.first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id (+); 
-- NULL이 포함된 테이블 쪽에 (+) 표기한다

SELECT * FROM employees WHERE department_id IS NULL;
-- Kimberly는 부서에 소속되지 않음을 확인할 수 있다

-- ANSI SQL : 명시적으로 JOIN 방법을 정한다
SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp 
    LEFT OUTER JOIN departments dept 
    ON emp.department_id = dept.department_id;

-------------------
-- RIGHT OUTER JOIN
-------------------
-- RIGHT 테이블의 모든 레코드가 출력 결과에 참여

-- ORACLE SQL
SELECT first_name,
    emp.department_id,
    dept.department_id,
         department_name
FROM employees emp , departments dept
WHERE emp.department_id (+)= dept.department_id;
-- departments 테이블 레코드 전부를 출력에 참여하기에.

-- ANSI SQL : 명시적으로 JOIN 방법을 정한다
SELECT first_name,
    emp.department_id,
    dept.department_id,
       department_name
FROM employees emp 
    RIGHT OUTER JOIN departments dept
        ON emp.department_id = dept.department_id;
        
-------------------
-- FULL OUTER JOIN
-------------------

-- JOIN에 참여한 모든 테이블의 모든 레코드를 출력에 참여
-- 짝이 없는 레코드들은 null을 포함해서 출력에 참여시킨다

--ANSI SQL
SELECT first_name,
    emp.department_id,
    dept.department_id,
        department_name
FROM employees emp
    FULL OUTER JOIN departments dept
        ON emp.department_id = dept.department_id;
        
-------------------
-- NATURAL JOIN
-------------------

-- 조인할 테이블에 같은 이름의 컬럼이 있을 경우, 해당 컬럼을 기준으로 JOIN
-- 실제 본인이 JOIN 할 조건과 일치하는지 확인하고 JOIN 해야한다
-- 어떤 컬럼이 정확히 일치하는지 제대로 확인해야 한다

SELECT * FROM employees emp NATURAL JOIN departments dept;

SELECT * FROM employees emp 
    JOIN departments dept 
        ON emp.department_id = dept.department_id;
        
SELECT * FROM employees emp 
    JOIN departments dept 
        ON emp.manager_id = dept.manager_id;
        
SELECT * FROM employees emp 
    JOIN departments dept 
        ON emp.manager_id = dept.manager_id
        AND emp.department_id = dept.department_id;
        
-------------------
-- SELF JOIN
-------------------        
-- 자기 자신과 JOIN
-- 자신을 두번 호출하는 형태이기에 별칭을 반드시 부여해야한다

SELECT * FROM employees; -- 회사 직원은 총107명임을 확인

-- 1번째 방법
SELECT
    emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.first_name
FROM employees emp 
    JOIN employees man
        ON emp.manager_id = man.employee_id;
-- 2번째 방법
SELECT
    emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.first_name      
FROM employees emp, employees man
WHERE emp.manager_id = man.employee_id;

-- Steven은 매니저가 없기에 총 106명으로 확인