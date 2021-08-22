2021081102)DML (DATA MANIPULATION LANGUAGE)
-INSERT, UPDATE, DELETE
1) INSERT 
    - 새로운 자료를 테이블에 저장(테이블을 생성한 순선대로 넣어야 된다.)
    - 입력순서는 테이블 생성순과 같음
        (사용형식)
        INSERT INTO 테이블명 [(컬럼명1,컬럼명2,...)]
            VALUES(값1,값2....);
        * 테이블명: 대상 테이블명
        * 컬럼명: 자료를 입력할 컬럼명
          생략가능하며 모든 컬럼명이 생략되면 컬럼이 기술된 순서와 갯수에 맞게 VALUES절에서 값이 기술된어야 한다.
        * 컬럼명: 컬럼명 중 일부가 생략될 수 있음
          컬럼명이 기술되면 기술된 순서와 갯수에 맞게 VALUES절에서 값이 기술되어야 한다.(단, 컬럼생성시 NOT NULL로 기술된 컬럼은 생략 불가능)
        
사용예) TBL_GOODS테이블에 다음 자료를 입력하시오.
-------------------------------------------
상품코드        상품명     가격
P1001         신라면      1200
P1002         진라면      1000
P1101         양조식초    15000
P1102         
-------------------------------------------
INSERT INTO TBL_GOODS
    VALUES('P1001', '신라면', 1200);
INSERT INTO TBL_GOODS
    VALUES('P1002', '진라면', 1000);  
INSERT INTO TBL_GOODS(G_PRICE, G_NAME, G_ID)
    VALUES(15000,'양조식초','P1101');  
INSERT INTO TBL_GOODS(G_ID,G_NAME)
    VALUES('P1012', '진짜라면');  
INSERT INTO TBL_GOODS(G_ID)
    VALUES('P1102'); 
    SELECT * FROM TBL_GOODS;

사용예) 고객테이블에 다음 자료를 입력하시오.
-------------------------------------------    
고객번호    고객명     전화번호    주소
'A01'       '홍길동'    042-222-8202  '대전시 중구 대흥동 500
'B01'       '홍길순'           
'B02'       '박디비'                  '서울시 성북구 장위동 400
-------------------------------------------
INSERT INTO TBL_CUSTS
    VALUES('A01','홍길동',042-222-8202,'대전시 중구 대흥동 500');

INSERT INTO TBL_CUSTS
    VALUES('B01','홍길순','','대전시 중구 대흥동 500');
    
INSERT INTO TBL_CUSTS
    VALUES('C01','홍길자','','');

INSERT INTO TBL_CUSTS
    VALUES('D01','홍길자',213243525,'');   

INSERT INTO TBL_CUSTS
    VALUES('E01','ASDA',NULL,'');   
    
    SELECT * FROM TBL_CUSTS;

사용예)'BO1'고객이 오늘 'P1001' 상품을 5개, 'P1101'상품을 2개 구입한 경우 주문테이블에 해당 정보를 저장하시오.
주문번호는 날짜8자리와 차례대로 부여하는 번호 4자리로 구성
SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||'0001'
FROM DUAL;

--문제 시작
INSERT INTO TBL_ORDERS(OR_ID,C_ID,OR_DATE)
    VALUES(TO_CHAR(SYSDATE,'YYYYMMDD')||'0001','B01',SYSDATE);
    
INSERT INTO TBL_ORDERS_GOODS
    VALUES('P1002',TO_CHAR(SYSDATE,'YYYYMMDD')||'0001',2);
---금액합계를 TBL_ORDERS의 금액컬럼에 저장
UPDATE TBL_ORDERS C
SET C.OR_AMT=(SELECT SUM(G_OTY*G_PRICE)
                FROM TBL_GOODS A,TBL_ORDERS_GOODS B
                WHERE B.OR_ID=TO_CHAR(SYSDATE,'YYYYMMDD')||'0001'
                AND A.G_ID=B.G_ID)
WHERE C.OR_ID=TO_CHAR(SYSDATE,'YYYYMMDD')||'0001';
