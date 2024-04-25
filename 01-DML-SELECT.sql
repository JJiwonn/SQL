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

-- NULL
-- NULL은 0이나 공백과 다르게 빈 값이다.
-- NULL은 산술연산 결과, 통계 결과를 왜곡시키기에 NULL에 대한 처리는 철저하게 해야한다
-- 이름, 급여, 커미션 비율을 출력해보자
SELECT first_name, salary, commission_pct FROM employees;

-- 이름, 커미션 비율을 포함한 급여를 출력해보자
SELECT first_name, salary, commission_pct, salary + salary * commission_pct FROM employees;
-- NULL이 포함된 연산식의 결과는 NULL이다.
-- NULL을 처리하기 위한 함수 NVL이 필요하다.
-- NVL (표현식1, 표현식2)일때 표현식1이 NULL일 경우 표현식2로 대체하여 출력한다.

-- NVL을 사용하여 잘못계산된 식을 다시 계산해보자.
SELECT first_name, salary, commission_pct, salary + salary * NVL(commission_pct, 0) FROM employees;

-- 별칭: Alias
-- Alias는 Projection 단계에서 출력용으로 표시되는 임시 컬럼 제목이다.
-- 컬럼명 뒤에 별칭입력 또는 컬렴명 뒤에 as별칭 으로 사용하여 출력한다.
-- 별칭명에 특수문자가 포함된 경우에는 "" 큰따옴표로 표시하여 출력한다.

-- 직원아이디, 이름, 급여를 출력해보자.
-- 직원아이디는 empNO, 이름은 f-name, 급여는 월 급 으로 표시한다.
SELECT employee_id as empNO , first_name as "f-name", salary "월 급" FROM employees;

-- 직원이름의 first_name과 last_name을 합쳐서 name으로 출력해보자.
-- 급여(커미션이 포함된), 급여 * 12 연봉 별칭으로 출력해보자.
SELECT first_name ||' '|| last_name "Full name", 
       salary + salary * nvl(commission_pct, 0)"급여(커미션포함)", 
       salary *12 연봉 
FROM employees;

-- 연습문제
SELECT first_name ||' '|| last_name 이름,
       hire_date 입사일,
       phone_number 전화번호,
       salary 급여,
       salary * 12 연봉
FROM employees;

-- WHERE
-- 특정 조건을 기준으로 레코드를 선택한다.(SELECTION)

-- 비교연산: =, <>, >, >=, <, <=
-- 사원들 중에서 급여가 15000이상인 직원들의 이름과 급여를 출력해보자
SELECT first_name, salary FROM employees WHERE salary >= 15000;

-- 입사일이 17/01/01 이후인 직원들의 이름과 입사일을 출력해보자
SELECT first_name, hire_date FROM employees WHERE hire_date >= '17/01/01';

-- 급여가 4000미만이거나 17000초과인 사원의 이름과 급여를 출력해보자
SELECT first_name, salary FROM employees WHERE salary < 4000 or salary > 17000;

-- 급여가 14000이상이고, 17000이하인 사원의 이름과 급여를 출력해보자
SELECT first_name, salary FROM employees WHERE salary >=14000 AND salary <=17000;

-- BETWEEN: 범위 비교
SELECT first_name, salary FROM employees WHERE salary BETWEEN 14000 AND 17000;
-- BETWEEN은 위에 AND문과 동일한 출력값을 갖는다

-- NULL 체크 =, <> 연산자는 사용할수 없다
-- IS NULL, IS NOT NULL만 사용할 수 있다

-- commission을 받지 않는 사람들을 출력해보자(commission_pct가 null인 레코드)
SELECT first_name,commission_pct FROM employees WHERE commission_pct IS NULL;

-- commission을 받는 사람들을 출력해보자(commission_pct가 null이 아닌 레코드)
SELECT first_name,commission_pct FROM employees WHERE commission_pct IS NOT NULL;

-- 사원들 중 10, 20, 40번 부서에서 근무하는 직원들의 이름과 부서아이디를 출력해보자
-- (부서아이디는 하나이기에 10,20,40중에서 하나만 충족해도 출력하는 조건이 만들어져야한다. 총 3개의 조건식이 확인된다)
SELECT first_name, department_id FROM employees 
WHERE department_id =10 or department_id =20 or department_id =40;

-- IN 연산자: 특정집합의 요소와 비교한다
SELECT first_name, department_id FROM employees WHERE department_id IN (10,20,40);
-- or을 사용하여 조건식을 하나씩 만들어도 되지만 많은 조건식을 가질경우 IN 연산자를 사용하면 같은 출력값을 확인할 수 있다.

-- LIKE 연산자
-- 와일드카드(%, _)를 이용한 부분 문자열 매칭한다.
-- % : 0개 이상의 정해지지 않은 문자열
-- _(언더바) : 1개 이상의 정해지지 않은 문자(1개만 받기때문에 문자열이 아닌 문자가 된다)

-- 이름에 am을 포함하고 있는 사원의 이름과 급여를 출력해보자
SELECT first_name, salary FROM employees WHERE first_name LIKE '%am%';

-- 이름에 두번째 글자가 a인 사원의 이름과 급여를 출력해보자
SELECT first_name, salary FROM employees WHERE first_name LIKE '_a%';

-- 이름의 네번째 글자가 a인 사원의 이름과 급여를 출력해보자
SELECT first_name, salary FROM employees WHERE first_name LIKE '___a%';

-- 이름이 네글자인 사원들 중에서 두번째 글자가 a인 사원의 급여를 출력해보자
SELECT first_name, salary FROM employees WHERE first_name LIKE '_a__';


-- 쿼리 연습
-- 부서 ID가 90인 사원 중, 급여가 10000이상인 사원의 이름과 부서ID, 급여를 출력해보자
SELECT first_name, department_id, salary FROM employees WHERE department_id =90 AND salary >=10000;

-- 입사일이 11/01/01 ~ 17/12/31 구간에 있는 사원의 이름과 입사일 목록을 출력해보자
-- 1. BETWEEN 연산자 활용
SELECT first_name, hire_date FROM employees WHERE hire_date BETWEEN '11/01/01' AND '17/12/31';
-- 2. 비교 조합 활용
SELECT first_name, hire_date FROM employees WHERE hire_date >= '11/01/01' AND hire_date <='17/12/31';

-- manager_id가 100, 120, 147인 사원의 목록을 출력해보자
-- 1. IN 연산자 활용
SELECT employee_id employee, first_name name, manager_id manager 
FROM employees 
WHERE manager_id IN (100,120,147);
-- 2. 비교연산자 + 논리연산자의 조합
SELECT employee_id employee, first_name as name, manager_id as manager 
FROM employees 
WHERE manager_id = 100 or manager_id =120 or manager_id =147;


-- ORDER BY
-- 특정 컬럼명, 연산식, 별칭, 컬럼 순서를 기준으로 레코드를 정렬한다
-- ACS(오름차순: default), DESC(오름차순)
-- 여러개의 컬럼에 적용할 수 있고 , (콤마)로 구분한다

-- 부서 번호의 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력해보자
SELECT department_id, salary, first_name FROM employees
ORDER BY department_id ASC; -- ACS는 생략가능하다

-- 급여가 10000 이상인 직원을 내림차순으로 정렬하고 급여, 이름을 출력해보자
SELECT salary, first_name FROM employees WHERE salary >= 10000
ORDER BY salary DESC;

-- 부서번호는 오름차순, 급여는 내림차순으로 정렬하고 부서 번호, 급여, 이름순으로 출력해보자
SELECT department_id, salary, first_name FROM employees
ORDER BY department_id, salary DESC; -- 정렬기준을 어떻게 세우느냐에 따라서 성능과 출력결과에 영향을 미칠 수 있다

------------------ 단일행 함수---------------
-- 단일 레코드를 기준으로 특정 컬럼에 값에 적용되는 함수
-- 문자열 단일행 함수
SELECT first_name, last_name,  
CONCAT(first_name, CONCAT(' ', last_name)),
first_name||' '||last_name,
INITCAP (first_name ||' ' || last_name) -- 각 단어의 첫글자를 대문자로 출력
FROM employees;

SELECT first_name, last_name,
LOWER(first_name), UPPER(first_name),
LPAD(first_name, 20, '#'), -- 왼쪽 빈자리 채움
RPAD(first_name,20,'*')    -- 오른쪽 빈자리 채움
FROM employees;


SELECT '      Oracle           ', '*******Database********',
LTRIM ('      Oracle           '), -- 왼쪽의 빈공간을 삭제
RTRIM ('      Oracle           '),  -- 오른쪽의 빈공간을 삭제
TRIM ('*'FROM'*******Database********'), -- 앞뒤에 잡음 문자를 삭제
SUBSTR('Oracle Database', 8, 4),-- Oracle Database에서 공백포함 앞에서 8번째부터 4까지 길이를 출력
SUBSTR('Oracle Database', -8, 4),-- Oracle Database에서 공백포함 뒤에서 8번째부터 4까지 길이를 출력
LENGTH('Oracle Database') -- 문자열 길이
FROM dual;

-- 수치형 단일행 함수

SELECT 3.14159 파이,
    ABS(-3.14), -- 절대값
    CEIL(-3.14), -- 올림함수
    FLOOR(-3.14), -- 내림함수
    ROUND(3.5), -- 반올림
    ROUND(3.14159,3), -- 소수점 셋째자리까지 보여줘라(넷째자리에서 반올림)
    TRUNC(3.5), -- 버림
    TRUNC(3.14159,3), -- 소수점 셋짜자리까지 보여줘라(넷째자리에서 버림)
    SIGN(-3.14159), -- 부호(-1:음수, 0:0, +1:양수)로 표현해라
    MOD(7,3), -- 7을 3으로 나눈 나머지
    POWER(2,4) -- 2의 4제곱
FROM dual;

-------------DATA FORMAT----------

-- 현재 session 정보 확인
SELECT * FROM nls_session_parameters;

-- 현재 날짜 포맷이 어떻게 되는가
-- 딕셔너리를 확인해야한다
SELECT value FROM nls_session_parameters -- 환경변수 딕셔너리를 확인함
WHERE parameter='NLS_DATE_FORMAT';

-- 현재 날짜 : SYSDATE
SELECT SYSDATE FROM dual; -- 가상테이블 dual로부터 받아옴으로 1개의 레코드

SELECT SYSDATE FROM employees; -- employees 테이블로부터 받아옴으로 employees 테이블 레코드의 갯수만큼

-- 날짜 관련 단일행 함수
SELECT
    sysdate,
    ADD_MONTHS(sysdate, 1), -- 1개월이 지난 후의 날짜
    LAST_DAY(sysdate), -- 현재 달의 마지막 날짜
    MONTHS_BETWEEN('12/09/24',sysdate), -- 두 날짜 사이의 개월 차
    NEXT_DAY(sysdate,7), -- 1:일 ~ 7:토
    NEXT_DAY(sysdate,'일'), -- NLS_DATE_LANGUAGE의 설정에 따름
    ROUND(sysdate,'MONTH'), -- MONTH를 기준으로 반올림
    TRUNC(sysdate,'MONTH') -- MONTH를 기준으로 내림
FROM dual;

SELECT first_name, hire_date,
    ROUND(MONTHS_BETWEEN(sysdate, hire_date))as 근속월수
FROM employees;

--------------변환함수------------
-- TO_NUMBER(s, fmt): 문자열-> 숫자
-- TO_DATE(s, fmt): 문자열-> 날짜
-- TO_CHAR(d, fmt): 숫자, 날짜-> 문자열

-- TO_CHAR
SELECT 
    first_name,
    TO_CHAR(hire_date,'YYYY-MM-DD')as "년-월-일"
FROM employees;

-- 현재 시간을 년-월-일 시:분:초로 표기
SELECT sysdate,
    TO_CHAR(sysdate,'YYYY-MM-DD HH:MI:SS')
FROM dual;

SELECT
    TO_CHAR(30000000,'L999,999,999')
FROM dual;

-- 모든 직원의 이름과 연봉 정보를 표시해보자
SELECT first_name, salary, commission_pct,
    TO_CHAR((salary + salary * nvl(commission_pct,0))*12, '$999,999.99') 연봉
FROM employees;

-- 문자-> 숫자: TO_NUMBER
SELECT '$57,600',
    TO_NUMBER('$57,600', '$999,999')/12 월급
FROM dual;

-- 문자-> 날짜: TO_DATE
SELECT '2012-09-24 13:48:00' 어느날,
    TO_DATE ('2012-09-24 13:48:00', 'YYYY-MM-DD HH24:MI:SS') 날짜
FROM dual;

-- 날짜 연산
-- Date +/- Number : 특정 날수를 더하거나 뺄 수 있다
-- Date - Date : 특정 날짜에서 특정 날짜를 빼면 두 날짜 사이에 경과일수를 확인 할 수 있다
-- Date + Number / 24 : 특정 시간이 지난 후의 날짜
SELECT sysdate,
    sysdate +1 , sysdate -1,
    sysdate - TO_DATE('20240424'),
    sysdate + 48 /24
FROM dual;

-- NVL function
SELECT first_name, 
    salary, 
    NVL(salary * commission_pct,0) commission
FROM employees;

-- NVL2 function
SELECT first_name, 
    salary, 
    NVL2(commission_pct, salary / commission_pct,1) commission
FROM employees;

-- CASE function
-- 보너스를 지급하기로 했을 때
-- AD관련 직종에게는 20%, SA관련 직종에게는 10%, IT관련 직종에게는 8%, 나머지에게는 5%
SELECT first_name, job_id, salary,
    SUBSTR(job_id, 1, 2),
    CASE SUBSTR(job_id, 1, 2) WHEN 'AD' THEN salary * 0.2
                              WHEN 'SA' THEN salary * 0.1 
                              WHEN 'IT' THEN salary *0.08
                              ELSE salary *0.05
    END 보너스
FROM employees;

-- DECODE 함수
SELECT first_name, job_id, salary,
    SUBSTR(job_id, 1, 2),
    DECODE(SUBSTR(job_id, 1, 2),
                         'AD' , salary * 0.2,
                         'SA' , salary * 0.1, 
                         'IT' , salary *0.08,
                         salary *0.05) 보너스
FROM employees;

-- 연습문제(2_PDF_58p)
-- 직원의 이름, 부서, 팀을 출력(팀은 부서 ID로 결정)
-- 10 ~ 30 : A-GROUP
-- 40 ~ 50 : B-GROUP
-- 60 ~ 100 : C-GROUP
-- 나머지부서 : REMAINDER
SELECT first_name, department_id,
    CASE WHEN department_id <=30 THEN 'A-GROUP'
        WHEN department_id<=50  THEN 'B-GROUP'
        WHEN department_id<=100 THEN 'C-GROUP'
        ELSE 'REMAINDER' 
    END team             
FROM employees
ORDER BY team ASC, department_id ASC;
                