2021-08-27-01)
사용예) 2005년 5월 제품별 매출수량합계를 구하되 매출수량 합계가 20개 이상인 제품만 조회하시오.
SELECT CART_PROD AS 제품,
       SUM(CART_QTY) AS 매출수량합계
FROM   CART 
WHERE CART_NO LIKE '200505%'
GROUP BY CART_PROD
HAVING SUM(CART_QTY) >=20
ORDER BY 1;

사용예) 2005년 4-6월 사이에 회원별로 구매현황을 조회하시오. 단 구매금액을 기준으로 그 값이 100만원 이상인 회원들의
회원번호, 회원명, 구매금액합계를 출력하시오.

SELECT  B.MEM_ID 회원번호, 
        B.MEM_NAME 회원명, 
        SUM(A.CART_QTY*C.PROD_PRICE) 구매금액합계
FROM    CART A, MEMBER B, PROD C
WHERE   SUBSTR(A.CART_NO,1,6) BETWEEN '200504' AND '200506'
AND     (A.CART_MEMBER = B.MEM_ID) --조인조건
AND     (C.PROD_ID = A.CART_PROD) --조인조건
GROUP BY B.MEM_ID, B.MEM_NAME --위의 조건을 가지고 회원번호가 같은 사람끼리 모으고 회원명끼리도 모아라
HAVING  SUM(A.CART_QTY*C.PROD_PRICE) >= 1000000
ORDER BY 3 DESC;


SELECT SALARY+MANAGER_ID FROM EMPLOYEES;

사용예) 2005년 5월 구매수량이 많은 회원 5명을 조회하시오.
SELECT  A.CID AS 회원번호,
        A.AMT AS 구매수량합계
FROM   (SELECT      CART_MEMBER AS CID,
                    SUM(CART_QTY) AS AMT
        FROM        CART
        WHERE       CART_NO LIKE '200505%'
        GROUP BY    CART_MEMBER
        ORDER BY    2 DESC) A
WHERE   ROWNUM <=5;

먼저 카트 테이블이 불려오고 WHERE절에서 5월자료를 뽑고 그다음에 ROWNUM 5개를 뽑고 카트맴버분으로 GROUP BY하고 그것을 SELECT절에서 합계를 내서 마지막으로 ORDER BY를 한다
그래서 A라고 하는 가상테이블 뷰를 만들어 준다. 서브쿼리 형식이다, 참조시 오류를 방지하기 위해서 영어로 별칭을 만들어 준다

**회원테이블에서 5명 출력
SELECT MEM_ID, MEM_NAME
FROM MEMBER
WHERE ROWNUM<=5;
--가짜 컬럼

사용예) 2005년 5월 구매수량합계가이 가장 많은 회원 1명을 조회하시오.
SELECT  A.CID AS 회원번호,
        A.AMT AS 구매수량합계
FROM   (SELECT      CART_MEMBER AS CID,
                    SUM(CART_QTY) AS AMT
        FROM        CART
        WHERE       CART_NO LIKE '200505%'
        GROUP BY    CART_MEMBER
        ORDER BY    2 DESC) A
WHERE   ROWNUM <=1;
MAX(COLUMN) GREATEST(ROW)

SELECT MAX(A.AMT)
FROM  (SUM(CART_OTY) AS AMT) A;

사용예) 2005년도 월별 회원별 구매현황(구매수량합계)을 조회하시오
SELECT  SUBSTR(CART_NO,1,6) AS 월별, 
        CART_MEMBER AS 회원별, 
        SUM(CART_QTY) AS 구매수량합계
FROM    CART
WHERE   CART_NO LIKE '2005%'
GROUP BY SUBSTR(CART_NO,1,6),CART_MEMBER
ORDER BY 3 DESC;
1. 월별로 모아 2. 회원별로 모아 3. 05년도로 나누고 그 다음에 SUM한다




SELECT MAX(SUM(CART_OTY) AS 구매수량합계
FROM    CART
WHERE   CART_NO LIKE '200505%';

2) AVG(COL)
    -'COL'에 값의 평균값을 반환
사용예) 사원테이블에서 사원의 평균급여를 조회하시오.
    SELECT ROUND(AVG(SALARY))
    FROM HR.EMPLOYEES;
    
사용예) 사원테이블에서 각 부서별 평균급여를 조회하시오.
    SELECT  DEPARTMENT_ID 부서, 
            ROUND(AVG(SALARY)) 평균급여,
            SUM(SALARY) 급여합계
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
    ORDER BY DEPARTMENT_ID;

사용예) 사원테이블에서 평균급여보다 많은 급여를 받는 사원의 사원번호, 사원명, 직책코드, 급여를 조회하시오.
SELECT  EMPLOYEE_ID 사원번호, 
        EMP_NAME 사원명, 
        JOB_ID 직책코드, 
        SALARY 급여
FROM    EMPLOYEES
WHERE   SALARY>=(SELECT AVG(SALARY) FROM HR.EMPLOYEES)
ORDER BY 4 DESC;
열은 SELECT절 행은 WHERE, 서브쿼리는 SELECT WHERE절에도 올수 있다.
집계함수를 써서 다른 조건에 비교하는 비교로도 사용되기도 한다.

사용예) 2005년 판매자료를 분석하여 제품별 평균판매수량를 조회하시오
SELECT      A.PROD_ID 분류별,
            A.PROD_NAME 제품명,
            ROUND(AVG(B.CART_QTY)) 평균판매수량
FROM        PROD A, CART B
WHERE       B.CART_PROD = A.PROD_ID
AND         CART_NO LIKE '2005%' 
GROUP BY    A.PROD_ID, A.PROD_NAME
ORDER BY    3 DESC;
AVG를 쓴다는 이유는 내부적으로 다 더해서 수를 구해서 나눠준다.

SELECT      A.PROD_ID 분류별,
            A.PROD_NAME 제품명,
            SUM(B.CART_QTY) 판매수량,
            COUNT(*)    판매횟수
FROM        PROD A, CART B
WHERE       B.CART_PROD = A.PROD_ID
AND         CART_NO LIKE '2005%' 
GROUP BY    A.PROD_ID, A.PROD_NAME
ORDER BY    3 DESC;

사용예) 상품테이블에서 상품분류별 평균마일리지를 구하시오
SELECT PROD_LGU 상품분류,
       ROUND(AVG(PROD_MILEAGE)) 평균마일리지  
FROM    PROD 
GROUP BY PROD_LGU
ORDER BY 2 DESC;

3) COUNT(*|COL)
    -조건에 맞는 자료의 갯수(행의 수)를 반환
    -외부조인을 제외하고 COUNT함수는 '*'나 'COL'을 매개변수로 기술해도 결과는 동일
    -외부조인인 경우 반드시 'COL'값을 사용해야함
    
내부조인은 만족하는 자료, 값만 출력한다. 데이터 많은 경우 다 버린다.
외부조인은 모든 값을 다 보여준다. 모자란 곳에 NULL을 넣는다. COUNT는 NULL값이 있든 없든 다 센다, COL명을 기술해주면 0이 출력된다.

사용에) 사원테이블에서 각 부서별 인원수를 조회하시오.
SELECT  DEPARTMENT_ID, COUNT(*) 인원수, COUNT(EMP_NAME) 인원수
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID DESC;

사용에) 2005년 1-6월 월별 매입금액합계와 매입횟수를 조회하시오
SELECT      TO_CHAR(BUY_DATE, 'MM') AS 월별, 
            SUM(BUY_QTY*BUY_COST) AS 매입금액합계, 
            COUNT(BUY_QTY) AS 매입횟수
FROM        BUYPROD
WHERE       BUY_DATE BETWEEN '20050101' AND '20050630'
GROUP BY    TO_CHAR(BUY_DATE, 'MM')
ORDER BY    1;

사용예) 2005년 4-6월 회원별 구매횟수와 평균구매금액을 조회하시오
SELECT      A.CART_MEMBER AS 회원별,
            COUNT(A.CART_NO) AS 구매횟수, 
            --C.MEM_NAME AS 회원이름,
            ROUND(AVG(A.CART_QTY*B.PROD_PRICE)) AS 평균구매금액 
FROM        CART A, PROD B--, MEMBER C
WHERE       SUBSTR(CART_NO,1,6) BETWEEN '200504' AND '200506'
--AND         A.CART_MEMBER = C.MEM_ID
AND         A.CART_PROD = B.PROD_ID
GROUP BY    A.CART_MEMBER
ORDER BY    2 DESC;
--------------------------------------
SELECT      A.CART_MEMBER AS 회원별,
            COUNT(A.CART_NO) AS 구매횟수, 
            C.MEM_NAME AS 회원이름,
            ROUND(AVG(A.CART_QTY*B.PROD_PRICE)) AS 평균구매금액 
FROM        CART A, PROD B, MEMBER C
WHERE       SUBSTR(CART_NO,1,6) BETWEEN '200504' AND '200506'
AND         A.CART_MEMBER = C.MEM_ID
AND         A.CART_PROD = B.PROD_ID
GROUP BY    A.CART_MEMBER, C.MEM_NAME, ROLLUP(A.CART_QTY*B.PROD_PRICE)
ORDER BY    4 DESC;

