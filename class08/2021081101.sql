2021-08-11-01)
사용예) 상품테이블을 생성하시오
    1)상품테이블명 : TBL_GOODS
    2)컬럼명
-----------------------------------------------------    
    컬럼명     데이터타입       N.N     제약사항
----------------------------------------------------- 
    G_ID      CHAR(5)       N.N     PK
    G_NAME    VARCHAR2(30)
    G_PRICE   NUMBER(6)             DEFAULT 0
-----------------------------------------------------

    CREATE TABLE TBL_GOODS(
    G_ID CHAR(5) NOT NULL,
    G_NAME VARCHAR2(30),
    G_PRICE NUMBER(6) DEFAULT 0,
    
    CONSTRAINT pk_TBL_GOODS PRIMARY KEY(G_ID));

사용예) 상품테이블을 생성하시오
    1)상품테이블명 : TBL_CUSTS
    2)컬럼명
-----------------------------------------------------    
    컬럼명     데이터타입       N.N     제약사항
----------------------------------------------------- 
    C_ID      CHAR(3)                  PK
    C_NAME    VARCHAR2(30)   n.n
    C_TEL   NUMBER(20)             
    C_ADDR    VARCHAR2(80)
-----------------------------------------------------
    CREATE TABLE TBL_CUSTS(
    C_ID CHAR(3),
    C_NAME VARCHAR2(30) NOT NULL,
    C_TEL NUMBER(20),
    C_ADDR VARCHAR2(80),
    
    CONSTRAINT pk_TBL_CUSTS PRIMARY KEY(C_ID));
    
사용예) 상품테이블을 생성하시오
    1)상품테이블명 : TBL_ORDERS
    2)컬럼명
-----------------------------------------------------    
    컬럼명     데이터타입       N.N     제약사항
----------------------------------------------------- 
    OR_ID   NUMBER(12)                  PK
    C_ID    CHAR(3)                     FK
    OR_DATE DATE                        DEFAULT SYSDATE            
    OR_AMT  NUMBER(8)
-----------------------------------------------------

    CREATE TABLE TBL_ORDERS(
    OR_ID   NUMBER(12),
    C_ID    CHAR(3),
    OR_DATE DATE DEFAULT SYSDATE,
    OR_AMT  NUMBER(8),
    
    CONSTRAINT pk_TBL_ORDERS PRIMARY KEY(OR_ID),
    CONSTRAINT fk_orders_custs FOREIGN KEY(C_ID)
        REFERENCES TBL_CUSTS(C_ID));
        
사용예) 상품테이블을 생성하시오
    1)상품테이블명 : TBL_ORDERS_GOODS
    2)컬럼명
-----------------------------------------------------    
    컬럼명     데이터타입       N.N     제약사항
----------------------------------------------------- 
     G_ID       CHAR(5)                 PK/FK
     OR_ID      NUMBER(12)              PK/FK
     G_QTY      NUMBER(3)
-----------------------------------------------------

    CREATE TABLE TBL_ORDERS_GOODS(
        G_ID CHAR(5),
        OR_ID NUMBER(12),
        G_QTY NUMBER(3),
        
            CONSTRAINT pk_ORDERS_GOODS PRIMARY KEY(G_ID,OR_ID),
            CONSTRAINT fk_OG_GOODS FOREIGN KEY(G_ID)
                REFERENCES TBL_GOODS(G_ID),
            CONSTRAINT fk_OG_ORDERS FOREIGN KEY(OR_ID)
                REFERENCES TBL_ORDERS(OR_ID));
        
**컬럼명 변경
    ALTER TABLE 테이블명
        RENAME COLUMN 원래컬럼명 TO 바꿀컬럼명;
        
사용예) 주문테이블의 주문번호 컬럼 'GR_ID'로 기술한 것을 'OR_ID'로 바꿀려면
    ALTER TABLE TBL_ORDERS
        RENAME COLUMN 'GR_ID' TO 'OR_ID';
        
**컬럼 수정(데이타 타입 또는 크기 수정)
    ALTER TABLE 테이블명
        MODIFY(컬럼명 데이터타입[(크기)];
사용예) 주문테이블에서 주문번호를 NUMBER(12)에서 CHAR(12)로 바꾸시오
    ALTER TABLE TBL_ORDERS_GOODS
        MODIFY(OR_ID CHAR(12));--기본키이면서 외래키이기 때문에 변경되지 않음, 참조되고 있기 때문이다.
                               --기본키이면 바꿀수 있다
사용예) 주문테이블에서 수량을 NUMBER(3)에서 NUMBER(5)로 바꾸시오
    ALTER TABLE TBL_ORDERS_GOODS
        MODIFY(G_QTY NUMBER(5));
        
** 테이블명 수정
ALTER TABLE 원본테이블 RENAME TO 바꿀 테이블명;

예) TBL_ORSER이라는 테이블을 TBL_ORDER로 바꿀려면
    ALTER TABLE TBL_ORSER RENAME TO TBL_ORDER;--
    
