2021-09-02-01)
1)외부조인
- 내부조인은 조인조건을 만족하는 자료만 연산에 포함
- 외부조인은 부족한 쪽의 테이블에 null로 채워진 행을 삽입한 후 조인연산 수행
(일반 외부조인 사용형식)
SELECT  컬럼 LIST
FROM    테이블명1, 테이블명2 ....
WHERE   테이블명1.컬럼명[(+)]=테이블명2.컬럼명[(+)]

. 자료의 종류가 적은 쪽의 조인조건에 외부조인 연산자 '(+)'를 기술 --줄이나 데이터 갯수가 아니라 종류로 판단해서 적은쪽에 +를 붙인다
. 복수개의 조인조건에 외부조인이 필요하면 모두 '(+)'를 기술해야함
. 세개의 테이블 A,B,C가 연산에 참여하고 A를 기준으로 B가 확장되어 조인됨과 동시에 C를 기준으로 다시 B가 외부조인 될 수 없다
  즉, A=B(+) AND C=B(+)는 허용되지 않는다. --일관성이 없어서 허용되지 않는다
. '(+)'연산자와 OR 연산자는 같이 사용할 수 없다.
. 일반조건과 외부조인조건이 같이 사용된 경우 외부조인 결과가 반환되지 않음->ANSI외부조인 또는 서브쿼리로 해결
-- 이너조인은 적은쪽으로 맞춰 조인되고 넘치는건 버린다
-- 외부조인은 
-- A=B(+) AND A=C(+)되나요?
(ANSI외부조인 사용형식)
SELECT 컬럼 LIST
FROM   테이블명1
FULL|LEFT|RIGHT OUTER JOIN 테이블명2 ON(조인조건 [AND 일반조건])

[WHERE 일반조건]
. 테이블명1과 테이블명2는 반드시 직접 조인이 가능한 테이블 이어야 함
. 테이블명3부터는 바로 위의 결과와 조인
. FULL OUTER: 양쪽테이블 모두 데이터가 서로 부족한 경우
. LEFT OUTER: FROM절에 기술된 테이블명1이 테이블명2보다 더 많은 종류의 자료가 있는 경우
. RIGHT OUTER: FROM절에 기술된 테이블명2이 테이블명1보다 더 많은 종류의 자료가 있는 경우

사용예)
상품테이블에서 모든 상품분류별 상품의 수를 조회하시오 ALIAS는 분류코드, 분류명, 상품의 수
LPROD(제일 꼭대기 키이다, 외래키가 하나도 존재하지 않는);
SELECT      B.LPROD_GU AS 분류코드, 
            B.LPROD_NM AS 분류명, 
            COUNT(A.PROD_UNIT) AS "상품의 수"
FROM        PROD A, LPROD B
WHERE       A.PROD_LGU(+)=B.LPROD_GU
GROUP BY    B.LPROD_GU, B.LPROD_NM
ORDER BY    1;

SELECT COUNT(DISTINCT(PROD_LGU)) AS "상품코드 수"--중복을 제거하고 
FROM PROD
ORDER BY 1;
--외부조인시에 카운트는 괄호에 *를 하면 안되고 명시를 해줘야 된다.

사용예)
2005년도 2월 모든 상품별 매입정보를 조회하시오
(내부조인)
SELECT      B.PROD_ID AS 상품코드,--양쪽에 모두 존재하는 컬럼이면 더 큰 종류의 것을 써줘라 
            SUM(A.BUY_QTY) AS 매입수량, 
            SUM(A.BUY_QTY*A.BUY_COST) AS 매입금액
FROM        BUYPROD A, PROD B
WHERE       A.BUY_PROD = B.PROD_ID
AND         BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
GROUP BY    B.PROD_ID
ORDER BY    1;
--상품별 GROUP BY 절
--날짜 기간등은 일반 조건으로 처리
--전부 모든 OUTER조인
(2005년 2월에 매입된 상품의 종류)
SELECT DISTINCT(BUY_PROD)
FROM    BUYPROD
WHERE   BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
-------------------------------------------------------------
SELECT      B.PROD_ID AS 상품코드,--양쪽에 모두 존재하는 컬럼이면 더 큰 종류의 것을 써줘라 
            SUM(A.BUY_QTY) AS 매입수량, 
            SUM(A.BUY_QTY*A.BUY_COST) AS 매입금액
FROM        BUYPROD A, PROD B
WHERE       A.BUY_PROD(+) = B.PROD_ID
AND         BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
GROUP BY    B.PROD_ID
ORDER BY    1;
-----------------------------------------------------------
SELECT      B.PROD_ID AS 상품코드,--양쪽에 모두 존재하는 컬럼이면 더 큰 종류의 것을 써줘라 
            NVL(SUM(A.BUY_QTY),0) AS 매입수량, 
            NVL(SUM(A.BUY_QTY*A.BUY_COST),0) AS 매입금액
FROM        PROD B LEFT OUTER JOIN BUYPROD A ON ( A.BUY_PROD = B.PROD_ID AND BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201')))
--WHERE 하고 조건절을 넣으면 아우터조인이 아니라 이너조인으로 인식된다. 따라서 AND로 해서 조인절 안에 넣어줘야 된다.
--WHERE절에 넣으면 FROM절까지 데이터가 74개 나오다가 WHERE절에 의해서 24건만 나오게 된다.
GROUP BY    B.PROD_ID
ORDER BY    1;
----------------------------------------------------------------
SELECT      B.LPROD_GU AS 분류코드, 
            B.LPROD_NM AS 분류명, 
            COUNT(A.PROD_UNIT) AS "상품의 수"
FROM        PROD A RIGHT OUTER JOIN LPROD B ON ( A.PROD_LGU=B.LPROD_GU)--많은 쪽이 오른쪽이니깐 RIGHT OUTER조인이다
GROUP BY    B.LPROD_GU, B.LPROD_NM
ORDER BY    1;
-----------------------------------------------------------------
(SUBQUERY)
SELECT      PROD_ID AS 상품코드, --많은쪽것을 써라
            NVL(TBLA.QAMT,0) AS 매입수량,
            NVL(TBLA.CAMT,0) AS 매입금액
FROM        (SELECT      B.PROD_ID AS PID,
                        SUM(A.BUY_QTY) AS QAMT, 
                        SUM(A.BUY_QTY*A.BUY_COST) AS CAMT
            FROM        BUYPROD A, PROD B
            WHERE       A.BUY_PROD = B.PROD_ID
            AND         BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
            GROUP BY    B.PROD_ID) TBLA, PROD
WHERE       TBLA.PID(+)=PROD_ID
ORDER BY    1;
--WHERE절 하나로 합치면 안되서 따로 처리해야된다.
---------------------------------------------------------------------------------------------------
(사용예)
모든 부서별 사원수를 조회하시오.
SELECT   A.DEPARTMENT_ID AS 부서코드,
         A.DEPARTMENT_NAME AS 부서명,
         COUNT(B.EMPLOYEE_ID) AS 사원수
FROM    DEPARTMENTS A FULL OUTER JOIN EMPLOYEES B ON (A.DEPARTMENT_ID=B.DEPARTMENT_ID)
GROUP BY A.DEPARTMENT_NAME, A.DEPARTMENT_ID
ORDER BY 3 DESC;
--COUNT함수는 행을 COUNT하기 때문에 (*)을 하면 안된다
--EMPLOYEES테이블에서는 11개의 테이블만 사용되고 DEPARTMENT테이블에서는 27개가 있기 떄문에 EMPLOYEES를 기준으로 하면 16개의 널값이 나온다
----------------------------------------------------------------------------------------
SELECT   A.DEPARTMENT_NAME AS 부서명,
         COUNT(B.EMPLOYEE_ID) AS 사원수
FROM    DEPARTMENTS A, EMPLOYEES B 
WHERE   A.DEPARTMENT_ID=B.DEPARTMENT_ID(+)
GROUP BY A.DEPARTMENT_NAME;
-------------------------------------------------------------------------------------------
사용예)
2005년도 4월 모든 상품별 매출정보를 조회하시오
SELECT      B.PROD_ID AS 상품코드, 
            B.PROD_NAME AS 상품명, 
            NVL(SUM(A.CART_QTY),0)  AS 매출수량,
            NVL(SUM(A.CART_QTY*B.PROD_SALE),0) AS 매출액
FROM        PROD B LEFT OUTER JOIN CART A ON (B.PROD_ID=A.CART_PROD AND SUBSTR(CART_NO,1,6) LIKE '200504')
GROUP BY    B.PROD_ID, B.PROD_NAME
ORDER BY    3 DESC;

SELECT  COUNT(PROD_ID)
FROM    PROD;
 
SELECT  TBLB.PROD_ID AS 상품코드,
        TBLB.PROD_NAME   AS 상품명,
        NVL(TBLA.TCQTY,0) AS 매출수,
        NVL(TBLA.TSALE,0)  AS 매출액
FROM (      
            SELECT      B.PROD_ID AS CARTNUMBER, 
                        B.PROD_NAME AS CARTNAME, 
                        NVL(SUM(A.CART_QTY),0)  AS TCQTY,
                        NVL(SUM(A.CART_QTY*B.PROD_SALE),0) AS TSALE
            FROM        PROD B, CART A 
            WHERE       B.PROD_ID=A.CART_PROD 
            AND         SUBSTR(CART_NO,1,6) LIKE '200504'
            GROUP BY    B.PROD_ID, B.PROD_NAME) TBLA, PROD TBLB
WHERE      TBLB.PROD_ID = TBLA.CARTNUMBER(+)
ORDER BY  4 DESC;

SELECT  DISTINCT(CART_PROD),
        COUNT(DISTINCT(CART_PROD))--중복배제
FROM    CART
WHERE   CART_NO LIKE '200504%'
GROUP BY CART_PROD;

SELECT      B.PROD_ID AS 상품코드, 
            B.PROD_NAME AS 상품명, 
            NVL(SUM(A.CART_QTY),0)  AS 매출수량,
            NVL(SUM(A.CART_QTY*B.PROD_SALE),0) AS 매출액
FROM        PROD B LEFT OUTER JOIN CART A ON (B.PROD_ID=A.CART_PROD AND SUBSTR(CART_NO,1,6) LIKE '200504')
GROUP BY    B.PROD_ID, B.PROD_NAME
ORDER BY    3 DESC;

사용예)
2005년도 4월 모든 상품별 매입/매출정보를 조회하시오
사용예)
사원테이블에서 자기부서의 평균급여보다 급여를 많이받는 사원들을 조회하시오
SELECT      B.PROD_ID AS 상품코드,
            B.PROD_NAME AS 상품명,
            NVL(SUM(A.BUY_QTY),0) AS 매입수량, 
            NVL(SUM(A.BUY_QTY*A.BUY_COST),0) AS 매입금액
FROM        PROD B LEFT OUTER JOIN BUYPROD A ON ( A.BUY_PROD = B.PROD_ID AND BUY_DATE BETWEEN TO_DATE('20050401') AND LAST_DAY(TO_DATE('20050401')))

GROUP BY    B.PROD_ID,B.PROD_NAME
ORDER BY    1;
UNION ALL
SELECT      B.PROD_ID AS 상품코드, 
            B.PROD_NAME AS 상품명, 
            NVL(SUM(A.CART_QTY),0)  AS 매출수량,
            NVL(SUM(A.CART_QTY*B.PROD_SALE),0) AS 매출액
FROM        PROD B LEFT OUTER JOIN CART A ON (B.PROD_ID=A.CART_PROD AND SUBSTR(CART_NO,1,6) LIKE '200504')
GROUP BY    B.PROD_ID, B.PROD_NAME
ORDER BY    1;
------------------------------------------
위문제에 대한 SQL을 작성하여 숙제1은 SEM-PC 'D:\공유폴더\ORACLE\HOMEWORK01'에 숙제2는 SEM-PC 'D:\공유폴더\ORACLE\HOMEWORK2'에 전송하시오

파일명: 본인성명_숙제1.TXT,본인성명_숙제2.TXT
제출일자: 2021년 9월 12일까지
----------------------------------------
사용예)
2005년도 4월 모든 상품별 매입/매출정보를 조회하시오
WITH SALEA AS (SELECT        B.PROD_ID AS PROCODE, 
                             B.PROD_NAME AS PRONAME, 
                             NVL(SUM(A.CART_QTY),0)  AS SUMSALE,
                             NVL(SUM(A.CART_QTY*B.PROD_SALE),0) AS ALLSALE
                FROM         PROD B LEFT OUTER JOIN CART A ON (B.PROD_ID=A.CART_PROD AND SUBSTR(CART_NO,1,6) LIKE '200504')
                GROUP BY     B.PROD_ID, B.PROD_NAME),
WITH COSTA AS   (SELECT      B.PROD_ID AS PROCODE,
                             B.PROD_NAME AS PRONAME,
                             NVL(SUM(A.BUY_QTY),0) AS SUMCOST, 
                             NVL(SUM(A.BUY_QTY*A.BUY_COST),0) AS ALLCOST
                FROM        PROD B LEFT OUTER JOIN BUYPROD A ON ( A.BUY_PROD = B.PROD_ID AND BUY_DATE BETWEEN TO_DATE('20050201') 
                            AND LAST_DAY(TO_DATE('20050201'))))
SELECT      COSTA.SUMCOST AS 매입수량,
            COSTA.ALLCOST AS 매입금액,
            SALEA.SUMSALE AS 매출수량,
            SALEA.ALLSALE AS 매출금액
FROM        SALEA, COSTA
WHERE       SALEA.PROCODE = COSTA.PROCODE;
-------------------------------------------------------------------------------------
사용예)
2005년도 4월 모든 상품별 매입/매출정보를 조회하시오
SELECT      A.PROD_ID AS 상품코드, A.PROD_NAME AS 상품명, 
            NVL(SUM(C.BUY_QTY),0) AS 매입수량, NVL(SUM(C.BUY_QTY*C.BUY_COST),0) AS 매입금액, 
            NVL(SUM(B.CART_QTY),0) AS 매출수량, NVL(SUM(B.CART_QTY*A.PROD_PRICE),0) AS 매출금액
FROM        PROD A LEFT OUTER JOIN CART B ON (A.PROD_ID=B.CART_PROD AND SUBSTR(CART_NO,1,6) LIKE '200504')
            JOIN BUYPROD C ON (A.PROD_ID=C.BUY_PROD AND SUBSTR(CART_NO,1,6) LIKE '200504')
GROUP BY     A.PROD_ID, A.PROD_NAME
ORDER BY    1;
----------------------------------------------------------------------------------------------------------------------
2005년도 4월 모든 상품별 매입/매출정보를 조회하시오
SELECT      A.PROD_ID AS 상품코드, A.PROD_NAME AS 상품명, 
            NVL(SUM(C.BUY_QTY),0) AS 매입수량, NVL(SUM(C.BUY_QTY*A.PROD_COST),0) AS 매입금액, 
            NVL(SUM(B.CART_QTY),0) AS 매출수량, NVL(SUM(B.CART_QTY*A.PROD_PRICE),0) AS 매출금액
FROM        PROD A LEFT OUTER JOIN CART B ON (A.PROD_ID=B.CART_PROD AND SUBSTR(CART_NO,1,6) LIKE '200504')
            LEFT OUTER JOIN BUYPROD C ON (A.PROD_ID=C.BUY_PROD AND SUBSTR(CART_NO,1,6) LIKE '200504')
GROUP BY     A.PROD_ID, A.PROD_NAME
ORDER BY    1;
----------------------------------------------------------------------------------------------------------------------
사용예)
사원테이블에서 자기부서의 평균급여보다 급여를 많이받는 사원들을 조회하시오
사원테이블
사원
자기부서
자기부서의 평균급여보다 많은

SELECT      DEPARTMENT_ID 부서번호, DEPARTMENT_NAME 부서명, SALARY 급여, 부서평균급여
FROM        DEPARTMENTS A, EMPLOYEES B;

부서 평균 급여
SELECT    A.DEPARTMENT_ID AS 부서번호, 
          ROUND(AVG(B.SALARY)) AS 부서평균급여
FROM      DEPARTMENTS A, EMPLOYEES B
WHERE     A.DEPARTMENT_ID= B.DEPARTMENT_ID  
GROUP BY  A.DEPARTMENT_ID;

합치기
SELECT      B.DEPTNO AS 부서번호, B.DEPTNAME AS 부서명, A.EMP_NAME AS 사원이름 ,A.SALARY AS 급여, B.AVGSAL AS 부서평균급여
FROM        EMPLOYEES A LEFT OUTER JOIN (SELECT      A.DEPARTMENT_ID AS DEPTNO, 
                                      A.DEPARTMENT_NAME AS DEPTNAME,
                                      ROUND(AVG(B.SALARY)) AS AVGSAL
                            FROM      DEPARTMENTS A, EMPLOYEES B
                            WHERE     A.DEPARTMENT_ID= B.DEPARTMENT_ID  
                            GROUP BY  A.DEPARTMENT_ID, A.DEPARTMENT_NAME) B ON (A.DEPARTMENT_ID = B.DEPTNO)
WHERE       A.SALARY > B.AVGSAL;
--