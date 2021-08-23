2012-08-23-01
9) INSTR(c1, c2[,m[,n]]) --index of string, �־��� ���ڿ����� Ư�� ���ڰ� ��Ÿ�� ��ġ��,�ڹٿ��� charAt() �־��� ���ڿ����� ���� ��ȯ
    - �־��� ���ڿ� c1���� c2���ڰ� ó�� ��Ÿ���� ��ġ��(�ε���)�� ��ȯ, m�� �˻� ������ġ ���̰�, n�� �ݺ�Ƚ���� ����
    - M��N�� �����Ǹ� ó�� ���� ��ġ�� �����ش�.

��뿹) 
    SELECT  TRIM(INSTR('APPLEPERSIMONBANNAORANGE','A')) A,
            TRIM(INSTR('APPLEPERSIMONBANNAORANGE','A',5)) B,
            TRIM(INSTR('APPLEPERSIMONBANNAORANGE','A',1,2)) C,
            TRIM(INSTR('APPLEPERSIMONBANNAORANGE','A',10,2)) D
    FROM    DUAL;
    
10) LENGTH(c1), LENGTHB(C1)
    -LENGTH(c1) : C1�� ���Ե� ���ڼ� ��ȯ
    -LENGTHB(C1) : C1�� ���Ե� �������� ����(BYTE) ��ȯ
    
��뿹)
    SELECT  MEM_ADD1 �ּ�,
            LENGTH(MEM_ADD1) ���ڼ�,
            LTRIM(LENGTHB(MEM_ADD1)) "��� ������ ũ��"
    FROM MEMBER;
    --�����޼��� FROM KEYWORD�� ������ FROM ���� �߸� �Ȱ� �ƴ϶� SELECT ���� �߸��� ������ Ȯ�� �غ���.
    
    SELECT  EMP_NAME �����,
            LENGTH(EMP_NAME) ���ڼ�,
            LENGTHB(EMP_NAME) "������ ũ��"
    FROM    HR.EMPLOYEES
    WHERE   DEPARTMENT_ID=80;

2. �����Լ�
    1) �������Լ�
        - ABS(N), SIGN(N), SQRT(N), POWER(N,E), ...
        (1) ABS(N)
            .N�� ���밪 ��ȯ --������ ���Ҷ� ���
        (2) SIGN(N)
            .N�� ��ȣ�� ���� -1, 0, 1�� ��ȯ
            .N>0 �̸� N�� ũ�⿡ ������� 1�� ��ȯ
            .N<0 �̸� N�� ũ�⿡ ������� -1�� ��ȯ
            .N=0 �̸� N�� ũ�⿡ ������� 0�� ��ȯ
        (3) SQRT(N)
            .N�� ���� ���� ��ȯ --�ε��� �Ź�, ���� ������ �����. 405ȣ ������ ģ���� ��� �м��� �� �� �ִ� ������Ʈ, ��� �м��� ���ؼ��� �α�+����
            --���� ������ �� ����. ���������� �ڵ����� ���, �����α��� ���ƾ� �ǰ�, ���� ����� ���ƾߵȴ�, �����α��� ���ƾ� �ȴ�. ����������
            --���ð��翡�� ������ �������� �ǰŷ� ������ ����
            --�ΰ����� �κп��� ��ȭ�н��� �̿��ϸ� �ڱ��н��� ��ų�� �ִ�
        (4) POWER(N,E)
            .N�� E�� �ŵ���� ��(�� N�� E��)
��뿹)
    SELECT  ABS(-290) A,
            ABS(-0.0093) B,
            SIGN(100000) C,
            SIGN(0.000001) D,
            SIGN(-290) E,
            SIGN(0) F,
            SQRT(77) G,
            POWER(2,10) H
    FROM    DUAL;
    
    2) GREATEST(N1,N2,[,N3,...]), LEAST(N1,N2,[,N3,...])
    - GREATEST(N1,N2,[,N3,...]): �־��� �� N1~NM�� ���� ū ���� ��ȯ
    - LEAST(N1,N2,[,N3,...]): �־��� �� N1~NM�� ���� ���� ���� ��ȯ
    --MAX�� MINIMUM�� ���� ���ϴ� ���� ���Ҷ� ���, �׷��� ���� ����� ����
    --GREATEST�� LEAST �˰� �ִ� �� �߿�
��뿹)
    SELECT  PROD_ID,
            PROD_NAME,
            GREATEST(PROD_SALE,PROD_PRICE,PROD_COST) ū��
    FROM    PROD;        
--��(�÷�)���� �־������� MAX�� ����, GREATEST�� ������ ������ ���� ū ����

    SELECT  MAX(PROD_SALE),
            MAX(PROD_PRICE),
            MAX(PROD_COST)
    FROM    PROD;
    
��뿹) GREATEST �Լ��� ����Ͽ� ������̺��� �޿��� 2500�̸��� ����� �޿��� 2500���� ��ȯ�ϴ� SQL�� �ۼ��Ͻÿ�
       ALIAS�� �����ȣ, �����, ���޿�, ����޿�
    SELECT  EMPLOYEE_ID �����ȣ, 
            EMP_NAME �����, 
            SALARY ���޿�,
            GREATEST(SALARY, 2500) ����޿� 
    FROM    EMPLOYEES
    WHERE   SALARY < 2500;

    SELECT LEAST('������','��õ��','õ�Ƚ�','���ɽ�') FROM DUAL;
    --ù���ڸ� ������ ASCII������ ������ ���� ���� ���Ѵ�.
    
    3) ROUND(N,L), TRUNC(N,L)
        - L�� ����� ���
        .ROUND: �־��� �� N���� �Ҽ��� ���� L+1��° �ڸ����� �ݿø��Ͽ� L�ڸ����� ��ȯ
        .TRUNC: �־��� �� N���� �Ҽ��� ���� L+1��° �ڸ����� �����Ͽ�(�ڸ�����) L�ڸ����� ��ȯ
        - L�� ������ ���
        .ROUND: �־��� �� N���� �����κ� L��° �ڸ����� �ݿø��� ����� ��ȯ
        .TRUNC: �־��� �� N���� �����κ� L��° �ڸ����� ������ ����� ��ȯ
        - L�� �����Ǹ� 0���� ����
        -- 374.456789// ROUND ,2�� 300 TRUNC ,2�� 200// ROUN , �̸� �Ҽ����� ���ش�.
        
��뿹) ������̺��� ������� ���޵� �޿��� ����Ͽ� ����Ͻÿ�. ���޾�=�޿�+���ʽ�-����. ���ʽ�=�޿��� 17%. ����=(�޿�+���ʽ�)�� 6%.
       ���޾��� �Ҽ�1�ڸ����� �ݿø��Ͽ� ����Ͻÿ�
       ALIAS�� �����ȣ, �Ի���, �����ڵ�, �޿�, ���ʽ�, ����, ���޾�
    SELECT  EMPLOYEE_ID �����ȣ, 
            HIRE_DATE �Ի���, 
            JOB_ID �����ڵ�,
            SALARY  �޿�, 
            (SALARY*0.17) ���ʽ�, 
            ROUND((SALARY+SALARY*0.17)*0.06,1) ����,
           -- ROUND(((SALARY+(SALARY*0.17))-((SALARY+SALARY*0.17)*0.06)),1) ���޾�
            TO_CHAR(((SALARY+(SALARY*0.17))-((SALARY+SALARY*0.17)*0.06)),'999,999.0') ���޾�
           -- CHAR�� ���� + - / *�� ���̻� ����� �� ����.
    FROM    EMPLOYEES; 
   
��뿹) 2005�� 7�� ������Ȳ�� ����Ͻÿ�
        ����� ������ CART_NO ��¥, ȸ����, ��ǰ��, CART_QTY ����, �ݾ��̸� �ݾ��� �ʴ������� �����Ͽ� ����Ͻÿ�
        
    SELECT  SUBSTR(A.CART_NO,1,8) ��¥, 
            B.MEM_NAME ȸ����, 
            C.PROD_NAME ��ǰ��, 
            A.CART_QTY ����, 
            A.CART_QTY*C.PROD_PRICE �ݾ�,
           TRUNC(A.CART_QTY*C.PROD_PRICE, -2) �ݾ�1
    FROM    CART A, MEMBER B, PROD C
    WHERE   A.CART_NO LIKE '200507%'
    AND     A.CART_MEMBER=B.MEM_ID
    AND     A.CART_PROD=C.PROD_ID
    ORDER BY 1;
    
4) FLOOR(N), CEIL(N)
    -FLOOR(N): N�� ���ų� N���� ���� �� �� ���� ū ���� --���������� �������
    -CEIL(N): N�� ���ų� N���� ū �� �� ���� ���� ������ ��ȯ�ϴ� �Լ��� �޿�, ���ݰ� ���� �ݾ� ó���� �ַ� ��� --ū������ �������
    
��뿹) SELECT   FLOOR(268.2345),
                FLOOR(-268.2345),
                CEIL(268.2345),
                CEIL(-268.2345)
       FROM     DUAL;
    -- MOD REMINDER ������ ���ϴ� ����
        
5) MOD(N1,N2), REMAINDER(N1,N2)
    -N1�� N2�� ���� �������� ��ȯ
    -�� �Լ��� ���������� ���� ����� �ٸ���
    -REMAINDER�� �������� ������ 50%�̻��� ���� �Ǿ��� �� �� ���� �򿡼� ������ ���� ���� (������N1:�����⸦ ���ϴ� ��,����N2:������ ��)
    -MOD(N1,N2)=N1-N2*FLOOR(N1/N2)
    -REMAINDER(N1,N2)=N1-N2*ROUND(N1/N2)
    
    EX) MOD(26,7) = 26-7*FLOOR(26/7)
                  = 26-7*FLOOR(3.7143)
                  = 26-7*3
                  = 26-21
                  = 5
        REMAINDER(26,7) = 26-7*ROUND(26/7)
                        = 26-7*ROUND(3.7143)
                        = 26-7*4
                        = -2
    SELECT MOD(26,7), REMAINDER(26,7) FROM DUAL;
        
6) WIDTH_BUCKET(N,MIN,MAX,B)
    - MIN���� MAX������ ���� B���� �������� ���������� �־��� �� N�� �� ���� �� ��� ������ ���ԵǴ����� ��ȯ

��뿹) ������̺��� �޿��� 10���� �������� ������ �� ����� ��� ������ ���ԵǴ����� ��ȸ�Ͻÿ�.
       ALIAS�� �����ȣ, �����, �޿�, ������

    SELECT  EMPLOYEE_ID �����ȣ, 
            EMP_NAME �����, 
            SALARY �޿�, 
            WIDTH_BUCKET(SALARY, 2000,25000, 10) ������ --���Ѱ��ϰ� ���� ������ ������ �Ѿ�� �ȴ�. ���Ѱ��� ������ �ȴ�.
    FROM    EMPLOYEES;
        
��뿹) ȸ�����̺��� ȸ���� ���ϸ����� 1000-9000 ������ 10���� �����Ҷ� ��� ������ ���ϴ����� ���ϰ� �� �������� ��޶��� ����Ͻÿ�.
        ��, ���ϸ����� ���� ����� ���� ����� �ο��Ͻÿ�
        ALIAS�� ȸ����ȣ, ȸ����, ���ϸ���, ���
        SELECT  MEM_ID ȸ����ȣ, 
                MEM_NAME ȸ����, 
                MEM_MILEAGE ���ϸ���, 
                WIDTH_BUCKET(MEM_MILEAGE, 9000, 999, 10) ���
        FROM    MEMBER;
    

