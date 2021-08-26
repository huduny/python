2021-08-26-01
4) TO_DATE(c1 [,fmt])
    -주어진 문자열 C1을 'fmt'형식에 맞는 날짜 자료로 형을 변환 시킴
    -'fmt'는 TO-CHAR 함수의 날짜 변환형식 지정 문자열과 같으나 날짜 자료형으로 취급할 수 있는 문자열만 활용
    
사용예) 장바구니 테이블에서 2005년 6월 판매현황을 조회하시오
    Alias는 월일, 제품코드, 판매수량 이다.
    SELECT  TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,8)), 'MM-DD') 월일, 
            CART_PROD 제품코드, 
            CART_QTY 판매수량
    FROM    CART
    WHERE   CART_NO LIKE '200506%'
    ORDER BY 1;

**NULL 처리함수
널값은 원본데이터를 파괴시킬수 있다.
오라클은 값을 입력하지 않으면 무조건 널이 입력된다. 그래서 그 이후에 연산을 할때 문제가 된다.
-데이터가 NULL 값으로 초기화 된 경우 연산의 결과가 모두 NULL이 됨
-특정 자료가 NULL값인지를 판단하여 NULL을 연산 대상으로 처리하는 함수
-NVL,NVL2,NULLIF 등이 제공

1)NVL(COL1, VAL)
    -'COL'의 값이 NULL이면 'VAL'값을 반환하고, NULL이 아니면 'COL1'값을 반환
    -가장 많이 사용
    -'CPL1'과 'VAL'의 자료타입은 동일해야함

사용예) 사원테이블에서 영업실적 코드를 조회하여 NULL인 경우에 '영업실적없음'을 NULL이 아닌 경우에 영업 실적 코드를 비고난에 출력하시오.
ALIAS는 사원번호, 사원명, 직책코드, 비고
    SELECT      EMPLOYEE_ID 사원번호, 
                EMP_NAME 사원명, 
                JOB_ID 직책코드, 
                COMMISSION_PCT 영업실적,
                LPAD(NVL(TO_CHAR(COMMISSION_PCT,'0.99'), '영업실적 없음'),14) 비고 --COL과 VAL는 같은 자료타입이 동일해야된다.
    FROM        EMPLOYEES;

    
사용예) 상품테이블에서 'P301'에 속한 상품의 할인 판매가를 매입가와 같도록 가격을 갱신하시오.
    UPDATE  PROD 
    SET     PROD_SALE=PROD_COST
    WHERE   PROD_ID LIKE 'P301%';
    --매입했던 가격으로 팔겠다 원가로 팔아서 처분해 버리겠다.
    
2)NVL2(COL,VAL1,VAL2)
    -'COL'의 값이 NULL이면 'VAL2'값을 반환하고, NULL이 아니면 'VAL1'값을 반환 함
    -'VAL1','VAL2' 두 값의 타입은 일치해야 함
    
사용예)상품테이블에서 상품의 크기(PROD_SIZE)가 NULL이면 상품의 마일리지는 매입가의 10%를 NULL이 아니면 상품의 마일리지는 판매가의 10%로 계산하여
갱신하시오

SELECT   PROD_ID AS 상품명,
         PROD_SIZE AS 크기,
         PROD_COST AS 매입가,
         PROD_PRICE AS 판매가,
         ROUND(NVL2(PROD_SIZE,PROD_PRICE*0.001,PROD_COST*0.001)) AS 마일리지 
FROM     OYK93.PROD;
        
UPDATE   PROD 
SET      PROD_MILEAGE = ROUND(NVL2(PROD_SIZE,PROD_PRICE*0.001,PROD_COST*0.001));
    
3)NULLIF(COL1,COL2)
-'COL1'과'COL2'의 값이 같으면 NULL을 같지 않으면 'COL1'을 반환

사용예) 상품테이블에서 매입가와 할인가가 같으면 '단종상품'을 같은 값이 아니면 '정상상품'을 비고난에 출력하시오
ALIAS는 상품코드, 상품명, 매입가, 매출가, 할인판매가, 비고
    



COMMIT;
SELECT      PROD_ID AS 상품코드, 
            PROD_NAME AS 상품명, 
            PROD_COST AS 매입가, 
            PROD_PRICE AS 매출가, 
            PROD_SALE AS 할인판매가, 
            NVL2(NULLIF(PROD_COST, PROD_SALE),'정상상품','단종상품') AS 비고
FROM        PROD;

----------------------------------
ALTER TABLE PROD ADD REMARK VARCHAR2(25);
ROLLBACK;   

UPDATE      PROD
SET         REMARK = NVL2(NULLIF(PROD_COST, PROD_SALE),'정상상품','단종상품');

ROLLBACK;
--롤백은 컬럼은 안 없어진다

ALTER TABLE PROD
DROP COLUMN REMARK;
ROLLBACK;

DELETE : 테이블에서 데이터를 행 단위로 삭제
DROP : 테이블의 형식과 모든 데이터 삭제
TRUNCATE - 테이블의 모든 데이터만 삭제

4) IS NULL, IS NOT NULL
    -특정 컬럼에 저장된 값이 NULL인지 판단할 때 '='연산자는 사용할 수 없음
    
사용예) 사원테이블에서 영업실적이 NULL이 아닌 사원을 조회하시오
        ALIAS는 사원번호, 사원명, 영업실적, 부서코드
        
        SELECT  EMPLOYEE_ID 사원번호, EMP_NAME 사원명, COMMISSION_PCT 영업실적, DEPARTMENT_ID 부서코드
        FROM    EMPLOYEES
        WHERE   COMMISSION_PCT IS NOT NULL
                AND DEPARTMENT_ID IS NOT NULL;
                
                
                