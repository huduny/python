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