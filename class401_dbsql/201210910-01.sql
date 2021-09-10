2021-0910-01
���ν��� ��������)

EXECUTE|EXEC ���ν�����[(�Ű����� LIST)]; -- ��������

OR
    ���ν�����[(�Ű����� LIST)]; --�͸����̳� �Ѽ��Ǵ� �ٸ� ���ν���, �ƿ��Ű������� �̿��Ҷ�
--��������ÿ��� EXECUTE�� ��ߵǴµ� �ٸ����� ���� ���� �Ⱦ���.

��뿹) ȸ����ȣ�� �Է¹޾� �ش�ȸ���� 2005�⵵ ���űݾװ� ���ż����� ��ȸ�ϴ� ���ν����� �ۼ��Ͻÿ�.
--���ν����� ���鶧 ����ؾߵɰ��� �Ű������� �������� �Ұ��̰� ��� ������
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
    
    V_RES:='ȸ����ȣ:'||P_MID||', '||'���ż���'||V_QTY||','||'���űݾ�'||V_SUM;
    
    DBMS_OUTPUT.PUT_LINE(V_RES);
    
END;

(����)-���κ�
EXECUTE PROC_CART_QTY('c001');
-------------------------
(��� ȸ���� ���� ����)
DECLARE 
BEGIN
    FOR REC IN (SELECT MEM_ID FROM MEMBER)
    LOOP
        PROC_CART_QTY(REC.MEM_ID);
    END LOOP;       
END;
--����Ʈ ������ �������� ����� �������� �ϳ��� ó���ϱ� ���� ����ϴ� ���� Ŀ���̴�.

��뿹)10-110 ������ �μ���ȣ�� �Է¹޾� �μ���� �ش�μ��� ��� �޿��� ��ȯ�ϴ� ���ν����� �ۼ��Ͻÿ�.
--�Ű������� �̿��ؼ� ���ν����� �����͸� ������ ������ ���� �� �ִ�.\

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

(����)
DECLARE     
    V_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE; --������ DECLARE ���� ������ ����
    V_ASAL NUMBER(10):=0;
BEGIN
    PROC_EMP_DEPT(30,V_NAME,V_ASAL);
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ�'||30);
    DBMS_OUTPUT.PUT_LINE('�μ���'||V_NAME);
    DBMS_OUTPUT.PUT_LINE('��ձ޿�'||V_ASAL);
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
��뿹) �⵵�� ���� �Է� �޾� �ش�Ⱓ ���� ���������� �����Ͽ�/ ���Լ����հ�� ���Աݾ��� ��ȯ�޴� ���ν����� ���� �ڵ带 �ۼ��Ͻÿ�.
�⵵�� ���� �Է¹ް� ��������
���Լ���, ���Աݾ� ��ȭ

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

(����)
DECLARE     
    V_SQTY BUYPROD.BUY_QTY%TYPE; --������ DECLARE ���� ������ ����
    V_SCOST BUYPROD.BUY_COST%TYPE;
BEGIN
    PROC_BUYPROD('20050401','20050401',V_SQTY,V_SCOST);
    
    DBMS_OUTPUT.PUT_LINE('���: '||'2005/04');
    DBMS_OUTPUT.PUT_LINE('���Լ���:'||V_SQTY);
    DBMS_OUTPUT.PUT_LINE('���Աݾ�:'||V_SCOST);
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

(����)
DECLARE     
    V_SQTY BUYPROD.BUY_QTY%TYPE; --������ DECLARE ���� ������ ����
    V_SCOST BUYPROD.BUY_COST%TYPE;
BEGIN
    PROC_BUYPROD('20050601',V_SQTY,V_SCOST);
    
    DBMS_OUTPUT.PUT_LINE('���: '||'2005/05');
    DBMS_OUTPUT.PUT_LINE('���Լ���:'||V_SQTY);
    DBMS_OUTPUT.PUT_LINE('���Աݾ�:'||V_SCOST);
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

(����)
DECLARE     
    V_SQTY BUYPROD.BUY_QTY%TYPE:=0; --������ DECLARE ���� ������ ����
    V_SCOST BUYPROD.BUY_COST%TYPE:=0;
BEGIN
    PROC_BUYPROD('20050401',V_SQTY,V_SCOST);
    
    DBMS_OUTPUT.PUT_LINE('���: '||'2005/04');
    DBMS_OUTPUT.PUT_LINE('���Լ���:'||V_SQTY);
    DBMS_OUTPUT.PUT_LINE('���Աݾ�:'||V_SCOST);
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
����)
DECLARE 
    V_QTY NUMBER:=0;
    V_SUM NUMBER:=0;
BEGIN
    PROC_MON_BUY('200503',V_QTY,V_SUM);
    
    DBMS_OUTPUT.PUT_LINE('���ԱⰣ: 2005�� 3��');
    DBMS_OUTPUT.PUT_LINE('���Լ���:'||V_QTY);
    DBMS_OUTPUT.PUT_LINE('���Աݾ�:'||V_SUM);
END;

2021-0901-02) USER DEFINED FUNCTION(FUNCTION)
- ��ȯ ���� ����(�Լ����� ���Ͽ� ���� ��ȯ)
- ���� �ݺ� ����ϴ� ���������� ������ ���� ���� �̸� ����� �����Լ�ó�� ���
- SELECT ������ ��� ����
(�������)
CREATE[OR REPLACE] FUNCTION �Լ��� [(
�÷��� [MODE] Ÿ�Ը� [:=|DEFAULT ��][,]
        :
�÷��� [MODE] Ÿ�Ը� [:=|DEFAULT ��])--Ÿ�Ը� �ڿ� ũ�� �����ϸ� �ȵȴ�.

RETURN Ÿ�Ը� --���ϵǴ� ������ Ÿ�Ը� �������ִ°��̰� ���� �����Ͱ� ��ȯ�Ǵ� ���� BEGIN-END�κ��̴�.
IS|AS
�����
BEGIN
�����
:
RETURN EXPR;
[EXCEPTION 
    ����ó����;
]
END;
--�Լ��� �ѹ��� �ϳ��� �����͸� ��ȯ�Ҽ� �־ �ؿ� ���� ���� ��쿡�� �ΰ��� �Լ��� �ʿ��ϴ�.
��뿹) ȸ����ȣ�� �Է¹޾� 2005�� 5�� ȸ���� ���ų����� �����Ͽ� ����Ͻÿ�
ALIAS�� ȸ����ȣ, ȸ����, ���ż���, ���űݾ�
(���ż�������) 
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

(���űݾ�����) 
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
    
(����)
SELECT  MEM_ID AS ȸ����ȣ,
        MEM_NAME AS ȸ����,
        NVL(FN_CART_QTY(MEM_ID),0) AS ���ż���,
        NVL(FN_CART_QTY(MEM_ID),0) AS ���űݾ�
FROM    MEMBER;

��뿹) 2005�� 5�� ��ǰ�� �԰������ �������� ���ϴ� �Լ��� �ۼ��ϰ� �� ���� �̿��Ͽ� ��� �������̺��� �����Ͻÿ�.
�������ڴ� 5�� 31���̴�.
UPDATE REMAIN A
SET (A.REAIN_I, A.REMAIN_O, A.REAMIN_99, REAMIN_J_DATE)=
    (SELECT A.REAIN_I+NVL(�԰�,0), A.REMAIN_O+NVL(���,0), A.REAMIN_99+NVL(�԰�,0)-NVL(���,0), TO_DATE('20050531')
     FROM PROD B
     WHERE B.PROD_ID=A.PROD_ID)
WHERE A.YEAR = '2005';

FN_PROD_ID, FN_CART_ID
(�԰����)
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
(������)
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
(����)
FN_PROD_ID, FN_CART_ID
UPDATE REMAIN A
SET (A.REAIN_I, A.REMAIN_O, A.REAMIN_99, REAMIN_J_DATE)=
    (SELECT A.REAIN_I+NVL(FN_PROD_ID,0), A.REMAIN_O+NVL(FN_CART_ID,0), A.REAMIN_99+NVL(FN_PROD_ID,0)-NVL(FN_CART_ID,0), TO_DATE('20050531')
     FROM PROD B
     WHERE B.PROD_ID=A.PROD_ID)
WHERE A.YEAR = '2005';



