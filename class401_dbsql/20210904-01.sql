2021-09-04 숙제
오영균_숙제
위문제에 대한 SQL을 작성하여 숙제1은 SEM-PC 'D:\공유폴더\ORACLE\HOMEWORK01'에 숙제2는 SEM-PC 'D:\공유폴더\ORACLE\HOMEWORK2'에 전송하시오

파일명: 본인성명_숙제1.TXT,본인성명_숙제2.TXT
제출일자: 2021년 9월 12일까지
------------------------------------------------------------------------------------------------------------
2005년 5월 회원별 구매금액 합계를 구하되/ 4월 구매한 모든 회원의 구매금액 보다 많은 회원들을 조회하시오.(MAX함수를 사용하지 마시오)
SELECT
    C.MEM_ID AS 회원아이디,
    C.MEM_NAME AS 회원이름,
    X.SSELL AS 구매금액합계
FROM
    (
        SELECT
            A.CART_MEMBER AS MNA,
            NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS SSELL
        FROM
            CART A
            LEFT OUTER JOIN PROD B ON ( A.CART_PROD = B.PROD_ID
                                        AND SUBSTR(A.CART_NO,1,6) LIKE '200504' )
        GROUP BY
            A.CART_MEMBER
    ) Z
    LEFT OUTER JOIN (
        SELECT
            A.CART_MEMBER AS MNA,
            NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS SSELL
        FROM
            CART A
            LEFT OUTER JOIN PROD B ON ( A.CART_PROD = B.PROD_ID
                                        AND SUBSTR(A.CART_NO,1,6) LIKE '200505' )
        GROUP BY
            A.CART_MEMBER
    ) X ON ( Z.MNA = X.MNA )
    LEFT OUTER JOIN MEMBER C ON ( Z.MNA = C.MEM_ID )
WHERE
    X.SSELL > Z.SSELL   
------------------------------------------------------------------------------------------------------------ 
2. 사원테이블에서 자기부서의 평균급여보다 급여를 많이받는 사원들을 조회하시오    
Select
    B.Deptno As 부서번호,
    B.Deptname As 부서명,
    A.Emp_Name As 사원이름,
    A.Salary As 급여,
    B.Avgsal As 부서평균급여
From
    Employees A
    Left Outer Join (
        Select
            A.Department_Id As Deptno,
            A.Department_Name As Deptname,
            Round(Avg(B.Salary) ) As Avgsal
        From
            Departments A,
            Employees B
        Where
            A.Department_Id = B.Department_Id
        Group By
            A.Department_Id,
            A.Department_Name
    ) B On ( A.Department_Id = B.Deptno )
Where
    A.Salary > B.Avgsal;
------------------------------------------------------------------------------------------------------------
3. 합치기/  2005년도 4월 모든 상품별 매입/매출정보를 조회하시오
SELECT
    Z.PROD_ID AS 상품번호,
    X.BQ AS 매입수량,
    X.BQC AS 매입금액,
    C.CQ AS 매출수량,
    C.CPP AS 매출금액
FROM
    PROD Z
    LEFT OUTER JOIN (
        SELECT
            A.PROD_ID AS BP,
            NVL(SUM(B.BUY_QTY),0) AS BQ,
            NVL(SUM(B.BUY_QTY * B.BUY_COST),0) AS BQC
        FROM
            PROD A
            LEFT OUTER JOIN BUYPROD B ON ( A.PROD_ID = B.BUY_PROD
                                           AND BUY_DATE BETWEEN '20050401' AND '20050430' )
        GROUP BY
            A.PROD_ID
    ) X ON ( Z.PROD_ID = X.BP )
    LEFT OUTER JOIN (
        SELECT
            C.PROD_ID AS CP,
            NVL(SUM(D.CART_QTY),0) AS CQ,
            NVL(SUM(D.CART_QTY * C.PROD_PRICE),0) AS CPP
        FROM
            PROD C
            LEFT OUTER JOIN CART D ON ( C.PROD_ID = D.CART_PROD
                                        AND SUBSTR(CART_NO,1,6) LIKE '200504' )
        GROUP BY
            C.PROD_ID
    ) C ON ( Z.PROD_ID = C.CP )
ORDER BY
    1;






