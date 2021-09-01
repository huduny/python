2021-09-01-01)
2) ��Ƽ����
    - ���������� ���Ǵ� ����
    - ���������� ��ȯ�Ǵ� ���̺�(��)�� ���� ������������ �����ϴ� �����͸� �����ϴ� ���� ���
    - NOT IN �Ǵ� EXISTS ������ ���
    
** �μ����̺� �μ���ȣ 30,50,90�� �μ��� �μ��� �����ȣ(MANAGER_ID)�� NULL�� �����Ͻÿ�.
UPDATE      DEPARTMENTS -- ���̺�
SET         MANAGER_ID=NULL -- ���� �ٲ��
WHERE       DEPARTMENT_ID IN(30,50,90); --����, ������

SELECT * 
FROM DEPARTMENTS
WHERE DEPARTMENT_ID IN(30,50,90);
ROLLBACK;

��뿹) �μ����̺��� MANAGER_ID�� NULL�� �μ� �̿��� �μ��� �ٹ��ϴ� ����� �����ȣ, �����, �μ���ȣ, �μ����� ��ȸ�Ͻÿ�.

SELECT      A.EMPLOYEE_ID �����ȣ, 
            A.EMP_NAME �����, 
            B.DEPARTMENT_ID �μ���ȣ, 
            B.DEPARTMENT_NAME �μ���
FROM        EMPLOYEES A JOIN DEPARTMENTS B ON (B.DEPARTMENT_ID=A.EMPLOYEE_ID);
WHERE       NOT IN (SELECT      DEPARTMENT_ID
                    FROM        DEPARTMENTS
                    WHERE       MANAGER_ID IS NULL);

-------------------------------------------
SELECT      DEPARTMENT_ID
FROM        DEPARTMENTS
WHERE       MANAGER_ID IS NULL;
--------------------------------------------
SELECT      A.EMPLOYEE_ID �����ȣ, 
            A.EMP_NAME �����, 
            B.DEPARTMENT_ID �μ���ȣ, 
            B.DEPARTMENT_NAME �μ���
FROM        EMPLOYEES A,  DEPARTMENTS B
WHERE       A.EMPLOYEE_ID = B.DEPARTMENT_ID
AND         A.DEPARTMENT_ID NOT IN(SELECT   DEPARTMENT_ID
                                    FROM    DEPARTMENTS
                                    WHERE   MANAGER_ID IS NULL);

SELECT      A.EMPLOYEE_ID �����ȣ, 
            A.EMP_NAME �����, 
            A.DEPARTMENT_ID �μ���ȣ, 
            B.DEPARTMENT_NAME �μ���
FROM        EMPLOYEES A,  DEPARTMENTS B
WHERE       A.EMPLOYEE_ID = B.DEPARTMENT_ID
AND         A.DEPARTMENT_ID NOT IN (SELECT      DEPARTMENT_ID
                                    FROM        DEPARTMENTS
                                    WHERE       MANAGER_ID IS NULL);
-------------------------------------------------------
SELECT      A.EMPLOYEE_ID �����ȣ, 
            A.EMP_NAME �����, 
            B.DEPARTMENT_ID �μ���ȣ, 
            B.DEPARTMENT_NAME �μ���
FROM        EMPLOYEES A,  DEPARTMENTS B
WHERE       A.EMPLOYEE_ID = B.DEPARTMENT_ID
AND         NOT EXISTS (SELECT 1 --1�� TRUE 0�� FALSE
                        FROM   DEPARTMENTS C 
                        WHERE  C.MANAGER_ID IS NULL
                        AND    A.EMPLOYEE_ID = C.DEPARTMENT_ID);
--10�� �μ��� ������ ���� �ʾƼ� 1�� ������� �ʴ´�. �׷��� EXISTS�� FALSE�� �Ǵµ� NOT�� �ٿ��� TRUE�� �Ǽ� �� SELECT���� ����ȴ�.
--30�� �μ��� ������ �¾Ƽ� NULL�̾ ������ ���̾ 1�� ����ϰ� EXISTS�� ���� �ǰ� NOT�� �پ FALSE�� �ǰ� WHERE���� ������ �Ǽ� ó������ �ʴ´�.
--EXISTS�� �ڿ� �ݵ�� ���������� ����;ߵȴ�

��뿹) 2005�� 5���� 6�� �ǸŻ�ǰ �� 5������ �Ǹŵ� ��ǰ�� ��ǰ�� ���������� ��ȸ�Ͻÿ�
ALIAS�� ��ǰ�ڵ�, ��ǰ��, �Ǹż����հ�, �Ǹűݾ��հ�
--UNION, INTERSECT, MINUS(4���� ���� ������)

---------------------------------------------------
--NOT IN
SELECT  A.CART_PROD AS ��ǰ�ڵ�, 
        B.PROD_NAME AS ��ǰ��, 
        SUM(A.CART_QTY) AS �Ǹż����հ�, 
        SUM(A.CART_QTY*B.PROD_SALE) AS �Ǹűݾ��հ�
FROM    CART A INNER JOIN PROD B ON (A.CART_PROD=B.PROD_ID)
WHERE   SUBSTR(CART_NO, 1, 6) BETWEEN '200505' AND '200506'
AND     CART_PROD NOT IN (SELECT  CART_PROD
                          FROM    CART
                          WHERE   SUBSTR(CART_NO, 1, 6) LIKE '200506')
GROUP BY A.CART_PROD, B.PROD_NAME
------------------------------------------------------
SELECT  CART_PROD
FROM    CART 
WHERE   SUBSTR(CART_NO, 1, 6) LIKE '200505'
------------------------------------------------------
SELECT  CART_PROD
FROM    CART 
WHERE   SUBSTR(CART_NO, 1, 6) BETWEEN '200505' AND '200506'
-----------------------------------------------------------
SELECT  CART_PROD
FROM    CART 
WHERE   SUBSTR(CART_NO, 1, 6) LIKE '200506'
-------------------------------------------------------
SELECT  A.CART_PROD AS ��ǰ�ڵ�, 
        B.PROD_NAME AS ��ǰ��, 
        SUM(A.CART_QTY) AS �Ǹż����հ�, 
        SUM(A.CART_QTY*B.PROD_SALE) AS �Ǹűݾ��հ�
FROM    CART A, PROD B
WHERE   A.CART_PROD=B.PROD_ID
AND     SUBSTR(CART_NO, 1, 6) BETWEEN '200505' AND '200506'
GROUP BY A.CART_PROD, B.PROD_NAME
------------------------------------------------------------
--NOT EXISTS
SELECT  A.CART_PROD AS ��ǰ�ڵ�, 
        B.PROD_NAME AS ��ǰ��, 
        SUM(A.CART_QTY) AS �Ǹż����հ�, 
        SUM(A.CART_QTY*B.PROD_SALE) AS �Ǹűݾ��հ�
FROM    CART A, PROD B
WHERE   A.CART_PROD=B.PROD_ID
AND     SUBSTR(CART_NO, 1, 6) BETWEEN '200505' AND '200506'
AND           NOT EXISTS (SELECT    3
                          FROM    CART C
                          WHERE   A.CART_PROD=C.CART_PROD
                          AND     SUBSTR(CART_NO, 1, 6) LIKE '200506')
GROUP BY A.CART_PROD, B.PROD_NAME
-----------------------------------------------------------
SELECT  A.CART_PROD AS ��ǰ�ڵ�, 
        B.PROD_NAME AS ��ǰ��, 
        SUM(A.CART_QTY) AS �Ǹż����հ�, 
        SUM(A.CART_QTY*B.PROD_SALE) AS �Ǹűݾ��հ�
FROM    CART A, PROD B
WHERE   A.CART_PROD=B.PROD_ID
AND     SUBSTR(CART_NO, 1, 6) BETWEEN '200505' AND '200506'
AND                  EXISTS (SELECT  2
                          FROM    CART C
                          WHERE   A.CART_PROD=C.CART_PROD
                          AND     SUBSTR(CART_NO, 1, 6) LIKE '200506')
GROUP BY A.CART_PROD, B.PROD_NAME
--LIKE�����ڸ� ����ҷ��� ����� ���ڿ��̾�� �Ѵ�.
SELECT  A.CART_PROD AS ��ǰ�ڵ�, 
        B.PROD_NAME AS ��ǰ��, 
        SUM(A.CART_QTY) AS �Ǹż����հ�, 
        SUM(A.CART_QTY*B.PROD_SALE) AS �Ǹűݾ��հ�
FROM    CART A, PROD B
WHERE   A.CART_PROD=B.PROD_ID
AND     SUBSTR(A.CART_NO, 1, 6) LIKE '200505'
AND     A.CART_PROD NOT IN (SELECT DISTINCT CART_PROD
                           FROM    CART
                           WHERE   SUBSTR(CART_NO, 1, 6) LIKE '200506')
GROUP BY A.CART_PROD, B.PROD_NAME
ORDER BY 1;
-----------------------------
SELECT  A.CART_PROD AS ��ǰ�ڵ�, 
        B.PROD_NAME AS ��ǰ��, 
        SUM(A.CART_QTY) AS �Ǹż����հ�, 
        SUM(A.CART_QTY*B.PROD_SALE) AS �Ǹűݾ��հ�
FROM    CART A, PROD B
WHERE   A.CART_PROD=B.PROD_ID
AND     SUBSTR(A.CART_NO, 1, 6) LIKE '200505'
AND             NOT EXISTS (SELECT 1
                           FROM    CART C
                           WHERE   SUBSTR(C.CART_NO, 1, 6) LIKE '200506'
                           AND      C.CART_PROD =PROD_ID)--NULL���� �����ϱ� ���ؼ� PROD_ID�� ������ �´�.
GROUP BY A.CART_PROD, B.PROD_NAME
ORDER BY 1;

3) ��������
    -�ϳ��� ���̺��� ���� �ٸ� ���̺�� �����Ͽ� ��Ī�� �ο��ϰ� ���ο����� ����

��뿹) ȸ�����̺��� �ſ�ȯȸ��('c001')�� ���ϸ������� �� ���� ���ϸ����� �����ϰ� �ִ� ȸ������ ��ȸ�Ͻÿ�
alias�� ȸ����ȣ, ȸ����, ���ϸ���
SELECT  B.MEM_ID AS ȸ����ȣ, 
        B.MEM_NAME AS ȸ����,
        B.MEM_MILEAGE AS ���ϸ���
FROM    MEMBER A, MEMBER B
WHERE   UPPER(A.MEM_ID)='C001'
AND     A.MEM_MILEAGE < B.MEM_MILEAGE;
--NONEQU���� �񵿵�����
��뿹) 2005�� 4�� ȸ���� ��ձ��ž׺��� �� ���� ���Ÿ� �� ȸ������ ��ȸ�Ͻÿ�
--���ں��� ���űݾ� �հ谡 ���´����� �װ��� AVG�� ���ؾߵȴ�.
ALIAS�� ȸ����ȣ, ȸ����, ���űݾ�
WITH A AS (SELECT      A.MEM_ID AS AM, 
            A.MEM_NAME AS AN, 
            SUM(B.CART_QTY*C.PROD_SALE) AS AP
FROM        MEMBER A, CART B, PROD C
WHERE       (CART_MEMBER=MEM_ID)
AND         (CART_PROD=PROD_ID)
GROUP BY    A.MEM_ID, A.MEM_NAME)
--------------------------------------------------------------------
2005�� 4�� ��ձ��ž�
1. 4�� ��ٱ��Ϻ� ���űݾ� �հ�
SELECT  CART_NO,
        SUM(CART_QTY*PROD_PRICE)
FROM    CART , PROD 
WHERE   CART_NO LIKE '200504%'
GROUP BY    CART_NO
ORDER BY    1;
-----------------------------------------------------------------------
2. 1������ ���� �հ��� ��հ�
SELECT  AVG(A.CSUM) AS AMT
FROM    (SELECT CART_NO AS SNO,
                SUM(CART_QTY*PROD_PRICE) AS CSUM
         FROM   CART, PROD
         WHERE CART_NO LIKE '200504%'
         AND    CART_PROD=PROD_ID
         GROUP BY CART_NO) A;
-- �Ϲ� Ŀ���� ������ �ʾƼ� GROUP BY���� ������� �ʾƵ� �ȴ�.
---------------------------------------------------------------------------        
3. 2005�� 4�� ȸ���� ���űݾ��հ�
SELECT  CART_MEMBER,
        SUM(CART_QTY*PROD_PRICE)
FROM    CART, PROD
WHERE   CART_PROD=PROD_ID
AND     CART_NO LIKE '200504%'
GROUP BY CART_MEMBER
ORDER BY 1;
-------------------------------------------------------------------
4. ����
SELECT  C.MEM_ID AS ȸ����ȣ, 
        C.MEM_NAME AS ȸ���̸�,
        B.CSUM AS �����հ�,
        B.AMT AS ���
FROM 
(SELECT  CART_MEMBER,
        SUM(CART_QTY*PROD_PRICE)
FROM    CART, PROD
WHERE   CART_PROD=PROD_ID
AND     CART_NO LIKE '200504%'
GROUP BY CART_MEMBER) A,

(SELECT  AVG(A.CSUM) AS AMT
FROM    (SELECT CART_NO AS SNO,
                SUM(CART_QTY*PROD_PRICE) AS CSUM
         FROM   CART, PROD
         WHERE CART_NO LIKE '200504%'
         AND    CART_PROD=PROD_ID
         GROUP BY CART_NO) A) B, 
         
         MEMBER C
WHERE   C.MEM_ID = A.CID
AND     B.AMT<B.CSUM;
--------------------------------------------------------------
FROM    CART, PROD
WHERE   CART_NO LIKE '200504%'
GROUP BY    CART_NO
ORDER BY    1;
---------------------------------------------------------
WITH A AS (SELECT      A.MEM_ID AS AM, 
            A.MEM_NAME AS AN, 
            SUM(B.CART_QTY*C.PROD_SALE) AS AP
     B AS (SELECT CART_NO AS SNO,
                SUM(CART_QTY*PROD_PRICE) AS CSUM,
                COUNT(*) AS CNT
           FROM   CART, PROD
           WHERE CART_NO LIKE '200504%'
           AND    CART_PROD=PROD_ID
           GROUP BY CART_NO)      
SELECT    MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����, ���űݾ�           
FROM       A, B
WHERE      

WITH        B  AS (SELECT CART_NO AS SNO,
               SUM(CART_QTY*PROD_PRICE) AS CSUM,
               COUNT(*) AS CNT
            FROM   CART, PROD
            WHERE CART_NO LIKE '200504%'
            AND    CART_PROD=PROD_ID
            GROUP BY CART_NO)
SELECT      AVG(B.CSUM) AS AMT
FROM        B
----------------------------------------------------------
��뿹) '�Ǹ��' �ŷ�ó�� ���� ������ �ִ� ��� �ŷ�ó�� ��ȸ�Ͻÿ�
ALIAS�� �ŷ�ó�ڵ�, �ŷ�ó��, �ּ�, ��ȭ��ȣ, �����
SELECT      B.BUYER_ID AS �ŷ�ó�ڵ�, 
            B.BUYER_ID AS �ŷ�ó��, 
            B.BUYER_ADD1||' '||B.BUYER_ADD2 AS �ּ�, 
            B.BUYER_COMTEL AS ��ȭ��ȣ, 
            B. BUYER_CHARGER AS �����
FROM        BUYER A, BUYER B
WHERE       A.BUYER_NAME = '�Ǹ��'
AND         SUBSTR(A.BUYER_ADD1,1,2)=SUBSTR(B.BUYER_ADD1,1,2)
ORDER BY 1;
----
SELECT      B.BUYER_ID AS �ŷ�ó�ڵ�, 
            B.BUYER_ID AS �ŷ�ó��, 
            B.BUYER_ADD1||' '||B.BUYER_ADD2 AS �ּ�, 
            B.BUYER_COMTEL AS ��ȭ��ȣ, 
            B. BUYER_CHARGER AS �����
FROM        BUYER A INNER JOIN BUYER B ON (SUBSTR(A.BUYER_ADD1,1,2)=SUBSTR(B.BUYER_ADD1,1,2))
WHERE       A.BUYER_NAME = '�Ǹ��'
ORDER BY 1;

------------------------------------------------------------------------------
��뿹) 2005�� 4�� ȸ���� ��ձ��ž׺��� �� ���� ���Ÿ� �� ȸ������ ��ȸ�Ͻÿ�
--���ں��� ���űݾ� �հ谡 ���´����� �װ��� AVG�� ���ؾߵȴ�.
ALIAS�� ȸ����ȣ, ȸ����, ���űݾ�
1. 4�� ��ٱ��Ϻ� ���űݾ� �հ�
SELECT      CART_NO,
            SUM(CART_QTY*PROD_PRICE)
FROM        CART , PROD 
WHERE       CART_NO LIKE '200504%'
GROUP BY    CART_NO
ORDER BY    1;
--�ߺ��Ǵ� �÷����� ������ ��Ī�� ������ �� �ִ�.
SELECT      A.CART_NO,
            SUM(A.CART_QTY*B.PROD_PRICE)
FROM        CART A, PROD B
WHERE       A.CART_NO LIKE '200504%'
AND         A.CART_PROD=B.PROD_ID
GROUP BY    A.CART_NO
ORDER BY    1;

2. 1������ ���� �հ��� ��հ�
WITH A AS (SELECT   A.CART_NO AS SNO,
                    SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
           FROM     CART A, PROD B
           WHERE    A.CART_NO LIKE '200504%'
           AND      A.CART_PROD=B.PROD_ID
           GROUP BY A.CART_NO)
SELECT  AVG(A.CSUM) AS AMT
FROM    A;


3. 2005�� 4�� ȸ���� ���űݾ��հ�
SELECT  A.CART_MEMBER AS ȸ��,
        SUM(A.CART_QTY*B.PROD_PRICE) AS �հ�
FROM    CART A, PROD B
WHERE   A.CART_PROD=B.PROD_ID
AND     A.CART_NO LIKE '200504%'
GROUP BY A.CART_MEMBER
ORDER BY 1;

4. ����
WITH A AS  (SELECT       A.CART_NO AS CID, 
                         SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
            FROM         CART A, PROD B
            WHERE        A.CART_NO LIKE '200504%'
            AND          A.CART_PROD=B.PROD_ID
            GROUP BY     A.CART_NO),
     B AS  (WITH A AS (  SELECT   A.CART_NO AS SNO,
                         SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
            FROM         CART A, PROD B
            WHERE        A.CART_NO LIKE '200504%'
            AND          A.CART_PROD=B.PROD_ID
            GROUP BY     A.CART_NO)
            SELECT       AVG(A.CSUM) AS AMT
            FROM         A),
     C AS  (SELECT       A.CART_MEMBER AS ȸ��,
                         SUM(A.CART_QTY*B.PROD_PRICE) AS �հ�
            FROM         CART A, PROD B
            WHERE        A.CART_PROD=B.PROD_ID
            AND          A.CART_NO LIKE '200504%'
            GROUP BY     A.CART_MEMBER)

SELECT      A.CID AS ȸ����ȣ, 
            D.MEM_NAME AS ȸ����,
            A.CSUM AS ���űݾ��հ�
FROM        A, B, C, MEMBER D
WHERE       D.MEM_ID=A.CID
AND         B.AMT<A.CSUM;
------------------------------------------------
SELECT
    A.CID AS ȸ��,
    C.MEM_NAME AS ȸ����,
    A.CSUM  AS ���ű�
FROM
    (SELECT
        CART_MEMBER AS CID,
        SUM(CART_QTY*PROD_PRICE) AS CSUM
    FROM    CART, PROD
    WHERE   CART_PROD=PROD_ID
    AND CART_NO LIKE '200504%'
    GROUP BY CART_MEMBER
    ORDER BY    1) A, (SELECT
                            AVG(A.SUM) AS AMT
                            FROM    (SELECT
                                        CART_NO AS CNO,
                                        SUM(CART_QTY*PROD_PRICE) AS CSUM
                                    FROM CART, PROD
                                    WHERE CART_NO LIKE '200504%'
                                    AND CART_PROD=PROD_ID
                                    GROUP BY CART_NO) A) B, MEMBER C
    WHERE C.MEM_ID=A.CID
    AND   B.AMT<A.CSUM;
-----------------------------------------------------------------------------
--     ��ǰ�ڵ�, ��ǰ��, �Ǹż����հ�, �Ǹűݾ��հ�
SELECT      B.CART_PROD AS ��ǰ�ڵ�
            ,A.PROD_NAME AS ��ǰ��
            ,SUM(B.CART_QTY) AS �Ǹż����հ�
            ,SUM(A.PROD_SALE*B.CART_QTY) AS �Ǹűݾ��հ�
FROM        PROD A, CART B
WHERE       A.PROD_ID=B.CART_PROD
AND         B.CART_NO LIKE '200505%'
GROUP BY    B.CART_PROD, A.PROD_NAME;
------------------------------------------
SELECT      A.CART_PROD AS ��ǰ�ڵ�
            ,A.PROD_NAME AS ��ǰ��
            ,B.CART_QTY AS �Ǹż����հ�
            ,A.PROD_SALE*B.CART_QTY AS �Ǹűݾ��հ�
FROM        PROD A, CART B
WHERE       A.PROD_ID=B.CART_PROD
AND         B.CART_NO LIKE '200505%'
AND         EXISTS
(SELECT      C.CART_PROD AS ��ǰ�ڵ�
            ,A.PROD_NAME AS ��ǰ��
            ,C.CART_QTY AS �Ǹż����հ�
            ,A.PROD_SALE*C.CART_QTY AS �Ǹűݾ��հ�
FROM        PROD A, CART C
WHERE       A.PROD_ID=C.CART_PROD
AND         C.CART_NO LIKE '200506%'
AND         C.CART_PROD = A.PROD_ID
);
--������
--1.���̿� AND EXISTS(������) 2.�ι�° ���տ� ��ȣ 3.�ι�° ���տ� AND�� ������ ������ �����ش�. 
--�� �ڿ� �ߺ��� ������ ���Ÿ� ���� �׷���̸� ���� NOT�� �Ἥ ������
