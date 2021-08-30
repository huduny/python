2021-08-30-01

사용예) 2005년 6월 모든 상품에 대하여 판매횟수,판매수량,판매금액을 조회하시오
        ALIAS는 상품코드,상품명,판매횟수,판매수량,판매금액이다.
        SELECT      A.CART_PROD AS 상품코드,
                    B.PROD_NAME AS 상품명,
                    NVL(COUNT(A.CART_PROD), 0) AS 판매횟수,
                    SUM(A.CART_QTY) AS 판매수량,
                    SUM(A.CART_QTY*B.PROD_SALE) AS 판매금액
        FROM        CART A, PROD B
        WHERE       A.CART_NO LIKE '200506%' AND A.CART_PROD = B.PROD_ID
        GROUP BY    A.CART_PROD, B.PROD_NAME 
        ORDER BY    1 DESC;
        
        SELECT      B.PROD_ID AS 상품코드,
                    B.PROD_NAME AS 상품명,
                    COUNT(A.CART_QTY) AS 판매횟수,
                    NVL(SUM(A.CART_QTY),0) AS 판매수량,
                    NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS 판매금액
        FROM        CART A
        RIGHT OUTER JOIN PROD B ON (A.CART_PROD=B.PROD_ID
        AND         A.CART_NO LIKE '200506%')
        GROUP BY    B.PROD_ID, B.PROD_NAME;
-- 전부, 모든이라는 부사가 붙으면 4~6월달 판매가 안됬으면 0이 되어야 한다.
-- 외부조인시 COUNT를 쓸때에는 카운트에 기준이 되는 컬럼명을 기술해야 된다.

4.MAX(COL), .MIN(COL)
- 'COL'으로 기술된 컬럼의 값 중 가장 큰 값을 반환
- 'COL'으로 기술된 컬럼의 값 중 가장 작은 값을 반환
- 중첩사용이 허용되지 않음

사용예) 사원테이블에서 부서별 최대급여액과, 최소급여액을 구하시오
--여래개의 열중에서 제일 적은 큰 값을 구할때는 GREATEST OR LEASTEST를 사용한다.
SELECT  DEPARTMENT_ID AS 부서코드,
        MAX(SALARY) AS 최대급여액,
        MIN(SALARY) AS 최소급여액
FROM    EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY 1;
--부서별로 다 모은 다음에 부서의 개수만큼 결과가 나온다. 다중행

사용예) 2005년 1월 최대매입수량 상품 정보를 조회하시오.
    ALIAS는 상품코드, 매입수량합계, 매입금액합계

SELECT      BUY_PROD,
            SUM(BUY_QTY)
FROM        BUYPROD
WHERE       BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
GROUP BY    BUY_PROD
ORDER BY    2 DESC;

SELECT  A.BID, MAX(A.BSUM)

FROM    (SELECT     BUY_PROD AS BID,
                    SUM(BUY_QTY) AS BSUM
            FROM        BUYPROD
            WHERE       BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
            GROUP BY    BUY_PROD
            ORDER BY    2 DESC) A
WHERE       ROWNUM =1
GROUP BY    A.BID;

WITH A AS (SELECT     BUY_PROD AS BID,
                    SUM(BUY_QTY) AS BSUM
            FROM        BUYPROD
            WHERE       BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
            GROUP BY    BUY_PROD
            ORDER BY    2 DESC)
SELECT A.BID, MAX(A.BSUM)
FROM  A
WHERE ROWNUM =1
GROUP BY    A.BID;  

사용예) 오늘이 2005년 7월 28일이라고 가정하고 다음 자료가 판매되었을때 그 정보를 CART테이블에 저장하시오
    [자료]
    판매고객:'E001'
    판매상품:'P202000007'
    판매수량: 5개
    
    판매상품:'P302000022'
    판매수량: 12개
    장바구니번호는 자동으로 생성시키시오.

-- CART테이블에 인설트 하고 재고테이블이 있다면 5개를 줄이고 마일리지를 적립해야줘야된다. 있는 자료의 값을 변경해주는 것이다.
-- 테이블에서 자동으로 조정해 주는 것이 트리거라고 한다.
(장바구니번호 생성)
    SELECT MAX(CART_NO)+1
    FROM    CART
    WHERE   CART_NO LIKE '20050728%';
-- 나중에 상품을 만들때는 숫자로만 집어넣어서 수정이 용이하도록 허저
(장바구니에 자료 삽입)
    INSERT INTO CART
    SELECT 'e001', MAX(CART_NO)+1, 'P202000007', '5'
    FROM    CART
    WHERE   CART_NO LIKE '20050728%';
    
(회원테이블에서 마일리지 변경)
    UPDATE MEMBER
    SET     MEM_MILEAGE=MEM_MILEAGE+(SELECT MEM_MILEAGE* 5 AS AMT
                                            FROM PROD
                                            WHERE PROD_ID='P202000007') 
                        WHERE  MEM_ID = 'e001';
                        
E001의 마일리즈 - 6500
마일리지 추가분 = 210
COMMIT;
--프로젝트때 무언가를 사고 팔때 쇼핑몰이다라고 하면 판매가 이루어진 다음 그 다음에 무엇을 해야 될지 생각해보자
--매출테이블에 저장하고 재고 테이블 변경해주고 등등
MAX(졸림) MIN(의욕)

