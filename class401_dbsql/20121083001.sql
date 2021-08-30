2021-08-30-01

��뿹) 2005�� 6�� ��� ��ǰ�� ���Ͽ� �Ǹ�Ƚ��,�Ǹż���,�Ǹűݾ��� ��ȸ�Ͻÿ�
        ALIAS�� ��ǰ�ڵ�,��ǰ��,�Ǹ�Ƚ��,�Ǹż���,�Ǹűݾ��̴�.
        SELECT      A.CART_PROD AS ��ǰ�ڵ�,
                    B.PROD_NAME AS ��ǰ��,
                    NVL(COUNT(A.CART_PROD), 0) AS �Ǹ�Ƚ��,
                    SUM(A.CART_QTY) AS �Ǹż���,
                    SUM(A.CART_QTY*B.PROD_SALE) AS �Ǹűݾ�
        FROM        CART A, PROD B
        WHERE       A.CART_NO LIKE '200506%' AND A.CART_PROD = B.PROD_ID
        GROUP BY    A.CART_PROD, B.PROD_NAME 
        ORDER BY    1 DESC;
        
        SELECT      B.PROD_ID AS ��ǰ�ڵ�,
                    B.PROD_NAME AS ��ǰ��,
                    COUNT(A.CART_QTY) AS �Ǹ�Ƚ��,
                    NVL(SUM(A.CART_QTY),0) AS �Ǹż���,
                    NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS �Ǹűݾ�
        FROM        CART A
        RIGHT OUTER JOIN PROD B ON (A.CART_PROD=B.PROD_ID
        AND         A.CART_NO LIKE '200506%')
        GROUP BY    B.PROD_ID, B.PROD_NAME;
-- ����, ����̶�� �λ簡 ������ 4~6���� �ǸŰ� �ȉ����� 0�� �Ǿ�� �Ѵ�.
-- �ܺ����ν� COUNT�� �������� ī��Ʈ�� ������ �Ǵ� �÷����� ����ؾ� �ȴ�.

4.MAX(COL), .MIN(COL)
- 'COL'���� ����� �÷��� �� �� ���� ū ���� ��ȯ
- 'COL'���� ����� �÷��� �� �� ���� ���� ���� ��ȯ
- ��ø����� ������ ����

��뿹) ������̺��� �μ��� �ִ�޿��װ�, �ּұ޿����� ���Ͻÿ�
--�������� ���߿��� ���� ���� ū ���� ���Ҷ��� GREATEST OR LEASTEST�� ����Ѵ�.
SELECT  DEPARTMENT_ID AS �μ��ڵ�,
        MAX(SALARY) AS �ִ�޿���,
        MIN(SALARY) AS �ּұ޿���
FROM    EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY 1;
--�μ����� �� ���� ������ �μ��� ������ŭ ����� ���´�. ������

��뿹) 2005�� 1�� �ִ���Լ��� ��ǰ ������ ��ȸ�Ͻÿ�.
    ALIAS�� ��ǰ�ڵ�, ���Լ����հ�, ���Աݾ��հ�

SELECT      BUY_PROD,
            SUM(BUY_QTY)
FROM        BUYPROD
WHERE       BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
GROUP BY    BUY_PROD
ORDER BY    2 DESC;

SELECT  A.BID, MAX(A.BSUM)

FROM    (SELECT     BUY_PROD AS BID,
                    SUM(BUY_QTY) AS BSUM
            FROM        BUYPROD
            WHERE       BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
            GROUP BY    BUY_PROD
            ORDER BY    2 DESC) A
WHERE       ROWNUM =1
GROUP BY    A.BID;

WITH A AS (SELECT     BUY_PROD AS BID,
                    SUM(BUY_QTY) AS BSUM
            FROM        BUYPROD
            WHERE       BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
            GROUP BY    BUY_PROD
            ORDER BY    2 DESC)
SELECT A.BID, MAX(A.BSUM)
FROM  A
WHERE ROWNUM =1
GROUP BY    A.BID;  

��뿹) ������ 2005�� 7�� 28���̶�� �����ϰ� ���� �ڷᰡ �ǸŵǾ����� �� ������ CART���̺� �����Ͻÿ�
    [�ڷ�]
    �ǸŰ�:'E001'
    �ǸŻ�ǰ:'P202000007'
    �Ǹż���: 5��
    
    �ǸŻ�ǰ:'P302000022'
    �Ǹż���: 12��
    ��ٱ��Ϲ�ȣ�� �ڵ����� ������Ű�ÿ�.

-- CART���̺� �μ�Ʈ �ϰ� ������̺��� �ִٸ� 5���� ���̰� ���ϸ����� �����ؾ���ߵȴ�. �ִ� �ڷ��� ���� �������ִ� ���̴�.
-- ���̺��� �ڵ����� ������ �ִ� ���� Ʈ���Ŷ�� �Ѵ�.
(��ٱ��Ϲ�ȣ ����)
    SELECT MAX(CART_NO)+1
    FROM    CART
    WHERE   CART_NO LIKE '20050728%';
-- ���߿� ��ǰ�� ���鶧�� ���ڷθ� ����־ ������ �����ϵ��� ����
(��ٱ��Ͽ� �ڷ� ����)
    INSERT INTO CART
    SELECT 'e001', MAX(CART_NO)+1, 'P202000007', '5'
    FROM    CART
    WHERE   CART_NO LIKE '20050728%';
    
(ȸ�����̺��� ���ϸ��� ����)
    UPDATE MEMBER
    SET     MEM_MILEAGE=MEM_MILEAGE+(SELECT MEM_MILEAGE* 5 AS AMT
                                            FROM PROD
                                            WHERE PROD_ID='P202000007') 
                        WHERE  MEM_ID = 'e001';
                        
E001�� ���ϸ��� - 6500
���ϸ��� �߰��� = 210
COMMIT;
--������Ʈ�� ���𰡸� ��� �ȶ� ���θ��̴ٶ�� �ϸ� �ǸŰ� �̷���� ���� �� ������ ������ �ؾ� ���� �����غ���
--�������̺� �����ϰ� ��� ���̺� �������ְ� ���
MAX(����) MIN(�ǿ�)

