-- SQL 문장의 주석
-- SQL 문장은 마지막에 ;(세미콜론)으로 끝난다.
-- SQL 문장의 키워드들은 대소문자를 구분하지 않는다
-- 실제 데이터의 경우 대소문자를 구분한다

-- 테이블 구조확인(describe)
DESCRIBE employees;
describe EMPLOYEES;
DESCRIBE departments;
describe locations;

-- DML (Data Manuplation Language)
-- SELECT

-- * : 테이블 내의 모든 컬럼 Projection, 테이블 설계시에 정의한 순서대로 출력된다.
SELECT * FROM employees;

-- 특정컬럼만 Projection하고자 하면 열 목록을 명시해야 한다.
-- employees 테이블의 first_name, phone_number, hire_date, salary만 보고 싶다면 컬럼 순서는 원하는대로 하면된다.
SELECT salary, hire_date, phone_number, first_name FROM employees;

-- 사원의 이름, 성, 급여, 전화번호, 입사일 정보를 출력해보자.
SELECT first_name, last_name, salary, phone_number, hire_date FROM employees;

-- 사원 정보로부터 사번, 이름, 성 정보를 출력해보자.
SELECT employee_id, first_name, last_name FROM employees;

-- 산술연산: 기본적인 산술연산을 수행할 수 있다.
-- dual: 특정 테이블의 값이 아닌 시스템으로부터 데이터를 받아오고자 할 때 사용하는 가상테이블
SELECT 3.14159 * 10 * 10 FROM dual; -- 무조건 SELECT과 FROM은 같이 명시되어야하기 때문에 특정테이블에서 불러올수없을 때 가상테이블을 사용한다.

-- 특정 컬럼의 값을 산술 연산에 포함시키고자 할 때.
SELECT first_name, salary, salary * 12 FROM employees;

-- 다음을 실행해보고 오류의 원인이 무엇인지 확인해보자.
SELECT first_name, job_id, job_id * 12 FROM employees;
-- ㄴ 오류의 원인은 job_id가 문자열(VARCHAR2)이기에 산술식은 수치데이터가 아니면 사용할 수 없다.
DESC employees;
