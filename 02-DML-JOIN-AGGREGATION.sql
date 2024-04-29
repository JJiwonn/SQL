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



-------------------
-- Group Aggregation
-------------------
-- 집계: 여러 행으로부터 데이터를 수집, 하나의 행으로 반환한다
-- COUNT: 레코드의 갯수 세기 함수
-- employees 테이블의 총 레코드 갯수는?
SELECT COUNT(*) FROM employees;  -- 107개로 확인완료
-- *로 카운트하면 모든 행의 수를 반환한다
-- 특정 컬럼내에 NULL값이 포함되어 있는지 여부는 중요하지 않다

-- commission을 받는 직원의 수를 알고 싶은데
-- commission_pct가 NULL인 경우를 제외하고 싶을 경우
SELECT COUNT(commission_pct) FROM employees; -- 35명 확인완료
-- 컬램내에 포함된 NULL 데이터를 카운터하지 않는다

-- 따라서 위에 [SELECT COUNT(commission_pct) FROM employees;]쿼리는
-- 아래 제시된 쿼리와 같다
SELECT COUNT(*) FROM employees
WHERE commission_pct IS NOT NULL;

-- SUM: 합계 함수
-- 모든 사원의 급여의 합계는?
SELECT SUM(salary) FROM employees;

-- AVG: 평균 함수
-- 사원들의 평균 급여는?
SELECT AVG(salary) FROM employees;

-- 사원들이 받는 평균 커미션 비율은?
SELECT AVG(commission_pct) FROM employees; -- 대략 22%정도임을 확인완료
-- AVG 함수는 NULL 값이 포함되어 있을 경우 그 값을 집계 수치에서 제외한다
-- NULL 값을 집계 결과에 포함시킬지의 여부는 정책으로 결정하고 수행해야한다
SELECT AVG(NVL(commission_pct,0)) FROM employees;

-- MIN / MAX : 최솟값 / 최댓값
-- AVG / MEDIAN : 산술평균 / 중앙값
SELECT 
    MIN(salary)최소급여,
    MAX(salary)최대급여,
    AVG(salary)평균급여,
    MEDIAN(salary)급여중앙값
FROM employees;

-- 흔히 범하는 오류
-- 부서별로 평균 급여값을 구하고자 할 때
SELECT department_id, AVG(salary)
FROM employees;                       -- 오류발생확인

SELECT department_id FROM employees;  -- 여러개의 레코드
SELECT AVG(salary) FROM employees;    -- 단일 레코드

SELECT department_id, salary
FROM employees
ORDER BY department_id;

--GROUP BY
SELECT department_id, ROUND(AVG(salary),2)  -- 두번째 소수점까지 나타내는 함수
FROM employees
GROUP BY department_id  -- 집계를 위해 특정 컬럼을 기준으로 그룹핑
ORDER BY department_id;


-- 부서별 평균 급여에 부서명도 포함하여 출력
SELECT emp.department_id, dept.department_name, ROUND(AVG(emp.salary),2)
FROM employees emp
    JOIN departments dept
        ON emp.department_id = dept.department_id
GROUP BY emp.department_id, dept.department_name
ORDER BY emp.department_id;
-- GROUP BY 절 이후에는 GROUP BY에 참여한 컬럼과 집계함수만 남는다


-- 평균 급여가 7000이상인 부서만 출력
SELECT department_id, AVG(salary)
FROM employees
WHERE AVG(salary) >= 7000    --아직 집계 함수가 시행되지 않은 상태이기에 집계함수의 비교가 불가하다
GROUP BY department_id
ORDER BY department_id;

-- 집계 함수 이후의 조건 비교 HAVING 절을 이용하여 출력
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
    HAVING AVG(salary) >= 7000  -- GROUP BY aggregation의 조건 필터링
ORDER BY department_id;


-- ROLLUP
-- GROUP BY 절과 함께 사용되고 그룹지어진 결과에 대해 좀 더 상세한 요약을 제공하는 기능을 수행한다
-- 일종의 ITEM TOTAL
SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY ROLLUP (department_id, job_id);

-- CUBE
-- GROUP BY 절과 함께 사용되고
-- CROSSTAB에 대한 SUMMARY를 함께 추출하는 함수이다
-- ROLLUP 함수에 의해 출력되는 ITEM TOTAL 값과 함께 COLUMN TOTAL 값을 함께 추출한다
SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY CUBE (department_id, job_id)
ORDER BY department_id;



-------------------
-- SUBQURY
-------------------

-- 모든 직원 급여의 중앙값보다 많은 급여를 받는 사원
-- 1)직원 급여의 중앙값은?
-- 2) 1)번의 결과보다 많은 급여를 받는 직원의 목록?

-- 1)직원 급여의 중앙값
SELECT MEDIAN(salary)FROM employees;     -- 1)번의 결과 6200 확인완료
-- 1)번의 결과(6200)보다 많은 급여를 받는 직원의 목록
SELECT first_name, salary
FROM employees
WHERE salary >=6200
ORDER BY salary ASC;

-- 1)과 2)의 쿼리를 합치기
SELECT first_name, salary
FROM employees
WHERE salary >= (SELECT MEDIAN(salary)FROM employees)
ORDER BY salary DESC;

-- Susan보다 늦게 입사한 사원의 정보
-- 1) Susan의 입사일
-- 2) 1)번의 결과보다 늦게 입사한 사원의 정보

-- 1) Susan의 입사일
SELECT hire_date FROM employees
WHERE first_name = 'Susan';       -- 1)번의 결과 12/06/07 확인완료

-- 2) 1)번의 결과보다 늦게 입사한 사원의 정보
SELECT first_name, hire_date
FROM employees
WHERE hire_date > '12/06/07';

-- 1)과 2)의 쿼리를 합치기
SELECT first_name, hire_date
FROM employees
WHERE hire_date > (SELECT hire_date FROM employees WHERE first_name = 'Susan');

-- 연습문제
-- 급여를 모든 직원 급여의 중앙값보다 많이 받으면서 Susan 보다 늦게 입사한 직원의 목록
-- 1) 급여를 모든 직원 급여의 중앙값보다 많이 받는 조건
-- 2) Susan의 입사일 보다 hire_date 늦게 입사한 조건
SELECT first_name, salary, hire_date
FROM employees
WHERE salary > (SELECT MEDIAN(salary)FROM employees) AND
      hire_date > (SELECT hire_date FROM employees WHERE first_name = 'Susan')
ORDER BY hire_date ASC, salary DESC;