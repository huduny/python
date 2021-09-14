2021-09-14
1) CART_NO �����Լ�
    
    CREATE OR REPLACE FUNCTION FN_CREATE_CART_NO (
        P_MID MEMBER.MEM_ID%TYPE)
       --( P_DATE IN VARCHAR2 )
        RETURN VARCHAR2
    IS
        V_CNT NUMBER := 0;
        V_DATE VARCHAR(9) := TO_CHAR( SYSDATE, 'YYYYMMDD') || '%';
        V_CART_NO CART.CART_NO%TYPE;
        V_MID MEMBER.MEM_ID%TYPE;
    BEGIN
        SELECT COUNT(*) INTO V_CNT
          FROM CART
         WHERE CART_NO LIKE V_DATE; -- ���� ��¥�� �α����� ȸ���� ��
      
      IF V_CNT = 0 THEN
         V_CART_NO := TO_CHAR ( SYSDATE, 'YYYYMMDD') || '00001';
        RETURN V_CART_NO;  
      ELSE   
        SELECT  A.CID, A.CNO INTO V_MID, V_CART_NO
          FROM ( SELECT CART_MEMBER AS CID,
                        CART_NO AS CNO
                   FROM CART
                  WHERE CART_NO LIKE V_DATE
                  ORDER BY CART_NO DESC) A
         WHERE ROWNUM = 1;
 
           IF P_MID !=  V_MID THEN
              V_CART_NO :=  V_CART_NO +1;
           END IF;
           RETURN V_CART_NO; 
      END IF;
    END;

(1) Ʈ���� �ǻ緹�ڵ� --������ ���ڵ�, ���� �ԷµǸ� ��ġ���� :new�� ������ �־ ���߿� �ʿ��� ���� �����´�. ���ڵ�(��)
- :NEW, :OLD���� --����� Ʈ���ſ����� ��밡��
-------------------------------------------------------------------------------------------------------
�ǻ緹�ڵ�               �ǹ�
-------------------------------------------------------------------------------------------------------
: NEW                 INSERT, UPDATE �̺�Ʈ���� ���  --������ �ƴ϶� ���ο� �����͸� ����� ������ new ���
                      �����Ͱ� ����(����)�Ǳ� ���� ���Ӱ� �Էµ� ��
                      DELETE �ÿ��� ��� NULL ��
:OLD                    DELETE, UPDATE �̺�Ʈ���� ��� --������ ����� �����͸� ����� ������ old���
                      �����Ͱ� ����(����)�Ǳ� ���� ����Ǿ� �ִ� ��
                      INSERT �ÿ��� ��� NULL��
-------------------------------------------------------------------------------------------------------
(2) Ʈ���� �Լ�
- Ʈ���� �߻��� �����̵� �̺�Ʈ�� ������ �Ǻ��ϱ����� �Լ�
-------------------------------------------------------------------------------------------------------
�Լ�          ����
-------------------------------------------------------------------------------------------------------
INSERING  �̺�Ʈ�� INSERT�̸� �� ��ȯ --if���� ����ؼ� �Ǻ��Ѵ�.
UPDATING  �̺�Ʈ�� UPDATE�̸� �� ��ȯ
deleting   �̺�Ʈ�� delete�̸� �� ��ȯ

���ο� �̺�Ʈ�� �����ϱ� ���ؼ���   :NEW  �� ����Ѵ�. Ʈ���ſ��� �����ؼ� :new.cart_no�ϸ� ���ο� �����Ͱ� �����ȴ�.        
                      
                      
                      
��뿹) ���� ȸ�� 'f001' ȸ���� 'P202000006' ��ǰ 10���� �������� ��� ���ڷḦ ��ٱ��Ͽ� �����ϰ�
��� �������̺��� �����ϴ� Ʈ���Ÿ� �ۼ��Ͻÿ�
(CART�� ����)
INSERT INTO CART
VALUES('f001', FN_CREATE_CART_NO('f001'), 'P202000006', 10);
ROLLBACK;
(Ʈ���� ����)
    CREATE OR REPLACE TRIGGER TG_UPDATE_REMAIN
    AFTER INSERT OR UPDATE OR DELETE ON CART
    FOR EACH ROW --�ึ�� ����� �ߴ� �Ź�
    DECLARE
        V_QTY NUMBER:=0;
        V_PROD PROD.PROD_ID%TYPE;
    BEGIN
        IF INSERTING THEN
            V_QTY:=:NEW.CART_QTY;
            V_PROD:=:NEW.CART_PROD;
        ELSIF UPDATING THEN
            V_QTY:=:NEW.CART_QTY-:OLD.CART_QTY;
            V_PROD:=:NEW.CART_PROD;
        ELSE 
            V_QTY:=-:OLD.CART_QTY;
            V_PROD:=:OLD.CART_PROD;
        END IF;
        
        UPDATE REMAIN A
        SET    A.REMAIN_O=A.REMAIN_O+V_QTY, --CART�� �Ǹ��̰� �ǸŴ� ����̴�
               A.REMAIN_99=A.REMAIN_O-V_QTY,
               A.REMAIN_J_DATE=SYSDATE
        WHERE  A.REMAIN_YEAR='2005'
        AND    A.PROD_ID=V_PROD;
    END;
��뿹) ���� ȸ�� 'f001' ȸ���� 'P202000006' ��ǰ 5���� �߰� �������� ��� ���ڷḦ ��ٱ��Ͽ� �����ϰ� ���ڷḦ ��α��Ͽ� ��� �������̺��� �����ϴ�
Ʈ���Ÿ� �ۼ��Ͻÿ�.
UPDATE CART SET CART_QTY=15 WHERE CART_NO = '2021091400001' AND CART_PROD='P202000006';
COMMIT;
��뿹) ���� ȸ�� 'f001' ȸ���� 'P202000006' ��ǰ 2���� ����� ��� ��ǰ���� ��� �� �ڷḦ ��ٱ��Ͽ� �����ϰ� ���ڷḦ ��α��Ͽ� ��� �������̺��� �����ϴ�
Ʈ���Ÿ� �ۼ��Ͻÿ�.
UPDATE CART SET CART_QTY=2 WHERE CART_NO = '2021091400001' AND CART_PROD='P202000006'; 
��뿹) ���� ȸ�� 'f001' ȸ���� 'P202000006' ��ǰ�� ��� ��ǰ���� ��� �� �ڷḦ ��ٱ��Ͽ� �����ϰ� ���ڷḦ ��α��Ͽ� ��� �������̺��� �����ϴ�
Ʈ���Ÿ� �ۼ��Ͻÿ�.
DELETE CART WHERE CART_NO = '2021091400001' AND CART_PROD='P202000006'; 

2021-0914-01) ��Ű��
- ���� �������� �ִ� PL/SQL Ÿ�� ����, ����������α׷�, Ŀ�� ���� �׸��� ���� ���� ��ü
- �����ϵǾ� ������ ����Ǹ�, �ٸ� ���α׷�(�ٸ� ��Ű��, �������α׷�, �ܺ����α׷�)���� ��Ű������ �׸��� ����, ����, ���� �� �� ����
- ��Ű�� ����� ����: ���ȭ, ���α׷� ������ ���̼�, ĸ��ȭ ���� ����
- ��Ű���� ����ο� ����η� ������
1)�����
 - ��Ű������ ����� Ÿ��, ����, ���, ����, �������α׷� ���� ������ Ÿ��(���α׷� ���)�� ����
 (�������)--�����ڵ尡 ���� ���α׷� ��ݸ� ����� �ش�.
 CREATE OR REPLACE PACKAGE ��Ű����
 IS
   ����, ���, Ŀ��, ���� ����; 
   
 FUNCTION �Լ��� [(�Ű����� LIST)]
 RETURN ��ȯŸ��; 
 
 PROCEDURE ���ν�����[(�Ű����� LIST)];
            :
END ��Ű����;
 
2)��Ű�� �����(����)
 - ��Ű�� ����ο��� ����� �������α׷��鿡 ���� ���� ����
 (�������)
 CREATE OR REPLACE PACKAGE BODY ��Ű����
 IS
   ����, ���, Ŀ��, ���� ����; 
   
 FUNCTION �Լ��� [(�Ű����� LIST)]
 RETURN ��ȯŸ��
 IS 
 BEGIN
    :
  RETURN EXP;
 END �Լ���;
 
 PROCEDURE ���ν�����[(�Ű����� LIST)]
 IS
 BEGIN
        :
 END ���ν�����;
        :
END ��Ű����; 
--����δ� ������Ʈ ������ �����δ� ������Ʈ �߿� ���������. ���� �ִ°��� ������Ÿ���̶�� �Ѵ�.

��뿹) ������� ��Ű���� �����Ϸ� �Ѵ�. ��Ű������ �����ȸ, �űԻ���Է�, ������ ó���� ���� �������α׷��� ���ԵǾ�� �Ѵ�. ��Ű���� ��� �����Ͻÿ�.

1)�����ȸ : �����ȣ�� �Է¹޾� �̸��� ��ȭ��ȣ�� ����ϴ� �Լ��� �Լ����� FN_GETINFO
2)�űԻ���Է� : �����ȣ, �̸�, �Ի���, �����ڵ�, �μ��ڵ带 �Է� �޾� ������̺� �����ϴ� ���ν����� �̸��� PROC_NEW_EMP
3)������ ó�� : ���ڿ� �����ȣ�� �Է¹޾� �������ڸ� '����'�� �����ϴ� ���ν����� ���ν������� PROC_RETIRE_EMP

��Ű������ DDIT_PKG�̴�.

(��Ű�� ����)
CREATE OR REPLACE PACKAGE ddit_pkg
IS
    FUNCTION FN_GETINFO(
                        P_EID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE)
RETURN VARCHAR2;

PROCEDURE  PROC_NEW_EMP(
                        P_NAME IN VARCHAR2, 
                        P_HIRE_DATE IN HR.EMPLOYEES.HIRE_DATE%TYPE, 
                        P_JOB_ID  IN HR.EMPLOYEES.JOB_ID%TYPE, 
                        P_DID IN HR.EMPLOYEES.DEPARTMENT_ID%TYPE,
                        P_MAIN IN HR.EMPLOYEES.EMAIL%TYPE);

PROCEDURE  PROC_RETIRE_EMP(
                           P_DATE IN DATE,
                           P_EID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE); 
END ddit_pkg;

(��Ű�� ���࿵��)
CREATE OR REPLACE PACKAGE BODY ddit_pkg
IS
    FUNCTION FN_GETINFO(
                        P_EID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE)
    RETURN VARCHAR2
    IS
        V_NAME EMPLOYEES.EMP_NAME%TYPE;
        V_TEL_NUM EMPLOYEES.PHONE_NUMBER%TYPE;
        
    BEGIN
        SELECT EMP_NAME, PHONE_NUMBER  INTO V_NAME, V_TEL_NUM
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID=P_EID;
        RETURN V_NAME||', '||V_TEL_NUM;
    END FN_GETINFO;
        

    PROCEDURE  PROC_NEW_EMP(
                            P_NAME IN VARCHAR2,
                            P_HIRE_DATE IN HR.EMPLOYEES.HIRE_DATE%TYPE, 
                            P_JOB_ID  IN HR.EMPLOYEES.JOB_ID%TYPE, 
                            P_DID IN HR.EMPLOYEES.DEPARTMENT_ID%TYPE,
                            P_MAIN IN HR.EMPLOYEES.EMAIL%TYPE)
    IS
        V_EID EMPLOYEES.EMPLOYEE_ID%TYPE;
    BEGIN
        SELECT MAX(EMPLOYEE_ID)+1 INTO V_EID FROM EMPLOYEES;
        INSERT INTO EMPLOYEES(EMPLOYEE_ID,FIRST_NAME,LAST_NAME,HIRE_DATE,JOB_ID,DEPARTMENT_ID,EMP_NAME, EMAIL)
        VALUES(V_EID,SUBSTR(P_NAME,1,1),SUBSTR(P_NAME,2),P_HIRE_DATE,P_JOB_ID,P_DID,P_NAME,P_MAIN); COMMIT;
    END PROC_NEW_EMP;
    
    PROCEDURE  PROC_RETIRE_EMP(
                               P_DATE IN DATE,
                               P_EID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE) 
    IS
    BEGIN
        UPDATE EMPLOYEES SET RETIRE_DATE=P_DATE WHERE EMPLOYEE_ID=P_EID; COMMIT;
    END PROC_RETIRE_EMP;                                
END ddit_pkg;

(����)
1)��ȸ - �����ȣ 116��
SELECT ddit_pkg.FN_GETINFO(116) FROM DUAL;
2)�űԻ�����
EXECUTE DDIT_PKG.PROC_NEW_EMP('ȫ�浿', SYSDATE, 'ST_MAN', 70,'ASDASDSA')
3)������ ó��
EXECUTE DDIT_PKG.PROC_RETIRE_EMP(SYSDATE,188);




 
 