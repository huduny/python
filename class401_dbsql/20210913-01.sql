2021-09-13-01

(입고수량)
    CREATE OR REPLACE FUNCTION FN_BUYPROD_QTY(
    P_YEAR IN VARCHAR2(4),
    P_MON IN VARCHAR2(4),
    P_PROD IN PROD.PROD_ID%TYPE) 
    RETURN NUMBER
    
    IS
        V_SDATE DATE:= TO_DATE(P_YEAR||P_MON||'01') NUMBER:=0;
        V_EDATE DATE:= LAST_DATE(V_SDATE);
        V_AMT NUMBER:= 0;
        
    BEGIN
        SELECT  NVL(SUM(BUY_QTY),0) INTO V_PSUM
        FROM    BUYPROD A
        WHERE   BUY_PROD=P_ID
        AND     BUY_DATE BETWEEN '20050501' AND '20050531';
    RETURN V_PSUM;
    END;
--------------------------------------------------------------------------------------------------------------------------------  
    CREATE OR REPLACE FUNCTION FN_BUYPROD_QTY(
    P_PERIOD IN VARCHAR2,
    P_PROD IN PROD.PROD_ID%TYPE) 
    RETURN NUMBER
    
    IS
        V_SDATE DATE:=TO_DATE(P_PERIOD||'01');
        V_EDATE DATE:=LAST_DAY(V_SDATE);
        V_AMT NUMBER:=0;
        
    BEGIN
        SELECT  NVL(SUM(BUY_QTY),0) INTO V_AMT
        FROM    BUYPROD
        WHERE   BUY_PROD=P_PROD
        AND     BUY_DATE BETWEEN V_SDATE AND V_EDATE;
    RETURN V_AMT;
    END;    
    
--------------------------------------------------------------------------------------------------------------------------------
UPDATE REMAIN A
SET (A.REMAIN_I, A.REMAIN_O, A.REMAIN_99, A.REMAIN_J_DATE)=
    (SELECT A.REMAIN_I+NVL(FN_BUYPROD_QTY('200505',B.PROD_ID),0), A.REMAIN_O+NVL(FN_CART_QTY('200505',B.PROD_ID),0), A.REMAIN_99+NVL(FN_BUYPROD_QTY('200505',B.PROD_ID),0)-NVL(FN_CART_QTY('200505',B.PROD_ID),0), TO_DATE('20050531')
     FROM PROD B
     WHERE B.PROD_ID=A.PROD_ID)
WHERE A.REMAIN_YEAR = '200505';   
--------------------------------------------------------------------------------------------------------------------------------
    CREATE OR REPLACE FUNCTION FN_CART_QTY(
    P_PERIOD IN VARCHAR2,
    P_PROD IN PROD.PROD_ID%TYPE) 
    RETURN NUMBER
    
    IS
        V_DATE CHAR(7):= P_PERIOD||'%';
        V_AMT NUMBER:= 0;
        
    BEGIN
        SELECT  NVL(SUM(CART_QTY),0) INTO V_AMT
        FROM    CART
        WHERE   CART_PROD=P_PROD
        AND     CART_NO LIKE V_DATE;
    RETURN V_AMT;
    END;    
--------------------------------------------------------------------------------------------------------------------------------  
2021-0913-01)트리거(TRIGGER)
- 임이의 이벤트가 발생되었을 때 다른 테이블이 자동 변경되도록 하는 모듈 또는 프로시져
(사용형식)
CREATE [OR REPLACE] TRIGGER 트리거명
BEFORE | AFTER      INSERT|UPDATE|DELETE -- 이벤트라고 한다, 이벤트들은 OR로 연결될 수 있따.
ON 테이블명 
[FOR EACH ROW] -- 대부분의 트리거는 FOR EACH ROW이다. 위험할 수 있다. 변경중에 트리거가 발생하면 ROCK이 걸릴 수 있다.
[WHEN 조건] -- FOR EACH ROW 일때만 사용할 수 있다. FOR EACH ROW와 WHEN 조건이 없으면 문장단위 TRIGER이다.
[DECLARE] --커서가 필요없으면 안쓴다.
BEGIN -- IS AS 를 쓸수는 없고 DECLARE와 BEGIN 사이에 변수 상수를 선언한다.
트리거 내용;
END;
. 'BEFORE | AFTER' : TIMMING으로 트리거 내용이 수행될 시간
  즉 이벤트인 'INSERT,UPDATE,DELETE' 중 어느 하나가 발생되기 전에 트리거 내용이 수행되어야 하면 'BEFORE',
  발생 후에 트리거 내용이 수행되어야 하면 'AFTER'를 기술 
. 'INSERT,UPDATE,DELETE' : 트리거를 발생시키는 이벤트로 OR로 연결 가능
. 'FOR EACH ROW': 해단위 트리거(결과의 모든 행마다 트리거 수행)
   생략되면 문장단위가 트리거(한 이벤트마다 한번만 트리거 수행)됨
. 'WHERE 조건': 행단위 트리거에서만 사용 가능하며, 이벤트에 설정된 테이블에 이벤트 발생에 대한 구체적 조건을 명시 
    
사용예) 문장단위 트리거 
제품분류테이블에서 순번(LPROD_ID)이 10-12번인 분류정보를 삭제하시오 삭제 후 '분류코드가 삭제되었습니다'라는 트리거를 작성하시오
--삭제후 AFTER, 이벤트-순번 분류정보 삭제, 본문-'분류코드가 삭제되었습니다', 한번만 본문이 나오니깐 문장단위 트리거이다.
CREATE OR REPLACE TRIGGER TG_DEL_LPROD
    AFTER DELETE ON LPROD
BEGIN DBMS_OUTPUT.PUT_LINE('분류코드가 삭제 되었습니다');
END;

    
DELETE LPROD
WHERE LPROD_ID >=10; --이렇게 하면 트리거 내용이 안나온다. 끝인지 아닌지 트리거가 몰라서 SELECT문을 기술해준다.
SELECT * FROM LPROD;  

ROLLBACK;
    
CREATE OR REPLACE TRIGGER TG_DEL_LPROD
    AFTER INSERT ON LPROD
BEGIN DBMS_OUTPUT.PUT_LINE('분류코드가 추가 되었습니다');
END;

INSERT INTO LPROD VALUES(15, 'P505', '잡동사니');

SELECT * FROM LPROD;
--------------------------------------------------------------------------------------------------------------------------------    
2) 행단위 트리거
- 결과 행마다 트리거 발생
사용예) 오늘 성은실('R001')회원이
        제품번호 'P201000019' 제품을 5개,
                'P302000006' 제품 10개,
                'P302000023'을 4개 구매했을때 이를 CART테이블에 저장하고 재고를 조정하시오.

CART 테이블에 데이터 삽입
1.카트번호 생성 함수
;
/
--P_MID : in바인드변수
CREATE OR REPLACE FUNCTION FN_CREATE_CARTNO(
    P_MID IN MEMBER.MEM_ID%TYPE)

RETURN VARCHAR2

IS
    --V_CNT NUMBER:=0;
    V_DATE VARCHAR(9):=TO_CHAR(SYSDATE, 'YYYYMMDD')||'%';
    V_CART_NO CART.CART_NO%TYPE;
    
BEGIN 
    /*SELECT COUNT(*) INTO V_CNT
    FROM CART
    WHERE CART_NO LIKE V_DATE;*/ -- 오늘 날짜에 로그인한 회원의 수
    --CART_NO LIKE '20050728%'
    --오늘 회원이 장을 봤을 땐 맥스값+1
    SELECT MAX(CART_NO)+1 INTO V_CART_NO
    FROM CART
    WHERE CART_NO LIKE V_DATE
    AND   CART_MEMBER = P_MID;
    
    --오늘 회원이 장을 안봤을 땐 맥스값
    SELECT MAX(CART_NO) INTO V_CART_NO
    FROM   CART
    WHERE  CART_NO LIKE V_DATE
    AND   CART_MEMBER != P_MID;   
    
    IF  
        --V_CNT = 0 
        V_CART_NO IS NULL THEN 
        V_CART_NO:=TO_CHAR(SYSDATE, 'YYYYMMDD')||'00001';
    ELSIF 
        V_CART_NO IS NOT NULL THEN 
        V_CART_NO:=TO_CHAR(V_CART_NO+1);
    END IF;

    RETURN V_CART_NO;
    
    END;
--------------------------------------------------------------------------------------------------------------------------------     
    SELECT FN_CREATE_CARTNO('j001') FROM DUAL;
    
INSERT INTO CART 
VALUES ('r001', FN_CREATE_CARTNO, 'P201000019', 5);
INSERT INTO CART 
VALUES ('r001', FN_CREATE_CARTNO, 'P302000006', 10);    
INSERT INTO CART 
VALUES ('r001', FN_CREATE_CARTNO, 'P302000023', 4);    
    
SELECT * FROM CART;    
    
SELECT * FROM REMAIN;
ROLLBACK;
--------------------------------------------------------------------------------------------------------------------------------
SELECT TO_CHAR(CART_NO+1) FROM CART;


    SELECT MAX(CART_NO)+1 --INTO V_CART_NO
    FROM CART
    WHERE CART_NO like '20050728%'--LIKE V_DATE
    AND   CART_MEMBER = 'j001';

    SELECT CART_NO --INTO V_CART_NO
    FROM CART
    WHERE CART_NO like '20050728%'
    and CART_MEMBER = 'j001'

    SELECT CART_NO --INTO V_CART_NO
    FROM CART
    WHERE CART_NO like '20050728%'
    and CART_MEMBER != 'j001';
/
--1. 이 사람을 변수에 넣음
SELECT CART_MEMBER --INTO MEM1
FROM CART
WHERE CART_NO = (SELECT MAX(CART_NO) FROM CART);
    
--2. 
만약 MEM1과 MEM2가 같으면 CART_NO가 그대로

만약 다르면 1 증가
------------------------------
CREATE OR REPLACE FUNCTION FN_CREATE_CARTNO1(
    P_MID IN MEMBER.MEM_ID%TYPE)

RETURN VARCHAR2

IS
    V_DATE VARCHAR(9):=TO_CHAR(SYSDATE, 'YYYYMMDD')||'%';
    V_CART_NO CART.CART_NO%TYPE;
    V_CART_MEM CART.CART_MEMBER%TYPE;
    /*
    CURSOR     CUR_CART_MEMBER IS
    SELECT     CART_MEMBER
    FROM       CART
    WHERE      CART_NO LIKE V_DATE; 
    */
    
BEGIN 
    SELECT  CART_MEMBER INTO V_CART_MEM
    FROM    CART
    WHERE   CART_NO LIKE V_DATE
    AND     CART_NO = (SELECT MAX(CART_NO) FROM CART); 
    /*
    IF  
        V_CART_MEM = P_MID
        THEN 
        V_CART_NO := V_CART_NO;
    ELSIF 
        V_CART_MEM != P_MID-- AND (V_CART_MEM IN (CUR_CART_MEMBER))
        THEN
        V_CART_NO:=TO_CHAR(V_CART_NO+1);
    ELSIF
        V_CART_MEM IS NULL
        THEN
        V_CART_NO:=TO_CHAR(SYSDATE, 'YYYYMMDD')||'00001';
    
    END IF;
    */
    IF  
        V_CART_NO IS NULL THEN 
        V_CART_NO:=TO_CHAR(SYSDATE, 'YYYYMMDD')||'00001';
    ELSIF 
        V_CART_NO IS NOT NULL THEN 
        V_CART_NO:=TO_CHAR(V_CART_NO+1);
    END IF;

    RETURN V_CART_NO;
    
    END;
--------------------------------------------
    SELECT FN_CREATE_CARTNO2('e001') FROM DUAL;
-------------------------------------------------
CREATE OR REPLACE FUNCTION FN_CREATE_CARTNO2(
    P_MID IN MEMBER.MEM_ID%TYPE)

RETURN VARCHAR2

IS
    V_DATE VARCHAR(9):=TO_CHAR(SYSDATE, 'YYYYMMDD')||'%';
    V_CART_NO CART.CART_NO%TYPE;
    V_CART_MEM MEMBER.MEM_ID%TYPE;
    
BEGIN 
    
    SELECT CART_MEMBER INTO V_CART_MEM
    FROM  CART
    WHERE CART_NO = (SELECT MAX(CART_NO) FROM CART WHERE CART_NO LIKE V_DATE)
    AND   CART_NO LIKE V_DATE;
    
    IF V_CART_MEM IS NULL THEN V_CART_NO:=TO_CHAR(SYSDATE, 'YYYYMMDD')||'00001'; 
    END IF;
    
    SELECT CART_NO INTO V_CART_NO
    FROM  CART
    WHERE CART_NO = (SELECT MAX(CART_NO) FROM CART WHERE CART_NO LIKE V_DATE)
    AND   CART_NO LIKE V_DATE;
    
    SELECT MAX(CART_NO) INTO V_CART_NO
    FROM   CART
    WHERE  CART_NO LIKE V_DATE
    AND    CART_MEMBER != P_MID;   

/*
    SELECT max(CART_NO) INTO V_CART_NO
    FROM CART
    WHERE CART_NO LIKE V_DATE
    AND   V_CART_MEM = P_MID;
    
    SELECT max(CART_NO)+1 INTO V_CART_NO
    FROM   CART
    WHERE  CART_NO LIKE V_DATE
    AND   V_CART_MEM != P_MID;   
    */
    IF 
        P_MID != V_CART_MEM THEN
        V_CART_NO:=V_CART_NO;
    ELSIF  
        P_MID = V_CART_MEM THEN
        V_CART_NO:=TO_CHAR(V_CART_NO+1);
    
    END IF;

    RETURN V_CART_NO;
   
    END;    
    
    
    select CART_NO from CART where rownum > 10;
    