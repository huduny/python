2021-08-18-01)�˻����(SELECT ��)
2021-08-18-01)�˻����(SELECT ��)
    -�ڷ� �˻���� ����
    -SELECT��, FROM��, WHERE��(���Ǳ��) ������ ����
    -SELECT��: ����� ��µǾ�� �� �÷� ����
        .�÷���, �����(+-*/), �Լ�(����,��¥,����,����ȯ ��)(���ڿ��� ���ڻ��), ��� ������ ���
        .��������� ���� �ʴ�    
    -FROM��: ���̺�(��) ����
        .��������� ���� ������
    -WHERE��: ����(�Ϲ�����, ��������)�� ���
        .FROM���� SELECT�� ���� �ռ� ���� ����
        .SELECT������ ���ǵ� ������Ī ���� ������ �� ����
        .WHERE���� ���꿡 ������ ���� ����
    1. ���������
    -��Ģ������('+','-','/','*')�� '()'�� ����
    ��뿹) ������̺��� �� ����� ���ʽ��� ����Ͽ� ����Ͻÿ�
        ���ʽ�=�޿�*���������ڵ�(COMMISSION_PCT)*25%
        ���޾�=�޿�+���ʽ�
        Alias�� �����ȣ, �����,�޿�,���ʽ�,���޾��̴�
        --ǥ�� SQL�� ������ ���� ������ ���� �ݺ����� ������. 
    SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS �����,
           SALARY AS �޿�,
           COMMISSION_PCT AS ���������ڵ�,
        --�����ͺ��̽��� ������ �ִ� ���� NULL�� �����µ� �ڹٿ��� �������� ���� ��쿡�� ������ �����ϰ� ���� ������ �⺻�ʱ�ȭ �ȴ�. 
        --����Ŭ�� ������ ������ NULL�� ����Ѵ�. NULL���� ��Ģ������ �͵��� ����� �� NULL�� �ȴ�.
        --NULL�� ���ִ� �Լ� NVL(��,0)�̸� NULL�̸� 0�� ǥ��
           NVL((SALARY * COMMISSION_PCT * 0.25),0) AS ���ʽ�,
           SALARY + NVL((SALARY * COMMISSION_PCT * 0.25),0) AS ���޾�
    FROM HR.EMPLOYEES;
        --������ ��Ÿ���� ���� ��� WHERE���� ����� �ʿ䰡 ����
    ��뿹2)ȸ�����̺��� ȸ���� �ֹε�Ϲ�ȣ ���ڸ� 6�ڸ��� �̿��Ͽ� ���̸� ����Ͽ� ����Ͻÿ�
    ALIAS�� ȸ����ȣ, ȸ����, �ֹε�Ϲ�ȣ, ����, ���ϸ��� --LGU(�з��ڵ�)local government unit 
    SELECT MEM_ID ȸ����ȣ, MEM_NAME ȸ����, MEM_REGNO1�ֹε�Ϲ�ȣ, ����, MEM_MILEAGE���ϸ���
        --�̸��� �Ժη� �ٲٸ� �ȵȴ�. �ܷ�Ű�� ����Ҷ� Ư��
        --PRICE���� COST���Դܰ�, �����Ͱ� �ϰ����� �Ҿ������ ������ ������ �ߺ��̴�. BUY_COST�� BUYPROB���� ��� �Ǵ� ���̴�.
        --������ �����ͺ��̽������� �ߺ��� �ּ�ȭ ���Ѿߵȴ�.
        --CART_NOīƮ ��ȣ(������ 8�ڸ�+5�ڸ���ȣ), PRICE*CART_QTY�� �ؾ� ���Ұ����� �� �� �ִ�, �з��ؼ� �����ϴ� ����(����ȭ)��Ų�ٰ� �Ѵ�(�̻������� �߻����� �ʵ���)
        --CART�� �θ� MEMBER��PROD �ΰ��̴�, �������̺�(������ ���ؼ� ����� ��ô�Ǵ� ��)
        --LPROD�� �з� ���̺��̴�, ���� ���踦 �м��ϱ� ���� ���̴�, ID(�ڵ�) ���ܴ�(�ܼ� ����)�ϼ��� �ִ�. GU(�з��ڵ�) NM(�з���)
        --REGNO1(�ֹι�ȣ), ADD1(�⺻�ּ�)ADD2(���ּ�)LIKE(���)MEMORIAL(���������)DELETE(Ȱ��,�޸�,Ż��)
        --OUTLINE(����), TOTALSTOCK(���� ���), PROPERSTOCK(���� ���), UNIT(����)
        ID NAME LGU BUYER COST PRICE
    ��뿹2)ȸ�����̺��� ȸ���� �ֹε�Ϲ�ȣ ���ڸ� 6�ڸ��� �̿��Ͽ� ���̸� ����Ͽ� ����Ͻÿ�
    ALIAS�� ȸ����ȣ, ȸ����, �ֹε�Ϲ�ȣ, ����, ���ϸ��� --LGU(�з��ڵ�)local government unit 
    
    SELECT MEM_ID "ȸ�� ��ȣ", 
           MEM_NAME ȸ����,  
           MEM_REGNO1||'-'||MEM_REGNO2 �ֹε�� ��ȣ, --||�ڹ��� ���ڿ� ���̴� ��ɰ� ����
           EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2)) ����, --1��°���� �ι�° ��¥ �̾Ƴ���) EXTRACT�̾Ƴ��� ���� ���� ���ڷ� ���
          MEM_MILEAGE ���ϸ��� --�����̳� ��ɹ��� ��Ī���� ������ �� �ֵ���ǥ
    FROM MEMBER;

**MEMBER ���̺� ���� �� �Ϻ� �ڷ㸦 �����Ͻÿ�
    1)ȸ����ȣ: 'M001'
      MEM_BIR: 1975/03/15 => 2001/03/15
      MEM_REGNO1: 750315 => 010315
      MEM_REGNO2: 255555 => 4555555
    UPDATE MEMBER
    SET    MEM_BIR = TO_DATE('20010315'),
           MEM_REGNO1 = '010315',
           MEM_REGNO2 = '4555555'
    WHERE  MEM_ID=LOWER('MOO1');

    1)ȸ����ȣ: 't001'
      MEM_BIR: 1976/05/06 => 2000/05/06
      MEM_REGNO1: 760506 => 000506
      MEM_REGNO2: 1454731 => 3454731
    UPDATE MEMBER
    SET    MEM_BIR = TO_DATE('20000506'),
           MEM_REGNO1 = '000506',
           MEM_REGNO2 = '3454731'
    WHERE  MEM_ID = LOWER('TOO1');

    1)ȸ����ȣ: 'd001'
      MEM_BIR: 1946/04/09 => 2008/04/09
      MEM_REGNO1: 460409 => 080409
      MEM_REGNO2: 1454731 => 3454731
    UPDATE MEMBER
    SET    MEM_BIR = TO_DATE('20080409'),
           MEM_REGNO1 = '080409',
           MEM_REGNO2 = '3454731'
    WHERE  MEM_ID = LOWER('M001');
    
    
    -�ڷ� �˻���� ����
    -SELECT��, FROM��, WHERE��(���Ǳ��) ������ ����
    -SELECT��: ����� ��µǾ�� �� �÷� ����
        .�÷���, �����(+-*/), �Լ�(����,��¥,����,����ȯ ��)(���ڿ��� ���ڻ��), ��� ������ ���
        .��������� ���� �ʴ�    
    -FROM��: ���̺�(��) ����
        .��������� ���� ������
    -WHERE��: ����(�Ϲ�����, ��������)�� ���
        .FROM���� SELECT�� ���� �ռ� ���� ����
        .SELECT������ ���ǵ� ������Ī ���� ������ �� ����
        .WHERE���� ���꿡 ������ ���� ����
    1. ���������
    -��Ģ������('+','-','/','*')�� '()'�� ����
    ��뿹) ������̺��� �� ����� ���ʽ��� ����Ͽ� ����Ͻÿ�
        ���ʽ�=�޿�*���������ڵ�(COMMISSION_PCT)*25%
        ���޾�=�޿�+���ʽ�
        Alias�� �����ȣ, �����,�޿�,���ʽ�,���޾��̴�
        --ǥ�� SQL�� ������ ���� ������ ���� �ݺ����� ������. 
    SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS �����,
           SALARY AS �޿�,
           COMMISSION_PCT AS ���������ڵ�,
        --�����ͺ��̽��� ������ �ִ� ���� NULL�� �����µ� �ڹٿ��� �������� ���� ��쿡�� ������ �����ϰ� ���� ������ �⺻�ʱ�ȭ �ȴ�. 
        --����Ŭ�� ������ ������ NULL�� ����Ѵ�. NULL���� ��Ģ������ �͵��� ����� �� NULL�� �ȴ�.
        --NULL�� ���ִ� �Լ� NVL(��,0)�̸� NULL�̸� 0�� ǥ��
           NVL((SALARY * COMMISSION_PCT * 0.25),0) AS ���ʽ�,
           SALARY + NVL((SALARY * COMMISSION_PCT * 0.25),0) AS ���޾�
    FROM HR.EMPLOYEES;
        --������ ��Ÿ���� ���� ��� WHERE���� ����� �ʿ䰡 ����
    ��뿹2)ȸ�����̺��� ȸ���� �ֹε�Ϲ�ȣ ���ڸ� 6�ڸ��� �̿��Ͽ� ���̸� ����Ͽ� ����Ͻÿ�
    ALIAS�� ȸ����ȣ, ȸ����, �ֹε�Ϲ�ȣ, ����, ���ϸ��� --LGU(�з��ڵ�)local government unit 
    SELECT MEM_ID ȸ����ȣ, MEM_NAME ȸ����, MEM_REGNO1�ֹε�Ϲ�ȣ, ����, MEM_MILEAGE���ϸ���
        --�̸��� �Ժη� �ٲٸ� �ȵȴ�. �ܷ�Ű�� ����Ҷ� Ư��
        --PRICE���� COST���Դܰ�, �����Ͱ� �ϰ����� �Ҿ������ ������ ������ �ߺ��̴�. BUY_COST�� BUYPROB���� ��� �Ǵ� ���̴�.
        --������ �����ͺ��̽������� �ߺ��� �ּ�ȭ ���Ѿߵȴ�.
        --CART_NOīƮ ��ȣ(������ 8�ڸ�+5�ڸ���ȣ), PRICE*CART_QTY�� �ؾ� ���Ұ����� �� �� �ִ�, �з��ؼ� �����ϴ� ����(����ȭ)��Ų�ٰ� �Ѵ�(�̻������� �߻����� �ʵ���)
        --CART�� �θ� MEMBER��PROD �ΰ��̴�, �������̺�(������ ���ؼ� ����� ��ô�Ǵ� ��)
        --LPROD�� �з� ���̺��̴�, ���� ���踦 �м��ϱ� ���� ���̴�, ID(�ڵ�) ���ܴ�(�ܼ� ����)�ϼ��� �ִ�. GU(�з��ڵ�) NM(�з���)
        --REGNO1(�ֹι�ȣ), ADD1(�⺻�ּ�)ADD2(���ּ�)LIKE(���)MEMORIAL(���������)DELETE(Ȱ��,�޸�,Ż��)
        --OUTLINE(����), TOTALSTOCK(���� ���), PROPERSTOCK(���� ���), UNIT(����)
        ID NAME LGU BUYER COST PRICE
    ��뿹2)ȸ�����̺��� ȸ���� �ֹε�Ϲ�ȣ ���ڸ� 6�ڸ��� �̿��Ͽ� ���̸� ����Ͽ� ����Ͻÿ�
    ALIAS�� ȸ����ȣ, ȸ����, �ֹε�Ϲ�ȣ, ����, ���ϸ��� --LGU(�з��ڵ�)local government unit 
    
    SELECT MEM_ID "ȸ�� ��ȣ", 
           MEM_NAME ȸ����,  
           MEM_REGNO1||'-'||MEM_REGNO2 �ֹε�� ��ȣ, --||�ڹ��� ���ڿ� ���̴� ��ɰ� ����
           EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2)) ����, --1��°���� �ι�° ��¥ �̾Ƴ���) EXTRACT�̾Ƴ��� ���� ���� ���ڷ� ���
          MEM_MILEAGE ���ϸ��� --�����̳� ��ɹ��� ��Ī���� ������ �� �ֵ���ǥ
    FROM MEMBER;

**MEMBER ���̺� ���� �� �Ϻ� �ڷ㸦 �����Ͻÿ�
    1)ȸ����ȣ: 'M001'
      MEM_BIR: 1975/03/15 => 2001/03/15
      MEM_REGNO1: 750315 => 010315
      MEM_REGNO2: 255555 => 4555555
    UPDATE MEMBER
    SET    MEM_BIR = TO_DATE('20010315'),
           MEM_REGNO1 = '010315',
           MEM_REGNO2 = '4555555'
    WHERE  MEM_ID=LOWER('MOO1');

    1)ȸ����ȣ: 't001'
      MEM_BIR: 1976/05/06 => 2000/05/06
      MEM_REGNO1: 760506 => 000506
      MEM_REGNO2: 1454731 => 3454731
    UPDATE MEMBER
    SET    MEM_BIR = TO_DATE('20000506'),
           MEM_REGNO1 = '000506',
           MEM_REGNO2 = '3454731'
    WHERE  MEM_ID = LOWER('TOO1');

    1)ȸ����ȣ: 'd001'
      MEM_BIR: 1946/04/09 => 2008/04/09
      MEM_REGNO1: 460409 => 080409
      MEM_REGNO2: 1454731 => 3454731
    UPDATE MEMBER
    SET    MEM_BIR = TO_DATE('20080409'),
           MEM_REGNO1 = '080409',
           MEM_REGNO2 = '3454731'
    WHERE  MEM_ID = LOWER('M001');
    
    
        SELECT MEM_ID "ȸ�� ��ȣ", 
           MEM_NAME AS ȸ����,  
           MEM_REGNO1||'-'||MEM_REGNO2 AS "�ֹε�� ��ȣ", --||�ڹ��� ���ڿ� ���̴� ��ɰ� ����, ""�� ���ڿ��� ������ ������ �� ����
           CASE WHEN SUBSTR(MEM_REGNO2,1,1)=3 OR
                     SUBSTR(MEM_REGNO2,1,1)=4 THEN
                 EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER('20'||SUBSTR(MEM_REGNO1,1,2))  --1��°���� �ι�° ��¥ �̾Ƴ���) EXTRACT�̾Ƴ��� ���� ���� ���ڷ� ���
            ELSE
                 EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2)) 
            END AS ����,
          MEM_MILEAGE ���ϸ��� --�����̳� ��ɹ��� ��Ī���� ������ �� �ֵ���ǥ
          FROM MEMBER;
          
    ��뿹2)ȸ�����̺��� ȸ���� �ֹε�Ϲ�ȣ ���ڸ� 6�ڸ��� �̿��Ͽ� ���̸� ����Ͽ� ���ɴ븦 ����Ͻÿ�.
    ALIAS�� ȸ����ȣ, ȸ����, �ֹι�ȣ, ���ɴ�, ���ϸ����̴�.
    10~19 10��, 20~29 20��, 30~39 30��
     SELECT MEM_ID "ȸ�� ��ȣ", 
            MEM_NAME AS ȸ����,  
            MEM_REGNO1||'-'||MEM_REGNO2 AS "�ֹε�� ��ȣ", --||�ڹ��� ���ڿ� ���̴� ��ɰ� ����, ""�� ���ڿ��� ������ ������ �� ����
            CASE WHEN SUBSTR(MEM_REGNO2,1,1)=3 OR
                     SUBSTR(MEM_REGNO2,1,1)=4 THEN
                  EXTRACT(YEAR FROM SYSDATE) - 
                    TO_NUMBER('20'||SUBSTR(MEM_REGNO1,1,2))  --1��°���� �ι�° ��¥ �̾Ƴ���) EXTRACT�̾Ƴ��� ���� ���� ���ڷ� ���
             ELSE
                  EXTRACT(YEAR FROM SYSDATE) - 
                    TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2)) 
            END ����,
            TRUNC(CASE WHEN SUBSTR(MEM_REGNO2,1,1)=3 OR
                     SUBSTR(MEM_REGNO2,1,1)=4 THEN
                  EXTRACT(YEAR FROM SYSDATE) - 
                    TO_NUMBER('20'||SUBSTR(MEM_REGNO1,1,2))  --1��°���� �ι�° ��¥ �̾Ƴ���) EXTRACT�̾Ƴ��� ���� ���� ���ڷ� ���
             ELSE
                  EXTRACT(YEAR FROM SYSDATE) - 
                    TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2)) 
            END,-1)||'��' AS ���ɴ�,
            MEM_MILEAGE ���ϸ��� --�����̳� ��ɹ��� ��Ī���� ������ �� �ֵ���ǥ
     FROM MEMBER;
     --TRUNC�Լ�(��,-1)�� �����̴�. ������ ���ڸ����� ������ ���ش�. -1���ڸ��� 1�� �ڸ��� ������ ������
     --ROUND�� �ݿø��� �Ǵµ� TRUNC�� ������ ������
     
     2.���迬����(OPERAND�ǿ����� OPERATION������)
     -�������� ũ�⸦ ���Ͽ� ���� ������ ��ȯ
     ->,<,>=,<=,=,<>(!=)
     -���� ���ǽ� ������ ���(WHERE��)--����Ŭ���� IF���� ����, WHERE������ ����Ѵ�
     
     ��뿹)ȸ�����̺��� ���ϸ����� 5000�̻��� ȸ���� ��ȸ�Ͽ� ȸ����ȣ, ȸ����, �ּ�, ����, ���ϸ����� ����Ͻÿ�
     SELECT MEM_ID ȸ����ȣ, 
            MEM_NAME ȸ����, 
            MEM_ADD1||' '||MEM_ADD2 �ּ�, 
            MEM_JOB ����, 
            MEM_MILEAGE ���ϸ���
    FROM    MEMBER
    WHERE   MEM_MILEAGE >= 5000
    ORDER BY MEM_MILEAGE ASC; --����Ŭ�� 1������ ī��Ʈ ��������Ʈ�� 10������ 5���� ���� �������� �Ѵ� ���� ��������, ASC��������
    --1�� ���������� ������̺��� ���θ޸𸮿� �������µ� 2�� �������� ���͸� 3�� ���������ϰ� 4������ ���÷��� ���ش�
    
    ��뿹) �������̺�(BUYPROD)���� ���Աݾ��� 10���� ������ �ڷḦ ��ȸ�Ͻÿ�
    ALIAS�� ��¥, ��ǰ�ڵ�, ���Լ���, �ܰ�, �ݾ��̸� ��¥��(ū������ ������)���� ����Ͻÿ�
    SELECT BUY_DATE ��¥, 
           BUY_PROD ��ǰ�ڵ�, 
           BUY_QTY ���Լ���, 
           BUY_COST �ܰ�, 
           (BUY_QTY*BUY_COST) �ݾ� 
    FROM   BUYPROD
    WHERE  (BUY_QTY*BUY_COST) <= 100000
    ORDER BY BUY_DATE ASC; --�÷� �ε����� SELECT���� �ش� ������ ORDERBY�� ���� �ִ�, ASC�� �⺻�̴�. �����Ǹ� �ڵ����� ����ȴ�
    --SELECT�� WHERE������ �ʰ� ����Ǽ� WHERE�� 5�� ����
    COMMIT;
    
    ��뿹)ȸ�����̺��� �������� '����'�� ȸ���� ��ȸ�Ͽ� ȸ����ȣ, ȸ����, �ּ�, �ڵ�����ȣ�� ����Ͻÿ�.
    SELECT MEM_ID ȸ����ȣ, 
           MEM_NAME ȸ����, 
           MEM_ADD1||' '||MEM_ADD2 �ּ�, 
           MEM_HP �ڵ�����ȣ
    FROM   MEMBER
    WHERE  SUBSTR(MEM_ADD1, 1,2) = '����';
    --WHERE MEM_ADD1 LIKE '����%';
    
    ��뿹) �������̺�(CART)���� ȸ���� 5-7�� ������Ȳ�� ����Ͻÿ�
           ��ȸ�� ������ ȸ����ȣ, ȸ����, ���űݾ� �̸� ���űݾ��� ���� ȸ������ ����Ͻÿ�
    SELECT A.CART_MEMBER ȸ����ȣ, 
           B.MEM_ID ȸ����, 
           SUM(A.CART_QTY*C.PROD_PRICE) ���űݾ� --SUM �ѻ���ڰ� ������ ��ǰ�ڵ�� ������ �����ִµ� �� ȸ���Ŵ� �� �����ش�
      FROM CART A, MEMBER B,PROD C --���̺� ������ �ο��� ���̴�(���̺� ��Ī)
     WHERE A.CART_MEMBER=B.MEM_ID
       AND A.CART_PROD=C.PROD_ID --��������, ���̺��� ��� 2�� �̻� ���������� �ּ��� ���̺�-1�� ��ŭ ����ߵȴ�.
       AND (SUBSTR(A.CART_NO,1,6)>='200505' AND SUBSTR(A.CART_NO,1,6)<='200507')
    GROUP BY A.CART_MEMBER, B.MEM_ID
    ORDER BY 3 DESC; --�÷��ε����� ����
           --SUM AVERAGE COUNT MINIMUM MAXIMUM �����Լ��� �Ϲ��÷��� SELECT���� ������ WHERE�� �������� GROUP BY�� �;ߵȴ�, GROUP BY���� �׷��Ҷ��� SELECT ����
           --�Ϲ� �÷��� �ٽ��ְ� SUM���� ���ΰŴ� �� �ᵵ �ȴ�.
           --FROM�� ������ WHERE���� �����Ѵ�, GROUP BY�� ȸ����ȣ�� ���� ������� ������, SELECT SUM�� �����Ѵ�. 
    
    
    
    
    
    
    
    
    
    
    