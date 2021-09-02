2021-0902-02)서브쿼리
    -서브쿼리는 하나의 SQL문 안에 보조로 사용되는 (중간결과) 또 다른 SELECT문
    -최종결과를 출력하는 밖에 존재하는 쿼리를 메인 쿼리라 함
    -구분
    
.메인쿼리와 연관성 여부에 따라 
    -연관성 있는 서브쿼리 VS 연관성 없는 서브쿼리
    
.사용되는 위치에 따라
    -일반서브쿼리: SELECT절에 사용
    -IN-LINE 서브쿼리: FROM절에 사용
    -중첩서브쿼리: WHERE절에 사용
    -연산자 오른쪽에 서브쿼리가 와야된다.
.반복되는 행의 수에 따라
    -단일행 서브쿼리 VS 복수행 서브쿼리
    -서브쿼리는 JOIN연산을 줄이기 위해 사용될 수 있음
    -알려지지않은 조건에 근거하여 값을 검색하는 경우 유용
    -단일행과 다중행을 비교하기 위해서는 =이 아니라 IN을 쓴다
    EX) WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM HR.EMPLOYEES WHERE DEPARTMENT_ID=30)

1. 연관성없는 서브쿼리
- 메인쿼리에 사용된 테이블과 서브쿼리에 사용된 테이블 사이에 JOIN으로 연결되지 않은 경우

사용에) 사원테이블에서 평균입금보다 급여가 더 많은 사원수를 조회하시오
(메인쿼리: 급여가 평균임금보다 더 많은 사원수
SELECT COUNT(*) AS 사원수
FROM HR.EMPLOYEES
WHERE SALARY>(평균임금);

(서브쿼리: 평균임금)
SELECT ROUND(AVG(SALARY))
FROM  HR.EMPLOYEES;

(결합)
SELECT COUNT(*) AS 사원수
FROM HR.EMPLOYEES
WHERE SALARY> (SELECT ROUND(AVG(SALARY))
FROM  HR.EMPLOYEES); 107번 실행

(연관성 있는 서브쿼리)(FROM절에 서브쿼리)(FROM절은 독립실행되어 1번만 실행되 변수처럼 사용된다)(조인조건이 =이외에도 연산자가 사용될수 있다)
SELECT COUNT(*) AS 사원수
FROM HR.EMPLOYEES A, (SELECT ROUND(AVG(SALARY)) AS SAL
                        FROM  HR.EMPLOYEES) B
WHERE A.SALARY>B.SAL; 연관성있는 서브쿼리
--메인쿼리와 서브쿼리가 담당하는 부분을 구분할줄 알아야 한다.

사용예) 사원테이블과 직무변동테이블에 사원번호와 직무코드가 동일한 사원을 조회하시오
ALIAS는 사원번호, 사원명, 직무코드

SELECT EMPLOYEE_ID AS 사원번호,
EMP_NAME AS 사원명,
JOB_ID AS 직무코드
FROM HR.EMPLOYEES
WHERE (EMPLOYEE_ID,JOB_ID)=(직무변동테이블에 사원번호와 직무코드를 조회)
--한꺼번에 두개를 비교하는 것

(직무변동테이블에 사원번호와 직무코드를 조회)
SELECT EMPLOYEE_ID, JOB_ID
FROM HR.JOB_HISTORY;
--나온값이 사원번호 테이블의 행과 똑같다면

결합
SELECT EMPLOYEE_ID AS 사원번호,
EMP_NAME AS 사원명,
JOB_ID AS 직무코드
FROM HR.EMPLOYEES 
WHERE (EMPLOYEE_ID,JOB_ID)IN(SELECT EMPLOYEE_ID, JOB_ID
                            FROM HR.JOB_HISTORY);
--왼쪽이 단일행이고 오른쪽이 여러행이면 IN을 쓴다.
--왼쪽 오른쪽 모두 같은 컬럼으로 비교해야 된다.