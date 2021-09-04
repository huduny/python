2021-09-03-01
사용예) 회원테이블에서 여성회원의 평균 마일리지보다 더 많은 마일리지를 보유한 회원을 조회하시오.
alias는 회원번호, 회원명, 성별, 마일리지

SELECT  MEM_ID AS 회원번호, 
        MEM_NAME AS 회원명, 
        CASE MEMBER WHEN SUBSTR(MEM_REGNO2,1,1)='2' OR
                         SUBSTR(MEM_REGNO2,1,1)='4' THEN '여성회원'
                    ELSE '남성회원' END AS 성별,
        MEM_MILEAGE AS 마일리지
FROM    MEMBER
WHERE   MEM_MILEAGE > (서브쿼리: 여성회원의 평균마일리지);

(서브쿼리: 여성회원의 평균마일리지)
SELECT  AVG(MEM_MILEAGE)
FROM    MEMBER
WHERE   SUBSTR(MEM_REGNO2,1,1) IN ('2','4');

SELECT  A.MEM_ID AS 회원번호, 
        A.MEM_NAME AS 회원명, 
        CASE MEMBER WHEN SUBSTR(A.MEM_REGNO2,1,1)='2' OR
                         SUBSTR(A.MEM_REGNO2,1,1)='4' THEN '여성회원'
                    ELSE '남성회원' END AS 성별,
        MEM_MILEAGE AS 마일리지
FROM    MEMBER A, (SELECT  AVG(MEM_MILEAGE) AS AVGA
FROM    MEMBER
WHERE   SUBSTR(A.MEM_REGNO2,1,1) IN ('2','4')) B
WHERE   MEM_MILEAGE > B.AVGA

SELECT  MEM_ID AS 회원번호, 
        MEM_NAME AS 회원명, 
        CASE WHEN SUBSTR(MEM_REGNO2,1,1)='2' OR
                         SUBSTR(MEM_REGNO2,1,1)='4' THEN '여성회원'
                    ELSE '남성회원' END AS 성별,
        MEM_MILEAGE AS 마일리지
FROM    MEMBER
WHERE   MEM_MILEAGE >(SELECT  AVG(MEM_MILEAGE)
FROM    MEMBER
WHERE   SUBSTR(MEM_REGNO2,1,1) IN ('2','4'))
ORDER BY 1;

2021-09-03-01
2.연관성 있는 서브쿼리
-메인쿼리에 사용된 테이블과 서브쿼리에 사용된 테이블이 JOIN으로 연결된 경우
-대부분의 서브쿼리가 이에 속함

사용예) 2005년도 모든 거래처별 매입금액합계와 매출금액합계를 구하시오
모든(OUTTER 조인) 거래처별(GROUP BY)

SELECT      거래처코드, 거래처명, 매입금액합계, 매출금액합계
FROM        BUYER A, (서브쿼리:2005년도 거래처별 매입금액합계) B, (서브쿼리:2005년 거래처별 매출금액합계) C, BUYPROD B, CART C, PROD D
--모든이 빠진 것은 이너조인
--거래처코드가 A에 훨씬더 많다.--한테이블이 동시에 확장 되는 것은 안되지만 A를 기준으로 B가 확장되고 A를 기준으로 C가확장되는 것은 괜찮다.

--2005년도 거래처별 매입금액합계
SELECT  BUYER_ID AS BID,
        SUM(BUY_QTY*PROD_COST) AS BAMT
FROM    BUYPROD, PROD, BUYER
WHERE   BUY_PROD = PROD_ID
AND     PROD_BUYER = BUYER_ID --이부분 까지가 거래처별
AND     EXTRACT(YEAR FROM BUY_DATE)=2005
GROUP BY BUYER_ID
--인라인 서브쿼리는 별칭을 참조한느 경우가 많아서 영어로 별칭을 주자

--2005년 거래처별 매출금액합계
SELECT  BUYER_ID AS BID,
        SUM(CART_QTY*PROD_PRICE) AS CAMT
FROM    CART, PROD, BUYER
WHERE   CART_PROD = PROD_ID
AND     PROD_BUYER = BUYER_ID --이부분 까지가 거래처별
AND     CART_NO LIKE '2005%'
GROUP BY BUYER_ID

--합치자
SELECT      A.BUYER_ID AS 거래처코드, --모든, 아우터 조인이 수행이 될때는 많은 쪽 걸 SELECT절에 기술
            A.BUYER_NAME AS 거래처명, 
            NVL(B.BAMT,0) AS 매입금액합계, 
            NVL(C.CAMT,0) AS 매출금액합계
            
FROM    BUYER A LEFT OUTER JOIN  

(SELECT  BUYER_ID AS BID,
        SUM(BUY_QTY*PROD_COST) AS BAMT
FROM    BUYPROD, PROD, BUYER
WHERE   BUY_PROD = PROD_ID
AND     PROD_BUYER = BUYER_ID
AND     EXTRACT(YEAR FROM BUY_DATE)=2005
GROUP BY BUYER_ID) B ON(A.BUYER_ID = B.BID) LEFT OUTER JOIN 

(SELECT  BUYER_ID AS BID,
        SUM(CART_QTY*PROD_PRICE) AS CAMT
FROM    CART, PROD, BUYER
WHERE   CART_PROD = PROD_ID
AND     PROD_BUYER = BUYER_ID --이부분 까지가 거래처별
AND     CART_NO LIKE '2005%'
GROUP BY BUYER_ID) C ON (A.BUYER_ID = C.BID)

사용예)2005년 4월 매입액이 많은 5개 상품의 판매정보를 조회하시오.
ALIAS는 상품코드, 상품명, 판매수량합계, 판매금액합계

2005년 4월 매입액이 많은 5개
--4월 매입액 순으로
SELECT  BUY_PROD AS 상품코드,
        SUM(BUY_QTY*BUY_COST) AS 매입액
FROM  BUYPROD
WHERE SUBSTR(TO_CHAR(BUY_DATE,'YYYYMM'),5,6)='04'
GROUP BY BUY_PROD
ORDER BY 2 DESC;
--4월 매입액 5개
SELECT  BUY_PROD AS PRODNUM
FROM    BUYPROD A , (SELECT  BUY_PROD AS BPROD,
                             SUM(BUY_QTY*BUY_COST) AS BSUM
                     FROM  BUYPROD
                     WHERE BUY_DATE BETWEEN '20050401' AND '20050430'
                     GROUP BY BUY_PROD
                     ORDER BY 2 DESC) B
WHERE ROWNUM <=5;

2005년 4월달의 매출액
SELECT  A.CART_PROD AS CARTNUM,
        B.PROD_NAME AS PRONAM,
        SUM(A.CART_QTY) AS TSELL,
        SUM(A.CART_QTY*B.PROD_PRICE) AS TSALE
FROM    CART A, PROD B
WHERE   SUBSTR(A.CART_NO,1,6) LIKE '200504'
GROUP BY A.CART_PROD, B.PROD_NAME

상품코드로 조인
SELECT  C.PRODNUM AS 상품코드, 
        D.PRONAM AS 상품명, 
        D.TSELL AS 판매수량합계, 
        D.TSALE AS 판매금액합계
FROM 
(SELECT  B.BPROD AS PRODNUM
FROM   (SELECT  BUY_PROD AS BPROD,
                             SUM(BUY_QTY*BUY_COST) AS BSUM
                     FROM  BUYPROD
                     WHERE BUY_DATE BETWEEN '20050401' AND '20050430'
                     GROUP BY BUY_PROD
                     ORDER BY 2 DESC) B
WHERE ROWNUM <=5) C, 

(SELECT  A.CART_PROD AS CARPROD,
        B.PROD_NAME AS PRONAM,
        SUM(A.CART_QTY) AS TSELL,
        SUM(A.CART_QTY*B.PROD_PRICE) AS TSALE
FROM    CART A, PROD B
WHERE   SUBSTR(A.CART_NO,1,6) LIKE '200504'
GROUP BY A.CART_PROD, B.PROD_NAME) D

WHERE  C.PRODNUM = D.CARPROD 
--AND    C.PRODNUM = E.PROD_ID ;







SELECT  A.CART_PROD AS 상품코드, 
        B.PROD_NAME AS 상품명, 
        SUM(CART_QTY) AS 판매수량합계, 
        SUM(CART_QTY*PROD_PRICE) AS 판매금액합계
FROM  CART A, PROD B,
(SELECT  BUY_PROD AS PRODNUM
FROM    BUYPROD A , (SELECT  BUY_PROD AS BPROD,
                             SUM(BUY_QTY*BUY_COST) AS BSUM
                     FROM  BUYPROD
                     WHERE BUY_DATE BETWEEN '20050401' AND '20050430'
                     GROUP BY BUY_PROD
                     ORDER BY 2 DESC) B
WHERE ROWNUM <=5;) C
WHERE   C.PRODNUM=A.CART_PROD
AND     C.PRODNUM=B.PROD_ID
GROUP BY  A.CART_PROD, B.PROD_NAME

SELECT  A.CART_PROD AS 상품코드, 
        B.PROD_NAME AS 상품명, 
        SUM(CART_QTY) AS 판매수량합계, 
        SUM(CART_QTY*PROD_PRICE) AS 판매금액합계
FROM CART Z, 
---------------------------------------------------------------------------------
SELECT  Z.CART_PROD AS 상품코드, 
        X.PROD_NAME AS 상품명, 
        SUM(Z.CART_QTY) AS 판매수량합계, 
        SUM(Z.CART_QTY*X.PROD_PRICE) AS 판매금액합계
        
FROM    CART Z, PROD X, (SELECT  B.BPROD AS PRODNUM
                         FROM   (SELECT  BUY_PROD AS BPROD,
                                        SUM(BUY_QTY*BUY_COST) AS BSUM
                                 FROM  BUYPROD
                                 WHERE BUY_DATE BETWEEN '20050401' AND '20050430'
                                 GROUP BY BUY_PROD
                                 ORDER BY 2 DESC) B
                         WHERE ROWNUM <=5) Y
WHERE   Y.PRODNUM = Z.CART_PROD
AND     Y.PRODNUM = X.PROD_ID
AND     SUBSTR(CART_NO,1,6) LIKE '200504'
GROUP BY Z.CART_PROD, X.PROD_NAME 
ORDER BY 1;
---------------------------------------------------------------------------------
--rankover이라는 함수를 쓰면 자동으로 순서를 매겨준다
--rownum을 먼저쓰면 rownum이 order by절 보다 먼저 실행 5개 거르고 그리고 오더바이절의 정렬한다.
--from절에 사용되는 서브쿼리는 독립실행되어야 한다.
--내부 조인 조건이기 때문에 조인 조건에 맞는 것만 출력해 준다.

2021-09-03-02)
**순위 반환함수(rank(), dense_rank(), row_number())
-rownum의 사레 코드는 where 절에서 사용되고 order by 절에 의하여 순서화가 이루어지기 때문에 순서화된 일정 갯수의 자료를 반환 받을 수 없음
-테이블의 특정 열을 기준으로 순위를 구하여 반환하기 위함
1)RANK()
. 동일 값에 동일 순위를 부여하고 그 다음 순위는 동일 순위의 갯수만큼 건너 뛴 값(순위)을 부여하는 방식
(사용형식)
SELECT 컬럼LIST,
        RANK() OVER(ORDER BY 기준컬럼 DESC) AS 컬럼별칭
FROM    테이블명
 :

사용예) 회원테이블에서 회원의 마일리지 점수에 따라 순위를 부여하시오
SELECT MEM_ID AS 회원번호,
MEM_NAME AS 회원명,
MEM_MILEAGE AS 마일리지,
RANK() OVER(ORDER BY MEM_MILEAGE desc) AS 순위
FROM MEMBER;

RANK() OVER, ROWNUM

사용예) 사원테이블에서 각 부서별로 사원들의 급여에 따른 순위를 부여하시오
alias는 사원번호, 사원명, 부서명, 급여, 순위
select  A.EMPLOYEE_ID AS 사원번호 , 
        A.EMP_NAME AS 사원명, 
        B.DEPARTMENT_NAME 부서명, 
        A.SALARY 급여, 
        RANK() OVER(ORDER BY SALARY) AS 순위
FROM HR.EMPLOYEES A LEFT OUTER JOIN HR.DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)

select  A.EMPLOYEE_ID AS 사원번호 , 
        A.EMP_NAME AS 사원명, 
        B.DEPARTMENT_NAME 부서명, 
        A.SALARY 급여, 
        RANK() OVER(PARTITION BY A.DEPARTMENT_ID 
                    ORDER BY A.SALARY DESC) AS 순위
FROM HR.EMPLOYEES A LEFT OUTER JOIN HR.DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)

2) DENSE_RANK()
. 동일 값에 동일 순위를 부여하고 그 다음 순위는 동일 순위의 갯수에 상관없이 그 다음 순위를 부여하는 방식
SELECT 컬럼LIST,
        DENSE_RANK() OVER(ORDER BY 기준컬럼 DESC) AS 컬럼별칭
FROM    테이블명
 :
 
사용예) 회원테이블에서 회원의 마일리지 점수에 따라 순위를 부여하시오
SELECT MEM_ID AS 회원번호,
MEM_NAME AS 회원명,
MEM_MILEAGE AS 마일리지,
DENSE_RANK() OVER(ORDER BY MEM_MILEAGE desc) AS 순위
FROM MEMBER;
 
3)row_number
-동일 값에도 순차적인 순위를 부여함
-select 칼럼리스트,
        row_number() over(order by 기준컬럼 desc) as 컬럼 별칭
from 테이블명

사용예) 회원테이블에서 회원의 마일리지 점수에 따라 순위를 부여하시오
SELECT MEM_ID AS 회원번호,
MEM_NAME AS 회원명,
MEM_MILEAGE AS 마일리지,
ROW_NUMBER() OVER(ORDER BY MEM_MILEAGE desc) AS 순위
FROM MEMBER;

사용예) 회원테이블에서 마일리지에 따라 순위를 부여하되 동일 마일리지이면 나이가 어린 순으로 순위를 부여하시오(rank() 함수)
SELECT  MEM_ID AS 회원번호,
        MEM_NAME AS 회원명,
        MEM_MILEAGE AS 마일리지,
        MEM_BIR AS 생년월일,
        Rank() OVER(ORDER BY MEM_MILEAGE desc, MEM_BIR DESC) AS 순위
FROM    MEMBER;

RANK함수는 앞에 순위를 비교하고 같은 값이 있으면 두번째 기준으로 구별한다

**복수행 서브쿼리
-서브쿼리 결과가 복수개의 행이 반환되는 서브쿼리
-사용되는 연산자는: IN ANY SOME EXISTS ALL

사용예) 2005년 5월 회원별 구매금액 합계를 구하되 4월 구매한 모든 회원의 구매금액 보다 많은 회원들을 조회하시오.
      (MAX함수를 사용하지 마시오)

(4월 구매한 모든 회원의 구매금액)(모든=OUTER조인)(모든 회원, 구매금액, 회원이름
SELECT  Z.CART_PROD AS CAPO, 
        SUM(Z.CART_QTY*X.PROD_PRICE) AS SUMP, 
        C.MEM_ID AS MID, 
        C.MEM_NAME AS MNA
FROM    MEMBER C LEFT OUTER JOIN CART Z ON (C.MEM_ID = Z.CART_MEMBER)
        OUTER JOIN ON PROD X ( X.PROD_ID =Z.CART_PROD)
WHERE   SUBSTR(Z.CART_NO,1,6) LIKE '200504'
GROUP BY Z.CART_PROD, C.MEM_ID, C.MEM_NAME
      
SELECT      MEM_ID     
            MEM_NAME
            
SELECT      A.CART_MEMBER AS MNA,     
            SUM(A.CART_QTY*B.PROD_PRICE) AS SSELL
FROM        CART A, PROD B   
WHERE       A.CART_PROD = B.PROD_ID
AND         SUBSTR(A.CART_NO,1,6) LIKE '200504'
GROUP BY    A.CART_MEMBER      
----------------------------------------------------------------------
RESULT) 4월 구매한 모든 회원의 구매금액 합계      
SELECT      A.CART_MEMBER AS MNA,     
            NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) AS SSELL
FROM        CART A LEFT OUTER JOIN PROD B ON (A.CART_PROD = B.PROD_ID AND SUBSTR(A.CART_NO,1,6) LIKE '200504')
GROUP BY    A.CART_MEMBER           
      
-----------------------------------------------------------------------      
SELECT  Z.CART_PROD AS CAPO, 
        C.MEM_ID AS MID, 
        C.MEM_NAME AS MNA,
        NVL(Z.CART_QTY, 0) AS SQTY
FROM    MEMBER C LEFT OUTER JOIN CART Z ON (C.MEM_ID = Z.CART_MEMBER)
WHERE   SUBSTR(Z.CART_NO,1,6) LIKE '200504'
-----------------------------------------------------------------------      
RESULT) 2005년 5월 회원별 구매금액 합계 
RESULT) 5월 구매한 모든 회원의 구매금액 합계      
SELECT      A.CART_MEMBER AS MNA,     
            NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) AS SSELL
FROM        CART A LEFT OUTER JOIN PROD B ON (A.CART_PROD = B.PROD_ID AND SUBSTR(A.CART_NO,1,6) LIKE '200505')
GROUP BY    A.CART_MEMBER       
--------------------------------------------------------------------     
      
합치기)     
2005년 5월 회원별 구매금액 합계를 구하되/ 4월 구매한 모든 회원의 구매금액 보다 많은 회원들을 조회하시오.(MAX함수를 사용하지 마시오)
SELECT      A.CART_MEMBER AS MNA,     
            NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) AS SSELL
            
FROM        CART A LEFT OUTER JOIN PROD B ON (A.CART_PROD = B.PROD_ID AND SUBSTR(A.CART_NO,1,6) LIKE '200505')
            
            OUTER JOIN (SELECT      A.CART_MEMBER AS MNA,     
            NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) AS SSELL
            FROM        CART A LEFT OUTER JOIN PROD B ON (A.CART_PROD = B.PROD_ID AND SUBSTR(A.CART_NO,1,6) LIKE '200504')
            GROUP BY    A.CART_MEMBER) C ON (A.CART_MEMBER = C.MNA)   

GROUP BY    A.CART_MEMBER 
WHERE   


SELECT      C.MEM_ID AS 회원아이디,
            C.MEM_NAME AS 회원이름,
            X.SSELL  AS 구매금액합계
            
FROM       (SELECT      A.CART_MEMBER AS MNA,     
            NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) AS SSELL
            FROM        CART A LEFT OUTER JOIN PROD B ON (A.CART_PROD = B.PROD_ID AND SUBSTR(A.CART_NO,1,6) LIKE '200504')
            GROUP BY    A.CART_MEMBER) Z LEFT OUTER JOIN 
            
            (SELECT      A.CART_MEMBER AS MNA,     
            NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) AS SSELL
            FROM        CART A LEFT OUTER JOIN PROD B ON (A.CART_PROD = B.PROD_ID AND SUBSTR(A.CART_NO,1,6) LIKE '200505')
            GROUP BY    A.CART_MEMBER) X ON (Z.MNA=X.MNA) 
            
            LEFT OUTER JOIN
            MEMBER C  ON (Z.MNA=C.MEM_ID) 
            
WHERE       X.SSELL > Z.SSELL

2005년 4월 매입 매출정보 BUYPROD /모든: 아우터조인
1.매입정보 (4월 매입정보)
SELECT      A.PROD_ID AS BP, 
            NVL(SUM(B.BUY_QTY),0) AS BQ,
            NVL(SUM(B.BUY_QTY*B.BUY_COST),0) AS BQC
FROM        PROD A LEFT OUTER JOIN BUYPROD B ON (A.PROD_ID=B.BUY_PROD AND BUY_DATE BETWEEN '20050401' AND '20050430')
GROUP BY    A.PROD_ID
2.매출정보 (4월 매출정보)
SELECT      C.PROD_ID AS CP,
            NVL(SUM(D.CART_QTY),0) AS CQ,
            NVL(SUM(D.CART_QTY*C.PROD_PRICE),0) AS CPP
FROM        PROD C LEFT OUTER JOIN CART D ON (C.PROD_ID=D.CART_PROD AND SUBSTR(CART_NO,1,6) LIKE '200504')
GROUP BY    C.PROD_ID
