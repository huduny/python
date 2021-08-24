2021-08-24-02
    - �ڷ��� ��(������ Ÿ��)�� ��ȯ�ϴ� �Լ�
    - CAST, TO_CHAR, TO_NUMBER, TO_DATE ����
    1)CAST(EXPR AS DATA_TYPE) TO_CHAR TO_NUMBER TO_DATE(���ڿ��� ��¥�� �ٲ۴�, ���ڸ� ��¥�� �ٲܼ� ����) : �� ��ġ������ ��ȯ�ǰ� ����Ǿ� �ִ� �����ʹ� ��ȯ�� ����.
    - �־��� ������ EXPR�� ��������� AS ���� ����� '������Ÿ��'���� ��ȯ
    - �����ڷ��� ���� �Һ���
    
    ��뿹) 2005�� 6�� ���ں� ������Ȳ�� ��ȸ�Ͻÿ�.
    ALIAS�� ��¥, �Ǹż����հ�, �Ǹűݾ��հ��̸� ��¥������ ����Ͻÿ�.
    
    SELECT  CAST(SUBSTR(A.CART_NO, 1, 8) AS DATE) AS ��¥, 
            SUM(A.CART_QTY) AS �Ǹż����հ�, 
            SUM(A.CART_QTY*B.PROD_PRICE) AS �Ǹűݾ��հ�
    FROM    CART A, PROD B
    WHERE       A.CART_PROD = B.PROD_ID AND //���� �����ϱ�        
    A.CART_NO LIKE '200506%'
    GROUP BY    SUBSTR(A.CART_NO, 1, 8)
    ORDER BY    1;
    15/1110
��뿹) 2005�� 5�� ���ں� ����ȸ������ ��ȸ�Ͻÿ�
��¥, ����ȸ���� ��, COUNT�Լ��� ������� ����
    SELECT  CAST(SUBSTR(CART_NO, 1, 8) AS DATE) AS ��¥,
            MAX(SUBSTR(CART_NO,9)) AS ����ȸ���� --9��°���� ������ �� 3��° �Ű������� �����Ǹ�
    FROM    CART 
    WHERE   CART_NO LIKE '200505%'
    GROUP BY CAST(SUBSTR(CART_NO,1,8) AS DATE)
    ORDER BY 1;
    
    SELECT CAST(SUBSTR(LPROD_GU,2,4) AS NUMBER) FROM LPROD;
    --���󵵼� TO_CHAR, TO_DATE, TO_NUMBER��
    
2) TO_CHAR(EXPR[,FMT])
    - 'EXPR'�����͸� 'FMT'���Ŀ� �µ��� ���ڿ��� ��ȯ
    - 'EXPR'�� ����, ��¥, ���ڿ�(CHAR,CLOB=>VARCHAR2)�� ���ڿ��� ��ȯ
    - ��¥�� �����������ڿ�(FMT)
    ----------------------------------------------------------------
    FORMAT����        �ǹ�      ��
    ----------------------------------------------------------------
    AD, CC, BC      ����,����       SELECT TO_CHAR(SYSDATE,'CC AD') FROM DUAL;
    Q               �б�           SELECT TO_CHAR(SYSDATE, 'BC Q"�б�"') FROM DUAL;
    YYYY,YYY,YY,Y   �⵵           SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;    
                                  SELECT TO_CHAR(SYSDATE, 'YYY-MM-DD') FROM DUAL;  
                                  SELECT TO_CHAR(SYSDATE, 'YY-MM-DD') FROM DUAL;  
    MM, RM          ��(01~12)      SELECT TO_CHAR(SYSDATE, 'YY-MM') FROM DUAL;
                      (I~XII)     SELECT TO_CHAR(SYSDATE, 'YY-RM') FROM DUAL;
    MON, MONTH      ��(1��~12��)   SELECT TO_CHAR(SYSDATE, 'YY-MON') FROM DUAL;
                                    SELECT TO_CHAR(SYSDATE, 'YY-MONTH') FROM DUAL;
    DD              ��(01-30)        SELECT TO_CHAR(SYSDATE, 'YY-MM-DD') FROM DUAL;
    D                ���� ��(1-7)      SELECT TO_CHAR(SYSDATE, 'YY-MM-D') FROM DUAL;
    DDD             ���� ��(1-365)     SELECT TO_CHAR(SYSDATE, 'YY-MM-DDD') FROM DUAL;
    DAY             �������� ���Ϸ�    SELECT TO_CHAR(SYSDATE, 'YY-MM-DAY') FROM DUAL;
    DL              ������(���ϱ���)    SELECT TO_CHAR(SYSDATE, 'DL') FROM DUAL;
    HH, HH12, HH24  �ð� 
    MI                  ��
    SS, SSSSS           ��           SELECT TO_CHAR(SYSDATE, 'SSSSS') FROM DUAL;
    --SS ���� �� ǥ�� SSSSS 0��0��0�ʺ��� ���ݱ��� ����� ��
    W, WW               ��
    --W���� WW 52��
    AM,PM,A.M.,P.M.S    ����,����      SELECT TO_CHAR(SYSDATE, 'YY-MM-DD AM HH24:MI:SS :SSSSS') FROM DUAL;
    --AM�� �ᵵ ���� �ð���� ���Ľð��� ���´�
    '" " '            ����ڰ� ������ ���ڿ��� �ݵ�� ""�ȿ� ���
                                      SELECT TO_CHAR(SYSDATE, 'YY-MM-DD AM"(��)" HH24:MI:SS :SSSSS') FROM DUAL;  
    ------------------------------------------------
     - ������ �����������ڿ�(FMT)
    ----------------------------------------------------------------
    FORMAT����            �ǹ�              ��
    ----------------------------------------------------------------
    .(DOT),,(COMMA)     �Ҽ����� �ڸ���       SELECT TO_CHAR(2345678,'99,999,999.99') FROM DUAL; --,�� ���� ���ڷμ��� ����� �Ұ� ����� ���ڷ� ��ȯ�� �ȵȴ�
    9,0                 9:��ȿ���ڿ� ����, �����Ǵ� �����Ͱ� ��ȿ�� 0�̸� ����ó��
                        0:��� ���ڿ� ����, �����Ǵ� �����Ͱ� ��ȿ�� 0�̸� 0�� ���
    PR                  ������ <>�ȿ� ǥ��    SELECT TO_CHAR(-2339,'9999PR'),
                                                  TO_CHAR(239,'999PR')  FROM DUAL
    L,$                 ȭ���ȣ ���         SELECT TO_CHAR(12345,'L99,999') FROM DUAL; -- L�� LOCATION ó�� ������ ���������� �����ȴ�
                                             SELECT TO_CHAR(12345,'$99,999') FROM DUAL;        
    ---------------------------------------------------------------
    SELECT TO_NUMBER(TO_CHAR(12345.789,'99,999.99')) FROM DUAL;
    SELECT (TO_CHAR(12345.789,'999,999.99')) FROM DUAL;
     SELECT TO_NUMBER(TO_CHAR(12345.789,'99999.99')) FROM DUAL;
    --9�� �����Ǵ� ���ڸ� ������ ���ڸ� ���, �ݿø�, �Ǿ��� �������� ǥ��
    --9�� 0���� �ᵵ �����Ǵ� ���ڸ� ������ ���ڸ� ��� �׷��� �Ǿտ� 0�� 0�� ������ 0�� ����Ѵ�. ���� �ִ� �������� ����
    --�ڸ��� ������ ���ڷ� ��ȯ���� ���ߴµ� �ڸ����� ���ָ� ���ڷ� ��ȯ�� �����ϴ�.
    --ȸ�迡�� ��ǥ�� ���鶧�� -ǥ�ø� <>�� ��ȣ�Ѵ�.
    
    
    
    
    