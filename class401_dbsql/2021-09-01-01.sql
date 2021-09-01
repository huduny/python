2021-09-01-01)
2) 안티조인
    - 서브쿼리가 사용되는 조인
    - 서브쿼리로 반환되는 테이블(뷰)에 없는 메인쿼리에만 존재하는 데이터를 추출하는 조인 방법
    - NOT IN 또는 EXISTS 연산자 사용
    
** 부서테이블에 부서번호 30,50,90번 부서의 부서장 사원번호(MANAGER_ID)를 NULL로 갱신하시오.
UPDATE      DEPARTMENTS -- 테이블
SET         MANAGER_ID=NULL -- 눌로 바꿔라
WHERE       DEPARTMENT_ID IN(30,50,90); --조건, 열구분

SELECT * 
FROM DEPARTMENTS
WHERE DEPARTMENT_ID IN(30,50,90);
ROLLBACK;

사용예) 부서테이블에서 MANAGER_ID가 NULL인 부서 이외의 부서에 근무하는 사원의 사원번호, 사원명, 부서번호, 부서명을 조회하시오.

SELECT      A.EMPLOYEE_ID 사원번호, 
            A.EMP_NAME 사원명, 
            B.DEPARTMENT_ID 부서번호, 
            B.DEPARTMENT_NAME 부서명
FROM        EMPLOYEES A JOIN DEPARTMENTS B ON (B.DEPARTMENT_ID=A.EMPLOYEE_ID);
WHERE       NOT IN (SELECT      DEPARTMENT_ID
                    FROM        DEPARTMENTS
                    WHERE       MANAGER_ID IS NULL);

-------------------------------------------
SELECT      DEPARTMENT_ID
FROM        DEPARTMENTS
WHERE       MANAGER_ID IS NULL;
--------------------------------------------
SELECT      A.EMPLOYEE_ID 사원번호, 
            A.EMP_NAME 사원명, 
            B.DEPARTMENT_ID 부서번호, 
            B.DEPARTMENT_NAME 부서명
FROM        EMPLOYEES A,  DEPARTMENTS B
WHERE       A.EMPLOYEE_ID = B.DEPARTMENT_ID
AND         A.DEPARTMENT_ID NOT IN(SELECT   DEPARTMENT_ID
                                    FROM    DEPARTMENTS
                                    WHERE   MANAGER_ID IS NULL);

SELECT      A.EMPLOYEE_ID 사원번호, 
            A.EMP_NAME 사원명, 
            A.DEPARTMENT_ID 부서번호, 
            B.DEPARTMENT_NAME 부서명
FROM        EMPLOYEES A,  DEPARTMENTS B
WHERE       A.EMPLOYEE_ID = B.DEPARTMENT_ID
AND         A.DEPARTMENT_ID NOT IN (SELECT      DEPARTMENT_ID
                                    FROM        DEPARTMENTS
                                    WHERE       MANAGER_ID IS NULL);
-------------------------------------------------------
SELECT      A.EMPLOYEE_ID 사원번호, 
            A.EMP_NAME 사원명, 
            B.DEPARTMENT_ID 부서번호, 
            B.DEPARTMENT_NAME 부서명
FROM        EMPLOYEES A,  DEPARTMENTS B
WHERE       A.EMPLOYEE_ID = B.DEPARTMENT_ID
AND         NOT EXISTS (SELECT 1 --1은 TRUE 0은 FALSE
                        FROM   DEPARTMENTS C 
                        WHERE  C.MANAGER_ID IS NULL
                        AND    A.EMPLOYEE_ID = C.DEPARTMENT_ID);
--10번 부서는 조건이 맞지 않아서 1을 출력하지 않는다. 그래서 EXISTS까 FALSE가 되는데 NOT을 붙여서 TRUE가 되서 위 SELECT문이 실행된다.
--30번 부서는 조건이 맞아서 NULL이어서 조건이 참이어서 1을 출력하고 EXISTS가 참이 되고 NOT이 붙어서 FALSE가 되고 WHERE절이 거짓이 되서 처리되지 않는다.
--EXISTS는 뒤에 반드시 서브쿼리가 따라와야된다

사용예) 2005년 5월과 6월 판매상품 중 5월에만 판매된 상품의 상품별 매출정보를 조회하시오
ALIAS는 상품코드, 상품명, 판매수량합계, 판매금액합계
--UNION, INTERSECT, MINUS(4개의 집합 연산자)

---------------------------------------------------
--NOT IN
SELECT  A.CART_PROD AS 상품코드, 
        B.PROD_NAME AS 상품명, 
        SUM(A.CART_QTY) AS 판매수량합계, 
        SUM(A.CART_QTY*B.PROD_SALE) AS 판매금액합계
FROM    CART A INNER JOIN PROD B ON (A.CART_PROD=B.PROD_ID)
WHERE   SUBSTR(CART_NO, 1, 6) BETWEEN '200505' AND '200506'
AND     CART_PROD NOT IN (SELECT  CART_PROD
                          FROM    CART
                          WHERE   SUBSTR(CART_NO, 1, 6) LIKE '200506')
GROUP BY A.CART_PROD, B.PROD_NAME
------------------------------------------------------
SELECT  CART_PROD
FROM    CART 
WHERE   SUBSTR(CART_NO, 1, 6) LIKE '200505'
------------------------------------------------------
SELECT  CART_PROD
FROM    CART 
WHERE   SUBSTR(CART_NO, 1, 6) BETWEEN '200505' AND '200506'
-----------------------------------------------------------
SELECT  CART_PROD
FROM    CART 
WHERE   SUBSTR(CART_NO, 1, 6) LIKE '200506'
-------------------------------------------------------
SELECT  A.CART_PROD AS 상품코드, 
        B.PROD_NAME AS 상품명, 
        SUM(A.CART_QTY) AS 판매수량합계, 
        SUM(A.CART_QTY*B.PROD_SALE) AS 판매금액합계
FROM    CART A, PROD B
WHERE   A.CART_PROD=B.PROD_ID
AND     SUBSTR(CART_NO, 1, 6) BETWEEN '200505' AND '200506'
GROUP BY A.CART_PROD, B.PROD_NAME
------------------------------------------------------------
--NOT EXISTS
SELECT  A.CART_PROD AS 상품코드, 
        B.PROD_NAME AS 상품명, 
        SUM(A.CART_QTY) AS 판매수량합계, 
        SUM(A.CART_QTY*B.PROD_SALE) AS 판매금액합계
FROM    CART A, PROD B
WHERE   A.CART_PROD=B.PROD_ID
AND     SUBSTR(CART_NO, 1, 6) BETWEEN '200505' AND '200506'
AND           NOT EXISTS (SELECT    3
                          FROM    CART C
                          WHERE   A.CART_PROD=C.CART_PROD
                          AND     SUBSTR(CART_NO, 1, 6) LIKE '200506')
GROUP BY A.CART_PROD, B.PROD_NAME
-----------------------------------------------------------
SELECT  A.CART_PROD AS 상품코드, 
        B.PROD_NAME AS 상품명, 
        SUM(A.CART_QTY) AS 판매수량합계, 
        SUM(A.CART_QTY*B.PROD_SALE) AS 판매금액합계
FROM    CART A, PROD B
WHERE   A.CART_PROD=B.PROD_ID
AND     SUBSTR(CART_NO, 1, 6) BETWEEN '200505' AND '200506'
AND                  EXISTS (SELECT  2
                          FROM    CART C
                          WHERE   A.CART_PROD=C.CART_PROD
                          AND     SUBSTR(CART_NO, 1, 6) LIKE '200506')
GROUP BY A.CART_PROD, B.PROD_NAME
--LIKE연산자를 사용할려면 대상이 문자열이어야 한다.
SELECT  A.CART_PROD AS 상품코드, 
        B.PROD_NAME AS 상품명, 
        SUM(A.CART_QTY) AS 판매수량합계, 
        SUM(A.CART_QTY*B.PROD_SALE) AS 판매금액합계
FROM    CART A, PROD B
WHERE   A.CART_PROD=B.PROD_ID
AND     SUBSTR(A.CART_NO, 1, 6) LIKE '200505'
AND     A.CART_PROD NOT IN (SELECT DISTINCT CART_PROD
                           FROM    CART
                           WHERE   SUBSTR(CART_NO, 1, 6) LIKE '200506')
GROUP BY A.CART_PROD, B.PROD_NAME
ORDER BY 1;
-----------------------------
SELECT  A.CART_PROD AS 상품코드, 
        B.PROD_NAME AS 상품명, 
        SUM(A.CART_QTY) AS 판매수량합계, 
        SUM(A.CART_QTY*B.PROD_SALE) AS 판매금액합계
FROM    CART A, PROD B
WHERE   A.CART_PROD=B.PROD_ID
AND     SUBSTR(A.CART_NO, 1, 6) LIKE '200505'
AND             NOT EXISTS (SELECT 1
                           FROM    CART C
                           WHERE   SUBSTR(C.CART_NO, 1, 6) LIKE '200506'
                           AND      C.CART_PROD =PROD_ID)--NULL값을 방지하기 위해서 PROD_ID를 가지고 온다.
GROUP BY A.CART_PROD, B.PROD_NAME
ORDER BY 1;

3) 셀프조인
    -하나의 테이블을 서로 다른 테이블로 간주하여 별칭을 부여하고 조인연산을 수행

사용예) 회원테이블에서 신용환회원('c001')의 마일리지보다 더 많은 마일리지를 보유하고 있는 회원들을 조회하시오
alias는 회원번호, 회원명, 마일리지
SELECT  B.MEM_ID AS 회원번호, 
        B.MEM_NAME AS 회원명,
        B.MEM_MILEAGE AS 마일리지
FROM    MEMBER A, MEMBER B
WHERE   UPPER(A.MEM_ID)='C001'
AND     A.MEM_MILEAGE < B.MEM_MILEAGE;
--NONEQU조인 비동등조인
사용예) 2005년 4월 회원의 평균구매액보다 더 많은 구매를 한 회원들을 조회하시오
--일자별로 구매금액 합계가 나온다음에 그것을 AVG를 구해야된다.
ALIAS는 회원번호, 회원명, 구매금액
WITH A AS (SELECT      A.MEM_ID AS AM, 
            A.MEM_NAME AS AN, 
            SUM(B.CART_QTY*C.PROD_SALE) AS AP
FROM        MEMBER A, CART B, PROD C
WHERE       (CART_MEMBER=MEM_ID)
AND         (CART_PROD=PROD_ID)
GROUP BY    A.MEM_ID, A.MEM_NAME)
--------------------------------------------------------------------
2005년 4월 평균구매액
1. 4월 장바구니별 구매금액 합계
SELECT  CART_NO,
        SUM(CART_QTY*PROD_PRICE)
FROM    CART , PROD 
WHERE   CART_NO LIKE '200504%'
GROUP BY    CART_NO
ORDER BY    1;
-----------------------------------------------------------------------
2. 1번에서 구한 합계의 평균값
SELECT  AVG(A.CSUM) AS AMT
FROM    (SELECT CART_NO AS SNO,
                SUM(CART_QTY*PROD_PRICE) AS CSUM
         FROM   CART, PROD
         WHERE CART_NO LIKE '200504%'
         AND    CART_PROD=PROD_ID
         GROUP BY CART_NO) A;
-- 일반 커럼이 쓰이지 않아서 GROUP BY절을 사용하지 않아도 된다.
---------------------------------------------------------------------------        
3. 2005년 4월 회원별 구매금액합계
SELECT  CART_MEMBER,
        SUM(CART_QTY*PROD_PRICE)
FROM    CART, PROD
WHERE   CART_PROD=PROD_ID
AND     CART_NO LIKE '200504%'
GROUP BY CART_MEMBER
ORDER BY 1;
-------------------------------------------------------------------
4. 결합
SELECT  C.MEM_ID AS 회원번호, 
        C.MEM_NAME AS 회원이름,
        B.CSUM AS 구매합계,
        B.AMT AS 평균
FROM 
(SELECT  CART_MEMBER,
        SUM(CART_QTY*PROD_PRICE)
FROM    CART, PROD
WHERE   CART_PROD=PROD_ID
AND     CART_NO LIKE '200504%'
GROUP BY CART_MEMBER) A,

(SELECT  AVG(A.CSUM) AS AMT
FROM    (SELECT CART_NO AS SNO,
                SUM(CART_QTY*PROD_PRICE) AS CSUM
         FROM   CART, PROD
         WHERE CART_NO LIKE '200504%'
         AND    CART_PROD=PROD_ID
         GROUP BY CART_NO) A) B, 
         
         MEMBER C
WHERE   C.MEM_ID = A.CID
AND     B.AMT<B.CSUM;
--------------------------------------------------------------
FROM    CART, PROD
WHERE   CART_NO LIKE '200504%'
GROUP BY    CART_NO
ORDER BY    1;
---------------------------------------------------------
WITH A AS (SELECT      A.MEM_ID AS AM, 
            A.MEM_NAME AS AN, 
            SUM(B.CART_QTY*C.PROD_SALE) AS AP
     B AS (SELECT CART_NO AS SNO,
                SUM(CART_QTY*PROD_PRICE) AS CSUM,
                COUNT(*) AS CNT
           FROM   CART, PROD
           WHERE CART_NO LIKE '200504%'
           AND    CART_PROD=PROD_ID
           GROUP BY CART_NO)      
SELECT    MEM_ID AS 회원번호, MEM_NAME AS 회원명, 구매금액           
FROM       A, B
WHERE      

WITH        B  AS (SELECT CART_NO AS SNO,
               SUM(CART_QTY*PROD_PRICE) AS CSUM,
               COUNT(*) AS CNT
            FROM   CART, PROD
            WHERE CART_NO LIKE '200504%'
            AND    CART_PROD=PROD_ID
            GROUP BY CART_NO)
SELECT      AVG(B.CSUM) AS AMT
FROM        B
----------------------------------------------------------
사용예) '피리어스' 거래처와 같은 지역에 있는 모든 거래처를 조회하시오
ALIAS는 거래처코드, 거래처명, 주소, 전화번호, 담당자
SELECT      B.BUYER_ID AS 거래처코드, 
            B.BUYER_ID AS 거래처명, 
            B.BUYER_ADD1||' '||B.BUYER_ADD2 AS 주소, 
            B.BUYER_COMTEL AS 전화번호, 
            B. BUYER_CHARGER AS 담당자
FROM        BUYER A, BUYER B
WHERE       A.BUYER_NAME = '피리어스'
AND         SUBSTR(A.BUYER_ADD1,1,2)=SUBSTR(B.BUYER_ADD1,1,2)
ORDER BY 1;
----
SELECT      B.BUYER_ID AS 거래처코드, 
            B.BUYER_ID AS 거래처명, 
            B.BUYER_ADD1||' '||B.BUYER_ADD2 AS 주소, 
            B.BUYER_COMTEL AS 전화번호, 
            B. BUYER_CHARGER AS 담당자
FROM        BUYER A INNER JOIN BUYER B ON (SUBSTR(A.BUYER_ADD1,1,2)=SUBSTR(B.BUYER_ADD1,1,2))
WHERE       A.BUYER_NAME = '피리어스'
ORDER BY 1;

------------------------------------------------------------------------------
사용예) 2005년 4월 회원의 평균구매액보다 더 많은 구매를 한 회원들을 조회하시오
--일자별로 구매금액 합계가 나온다음에 그것을 AVG를 구해야된다.
ALIAS는 회원번호, 회원명, 구매금액
1. 4월 장바구니별 구매금액 합계
SELECT      CART_NO,
            SUM(CART_QTY*PROD_PRICE)
FROM        CART , PROD 
WHERE       CART_NO LIKE '200504%'
GROUP BY    CART_NO
ORDER BY    1;
--중복되는 컬럼명이 없으면 별칭을 생략할 수 있다.
SELECT      A.CART_NO,
            SUM(A.CART_QTY*B.PROD_PRICE)
FROM        CART A, PROD B
WHERE       A.CART_NO LIKE '200504%'
AND         A.CART_PROD=B.PROD_ID
GROUP BY    A.CART_NO
ORDER BY    1;

2. 1번에서 구한 합계의 평균값
WITH A AS (SELECT   A.CART_NO AS SNO,
                    SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
           FROM     CART A, PROD B
           WHERE    A.CART_NO LIKE '200504%'
           AND      A.CART_PROD=B.PROD_ID
           GROUP BY A.CART_NO)
SELECT  AVG(A.CSUM) AS AMT
FROM    A;


3. 2005년 4월 회원별 구매금액합계
SELECT  A.CART_MEMBER AS 회원,
        SUM(A.CART_QTY*B.PROD_PRICE) AS 합계
FROM    CART A, PROD B
WHERE   A.CART_PROD=B.PROD_ID
AND     A.CART_NO LIKE '200504%'
GROUP BY A.CART_MEMBER
ORDER BY 1;

4. 결합
WITH A AS  (SELECT       A.CART_NO AS CID, 
                         SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
            FROM         CART A, PROD B
            WHERE        A.CART_NO LIKE '200504%'
            AND          A.CART_PROD=B.PROD_ID
            GROUP BY     A.CART_NO),
     B AS  (WITH A AS (  SELECT   A.CART_NO AS SNO,
                         SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
            FROM         CART A, PROD B
            WHERE        A.CART_NO LIKE '200504%'
            AND          A.CART_PROD=B.PROD_ID
            GROUP BY     A.CART_NO)
            SELECT       AVG(A.CSUM) AS AMT
            FROM         A),
     C AS  (SELECT       A.CART_MEMBER AS 회원,
                         SUM(A.CART_QTY*B.PROD_PRICE) AS 합계
            FROM         CART A, PROD B
            WHERE        A.CART_PROD=B.PROD_ID
            AND          A.CART_NO LIKE '200504%'
            GROUP BY     A.CART_MEMBER)

SELECT      A.CID AS 회원번호, 
            D.MEM_NAME AS 회원명,
            A.CSUM AS 구매금액합계
FROM        A, B, C, MEMBER D
WHERE       D.MEM_ID=A.CID
AND         B.AMT<A.CSUM;
------------------------------------------------
SELECT
    A.CID AS 회번,
    C.MEM_NAME AS 회원명,
    A.CSUM  AS 구매금
FROM
    (SELECT
        CART_MEMBER AS CID,
        SUM(CART_QTY*PROD_PRICE) AS CSUM
    FROM    CART, PROD
    WHERE   CART_PROD=PROD_ID
    AND CART_NO LIKE '200504%'
    GROUP BY CART_MEMBER
    ORDER BY    1) A, (SELECT
                            AVG(A.SUM) AS AMT
                            FROM    (SELECT
                                        CART_NO AS CNO,
                                        SUM(CART_QTY*PROD_PRICE) AS CSUM
                                    FROM CART, PROD
                                    WHERE CART_NO LIKE '200504%'
                                    AND CART_PROD=PROD_ID
                                    GROUP BY CART_NO) A) B, MEMBER C
    WHERE C.MEM_ID=A.CID
    AND   B.AMT<A.CSUM;
-----------------------------------------------------------------------------
--     상품코드, 상품명, 판매수량합계, 판매금액합계
SELECT      B.CART_PROD AS 상품코드
            ,A.PROD_NAME AS 상품명
            ,SUM(B.CART_QTY) AS 판매수량합계
            ,SUM(A.PROD_SALE*B.CART_QTY) AS 판매금액합계
FROM        PROD A, CART B
WHERE       A.PROD_ID=B.CART_PROD
AND         B.CART_NO LIKE '200505%'
GROUP BY    B.CART_PROD, A.PROD_NAME;
------------------------------------------
SELECT      A.CART_PROD AS 상품코드
            ,A.PROD_NAME AS 상품명
            ,B.CART_QTY AS 판매수량합계
            ,A.PROD_SALE*B.CART_QTY AS 판매금액합계
FROM        PROD A, CART B
WHERE       A.PROD_ID=B.CART_PROD
AND         B.CART_NO LIKE '200505%'
AND         EXISTS
(SELECT      C.CART_PROD AS 상품코드
            ,A.PROD_NAME AS 상품명
            ,C.CART_QTY AS 판매수량합계
            ,A.PROD_SALE*C.CART_QTY AS 판매금액합계
FROM        PROD A, CART C
WHERE       A.PROD_ID=C.CART_PROD
AND         C.CART_NO LIKE '200506%'
AND         C.CART_PROD = A.PROD_ID
);
--교집합
--1.사이에 AND EXISTS(교집합) 2.두번째 집합에 괄호 3.두번째 집합에 AND에 공통의 조인을 적어준다. 
--그 뒤에 중복된 데이터 제거를 위해 그룹바이를 쓰고 NOT을 써서 차집함
