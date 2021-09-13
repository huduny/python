2021-09-13-01

(�԰����)
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
2021-0913-01)Ʈ����(TRIGGER)
- ������ �̺�Ʈ�� �߻��Ǿ��� �� �ٸ� ���̺��� �ڵ� ����ǵ��� �ϴ� ��� �Ǵ� ���ν���
(�������)
CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
BEFORE | AFTER      INSERT|UPDATE|DELETE -- �̺�Ʈ��� �Ѵ�, �̺�Ʈ���� OR�� ����� �� �ֵ�.
ON ���̺�� 
[FOR EACH ROW] -- ��κ��� Ʈ���Ŵ� FOR EACH ROW�̴�. ������ �� �ִ�. �����߿� Ʈ���Ű� �߻��ϸ� ROCK�� �ɸ� �� �ִ�.
[WHEN ����] -- FOR EACH ROW �϶��� ����� �� �ִ�. FOR EACH ROW�� WHEN ������ ������ ������� TRIGER�̴�.
[DECLARE] --Ŀ���� �ʿ������ �Ⱦ���.
BEGIN -- IS AS �� ������ ���� DECLARE�� BEGIN ���̿� ���� ����� �����Ѵ�.
Ʈ���� ����;
END;
. 'BEFORE | AFTER' : TIMMING���� Ʈ���� ������ ����� �ð�
  �� �̺�Ʈ�� 'INSERT,UPDATE,DELETE' �� ��� �ϳ��� �߻��Ǳ� ���� Ʈ���� ������ ����Ǿ�� �ϸ� 'BEFORE',
  �߻� �Ŀ� Ʈ���� ������ ����Ǿ�� �ϸ� 'AFTER'�� ��� 
. 'INSERT,UPDATE,DELETE' : Ʈ���Ÿ� �߻���Ű�� �̺�Ʈ�� OR�� ���� ����
. 'FOR EACH ROW': �ش��� Ʈ����(����� ��� �ึ�� Ʈ���� ����)
   �����Ǹ� ��������� Ʈ����(�� �̺�Ʈ���� �ѹ��� Ʈ���� ����)��
. 'WHERE ����': ����� Ʈ���ſ����� ��� �����ϸ�, �̺�Ʈ�� ������ ���̺� �̺�Ʈ �߻��� ���� ��ü�� ������ ��� 
    
��뿹) ������� Ʈ���� 
��ǰ�з����̺��� ����(LPROD_ID)�� 10-12���� �з������� �����Ͻÿ� ���� �� '�з��ڵ尡 �����Ǿ����ϴ�'��� Ʈ���Ÿ� �ۼ��Ͻÿ�
--������ AFTER, �̺�Ʈ-���� �з����� ����, ����-'�з��ڵ尡 �����Ǿ����ϴ�', �ѹ��� ������ �����ϱ� ������� Ʈ�����̴�.
CREATE OR REPLACE TRIGGER TG_DEL_LPROD
    AFTER DELETE ON LPROD
BEGIN DBMS_OUTPUT.PUT_LINE('�з��ڵ尡 ���� �Ǿ����ϴ�');
END;

    
DELETE LPROD
WHERE LPROD_ID >=10; --�̷��� �ϸ� Ʈ���� ������ �ȳ��´�. ������ �ƴ��� Ʈ���Ű� ���� SELECT���� ������ش�.
SELECT * FROM LPROD;  

ROLLBACK;
    
CREATE OR REPLACE TRIGGER TG_DEL_LPROD
    AFTER INSERT ON LPROD
BEGIN DBMS_OUTPUT.PUT_LINE('�з��ڵ尡 �߰� �Ǿ����ϴ�');
END;

INSERT INTO LPROD VALUES(15, 'P505', '�⵿���');

SELECT * FROM LPROD;
--------------------------------------------------------------------------------------------------------------------------------    
2) ����� Ʈ����
- ��� �ึ�� Ʈ���� �߻�
��뿹) ���� ������('R001')ȸ����
        ��ǰ��ȣ 'P201000019' ��ǰ�� 5��,
                'P302000006' ��ǰ 10��,
                'P302000023'�� 4�� ���������� �̸� CART���̺� �����ϰ� ��� �����Ͻÿ�.

CART ���̺� ������ ����
1.īƮ��ȣ ���� �Լ�
;
/
--P_MID : in���ε庯��
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
    WHERE CART_NO LIKE V_DATE;*/ -- ���� ��¥�� �α����� ȸ���� ��
    --CART_NO LIKE '20050728%'
    --���� ȸ���� ���� ���� �� �ƽ���+1
    SELECT MAX(CART_NO)+1 INTO V_CART_NO
    FROM CART
    WHERE CART_NO LIKE V_DATE
    AND   CART_MEMBER = P_MID;
    
    --���� ȸ���� ���� �Ⱥ��� �� �ƽ���
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
--1. �� ����� ������ ����
SELECT CART_MEMBER --INTO MEM1
FROM CART
WHERE CART_NO = (SELECT MAX(CART_NO) FROM CART);
    
--2. 
���� MEM1�� MEM2�� ������ CART_NO�� �״��

���� �ٸ��� 1 ����
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
    