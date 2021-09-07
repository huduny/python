2021-09-06
**재고수불을 위한 테이블 생성
1. 테이블명: REMAIN
2. 컬럼: 
-------------------------------------------------------------
컬럼명           데이터타입       PK/FK           기본값
-------------------------------------------------------------
REMAIN_YEAR    CHART(4)       PK
PROD_ID        VARCHAR2(10)   PK/FK
REMAIN_J_00    NUMBER(5)                        0
REAMIN_I       NUMBER(5)                        0
REMAIN_O       NUMBER(5)                        0
REMAIN_J_99    NUMBER(5)                        0
REMAIN_J_DATE  DATE                             0
-------------------------------------------------------------
REMAIN_J_00: 기초재고
REAMIN_I: 입고량
REMAIN_O: 출고량
REMAIN_J_99: 기말재고
REMAIN_J_DATE: 변경 날짜

CREATE TABLE REMAIN (
REMAIN_YEAR    CHAR(4),
PROD_ID        VARCHAR2(10),
REMAIN_J_00    NUMBER(5) DEFAULT 0,
REMAIN_I       NUMBER(5) DEFAULT 0,
REMAIN_O       NUMBER(5) DEFAULT 0,
REMAIN_J_99    NUMBER(5) DEFAULT 0,
REMAIN_J_DATE  DATE,
CONSTRAINT PK_REMAIN PRIMARY KEY(REMAIN_YEAR,PROD_ID),
CONSTRAINT FK_REMAIN_PROD FOREIGN KEY(PROD_ID) 
REFERENCES PROD(PROD_ID));

1) 서브쿼리를 이용한 자료 삽입
(사용형식)
-INSERT INTO 테이블명[(컬럼LIST)]
서브쿼리;
.VALUES 절을 생략한다.
.서브쿼리 기술시 '()'를 생략함

사용예) REMAIN 테이블에 다음자료를 상ㅂ입하시오
    REMAIN_YEAR: '2005'
    PROD_ID: PROD테이블의 모든 상품코드
    REMAIN_J_00: PROD테이블의 PROD_PROPERSTOCK 값
    REMAIN_I,REAMIN_O: 0
    REMAIN_DATE: '2004-12-31'
    
INSERT INTO REMAIN (REMAIN_YEAR, PROD_ID, REMAIN_J_00, REMAIN_J_99, REMAIN_J_DATE)
SELECT '2005', PROD_ID, PROD_PROPERSTOCK, PROD_PROPERSTOCK, TO_DATE('20041231')
FROM PROD;

COMMIT;

1) 서브쿼리를 이용한 자료 수정
(사용형식)
UPDATE TABLE 테이블명
SET (컬럼명1[,컬럼명2,...]}=(서브쿼리)
[WHERE 조건]

사용예) 2005년 1~3월 사이에 발생된 매입정보로 재고수불테이블(REMAIN)의 데이터를 갱신하시오
REMAIN_I, REMAIN_J_99, REMAIN_J_DATE
UPDATE TABLE REMAIN_I, REMAIN_J_99, REMAIN_J_DATE
SET        REMAIN I = ( SELECT      BUY_PROD,
            SUM(BUY_QTY)
FROM        BUYPROD
WHERE       BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
GROUP BY    BUY_PROD    )
            REMAIN_J_99 = REMAIN I + 

2005년 1~3월 사이에 발생된 매입정보
SELECT      BUY_PROD,
            SUM(BUY_QTY)
FROM        BUYPROD
WHERE       BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
GROUP BY    BUY_PROD    

SELECT      BUY_PROD,
            SUM(BUY_QTY)
FROM        BUYPROD
WHERE       BUY_DATE BETWEEN '20050101' AND '20050131'
GROUP BY    BUY_PROD    

(메인쿼리)
UPDATE  REMAIN A
SET     (A.REMAIN_I, A.REMAIN_J_99, A.REMAIN_J_DATE)=
        (SELECT A.REMAIN_I+B.AMT, A.REMAIN_J_99+B.AMT, TO_DATE('20050331')
         FROM       (SELECT     BUY_PROD AS BID,
                                SUM(BUY_QTY) AS AMT
                     FROM       BUYPROD
                     WHERE      BUY_DATE BETWEEN '20050101' AND '20050331'
                     GROUP BY   BUY_PROD) B
         WHERE   A.PROD_ID = B.BID)
WHERE  A.REMAIN_YEAR='2005'
--ROLLBACK;
AND    A.PROD_ID IN (SELECT     DISTINCT BUY_PROD
                     FROM       BUYPROD
                     WHERE      BUY_DATE BETWEEN '20050101' AND '20050331');
--웨어절에서 업데이트 해야될 행을 지정해줘야 된다
--위에서 비교해도 또 써줘야 된다.
--위에는 변경되어질 값을 찾는거고 밑에는 업데이트를 담당하는 자료를 걸러내야된다.
COMMIT;
사용예) 2005년 4월 제품별 매출을 조회하여 재고수불테이블을 변경하시오
--서브쿼리 2005년 4월 제품별 매출
SELECT      CART_PROD AS CPROD,
            SUM(CART_QTY) AS SQTY
FROM        CART
WHERE       CART_NO LIKE '200504%'
GROUP BY    CART_PROD
        
--메인쿼리
UPDATE      REMAIN A
SET         (A.REMAIN_O, A.REMAIN_J_99, A.REMAIN_J_DATE)=
            (SELECT A.REMAIN_O+B.SQTY, A.REMAIN_J_99-B.SQTY ,TO_DATE('20050430')
             FROM (SELECT      CART_PROD AS CPROD,
                               SUM(CART_QTY) AS SQTY
                   FROM        CART
                   WHERE       CART_NO LIKE '200504%'
                   GROUP BY    CART_PROD) B
             WHERE  A.PROD_ID=B.CPROD)      
WHERE        A.REMAIN_YEAR='2005'
AND          A.PROD_ID IN (SELECT     DISTINCT CART_PROD
                           FROM       CART
                           WHERE      CART_NO LIKE '200504%') ;
COMMIT;   
-- PK키가 2개이므로 WHERE절에 2가지 모두 조건을 기술해 줘야 정확한 인덱스 즉 주소가 저장된다,
-- 복수개의 주요키가 있으면 웨어절에서 복수개 모두 작성해 줘야 된다.
ALTER TABLE REMAIN
RENAME COLUMN REMAIN_J_99 TO REMAIN_99;

사용예) 2005년 4월 28일 판매된 상품들 중 카트번호 '2005042800002'의 자료가 모두 반품되었다. 이를 처리하시오.
2005년 4월 28일 판매된 상품들 중 카트번호 '2005042800002'
SELECT   CART_PROD AS CPROD,
         SUM(CART_QTY) AS SCQTY
FROM     CART
WHERE    CART_NO LIKE '20050428%'
GROUP BY CART_PROD;

--합치기
UPDATE  REMAIN A
SET     (A.REMAIN_O, A.REMAIN_99, A.REMAIN_J_DATE) =
        (SELECT A.REMAIN_O-B.SCQTY, A.REMAIN_99+B.SCQTY, TO_DATE('20050501')
         FROM (SELECT   CART_PROD AS CPROD,
                        SUM(CART_QTY) AS SCQTY
               FROM     CART
               WHERE    CART_NO LIKE '20050428%'
               GROUP BY CART_PROD) B
         WHERE A.PROD_ID=B.CPROD)
WHERE    A.REMAIN_YEAR='2005'
AND      A.PROD_ID IN (SELECT     DISTINCT CART_PROD
                       FROM       CART
                       WHERE      CART_NO LIKE '2005042800002');

DELETE CART
WHERE CART_NO LIKE '2005042800002';
COMMIT;

2021-09-06-02)집합연산자
- 집합연산자는 SQL 검색결과를 집합(SET)으로 간주하여 여러 집합(여러 SQL 결과)을 대상으로하는 연산
- UNION, UNION ALL, INTERSECT(교집합), MINUS(차집합) 연산자 제공
- 사용상 제한사항
1) 집합연산자로 연결되는 각 SELECT절의 컬럼수 및 데이터 타입은 일치해야 함
    - 출력은 맨 처음 SELECT 절을 기준으로 출력된다.(제목이)
2) ORDER BY 절은 맨 마지막 SELECT 문에서만 사용 가능
3) BLOB, CLOB, BFILE 타입의 컬럼에 대하여 집합연산자를 사용할 수 없다.
4) LONG 타입의 컬럼은 UNION, INTERSECT, MINUS 연산에 참여 할 수 없음
--조인을 줄일수 있다. 서브쿼리를 줄여줄수 있다.
--UNION인 경우에는 중복된 값을 한번만(DISTINCT)해준다, UNION ALL은 중복된 값이 두번 나온다.

1. UNION
-합집합의 결과를 반환
-교집합 부분의 원소는 한번만 반환됨

사용예) 회원테이블에서 나이가 30대 회원의 회원번호, 회원명, 직업, 마일리지와 
        여성회원의 회원번호, 회원명, 직업, 마일리지를 조회하시오
        
        SELECT  MEM_ID AS 회호, MEM_NAME AS 회원명,CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('2','4') THEN '여성' ELSE '남성' END AS 성별,
                MEM_JOB AS 직업, MEM_MILEAGE AS 마일리지
        FROM    MEMBER
        WHERE   TRUNC(EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM MEM_BIR), -1) = 40
        UNION
        SELECT  MEM_ID AS 회원번호, MEM_NAME AS 회원명,CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('2','4') THEN '여성' ELSE '남성' END AS 성별, 
                RTRIM(MEM_LIKE) AS 기념일, MEM_MILEAGE AS 마일리지
        FROM    MEMBER
        WHERE   SUBSTR(MEM_REGNO2,1,1) IN('2','4')
        ORDER BY 3 DESC;


