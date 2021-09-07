2021-09-06
**�������� ���� ���̺� ����
1. ���̺��: REMAIN
2. �÷�: 
-------------------------------------------------------------
�÷���           ������Ÿ��       PK/FK           �⺻��
-------------------------------------------------------------
REMAIN_YEAR    CHART(4)       PK
PROD_ID        VARCHAR2(10)   PK/FK
REMAIN_J_00    NUMBER(5)                        0
REAMIN_I       NUMBER(5)                        0
REMAIN_O       NUMBER(5)                        0
REMAIN_J_99    NUMBER(5)                        0
REMAIN_J_DATE  DATE                             0
-------------------------------------------------------------
REMAIN_J_00: �������
REAMIN_I: �԰�
REMAIN_O: ���
REMAIN_J_99: �⸻���
REMAIN_J_DATE: ���� ��¥

CREATE TABLE REMAIN (
REMAIN_YEAR    CHAR(4),
PROD_ID        VARCHAR2(10),
REMAIN_J_00    NUMBER(5) DEFAULT 0,
REMAIN_I       NUMBER(5) DEFAULT 0,
REMAIN_O       NUMBER(5) DEFAULT 0,
REMAIN_J_99    NUMBER(5) DEFAULT 0,
REMAIN_J_DATE  DATE,
CONSTRAINT PK_REMAIN PRIMARY KEY(REMAIN_YEAR,PROD_ID),
CONSTRAINT FK_REMAIN_PROD FOREIGN KEY(PROD_ID) 
REFERENCES PROD(PROD_ID));

1) ���������� �̿��� �ڷ� ����
(�������)
-INSERT INTO ���̺��[(�÷�LIST)]
��������;
.VALUES ���� �����Ѵ�.
.�������� ����� '()'�� ������

��뿹) REMAIN ���̺� �����ڷḦ �����Ͻÿ�
    REMAIN_YEAR: '2005'
    PROD_ID: PROD���̺��� ��� ��ǰ�ڵ�
    REMAIN_J_00: PROD���̺��� PROD_PROPERSTOCK ��
    REMAIN_I,REAMIN_O: 0
    REMAIN_DATE: '2004-12-31'
    
INSERT INTO REMAIN (REMAIN_YEAR, PROD_ID, REMAIN_J_00, REMAIN_J_99, REMAIN_J_DATE)
SELECT '2005', PROD_ID, PROD_PROPERSTOCK, PROD_PROPERSTOCK, TO_DATE('20041231')
FROM PROD;

COMMIT;

1) ���������� �̿��� �ڷ� ����
(�������)
UPDATE TABLE ���̺��
SET (�÷���1[,�÷���2,...]}=(��������)
[WHERE ����]

��뿹) 2005�� 1~3�� ���̿� �߻��� ���������� ���������̺�(REMAIN)�� �����͸� �����Ͻÿ�
REMAIN_I, REMAIN_J_99, REMAIN_J_DATE
UPDATE TABLE REMAIN_I, REMAIN_J_99, REMAIN_J_DATE
SET        REMAIN I = ( SELECT      BUY_PROD,
            SUM(BUY_QTY)
FROM        BUYPROD
WHERE       BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
GROUP BY    BUY_PROD    )
            REMAIN_J_99 = REMAIN I + 

2005�� 1~3�� ���̿� �߻��� ��������
SELECT      BUY_PROD,
            SUM(BUY_QTY)
FROM        BUYPROD
WHERE       BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
GROUP BY    BUY_PROD    

SELECT      BUY_PROD,
            SUM(BUY_QTY)
FROM        BUYPROD
WHERE       BUY_DATE BETWEEN '20050101' AND '20050131'
GROUP BY    BUY_PROD    

(��������)
UPDATE  REMAIN A
SET     (A.REMAIN_I, A.REMAIN_J_99, A.REMAIN_J_DATE)=
        (SELECT A.REMAIN_I+B.AMT, A.REMAIN_J_99+B.AMT, TO_DATE('20050331')
         FROM       (SELECT     BUY_PROD AS BID,
                                SUM(BUY_QTY) AS AMT
                     FROM       BUYPROD
                     WHERE      BUY_DATE BETWEEN '20050101' AND '20050331'
                     GROUP BY   BUY_PROD) B
         WHERE   A.PROD_ID = B.BID)
WHERE  A.REMAIN_YEAR='2005'
--ROLLBACK;
AND    A.PROD_ID IN (SELECT     DISTINCT BUY_PROD
                     FROM       BUYPROD
                     WHERE      BUY_DATE BETWEEN '20050101' AND '20050331');
--���������� ������Ʈ �ؾߵ� ���� ��������� �ȴ�
--������ ���ص� �� ����� �ȴ�.
--������ ����Ǿ��� ���� ã�°Ű� �ؿ��� ������Ʈ�� ����ϴ� �ڷḦ �ɷ����ߵȴ�.
COMMIT;
��뿹) 2005�� 4�� ��ǰ�� ������ ��ȸ�Ͽ� ���������̺��� �����Ͻÿ�
--�������� 2005�� 4�� ��ǰ�� ����
SELECT      CART_PROD AS CPROD,
            SUM(CART_QTY) AS SQTY
FROM        CART
WHERE       CART_NO LIKE '200504%'
GROUP BY    CART_PROD
        
--��������
UPDATE      REMAIN A
SET         (A.REMAIN_O, A.REMAIN_J_99, A.REMAIN_J_DATE)=
            (SELECT A.REMAIN_O+B.SQTY, A.REMAIN_J_99-B.SQTY ,TO_DATE('20050430')
             FROM (SELECT      CART_PROD AS CPROD,
                               SUM(CART_QTY) AS SQTY
                   FROM        CART
                   WHERE       CART_NO LIKE '200504%'
                   GROUP BY    CART_PROD) B
             WHERE  A.PROD_ID=B.CPROD)      
WHERE        A.REMAIN_YEAR='2005'
AND          A.PROD_ID IN (SELECT     DISTINCT CART_PROD
                           FROM       CART
                           WHERE      CART_NO LIKE '200504%') ;
COMMIT;   
-- PKŰ�� 2���̹Ƿ� WHERE���� 2���� ��� ������ ����� ��� ��Ȯ�� �ε��� �� �ּҰ� ����ȴ�,
-- �������� �ֿ�Ű�� ������ ���������� ������ ��� �ۼ��� ��� �ȴ�.
ALTER TABLE REMAIN
RENAME COLUMN REMAIN_J_99 TO REMAIN_99;

��뿹) 2005�� 4�� 28�� �Ǹŵ� ��ǰ�� �� īƮ��ȣ '2005042800002'�� �ڷᰡ ��� ��ǰ�Ǿ���. �̸� ó���Ͻÿ�.
2005�� 4�� 28�� �Ǹŵ� ��ǰ�� �� īƮ��ȣ '2005042800002'
SELECT   CART_PROD AS CPROD,
         SUM(CART_QTY) AS SCQTY
FROM     CART
WHERE    CART_NO LIKE '20050428%'
GROUP BY CART_PROD;

--��ġ��
UPDATE  REMAIN A
SET     (A.REMAIN_O, A.REMAIN_99, A.REMAIN_J_DATE) =
        (SELECT A.REMAIN_O-B.SCQTY, A.REMAIN_99+B.SCQTY, TO_DATE('20050501')
         FROM (SELECT   CART_PROD AS CPROD,
                        SUM(CART_QTY) AS SCQTY
               FROM     CART
               WHERE    CART_NO LIKE '20050428%'
               GROUP BY CART_PROD) B
         WHERE A.PROD_ID=B.CPROD)
WHERE    A.REMAIN_YEAR='2005'
AND      A.PROD_ID IN (SELECT     DISTINCT CART_PROD
                       FROM       CART
                       WHERE      CART_NO LIKE '2005042800002');

DELETE CART
WHERE CART_NO LIKE '2005042800002';
COMMIT;

2021-09-06-02)���տ�����
- ���տ����ڴ� SQL �˻������ ����(SET)���� �����Ͽ� ���� ����(���� SQL ���)�� ��������ϴ� ����
- UNION, UNION ALL, INTERSECT(������), MINUS(������) ������ ����
- ���� ���ѻ���
1) ���տ����ڷ� ����Ǵ� �� SELECT���� �÷��� �� ������ Ÿ���� ��ġ�ؾ� ��
    - ����� �� ó�� SELECT ���� �������� ��µȴ�.(������)
2) ORDER BY ���� �� ������ SELECT �������� ��� ����
3) BLOB, CLOB, BFILE Ÿ���� �÷��� ���Ͽ� ���տ����ڸ� ����� �� ����.
4) LONG Ÿ���� �÷��� UNION, INTERSECT, MINUS ���꿡 ���� �� �� ����
--������ ���ϼ� �ִ�. ���������� �ٿ��ټ� �ִ�.
--UNION�� ��쿡�� �ߺ��� ���� �ѹ���(DISTINCT)���ش�, UNION ALL�� �ߺ��� ���� �ι� ���´�.

1. UNION
-�������� ����� ��ȯ
-������ �κ��� ���Ҵ� �ѹ��� ��ȯ��

��뿹) ȸ�����̺��� ���̰� 30�� ȸ���� ȸ����ȣ, ȸ����, ����, ���ϸ����� 
        ����ȸ���� ȸ����ȣ, ȸ����, ����, ���ϸ����� ��ȸ�Ͻÿ�
        
        SELECT  MEM_ID AS ȸȣ, MEM_NAME AS ȸ����,CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('2','4') THEN '����' ELSE '����' END AS ����,
                MEM_JOB AS ����, MEM_MILEAGE AS ���ϸ���
        FROM    MEMBER
        WHERE   TRUNC(EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM MEM_BIR), -1) = 40
        UNION
        SELECT  MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����,CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('2','4') THEN '����' ELSE '����' END AS ����, 
                RTRIM(MEM_LIKE) AS �����, MEM_MILEAGE AS ���ϸ���
        FROM    MEMBER
        WHERE   SUBSTR(MEM_REGNO2,1,1) IN('2','4')
        ORDER BY 3 DESC;


