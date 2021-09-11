2021-09-11)
--������ ������ �޾� �̸� ȸ����� ���ϸ����� ����ϴ� Ŀ��
--�̺κ��� SQL�̴� 
SELECT MEM_NAME,
        MEM_MILEAGE
FROM MEMBER
WHERE   MEM_JOB='ȸ���';--ȸ����� ������ �ްڴ�.

--PL/SQL�� ����
--DECLARE�� BEGIN ���̿��� ��������, ����ó��, Ŀ������, ������Ʈ ���� ���� 
--BEGIN�� END ���̴� �������̴�.
--DECLARE BEGIN END�� ���� ���� ANONYMOUS BLOCK�� �����ȴ�
--��Ģ�� ������ �����ؼ� �ű⿡ ��Ƽ� ����ؾ� �ȴ�.

/* 
��: ROW RECORD TUPLE
��: COLUMN, FIELD, ATTRIBUTE
2���� �迭�� ���̺�-�����̼� ����� ǥ��

ERD���̾�׷�: ��üENTITY�� ����RELATIONSHIP���� ǥ��
��ü�� ��ü����; ���踦 �����̼�, ��ü�� ���������� ������ �ִ� ������ �÷�
�������迡�� MEMBER�� ���Ǽ���(������) ȸ���̶�� ��ü�� �ȴ�. ȸ���� ���̵�, ����̶�� �Ӽ��� ������ �ִ�.
�� �������� ���� �Ӽ����� �������迡�� TABLE�� �ȴ�.

*SQL ������ ���
1.DDL: CREATE ALTER DROP --�����͸� ��� ����
2.DML: SELECT UPDATE DELETE INSERT --������ ����
3.DCL: GRANT REVOKE --���� ����
4.TCL: COMMIT ROLLBACK, SAVEPOINT --Ʈ����� ���ϰ���(���ڼ� �ϰ��� ���� ���Ӽ�)

*PL SQL ������ ���
�б⹮(IF, CASE ��):���������� ���μ����� �帧�� �ٲ۴�
-����Ÿ
PACKAGE
USER FUNCTION(�߿�)
STORED PROCEDURE(�߿�)
TRIGGER
ANONYMOUS BLOCK--����� �־���� �Լ��� ���ν����� ����� �� �ִ�. ���� ���嵹�̶�� �����ؾ� �ȴ�.

CLIENT�� SERVER�� �ִµ� CLIENT�� SQL���� ������ �ٷ� ������. PL/SQL�� ���ν��� ��� ���� �̹� ����س��� ���� �ҷ��� �����ϴ� ���̴�.
*/
SET SERVEROUTPUT ON;
/

DECLARE
    V_NAME VARCHAR2(90);
    V_MILEAGE NUMBER(10);
BEGIN 
    SELECT MEM_NAME, MEM_MILEAGE INTO V_NAME, V_MILEAGE --������ ����� �ֳĸ� ����� �������̰� ������ �ϳ��̱� ������/ 
                                                        --1. �⺻Ű�� �����ָ� �ȴ�(�⺻Ű�� �����ϱ� ������), select ����� ������ �Ѱ��� ������ ������ �ִ�/ 
                                                        --2.
    FROM MEMBER
    WHERE   1 =1 -- �ǹ� ���� TRUE�̱� ������ ������ ���ؼ� ������ ��
    AND MEM_ID = 'b001'
    and MEM_JOB='ȸ���';
    DBMS_OUTPUT.PUT_LINE(V_NAME||','|| V_MILEAGE);
END;
-----------------------------------------------------------------------------------------------
DECLARE
    V_NAME VARCHAR2(90);
    V_MILEAGE NUMBER(10);
    
    CURSOR CUR IS --���տ� CUR��� �̸��� ���δ�, �� ������ �ֱ�� ��ġ�� �ø��� BIND�Ѵ�, OPEN�̶�� ��ɾ� ���
    SELECT MEM_NAME, MEM_MILEAGE INTO V_NAME, V_MILEAGE  --�������� DECLARE BEGIN ���̿� �ø���               
    FROM MEMBER
    WHERE   1 =1
    and MEM_JOB='ȸ���';
BEGIN 
    OPEN CUR;
    FETCH CUR INTO V_NAME, V_MILEAGE; --CUR��� �ְ� FETCH(1���� �ٶ����)�� ����ȴ�
    WHILE CUR%FOUND LOOP
    DBMS_OUTPUT.PUT_LINE(V_NAME||','|| V_MILEAGE);
    FETCH CUR INTO V_NAME, V_MILEAGE; --WHILE�� �������� FETCH�� ����Ѵ�. ��ġ�� �Ƚ��ָ� ó�� FETCH�� ����Ų �κи� ��µȴ�.
    END LOOP;
    CLOSE CUR;
END;
-----------------------------------------------------------------
DECLARE
    V_NAME VARCHAR2(90);
    V_MILEAGE NUMBER(10);
    
    CURSOR CUR IS --���տ� CUR��� �̸��� ���δ�, �� ������ �ֱ�� ��ġ�� �ø��� BIND�Ѵ�, OPEN�̶�� ��ɾ� ���
    SELECT MEM_NAME, MEM_MILEAGE INTO V_NAME, V_MILEAGE  --�������� DECLARE BEGIN ���̿� �ø���               
    FROM MEMBER
    WHERE   1 =1
    and MEM_JOB='ȸ���';
BEGIN 
    OPEN CUR;
    LOOP --������ ������ �ؿ� ��ġ ����
    FETCH CUR INTO V_NAME, V_MILEAGE;
    EXIT WHEN CUR%NOTFOUND; --������ �κ��� �ʿ��ϴ�, FETCH�Ŀ� �����Ͱ� ������ �������Ͷ�, WHILE�� �ٸ��� ������ ���������� WHILE�� ������ ���� �Ŵ�
    DBMS_OUTPUT.PUT_LINE(CUR%ROWCOUNT||':'||V_NAME||','|| V_MILEAGE);
    END LOOP;
    CLOSE CUR;
END;
--------------------------------------------------------------------
DECLARE
    V_NAME VARCHAR2(90);
    V_MILEAGE NUMBER(10);
    
    CURSOR CUR(V_JOB VARCHAR2) IS --���տ� CUR��� �̸��� ���δ�, �� ������ �ֱ�� ��ġ�� �ø��� BIND�Ѵ�, OPEN�̶�� ��ɾ� ���
                                  --������ ���� �ޱ� ���ؼ� �׸��� ����� ��ߵȴ�. ������������ ������ ������ �ʿ䰡 ����.
    SELECT MEM_NAME, MEM_MILEAGE INTO V_NAME, V_MILEAGE  --�������� DECLARE BEGIN ���̿� �ø���               
    FROM MEMBER
    WHERE   1 =1
    and MEM_JOB=V_JOB;
BEGIN 
    OPEN CUR('�ֺ�');--�޸𸮿� �ö󰥶� PARAMETER�� ������ �ִ�.
    LOOP --������ ������ �ؿ� ��ġ ����
    FETCH CUR INTO V_NAME, V_MILEAGE;
    EXIT WHEN CUR%NOTFOUND; --������ �κ��� �ʿ��ϴ�, FETCH�Ŀ� �����Ͱ� ������ �������Ͷ�, WHILE�� �ٸ��� ������ ���������� WHILE�� ������ ���� �Ŵ�
    DBMS_OUTPUT.PUT_LINE(CUR%ROWCOUNT||':'||V_NAME||','|| V_MILEAGE);
    END LOOP;
    CLOSE CUR;
END;
--------------------------------------------------------------------------------
ACCEPT P_JOB PROMPT '������ �Է��ϼ���: ';
DECLARE
    V_NAME VARCHAR2(90);
    V_MILEAGE NUMBER(10);
    
    CURSOR CUR IS
    SELECT MEM_NAME, MEM_MILEAGE INTO V_NAME, V_MILEAGE              
    FROM MEMBER
    WHERE   1 =1
    and MEM_JOB='&P_JOB'; -- PROMPTâ�� �߸� P_JOB�� ���� ����� ���µ� ��Ģ�� &�� �� �ٿ���� �ȴ�. &�� �ּҸ� �����ִ� ���̴�.
BEGIN 
    OPEN CUR;
    LOOP 
    FETCH CUR INTO V_NAME, V_MILEAGE;
    EXIT WHEN CUR%NOTFOUND; 
    DBMS_OUTPUT.PUT_LINE(CUR%ROWCOUNT||':'||V_NAME||','|| V_MILEAGE);
    END LOOP;
    CLOSE CUR;
END;
-------------------------------------------------------------------------------------
--for�� ���� open,FETCH�� �ʿ����. 
ACCEPT P_JOB PROMPT '������ �Է��ϼ���: ';
DECLARE
    
    CURSOR CUR IS
    SELECT MEM_NAME, MEM_MILEAGE --CUR�ε� REC��� ��Ī�� �ָ� ���྿ �ݺ��ϸ� REC�� �־��ش�.              
    FROM MEMBER
    WHERE   1 =1 --�ּ�ó���� ���ϱ� ���� ���
    and MEM_JOB='&P_JOB';
BEGIN 
    FOR REC IN CUR LOOP 
    DBMS_OUTPUT.PUT_LINE(CUR%ROWCOUNT||':'||REC.MEM_NAME||','|| REC.MEM_MILEAGE);
    END LOOP;
    CLOSE CUR;
END;
--------------------------------------------------------------------------------------
ACCEPT P_JOB PROMPT '������ �Է��ϼ���: ';
DECLARE

BEGIN 
    FOR REC IN (SELECT MEM_NAME, MEM_MILEAGE               
                FROM MEMBER
                WHERE   1 =1
                and MEM_JOB='&P_JOB') --�̰͵� �����ϴ�
    LOOP 
    DBMS_OUTPUT.PUT_LINE(REC.MEM_NAME||','|| REC.MEM_MILEAGE);
    END LOOP;
    CLOSE CUR;
END;
---------------------------------------------------------------------------------------------
--���ν��� ����
// BIND����: IN/ OUT. �Ķ���͸� �޾��ִ�(������) ����
CREATE OR REPLACE PROCEDURE PROD_GETMEMLIST(P_JOB IN VARCHAR2) --BIND��������Ѵ�(����������)
IS
BEGIN 
    FOR REC IN (SELECT MEM_NAME, MEM_MILEAGE               
                FROM MEMBER
                WHERE   1 =1
                and MEM_JOB=P_JOB) --������ ����
    LOOP 
    DBMS_OUTPUT.PUT_LINE(REC.MEM_NAME||','|| REC.MEM_MILEAGE);
    END LOOP;
END; --�������ؼ� ����Ŭ ������ ĳ�ø޸𸮿� �־�д�. �̸��� ȣ���ϸ� �ٷ� ������ �ȴ�. 
-------------------------------------------------------------------------------------------------
--ȣ���ϱ�
EXEC PROD_GETMEMLIST('�л�');









*/