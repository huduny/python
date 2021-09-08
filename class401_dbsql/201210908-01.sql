2021-09-08-01
PL/SQL

-PROCEDUAL LANGUAGE SQL
-ǥ�� SQL�� ������ ����� Ư¡�� ����, �б�, �ݺ�ó���� �������ϴ� ���� ����
-BLOCK ������ ���ÿ� ���� SQL�� ����
-���ȭ, ĸ��ȭ ��� ����
-�͸���,�Լ�,���ν���,Ʈ����,��Ű��,

1. �͸���(ANONYMOUS BLOCK)
-������ ������� �ʰ� ��ũ��Ʈ������ ����Ǵ� ���
-PL/SQL�� �⺻ ����

(����)
DECLARE 
�����(����,���,Ŀ��) --����Ŭ ����� CONSTANT�� �ٿ��ָ� �ȴ�, Ŀ���� SQL�� ����� ���� ������ ���� ����� ���� EX)SELECT���� ����� Ŀ���̰� ���̴�.
                   --����� ������ ���� Ŀ���� CLOSE�ȴ�. �̸��� ��� �׷����̴�. �̸��� ���̸� �ʿ��Ҷ� �ҷ��ü�(����) �ִ�.
BEGIN              --SELECT INTO~FROM �������� ����ؾߵȴ�.
�����
[EXCEPTION         -- �ڹ��� TRY CATCH ����̶� ���
    ����ó����]
    END;
    
��뿹)Ű����� ���� �Է¹޾� �ش���� �¾ ȸ���� �̸�,�������,���ϸ����� ��ȸ�ϴ� �͸����� �ۼ��Ͻÿ�.
    
    ACCEPT P_MON PROMPT '���� �Է�: ' --;�� �� ���δ�
    DECLARE
    V_MON  NUMBER:=0; --:=�̶�� ���̴�.
    V_NAME MEMBER.MEM_NAME%TYPE;--�ش�Ǵ� Ÿ�԰� ���� Ÿ���� ����� ����
    V_BIR  MEMBER.MEM_BIR%TYPE;
    V_MILE MEMBER.MEM_MILEAGE%TYPE;
    BEGIN
    SELECT MEM_NAME, MEM_BIR, MEM_MILEAGE
    INTO V_NAME, V_BIR, V_MILE --�Ϲݺ������� ���� �ϳ� �ۿ� ������ �� �� ����.
    FROM MEMBER
    WHERE EXTRACT(MONTH FROM MEM_BIR)=TO_NUMBER('&P_MON')
    AND ROWNUM=1;--�Է¹��� �� '&~' �����Ѵٴ� ���� ��Ģ�̴�. ���ڿ��� ���ڷ� �ٲ��.
                                                            --SELECT INTO FROM WEHRE ������ �ۼ�, AND ROWNUM=1;�ϸ� 1����; ���.
    DBMS_OUTPUT.PUT_LINE('ȸ����:' || V_NAME);
    DBMS_OUTPUT.PUT_LINE('�������:' || V_BIR);
    DBMS_OUTPUT.PUT_LINE('���� ���ϸ���:' || V_MILE);
    DBMS_OUTPUT.PUT_LINE('--------------------');
    
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('�����߻�:'||SQLERRM);--SYSOUT�� �Ȱ��� ����̴�. ������ �ٹٲ�
    END;

1) ����(���)����
-BEGIN ��Ͽ��� ����� ����(���)����
(��������)
������[CONSTRAINT] ����Ÿ��|Ÿ�Ը�[(ũ��)][:=�ʱⰪ]; --�ʱⰪ�� �����Ҷ������� ���������� �ʱⰪ�� �����Ǹ� ����� �ȴ�. BEGIN����� ����� �����Ҽ� ����.
--�ʱⰪ�� �������� ������ NULL�� �ԷµǼ� �ݵ�� �ʱⰪ�� �־�����.

.����Ÿ��: ǥ�� SQL���� ����ϴ� Ÿ��, BINARY_INTEGER, PLS_INTEGER, BOOLEAN ��밡��
.����Ÿ��: ���̺��.�÷���%TYPE =>�ش� �÷�Ÿ������ ���� --TRUE FALSE NULL�߿� �ϳ��̴�
         ���̺��%ROWTYPE => �� ��Ÿ������ ���� (C����� STRUCTŸ��) --�Ѳ����� �����ϰ� ������ STRUCT���(�ٸ� Ÿ�Ե� ���� ����)
         --STRUCT+�Լ�=Ŭ�����̴�.
2) Ŀ�� ����
- Ŀ���� SQL���� ���� ���� ���� ����� ����
- ������ Ŀ���� ����� Ŀ���� ����
 (1) ������ Ŀ��
 . Ŀ���� �������� ���� SELECT ���� ����� ������ Ŀ��
 . OPEN�� ���ÿ� CLOSE��(Ŀ������� FETCH�� �� ����)--����� ������ �ٷ� CLOSE�ȴ�. CLOSE�Ǹ� Ŀ�� ������ �� �� ����.
 . Ŀ���Ӽ�--SQL�� Ŀ�������� ����.
 ----------------------------------------------------
 �Ӽ�                         �ǹ�
 SQL%ISOPEN            Ŀ���� ���������� TRUE(�׻� FALSE)
 SQL%NOTFOUND          Ŀ���� FETCH�� �ڷᰡ �� �̻� ������ TRUE --�ݺ������� �����͸� ã�ƿö�, ������ ������ üũ�Ҷ� ���
 SQL%FOUND             Ŀ���� FETCH�� �ڷᰡ ������ TRUE
 SQL%ROWCOUNT          Ŀ������ �ڷ� ��(���� ��)--Ŀ������ ���� ������ �ľ�
 -----------------------------------------------------
 (2) ����� Ŀ��
 . Ŀ�� ������ ���� ������ Ŀ��
 . ����ϱ� ���� ����->OPEN->FETCH->CLOSE �Ǿ����
 ----------------------------------------------------
 �Ӽ�                         �ǹ�
 Ŀ����%ISOPEN            Ŀ���� ���������� TRUE(�׻� FALSE)
 Ŀ����%NOTFOUND          Ŀ���� FETCH�� �ڷᰡ �� �̻� ������ TRUE
 Ŀ����%FOUND             Ŀ���� FETCH�� �ڷᰡ ������ TRUE
 Ŀ����%ROWCOUNT          Ŀ������ �ڷ� ��(���� ��)
 ----------------------------------------------------- 
 (Ŀ�� ����)
 
 CURSOR Ŀ����[(������ Ÿ�Ը�,...)] IS
 SELECT ��;
 --(������ Ÿ�Ը�)�� �Ű������̴�.
 --DECLARE ���� ��� Ŀ�� 3���� ����
 
 ��뿹) ���ϸ����� ���� 5���� ȸ����ȣ�� Ŀ���� ����
 CURSOR     CUR_MAX_MILE IS
 SELECT     A.MEM_ID
 FROM       (SELECT MEM_ID, MEM_MILEAGE
              FROM  MEMBER
              ORDER BY 2 DESC )A
 WHERE      ROWNUM <= 5;
--------------------------------------------------------------------------------------------------------------------------------
 ��뿹) ���ϸ����� ���� 5���� 2005�� 5�� ȸ����ȣ,ȸ����,���űݾ��հ� ���
DECLARE
  V_ID MEMBER.MEM_ID%TYPE;--VARIABLE
  V_NAME MEMBER.MEM_NAME%TYPE;
  V_SUM NUMBER:=0;
  
CURSOR     CUR_MAX_MILE IS
  SELECT     A.MEM_ID
  FROM       (SELECT MEM_ID, MEM_MILEAGE
              FROM  MEMBER
              ORDER BY 2 DESC )A
  WHERE      ROWNUM <= 5; 
  
BEGIN --�͸��� ����

OPEN CUR_MAX_MILE;--Ŀ������
  
LOOP --�ݺ�����
   
FETCH  CUR_MAX_MILE INTO V_ID;
EXIT WHEN CUR_MAX_MILE%NOTFOUND; -- FALSE�� �ؿ� ���� ����, TRUE�� ������
   
    SELECT SUM(CART_QTY*PROD_PRICE) INTO V_SUM
        FROM CART, PROD
        WHERE CART_NO LIKE '200505%'
        AND  PROD_ID=CART_PROD
        AND  CART_MEMBER=V_ID;
   
    SELECT MEM_NAME INTO V_NAME
        FROM MEMBER
        WHERE MEM_ID=V_ID;
   
DBMS_OUTPUT.PUT_LINE('ȸ����ȣ: '||V_ID);
DBMS_OUTPUT.PUT_LINE('ȸ����: '||V_NAME);
DBMS_OUTPUT.PUT_LINE('���űݾ��հ�: '||V_SUM);
DBMS_OUTPUT.PUT_LINE('---------------------');

END LOOP; --�ݺ�����
DBMS_OUTPUT.PUT_LINE('ȸ����: '||CUR_MAX_MILE%ROWCOUNT);
CLOSE CUR_MAX_MILE; --Ŀ������
END; --�͸��� ��
-------------------------------------------------------------------------------------------------------------------------------- 
--Ŀ���� ���� ���̴°� FOR���̰� ������ ���������� WHILE���̴�.
    SELECT SUM(CART_QTY*PROD_PRICE), MEM_NAME  INTO V_SUM, V_NAME
        FROM CART A, PROD B, MEMBER C
        WHERE CART_NO LIKE '200505%'
        AND  B.PROD_ID=A.CART_PROD
        AND  A.CART_MEMBER=V_ID
        AND  C.MEM_ID=V_ID;
----------------------------------------------------------------------   
DECLARE
  V_ID MEMBER.MEM_ID%TYPE;--VARIABLE
  V_NAME MEMBER.MEM_NAME%TYPE;
  V_SUM NUMBER:=0;
  
CURSOR     CUR_MAX_MILE IS
  SELECT     A.MEM_ID
  FROM       (SELECT MEM_ID, MEM_MILEAGE
              FROM  MEMBER
              ORDER BY 2 DESC )A
  WHERE      ROWNUM <= 5; 
  
BEGIN

OPEN CUR_MAX_MILE;
  
LOOP 
   
FETCH  CUR_MAX_MILE INTO V_ID;
EXIT WHEN CUR_MAX_MILE%NOTFOUND; -- FALSE�� �ؿ� ���� ����, TRUE�� ������
   
    SELECT SUM(A.CART_QTY*B.PROD_PRICE), C.MEM_NAME  INTO V_SUM, V_NAME
        FROM CART A, PROD B, MEMBER C
        WHERE CART_NO LIKE '200505%'
        AND  B.PROD_ID=A.CART_PROD
        AND  A.CART_MEMBER=V_ID
        AND  C.MEM_ID=V_ID
        GROUP BY C.MEM_NAME;
   
DBMS_OUTPUT.PUT_LINE('ȸ����ȣ: '||V_ID);
DBMS_OUTPUT.PUT_LINE('ȸ����: '||V_NAME);
DBMS_OUTPUT.PUT_LINE('���űݾ��հ�: '||V_SUM);
DBMS_OUTPUT.PUT_LINE('---------------------');

END LOOP;
DBMS_OUTPUT.PUT_LINE('ȸ����: '||CUR_MAX_MILE%ROWCOUNT);
CLOSE CUR_MAX_MILE;
END;
 
 
 
 




