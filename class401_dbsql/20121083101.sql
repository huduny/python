2021-08-31-01)

사용예) 2005년 6월 회원별 매출집계를 조회하시오
매출집계는 구매수량합계와 구매금액합계이며, 회원번호, 회원명도 함께 조회하시오.

SELECT      A.CART_MEMBER AS 회원번호, 
            B.MEM_NAME AS 회원명, 
            SUM(A.CART_QTY) AS 구매수량합계, 
            SUM(A.CART_QTY*C.PROD_COST) AS 구매금액합계
FROM        CART A JOIN MEMBER B ON (A.CART_MEMBER = B.MEM_ID) 
            JOIN PROD C ON (A.CART_PROD=C.PROD_ID)
WHERE       SUBSTR(A.CART_NO,1,6)='200506'
GROUP BY    A.CART_MEMBER,B.MEM_NAME
ORDER BY    1;

(ANSI 조인)
SELECT      A.CART_MEMBER AS 회원번호, 
            B.MEM_NAME AS 회원명, 
            SUM(A.CART_QTY) AS 구매수량합계, 
            SUM(A.CART_QTY*C.PROD_COST) AS 구매금액합계
FROM        CART A 
INNER       JOIN MEMBER B ON (A.CART_MEMBER = B.MEM_ID AND SUBSTR(A.CART_NO,1,6)='200506') 
INNER       JOIN PROD C ON (A.CART_PROD=C.PROD_ID)
--WHERE       SUBSTR(A.CART_NO,1,6)='200506'
GROUP BY    A.CART_MEMBER,B.MEM_NAME
ORDER BY    1;

사용예) HR 계정의 테이블들을 이용하여 미국 이외의 부서에 근무하는 사원정보를 조회하시오
ALIAS는 사원번호, 사원명, 부서명, 국가
EMPLOYEES DEPARTMENTS LOCATIONS COUNTRIES

SELECT  A.EMPLOYEE_ID AS 사원번호, 
        A.EMP_NAME AS 사원명, 
        B.DEPARTMENT_NAME AS 부서명, 
        D.COUNTRY_NAME AS 국가
FROM    EMPLOYEES A JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
        JOIN LOCATIONS C ON (C.LOCATION_ID = B.LOCATION_ID)
        JOIN COUNTRIES D ON (C.COUNTRY_ID=D.COUNTRY_ID AND D.COUNTRY_ID != 'US'); 
-----------
SELECT * FROM COUNTRIES
WHERE  COUNTRY_ID != 'US';
----------------------------------------------------------
SELECT  A.EMPLOYEE_ID AS 사원번호, 
        A.EMP_NAME AS 사원명, 
        B.DEPARTMENT_NAME AS 부서명, 
        E.JOB_TITLE AS 직무명,
        D.COUNTRY_NAME AS 국가
FROM    EMPLOYEES A, DEPARTMENTS B, LOCATIONS C, COUNTRIES D , JOBS E
WHERE   A.DEPARTMENT_ID = B.DEPARTMENT_ID
AND     C.LOCATION_ID = B.LOCATION_ID
AND     C.COUNTRY_ID = D.COUNTRY_ID
AND     A.JOB_ID = E.JOB_ID
AND     D.COUNTRY_ID != 'US';
-----------------------------------------------------
SELECT  A.EMPLOYEE_ID AS 사원번호, 
        A.EMP_NAME AS 사원명, 
        B.DEPARTMENT_NAME AS 부서명, 
        E.JOB_TITLE AS 직무명,
        D.COUNTRY_NAME AS 국가
FROM    EMPLOYEES A
INNER JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
INNER JOIN LOCATIONS C ON (C.LOCATION_ID = B.LOCATION_ID)
INNER JOIN COUNTRIES D ON (C.COUNTRY_ID = D.COUNTRY_ID)
INNER JOIN JOBS E ON (A.JOB_ID = E.JOB_ID)
WHERE  D.COUNTRY_ID != 'US';
----------------------------------------------------
SELECT  A.EMPLOYEE_ID AS 사원번호, 
        A.EMP_NAME AS 사원명, 
        B.DEPARTMENT_NAME AS 부서명, 
        E.JOB_TITLE AS 직무명,
        D.COUNTRY_NAME AS 국가
FROM    EMPLOYEES A
INNER JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
INNER JOIN LOCATIONS C ON (C.LOCATION_ID = B.LOCATION_ID)
INNER JOIN COUNTRIES D ON (C.COUNTRY_ID = D.COUNTRY_ID AND D.COUNTRY_ID != 'US')
INNER JOIN JOBS E ON (A.JOB_ID = E.JOB_ID)
ORDER BY 1;
------------------------------------------------------------
SELECT  A.EMPLOYEE_ID AS 사원번호, 
        A.EMP_NAME AS 사원명, 
        B.DEPARTMENT_NAME AS 부서명, 
        E.JOB_TITLE AS 직무명,
        D.COUNTRY_NAME AS 국가
FROM    EMPLOYEES A
left outer JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
left outer JOIN LOCATIONS C ON (C.LOCATION_ID = B.LOCATION_ID)
left outer JOIN COUNTRIES D ON (C.COUNTRY_ID = D.COUNTRY_ID AND D.COUNTRY_ID != 'US')
left outer JOIN JOBS E ON (A.JOB_ID = E.JOB_ID)
ORDER BY 1;
------------------------------------------
SELECT  A.EMPLOYEE_ID AS 사원번호, 
        A.EMP_NAME AS 사원명, 
        B.DEPARTMENT_NAME AS 부서명, 
        E.JOB_TITLE AS 직무명,
        D.COUNTRY_NAME AS 국가
FROM    EMPLOYEES A
right outer JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
right outer JOIN JOBS E ON (A.JOB_ID = E.JOB_ID)
right outer JOIN COUNTRIES D ON (C.COUNTRY_ID = D.COUNTRY_ID AND D.COUNTRY_ID != 'US')
right outer JOIN LOCATIONS C ON (C.LOCATION_ID = B.LOCATION_ID)
ORDER BY 1;
------------------------------------------
사용예) 2005년도 1월 거래처별 매입금액합계와 매입수량합계를 조회하시오.
alias는 거래처코드, 거래처명, 매입금액합계와 매입수량합계이고
매입금액이 500만원 이상인 거래처만 조회하시오

SELECT      A.BUYER_ID 거래처코드, 
            A.BUYER_NAME 거래처명, 
            SUM(B.BUY_QTY) 매입수량합계,
            SUM(B.BUY_QTY*B.BUY_COST) 매입금액합계
FROM        BUYER A, BUYPROD B, PROD C
WHERE       B.BUY_PROD = C.PROD_ID
AND          A.BUYER_ID =C.PROD_BUYER
AND         B.BUY_DATE BETWEEN '20050101' AND '20050131'
HAVING      SUM(B.BUY_QTY*B.BUY_COST) >= 5000000
GROUP BY    A.BUYER_ID, A.BUYER_NAME;

--둘사이에 직접적으로 연관되어 있지 않지만 PROD를 통해서 간접연결할수 있다.

SELECT      A.BUYER_ID 거래처코드, 
            A.BUYER_NAME 거래처명, 
            SUM(B.BUY_QTY) 매입수량합계,
            SUM(B.BUY_QTY*B.BUY_COST) 매입금액합계
FROM        BUYER A-- BUYPROD B, PROD C
INNER JOIN PROD C ON  (A.BUYER_ID =C.PROD_BUYER)
INNER JOIN BUYPROD B ON  (B.BUY_PROD = C.PROD_ID)
WHERE        B.BUY_DATE BETWEEN '20050101' AND '20050131'
HAVING      SUM(B.BUY_QTY*B.BUY_COST) >= 5000000
GROUP BY    A.BUYER_ID, A.BUYER_NAME;