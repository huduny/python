2005�⵵ ��ǰ�� �� �԰������ ����ϴ� Ŀ��
--LIKE�� ���Ǵ� %_�� ���ϵ�ī���̴�.
--�����Լ�(SUM, AVG, MAX, MIN, COUNT)
/
SET SERVEROUTPUT ON;
/
DECLARE
    V_PROD  VARCHAR2(30);
    V_QTY   NUMBER(10);
CURSOR  CUR IS
    SELECT    BUY_PROD,
              SUM(BUY_QTY)
    FROM      BUYPROD
    WHERE     BUY_DATE LIKE '2005%'
    GROUP BY  BUY_PROD
    ORDER BY  BUY_PROD;
BEGIN
    OPEN CUR;--�޸𸮿� �ø���
    FETCH CUR INTO V_PROD,V_QTY;--CUR�� ��ġ�ؼ� �ٶ󺸰� ���ش�.    --�����:��ġ ������ ���
    
    WHILE(CUR%FOUND)
     LOOP
        DBMS_OUTPUT.PUT_LINE(V_PROD||V_QTY);
        FETCH CUR INTO V_PROD,V_QTY;
     END LOOP;
    CLOSE CUR;
END;
--DECLARE BEGIN END�� ���� PL/SQL������ ����ȴ�.\
/--�����ø� �����صθ� CTRL+ENTER�ϸ� ������ �ȴ�.

DROP TABLE BUYPROD_2;
COMMIT;