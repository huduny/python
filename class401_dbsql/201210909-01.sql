2021-0909-01) �ݺ���
- ����Ŭ�� �ݺ����� LOOP, WHILE, FOR ���� ������
1)LOOP��
- ������ ���� �ܼ��� ���ѷ��� ��� ����
- EXIT ���� ����Ͽ� �ݺ����� Ż�� �� �� ����
- ��Ÿ �ݺ����� �⺻ ��������
(�������)
LOOP
 �ݺ�ó���ؾ��� ���(��);
 [EXIT WHEN ����;]
END LOOP;
. 'EXIT WEHN ����': ������ ���̸� �ݺ������� ���

��뿹) �������� 6���� ����ϴ� LOOP�� ����
DECLARE
    V_RESULT NUMBER:=0;--�ѹ��� ��Ƶ� ������ �ʱ�ȭ���� ������ ���� ������ �߻��� ��� ��� ���¿� �ִ´�.
    V_MESS VARCHAR2(100);
    V_CNT NUMBER:=1;
    
BEGIN
    LOOP
    V_RESULT:=V_CNT*6;
    V_MESS:='6 * '||V_CNT||' = '||V_RESULT;
    EXIT WHEN V_CNT>9;
    DBMS_OUTPUT.PUT_LINE(V_MESS);
    V_CNT:=V_CNT+1;
    END LOOP;
END;

��뿹)10~110�� ������ ����/�� �߻����� �ش� ���� �μ��� ����ӱ�/�� ���ϰ� �Ҽ� ��� �� ����ӱݺ��� ���� �޿��� �޴� ���/�� ��ȸ�Ͻÿ�.
��ȸ�� ������ /*�����ȣ,�����,�޿�,�μ���*/�̴�.
--���� �� �𸣰� ������ �ݺ��ؾߵɶ��� Ŀ���� ����Ѵ�

DECLARE
    V_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE; --�μ��ڵ�
    V_SAL HR.EMPLOYEES.SALARY%TYPE; -- ����ӱ�
    V_EID EMPLOYEES.EMPLOYEE_ID%TYPE; --�����ȣ
    V_ENAME EMPLOYEES.EMP_NAME%TYPE; --�����
    V_ESAL EMPLOYEES.SALARY%TYPE; --����޿�
    V_DNAME DEPARTMENTS.DEPARTMENT_NAME%TYPE; --�μ���
    
    CURSOR CUR_DEPT_SAL(P_AVGSAL NUMBER,P_DID EMPLOYEES.DEPARTMENT_ID%TYPE) IS
    --Ŀ�� �ȿ��� Ŀ����(�Ű����� Ÿ��), Ŀ���� SELECT���� �����ߴ��� ����� ������ �������϶�, �������� ������ ��ǥ���� �÷� ���� Ŀ���� ���, 
    --10���� ������� ��Ȯ�� �������� �ʴ��̻�
        SELECT EMPLOYEE_ID
        FROM    EMPLOYEES
        WHERE   SALARY <= P_AVGSAL
        AND     DEPARTMENT_ID=P_DID;
    --Ŀ���� �����ؾߵǴ� ��, �ش�μ� ��ձ޿����� �����ϴ� �����ȣ, �̸� ���ؼ� ��ձ޿����+�ش�μ�
BEGIN
    V_DID:=TRUNC(DBMS_RANDOM.VALUE(10,110),-1); --�μ���ȣ
    
    SELECT AVG(SALARY) INTO V_SAL
    FROM HR.EMPLOYEES
    WHERE   DEPARTMENT_ID = V_DID;
    
    OPEN CUR_DEPT_SAL(V_SAL, V_DID);
    
    LOOP
    FETCH CUR_DEPT_SAL INTO V_EID; --�ٴ����� SELECT���� �о�´�. ��ġ���� �����ȣ �ϳ��� V_EID�� �־���. 
    EXIT WHEN CUR_DEPT_SAL%NOTFOUND;
    SELECT A.EMP_NAME, A.SALARY, B.DEPARTMENT_NAME
    INTO   V_ENAME, V_ESAL, V_DNAME
    FROM   EMPLOYEES A, DEPARTMENTS B
    WHERE   A.DEPARTMENT_ID = B.DEPARTMENT_ID
    AND     A.EMPLOYEE_ID = V_EID;
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ: '||V_EID);
    DBMS_OUTPUT.PUT_LINE('�����: '||V_ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿�: '||V_ESAL);
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ�: '||V_DID);
    DBMS_OUTPUT.PUT_LINE('�μ���: '||V_DNAME);
    DBMS_OUTPUT.PUT_LINE('---------------------');
    END LOOP;

END;

��뿹) �ŷ�ó �� �ְŷ� ������ '��������'�� �ŷ�ó�� ã��/ 2005�� 3�� �ش� �ŷ�ó���� �������踦 ��ȸ�Ͻÿ�
alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ���Լ���, ���Աݾ��̴�.
--�������� �ŷ�ó���� 10����� 10���� ���� ���;� �ϴϱ� Ŀ���� ��ߵȴ�. Ŀ���� ����ҷ��� ���� �ƴ϶� �����ؼ� �������Ը� ��ȸ�� ���̴�. 
--�ݺ������� �� ���� ��ŭ �ݺ��Ѵ�.
DECLARE
    V_BID BUYER.BUYER_ID%TYPE; --�ŷ�ó�ڵ�\
    V_BNAME BUYER.BUYER_NAME%TYPE; --�ŷ�ó��
    V_AMT NUMBER:=0; --���Լ�������
    V_SUM NUMBER:=0; --���Աݾ�����
    
    CURSOR  CUR_BUYER01 IS  --FETCH�ϸ� ���پ� ROW�� �о�´�
    SELECT  BUYER_ID, BUYER_NAME
    FROM    BUYER
    WHERE   BUYER_BANK='��������';

BEGIN
    OPEN CUR_BUYER01;
   
    
    LOOP
        FETCH CUR_BUYER01 INTO V_BID,V_BNAME;
        
        EXIT WHEN CUR_BUYER01%NOTFOUND;
         
        SELECT  SUM(BUY_QTY), SUM(BUY_QTY*BUY_COST)
        INTO    V_AMT, V_SUM
        FROM    BUYPROD, PROD --PROD�� ���̾� ������� ���踦 ������
        WHERE   BUY_PROD=PROD_ID
        AND     PROD_BUYER=V_BID
        AND   BUY_DATE BETWEEN TO_DATE('20050301') AND TO_DATE('20050331');
        
        DBMS_OUTPUT.PUT_LINE('�ŷ�ó�ڵ�'||V_BID);
        DBMS_OUTPUT.PUT_LINE('�ŷ�ó��'||V_BNAME);
        DBMS_OUTPUT.PUT_LINE('���Լ�������'||V_AMT);
        DBMS_OUTPUT.PUT_LINE('���Աݾ�����'||V_SUM);
        DBMS_OUTPUT.PUT_LINE('');
        
    END LOOP;
    CLOSE CUR_BUYER01;
END;

2)WHILE ��
- ���߾���� WHILE ���� ����
- �ݺ�ó������ ������ Ȯ���Ͽ� �� ���� ���ΰ�� �ݺ� ���� �� ������ �����̸� �ݺ��� ����� ���
- EXIT���� ��� �����ϰ� �ݺ��� ����� ��
- CONTINUE�� 11G���� ��� ����
(�������)
WHILE ���� LOOP
�ݺ�ó����ɹ�(��);
[EXIT;]
[CONTINUE;]
END LOOP;

��뿹) �������� 6���� ����Ͻÿ�
DECLARE 
    V_CNT NUMBER:=0;
BEGIN
    WHILE V_CNT<9 LOOP
        V_CNT:=V_CNT+1;
        DBMS_OUTPUT.PUT_LINE('6*'||V_CNT||'='||6*V_CNT);
    END LOOP;
END;

��뿹)ù���� 100�� �� ���ĺ��� ������ 2�辿 �����ϴ� ��� ���ʷ� 250������ �Ѵ� ���� �׳����� ������ �ݾ��� ���Ͻÿ�

DECLARE 
V_DCURR NUMBER:=100;
V_SUM NUMBER:=0;
V_CNT NUMBER:=0;

BEGIN
WHILE V_SUM<=2500000 LOOP
    V_SUM:=V_SUM+V_DCURR;
    V_DCURR:=V_DCURR*2;
    V_CNT:=V_CNT+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('����ϼ�'||' '||V_CNT||'��'||'����ݾ�'||' '||V_SUM);
END;

��뿹) �ŷ�ó �� �ְŷ� ������ '��������'�� �ŷ�ó�� ã��/ 2005�� 3�� �ش� �ŷ�ó���� �������踦 ��ȸ�Ͻÿ�.(WHILE���� ���)
alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ���Լ���, ���Աݾ��̴�.
DECLARE
    V_BID BUYER.BUYER_ID%TYPE; --�ŷ�ó�ڵ�\
    V_BNAME BUYER.BUYER_NAME%TYPE; --�ŷ�ó��
    V_AMT NUMBER:=0; --���Լ�������
    V_SUM NUMBER:=0; --���Աݾ�����
    
    CURSOR  CUR_BUYER01 IS  --FETCH�ϸ� ���پ� ROW�� �о�´�
    SELECT  BUYER_ID, BUYER_NAME
    FROM    BUYER
    WHERE   BUYER_BANK='��������';

BEGIN
    OPEN CUR_BUYER01;
    
    FETCH CUR_BUYER01 INTO V_BID,V_BNAME;
    
    WHILE CUR_BUYER01%FOUND LOOP
        --��ġ���� ������ �ش��ڷᰡ �ִ��� ������ �� ���� ���� 
        --WHILE���� FETCH���� ���� ���ǹ��� �ۼ��Ǳ� ������ FETCH�� ���Ϲ� �ۿ��� ����Ǿ�� �ȴ�.
         
        SELECT  SUM(BUY_QTY), SUM(BUY_QTY*BUY_COST)
        INTO    V_AMT, V_SUM
        FROM    BUYPROD, PROD --PROD�� ���̾� ������� ���踦 ������
        WHERE   BUY_PROD=PROD_ID
        AND     PROD_BUYER=V_BID
        AND   BUY_DATE BETWEEN TO_DATE('20050301') AND TO_DATE('20050331');
        
        DBMS_OUTPUT.PUT_LINE('�ŷ�ó�ڵ�'||V_BID);
        DBMS_OUTPUT.PUT_LINE('�ŷ�ó��'||V_BNAME);
        DBMS_OUTPUT.PUT_LINE('���Լ�������'||V_AMT);
        DBMS_OUTPUT.PUT_LINE('���Աݾ�����'||V_SUM);
        DBMS_OUTPUT.PUT_LINE('');
    FETCH CUR_BUYER01 INTO V_BID,V_BNAME;
    END LOOP;
    CLOSE CUR_BUYER01;
END;
--WHILE���� �������� FETCH���� LOOP���� ��1�� LOOP�������� 1���� �� ����� �ȴ�.

--FOR���� 2���� �Ϲ� FOR Ŀ����� FOR
3) FOR��
- �ݺ�Ƚ���� ��Ȯ�� �˰� �ְų� �ݺ�Ƚ���� �߿��� ��� ���
(�Ϲ��� FOR���� �������)
FOR �ε����� IN [REVERSE] �ʱⰪ...������ LOOP
    �ݺ�ó���� ��ɹ�(��);
END LOOP;
- '�ε�����': �ʱⰪ���� ���������� ���� �޾� �ݺ��� �����ϴ� �����ν�  �ý��ۿ��� ������
- 'REVERSE': �������� �ݺ� ����
��뿹) �������� 6���� ����Ͻÿ�
DECLARE

BEGIN
    FOR I IN REVERSE 1..9 LOOP
    DBMS_OUTPUT.PUT_LINE('6 * '||I||'='||6*I);
    END LOOP;
END;

(Ŀ������ ����� for���� �������)
FOR ���ڵ�� IN Ŀ����|Ŀ�����ǹ� LOOP
�ݺ�ó���� ��ɹ�(��);
END LOOP;
. '���ڵ��' : Ŀ������ �� ���� ����ų ���ڵ������ �ý��ۿ��� ���� (������ ���� ����)
. 'Ŀ�����ǹ�' : ���𿵿��� Ŀ������(SELECT��)�� �ζ��� �������� �������� ����
. Ŀ������ �÷��� �����ϴ� ���: ���ڵ��.�÷���
. Ŀ���� OPEN, FETCH, CLOSE���� ���ʿ�

��뿹) �ŷ�ó �� �ְŷ� ������ '��������'�� �ŷ�ó�� ã��/ 2005�� 3�� �ش� �ŷ�ó���� �������踦 ��ȸ�Ͻÿ�.(FOR ���� ���)
alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ���Լ���, ���Աݾ��̴�.
DECLARE
    V_AMT NUMBER:=0; --���Լ�������
    V_SUM NUMBER:=0; --���Աݾ�����
    
    CURSOR  CUR_BUYER01 IS  --FETCH�ϸ� ���پ� ROW�� �о�´�
    SELECT  BUYER_ID, BUYER_NAME
    FROM    BUYER
    WHERE   BUYER_BANK='��������';

BEGIN

        FOR REC IN CUR_BUYER01 LOOP --REC�� �ý��ۿ��� �˾Ƽ� �������ش�.
         
        SELECT  NVL(SUM(A.BUY_QTY),0), NVL(SUM(A.BUY_QTY*B.PROD_COST),0)
        INTO    V_AMT, V_SUM
        FROM    BUYPROD A, PROD B --PROD�� ���̾� ������� ���踦 ������
        WHERE   B.PROD_BUYER=REC.BUYER_ID
        AND     A.BUY_PROD=B.PROD_ID
        AND    A.BUY_DATE BETWEEN TO_DATE('20050301') AND TO_DATE('20050331');
        
        DBMS_OUTPUT.PUT_LINE('�ŷ�ó�ڵ�'||REC.BUYER_ID);
        DBMS_OUTPUT.PUT_LINE('�ŷ�ó��'||REC.BUYER_NAME);
        DBMS_OUTPUT.PUT_LINE('���Լ�������'||V_AMT);
        DBMS_OUTPUT.PUT_LINE('���Աݾ�����'||V_SUM);
        DBMS_OUTPUT.PUT_LINE('');

    END LOOP;
END;

(IN LINE CURSOR)
DECLARE
    V_AMT NUMBER:=0; --���Լ�������
    V_SUM NUMBER:=0; --���Աݾ�����

BEGIN

        FOR REC IN ( SELECT  BUYER_ID, BUYER_NAME
                    FROM    BUYER
                    WHERE   BUYER_BANK='��������') -- ���� ���� ���Ǵ� �����̴�.
        LOOP
        SELECT  NVL(SUM(A.BUY_QTY),0), NVL(SUM(A.BUY_QTY*B.PROD_COST),0)
        INTO    V_AMT, V_SUM
        FROM    BUYPROD A, PROD B --PROD�� ���̾� ������� ���踦 ������
        WHERE   B.PROD_BUYER=REC.BUYER_ID
        AND     A.BUY_PROD=B.PROD_ID
        AND    A.BUY_DATE BETWEEN TO_DATE('20050301') AND TO_DATE('20050331');
        
        DBMS_OUTPUT.PUT_LINE('�ŷ�ó�ڵ�'||REC.BUYER_ID);
        DBMS_OUTPUT.PUT_LINE('�ŷ�ó��'||REC.BUYER_NAME);
        DBMS_OUTPUT.PUT_LINE('���Լ�������'||V_AMT);
        DBMS_OUTPUT.PUT_LINE('���Աݾ�����'||V_SUM);
        DBMS_OUTPUT.PUT_LINE('');

    END LOOP;
END;

2021-0909-02) PROCEDURE -- �Լ��� ��ȯ���� �ְ� SELECT�� WHERE���� ��� ���� BUT ���ν����� ��ȯ���� ��� ���� ���� ���Ѿ� �ȴ�. 
- Ư������� �����ϱ� ���� �Ϸ��� ��ɵ��� �������� �����ϵǾ� ������ ����
- �����ϵ� ������ ���ν��� ĳ���� ����ǹǷ� ó���ӵ��� ������
- CLIENT ���� ó�� ��ƾ�� �����Ͽ� �ϰ����ִ� ������ ���� ����
- ���� ������ ��ȣ
- ��Ʈ��ũ Ʈ���� ����--���ν��� �̸��� �Ű������� ������ ���� ����ϴ� �ڷ��� ���� ���ϼ� �ִ�. 
- ��ȯ���� ����
(�������)
CREATE [OR REPLACE] PROCEDURE ���ν����� 
[(�Ű������� [MORE] Ÿ�Ը� [:=��,]--�Ű������� ������ �Ƚᵵ �ȴ�. Ÿ�Կ� ũ�⸦ ���� ���� �ȵȴ�.
:)]
IS
�����;
BEGIN
�����;
[EXCEPTION
����ó����;
]
END;
.'�Ű�������' : ���� 'P_'�� ����
. MODE: IN, OUT, INOUT, �����Ǹ� IN���� ����
IN: �Է¿� --���ν��� ����, �ܺο��� �����͸� ���ν��� ������ ������ �ö�
OUT: ��¿� --�Ű������� ���ؼ� ���ν��� ������ ���޵� �� �ִ�. ���ν��� �̸����δ� ��ȯ�ɼ� ����.
INOUT: ����� ����(��� ����)
***'Ÿ�Ը�': ������ Ÿ�Ը� ���(ũ�� ������� ����)



