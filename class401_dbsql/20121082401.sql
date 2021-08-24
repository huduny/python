2021-08-24-01
사용예) EXTRACT
사원 테이블에서 입사일을 이용하여 근속년수를 구하고 근속년수가 15년 이상인 사원들에게 특별 상여금을 지급하려한다.
상여금은 급여의 35%이다. 모든 사원들의 사원번호, 이름, 입사일, 근속년수, 급여, 상여금, 지급액을 출력하시오.
단, 급여, 상여금, 지급액은 소수 1자리까지 출력

    SELECT  EMPLOYEE_ID 사원번호, 
            EMP_NAME 이름, 
            HIRE_DATE 입사일, 
            EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE) 근속년수, 
            SALARY 급여, 
            CASE WHEN (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE))>=15 
            THEN ROUND(SALARY*0.35,1)
            ELSE 0
            END AS 상여금, 
            CASE WHEN EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE)>=15 
            THEN ROUND(SALARY+SALARY*0.35,1)
            ELSE SALARY
            END AS  지급액
    FROM    HR.EMPLOYEES;

사용예) 회원테이블에서 이번달 생일인 회원을 조회하시오
ALIAS는 회원번호, 회원명, 생년월일

SELECT      MEM_ID AS 회원번호, 
            MEM_NAME AS 회원명, 
            MEM_BIR AS 생년월일
FROM        MEMBER
WHERE       EXTRACT(MONTH FROM SYSDATE)-1 = EXTRACT(MONTH FROM MEM_BIR);

    3) NEXT_DAY(D1, C1), LAST_DAY(D1)
        - NEXT_DAY: D1으로 제공된 날짜 이후 C1으로설정된 요일의 날짜 반환
                    C1은 월, 월요일, 화, 화요일,...일, 일요일 등으로 요일 지정
        - LAST_DAY(D1): D1으로 지정된 날짜의 해당월의 마지막 날짜 반환
                    보통 2월 마지막일자 반환에 주로 사용(윤년 OR 평년 구별)
     --날짜에 관련된 언어 설정이 한국어로 되어 있어서 C1에 한글로 입력해야된다.
                    
사용예)  SELECT NEXT_DAY(SYSDATE, '월') FROM DUAL;
        SELECT LAST_DAY(SYSDATE) FROM DUAL; --주로 2월달이 윤년인지 평년인지 구별할때 주로 많이 사용한다.
        
        SELECT NEXT_DAY(SYSDATE, '화요일'),
               NEXT_DAY(SYSDATE, '수요일'),
               LAST_DAY(SYSDATE)
        FROM    DUAL;

사용예) 2005년 2월 제품별 매입집계를 조회하시오.
ALIAS는 상품코드, 수량합계, 매입금액합계
    SELECT  BUY_PROD AS 상품코드, 
            SUM(BUY_QTY) AS 수량합계, 
            SUM(BUY_QTY*BUY_COST) AS 매입금액합계
    FROM    BUYPROD
    WHERE   BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
    GROUP BY BUY_PROD
    ORDER BY 1;
--기간은 웨어절에서 기술
--그룹바이는 상품코드로 지정하면 그 코드가 같은 것끼리 다 뭉쳐서 SUM 결과가 출력된다

    4) ADD_MONTHS(D1, N1)
    - 날짜 D1의 월에 N1 값을 더한 날짜 반환
    
사용예) SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

사용예) 사원테이블의 HIRE_DATE가 임시 고용날짜라고 간주하고 실 고용일은 임시고용일 부터 3개월 후인경우 실제 30, 50, 110 부서의 사원들에 대한
실제 입사일을 조회하시오.
    ALIAS는 사원번호,사원명,부서코드,직무코드,임시고용일,실제입사일
    SELECT  EMPLOYEE_ID AS 사원번호,
            EMP_NAME AS 사원명,
            DEPARTMENT_ID AS 부서코드,
            JOB_ID AS 직무코드,
            HIRE_DATE AS 임시고용일,
            ADD_MONTHS(HIRE_DATE, 3) AS 실제입사일
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID IN(30, 50, 110)
    ORDER BY DEPARTMENT_ID;

    5) MONTHS_BETWEEN(D1,D2)
    - 두 날짜 자료 D1과 D2사이의 달수를 숫자자료로 반환
    
사용예) SELECT   MEM_ID AS 회원번호,
                MEM_NAME AS 회원명,
                MEM_BIR AS 생년월일,
                EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS 나이1,
                TRUNC(MONTHS_BETWEEN(SYSDATE, MEM_BIR)/12)||'년 '||
                ROUND(MOD(MONTHS_BETWEEN(SYSDATE, MEM_BIR),12))||'개월' AS 나이2
        FROM    MEMBER;






