2021-0910-01
프로시져 실행형식)

EXECUTE|EXEC 프로시져명[(매개변수 LIST)]; -- 독립실행

OR
    프로시져명[(매개변수 LIST)]; --익명블록이나 한수또는 다른 프로시져, 아웃매개변수를 이용할때
--독립실행시에는 EXECUTE를 써야되는데 다른곳에 사용될 때는 안쓴다.

사용예) 회원번호를 입력받아 해당회원의 2005년도 구매금액과 구매수량을 조회하는 프로시져를 작성하시오.
--프로시져를 만들때 고려해야될것은 매개변수를 무엇으로 할것이고 몇개를 만들지
CREATE OR REPLACE PROCEDURE PROC_CART_QTY(
    P_MID IN MEMBER.MEM_ID%TYPE)
IS
    V_QTY NUMBER:=0;
    V_SUM NUMBER:=0;
    V_RES VARCHAR2(100);
BEGIN
    SELECT  SUM(CART_QTY), SUM(CART_QTY*PROD_PRICE)
    INTO    V_QTY, V_SUM
    FROM    CART, PROD
    WHERE   CART_PROD=PROD_ID
    AND     CART_NO LIKE '2005%'
    AND     CART_MEMBER = P_MID;
    
    V_RES:='회원번호:'||P_MID||', '||'구매수량'||V_QTY||','||'구매금액'||V_SUM;
    
    DBMS_OUTPUT.PUT_LINE(V_RES);
    
END;

(실행)-개인별
EXECUTE PROC_CART_QTY('c001');
-------------------------
(모든 회원의 구매 실적)
DECLARE 
BEGIN
    FOR REC IN (SELECT MEM_ID FROM MEMBER)
    LOOP
        PROC_CART_QTY(REC.MEM_ID);
    END LOOP;       
END;
--셀렉트 문에서 복수개의 결과가 나왔을때 하나씩 처리하기 위해 사용하는 것이 커서이다.

사용예)10-110 사이의 부서번호를 입력받아 부서명과 해당부서의 평균 급여를 반환하는 프로시져를 작성하시오.
--매개변수를 이용해서 프로시져의 데이터를 밖으로 가지고 나올 수 있다.\

CREATE OR REPLACE PROCEDURE PROC_EMP_DEPT(P_DID IN HR.EMPLOYEES.DEPARTMENT_ID%TYPE, 
                                          P_DNAME OUT HR.DEPARTMENTS.DEPARTMENT_NAME%TYPE, 
                                          P_ASAL OUT NUMBER)
IS

BEGIN
    SELECT  AVG(SALARY) INTO P_ASAL
    FROM    HR.EMPLOYEES
    WHERE   DEPARTMENT_ID=P_DID;
    
    SELECT  DEPARTMENT_NAME INTO P_DNAME
    FROM    HR.DEPARTMENTS
    WHERE   DEPARTMENT_ID=P_DID;
    
END;

(실행)
DECLARE     
    V_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE; --변수는 DECLARE 선언 영역에 선언
    V_ASAL NUMBER(10):=0;
BEGIN
    PROC_EMP_DEPT(30,V_NAME,V_ASAL);
    DBMS_OUTPUT.PUT_LINE('부서코드'||30);
    DBMS_OUTPUT.PUT_LINE('부서명'||V_NAME);
    DBMS_OUTPUT.PUT_LINE('평균급여'||V_ASAL);
END;
------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PROC_EMP_DEPT(P_DID IN EMPLOYEES.DEPARTMENT_ID%TYPE, 
                                          P_DNAME OUT DEPARTMENTS.DEPARTMENT_NAME%TYPE, 
                                          P_ASAL OUT NUMBER)
IS

BEGIN
    SELECT  AVG(SALARY) --INTO P_ASAL
    FROM    hr.EMPLOYEES
    WHERE   DEPARTMENT_ID=30--P_DID;
    
    SELECT  DEPARTMENT_NAME INTO P_DNAME
    FROM    DEPARTMENTS
    WHERE   DEPARTMENT_ID=P_DID;
    
END;
-------------------------------------------------------------------------------
사용예) 년도와 월을 입력 받아 해당기간 동안 매입정보를 집계하여/ 매입수량합계와 매입금액을 반환받는 프로시져와 실행 코드를 작성하시오.
년도와 월을 입력받고 매입정보
매입수량, 매입금액 반화

CREATE OR REPLACE PROCEDURE PROC_BUYPROD_01 (P_BUY_DATE_YEAR IN BUYPROD.BUY_DATE%TYPE, 
                                             P_BUY_DATE_MONTH IN BUYPROD.BUY_DATE%TYPE, 
                                             P_BUY_QTY OUT BUYPROD.BUY_QTY%TYPE,
                                             P_BUY_COST OUT BUYPROD.BUY_COST%TYPE)
IS

BEGIN
    
    SELECT  SUM(BUY_QTY) INTO P_BUY_QTY
    FROM    BUYPROD
    WHERE   EXTRACT(YEAR FROM BUY_DATE)=EXTRACT(YEAR FROM P_BUY_DATE_YEAR)
    AND     EXTRACT(MONTH FROM BUY_DATE)=EXTRACT(MONTH FROM P_BUY_DATE_YEAR);
    
    SELECT  SUM(BUY_QTY*BUY_COST) INTO P_BUY_COST
    FROM    BUYPROD
    WHERE   EXTRACT(YEAR FROM BUY_DATE)=EXTRACT(YEAR FROM P_BUY_DATE_YEAR)
    AND     EXTRACT(MONTH FROM BUY_DATE)=EXTRACT(MONTH FROM P_BUY_DATE_YEAR);
    
END;

(실행)
DECLARE     
    V_SQTY BUYPROD.BUY_QTY%TYPE; --변수는 DECLARE 선언 영역에 선언
    V_SCOST BUYPROD.BUY_COST%TYPE;
BEGIN
    PROC_BUYPROD('20050401','20050401',V_SQTY,V_SCOST);
    
    DBMS_OUTPUT.PUT_LINE('년월: '||'2005/04');
    DBMS_OUTPUT.PUT_LINE('매입수량:'||V_SQTY);
    DBMS_OUTPUT.PUT_LINE('매입금액:'||V_SCOST);
END;
-----------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PROC_BUYPROD (P_BUY_DATE IN BUYPROD.BUY_DATE%TYPE, 
                                          P_BUY_QTY OUT BUYPROD.BUY_QTY%TYPE,
                                          P_BUY_COST OUT BUYPROD.BUY_COST%TYPE)
IS

BEGIN
    
    SELECT  SUM(BUY_QTY) INTO P_BUY_QTY
    FROM    BUYPROD
    WHERE   TO_CHAR(BUY_DATE, 'YYYYMM')=TO_CHAR(P_BUY_DATE, 'YYYYMM');
    
    SELECT  SUM(BUY_QTY*BUY_COST) INTO P_BUY_COST
    FROM    BUYPROD
    WHERE   TO_CHAR(BUY_DATE, 'YYYYMM')=TO_CHAR(P_BUY_DATE, 'YYYYMM');
    
END;

(실행)
DECLARE     
    V_SQTY BUYPROD.BUY_QTY%TYPE; --변수는 DECLARE 선언 영역에 선언
    V_SCOST BUYPROD.BUY_COST%TYPE;
BEGIN
    PROC_BUYPROD('20050601',V_SQTY,V_SCOST);
    
    DBMS_OUTPUT.PUT_LINE('년월: '||'2005/05');
    DBMS_OUTPUT.PUT_LINE('매입수량:'||V_SQTY);
    DBMS_OUTPUT.PUT_LINE('매입금액:'||V_SCOST);
END;
----------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PROC_BUYPROD_01 (P_BUY_DATE IN BUYPROD.BUY_DATE%TYPE, 
                                             P_BUY_QTY OUT BUYPROD.BUY_QTY%TYPE,
                                             P_BUY_COST OUT BUYPROD.BUY_COST%TYPE)
IS

BEGIN
    
    SELECT  SUM(BUY_QTY) INTO P_BUY_QTY
    FROM    BUYPROD
    WHERE   EXTRACT(YEAR FROM BUY_DATE)=EXTRACT(YEAR FROM P_BUY_DATE)
    AND     EXTRACT(MONTH FROM BUY_DATE)=EXTRACT(MONTH FROM P_BUY_DATE);
    
    SELECT  SUM(BUY_QTY*BUY_COST) INTO P_BUY_COST
    FROM    BUYPROD
    WHERE   EXTRACT(YEAR FROM BUY_DATE)=EXTRACT(YEAR FROM P_BUY_DATE)
    AND     EXTRACT(MONTH FROM BUY_DATE)=EXTRACT(MONTH FROM P_BUY_DATE);
    
END;

(실행)
DECLARE     
    V_SQTY BUYPROD.BUY_QTY%TYPE:=0; --변수는 DECLARE 선언 영역에 선언
    V_SCOST BUYPROD.BUY_COST%TYPE:=0;
BEGIN
    PROC_BUYPROD('20050401',V_SQTY,V_SCOST);
    
    DBMS_OUTPUT.PUT_LINE('년월: '||'2005/04');
    DBMS_OUTPUT.PUT_LINE('매입수량:'||V_SQTY);
    DBMS_OUTPUT.PUT_LINE('매입금액:'||V_SCOST);
END;
-------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PROC_MON_BUY(
P_PERIOD IN VARCHAR2,
P_QTY OUT NUMBER,
P_SUM OUT NUMBER)
IS--DECLARE
V_SDATE DATE:=TO_DATE(P_PERIOD||'01');
V_EDATE DATE:=LAST_DAY(V_SDATE);
BEGIN
    SELECT SUM(BUY_QTY), SUM(BUY_QTY*BUY_COST) INTO P_QTY, P_SUM
    FROM BUYPROD
    WHERE   BUY_DATE BETWEEN V_SDATE AND V_EDATE;
END;
실행)
DECLARE 
    V_QTY NUMBER:=0;
    V_SUM NUMBER:=0;
BEGIN
    PROC_MON_BUY('200503',V_QTY,V_SUM);
    
    DBMS_OUTPUT.PUT_LINE('매입기간: 2005년 3월');
    DBMS_OUTPUT.PUT_LINE('매입수량:'||V_QTY);
    DBMS_OUTPUT.PUT_LINE('매입금액:'||V_SUM);
END;

2021-0901-02) USER DEFINED FUNCTION(FUNCTION)
- 반환 값이 존재(함수명을 통하여 값을 반환)
- 자주 반복 사용하는 서브쿼리나 복잡한 계산식 등을 미리 만들어 내장함수처럼 사용
- SELECT 문에서 사용 가능
(사용형식)
CREATE[OR REPLACE] FUNCTION 함수명 [(
컬럼명 [MODE] 타입명 [:=|DEFAULT 값][,]
        :
컬럼명 [MODE] 타입명 [:=|DEFAULT 값])--타입명 뒤에 크기 지정하면 안된다.

RETURN 타입명 --리턴되는 데이터 타입명만 지정해주는것이고 실제 데이터가 반환되는 것은 BEGIN-END부분이다.
IS|AS
선언부
BEGIN
실행부
:
RETURN EXPR;
[EXCEPTION 
    예외처리부;
]
END;
--함수는 한번에 하나의 데이터만 반환할수 있어서 밑에 문제 같은 경우에는 두개의 함수가 필요하다.
사용예) 회원번호를 입력받아 2005년 5월 회원의 구매내역을 집계하여 출력하시오
ALIAS는 회원번호, 회원명, 구매수량, 구매금액
(구매수량집계) 
    CREATE OR REPLACE FUNCTION FN_CART_QTY(
    P_MID IN MEMBER.MEM_ID%TYPE)
    
    RETURN NUMBER
    
    IS
        V_QTY NUMBER:=0;
    BEGIN
        SELECT  SUM(CART_QTY) INTO V_QTY
        FROM    CART
        WHERE   CART_MEMBER=P_MID
        AND     CART_NO LIKE '200505%';
    RETURN V_QTY;
    END;

(구매금액집계) 
    CREATE OR REPLACE FUNCTION FN_CART_SUM(
    P_MID IN MEMBER.MEM_ID%TYPE)
    
    RETURN NUMBER
    
    IS
        V_SUM NUMBER:=0;
    BEGIN
        SELECT  SUM(CART_QTY*PROD_PRICE) INTO V_SUM
        FROM    CART, PROD
        WHERE   CART_MEMBER=P_MID
        AND     CART_PROD=PROD_ID
        AND     CART_NO LIKE '200505%';
    RETURN V_SUM;
    END;
    
(실행)
SELECT  MEM_ID AS 회원번호,
        MEM_NAME AS 회원명,
        NVL(FN_CART_QTY(MEM_ID),0) AS 구매수량,
        NVL(FN_CART_QTY(MEM_ID),0) AS 구매금액
FROM    MEMBER;

사용예) 2005년 5월 제품별 입고수량과 출고수량을 구하는 함수를 작성하고 그 값을 이용하여 재고 수불테이블을 갱신하시오.
갱신일자는 5월 31일이다.
UPDATE REMAIN A
SET (A.REAIN_I, A.REMAIN_O, A.REAMIN_99, REAMIN_J_DATE)=
    (SELECT A.REAIN_I+NVL(입고,0), A.REMAIN_O+NVL(출고,0), A.REAMIN_99+NVL(입고,0)-NVL(출고,0), TO_DATE('20050531')
     FROM PROD B
     WHERE B.PROD_ID=A.PROD_ID)
WHERE A.YEAR = '2005';

FN_PROD_ID, FN_CART_ID
(입고수량)
    CREATE OR REPLACE FUNCTION FN_PROD_ID(
    P_ID IN BUYPROD.BUY_DATE%TYPE)
    
    RETURN NUMBER
    
    IS
        V_PSUM NUMBER:=0;
    BEGIN
        SELECT  SUM(BUY_QTY) INTO V_PSUM
        FROM    BUYPROD
        WHERE   BUY_PROD=P_ID
        AND     BUY_DATE BETWEEN '20050501' AND '20050531';
    RETURN V_PSUM;
    END;
(출고수량)
    CREATE OR REPLACE FUNCTION FN_CART_ID(
    C_ID IN CART.CART_NO%TYPE)
    
    RETURN NUMBER
    
    IS
        V_CSUM NUMBER:=0;
    BEGIN
        SELECT  SUM(A.CART_QTY) INTO V_CSUM
        FROM    CART A, PROD B
        WHERE   A.CART_PROD = B.PROD_ID
        AND     A.CART_NO LIKE '200505%';
    RETURN V_CSUM;
    END;
(쿼리)
FN_PROD_ID, FN_CART_ID
UPDATE REMAIN A
SET (A.REAIN_I, A.REMAIN_O, A.REAMIN_99, REAMIN_J_DATE)=
    (SELECT A.REAIN_I+NVL(FN_PROD_ID,0), A.REMAIN_O+NVL(FN_CART_ID,0), A.REAMIN_99+NVL(FN_PROD_ID,0)-NVL(FN_CART_ID,0), TO_DATE('20050531')
     FROM PROD B
     WHERE B.PROD_ID=A.PROD_ID)
WHERE A.YEAR = '2005';



