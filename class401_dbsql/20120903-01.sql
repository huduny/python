2021-09-03-01
��뿹) ȸ�����̺��� ����ȸ���� ��� ���ϸ������� �� ���� ���ϸ����� ������ ȸ���� ��ȸ�Ͻÿ�.
alias�� ȸ����ȣ, ȸ����, ����, ���ϸ���

SELECT  MEM_ID AS ȸ����ȣ, 
        MEM_NAME AS ȸ����, 
        CASE MEMBER WHEN SUBSTR(MEM_REGNO2,1,1)='2' OR
                         SUBSTR(MEM_REGNO2,1,1)='4' THEN '����ȸ��'
                    ELSE '����ȸ��' END AS ����,
        MEM_MILEAGE AS ���ϸ���
FROM    MEMBER
WHERE   MEM_MILEAGE > (��������: ����ȸ���� ��ո��ϸ���);

(��������: ����ȸ���� ��ո��ϸ���)
SELECT  AVG(MEM_MILEAGE)
FROM    MEMBER
WHERE   SUBSTR(MEM_REGNO2,1,1) IN ('2','4');

SELECT  A.MEM_ID AS ȸ����ȣ, 
        A.MEM_NAME AS ȸ����, 
        CASE MEMBER WHEN SUBSTR(A.MEM_REGNO2,1,1)='2' OR
                         SUBSTR(A.MEM_REGNO2,1,1)='4' THEN '����ȸ��'
                    ELSE '����ȸ��' END AS ����,
        MEM_MILEAGE AS ���ϸ���
FROM    MEMBER A, (SELECT  AVG(MEM_MILEAGE) AS AVGA
FROM    MEMBER
WHERE   SUBSTR(A.MEM_REGNO2,1,1) IN ('2','4')) B
WHERE   MEM_MILEAGE > B.AVGA

SELECT  MEM_ID AS ȸ����ȣ, 
        MEM_NAME AS ȸ����, 
        CASE WHEN SUBSTR(MEM_REGNO2,1,1)='2' OR
                         SUBSTR(MEM_REGNO2,1,1)='4' THEN '����ȸ��'
                    ELSE '����ȸ��' END AS ����,
        MEM_MILEAGE AS ���ϸ���
FROM    MEMBER
WHERE   MEM_MILEAGE >(SELECT  AVG(MEM_MILEAGE)
FROM    MEMBER
WHERE   SUBSTR(MEM_REGNO2,1,1) IN ('2','4'))
ORDER BY 1;

2021-09-03-01
2.������ �ִ� ��������
-���������� ���� ���̺�� ���������� ���� ���̺��� JOIN���� ����� ���
-��κ��� ���������� �̿� ����

��뿹) 2005�⵵ ��� �ŷ�ó�� ���Աݾ��հ�� ����ݾ��հ踦 ���Ͻÿ�
���(OUTTER ����) �ŷ�ó��(GROUP BY)

SELECT      �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��հ�, ����ݾ��հ�
FROM        BUYER A, (��������:2005�⵵ �ŷ�ó�� ���Աݾ��հ�) B, (��������:2005�� �ŷ�ó�� ����ݾ��հ�) C, BUYPROD B, CART C, PROD D
--����� ���� ���� �̳�����
--�ŷ�ó�ڵ尡 A�� �ξ��� ����.--�����̺��� ���ÿ� Ȯ�� �Ǵ� ���� �ȵ����� A�� �������� B�� Ȯ��ǰ� A�� �������� C��Ȯ��Ǵ� ���� ������.

--2005�⵵ �ŷ�ó�� ���Աݾ��հ�
SELECT  BUYER_ID AS BID,
        SUM(BUY_QTY*PROD_COST) AS BAMT
FROM    BUYPROD, PROD, BUYER
WHERE   BUY_PROD = PROD_ID
AND     PROD_BUYER = BUYER_ID --�̺κ� ������ �ŷ�ó��
AND     EXTRACT(YEAR FROM BUY_DATE)=2005
GROUP BY BUYER_ID
--�ζ��� ���������� ��Ī�� �����Ѵ� ��찡 ���Ƽ� ����� ��Ī�� ����

--2005�� �ŷ�ó�� ����ݾ��հ�
SELECT  BUYER_ID AS BID,
        SUM(CART_QTY*PROD_PRICE) AS CAMT
FROM    CART, PROD, BUYER
WHERE   CART_PROD = PROD_ID
AND     PROD_BUYER = BUYER_ID --�̺κ� ������ �ŷ�ó��
AND     CART_NO LIKE '2005%'
GROUP BY BUYER_ID

--��ġ��
SELECT      A.BUYER_ID AS �ŷ�ó�ڵ�, --���, �ƿ��� ������ ������ �ɶ��� ���� �� �� SELECT���� ���
            A.BUYER_NAME AS �ŷ�ó��, 
            NVL(B.BAMT,0) AS ���Աݾ��հ�, 
            NVL(C.CAMT,0) AS ����ݾ��հ�
            
FROM    BUYER A LEFT OUTER JOIN  

(SELECT  BUYER_ID AS BID,
        SUM(BUY_QTY*PROD_COST) AS BAMT
FROM    BUYPROD, PROD, BUYER
WHERE   BUY_PROD = PROD_ID
AND     PROD_BUYER = BUYER_ID
AND     EXTRACT(YEAR FROM BUY_DATE)=2005
GROUP BY BUYER_ID) B ON(A.BUYER_ID = B.BID) LEFT OUTER JOIN 

(SELECT  BUYER_ID AS BID,
        SUM(CART_QTY*PROD_PRICE) AS CAMT
FROM    CART, PROD, BUYER
WHERE   CART_PROD = PROD_ID
AND     PROD_BUYER = BUYER_ID --�̺κ� ������ �ŷ�ó��
AND     CART_NO LIKE '2005%'
GROUP BY BUYER_ID) C ON (A.BUYER_ID = C.BID)

��뿹)2005�� 4�� ���Ծ��� ���� 5�� ��ǰ�� �Ǹ������� ��ȸ�Ͻÿ�.
ALIAS�� ��ǰ�ڵ�, ��ǰ��, �Ǹż����հ�, �Ǹűݾ��հ�

2005�� 4�� ���Ծ��� ���� 5��
--4�� ���Ծ� ������
SELECT  BUY_PROD AS ��ǰ�ڵ�,
        SUM(BUY_QTY*BUY_COST) AS ���Ծ�
FROM  BUYPROD
WHERE SUBSTR(TO_CHAR(BUY_DATE,'YYYYMM'),5,6)='04'
GROUP BY BUY_PROD
ORDER BY 2 DESC;
--4�� ���Ծ� 5��
SELECT  BUY_PROD AS PRODNUM
FROM    BUYPROD A , (SELECT  BUY_PROD AS BPROD,
                             SUM(BUY_QTY*BUY_COST) AS BSUM
                     FROM  BUYPROD
                     WHERE BUY_DATE BETWEEN '20050401' AND '20050430'
                     GROUP BY BUY_PROD
                     ORDER BY 2 DESC) B
WHERE ROWNUM <=5;

2005�� 4������ �����
SELECT  A.CART_PROD AS CARTNUM,
        B.PROD_NAME AS PRONAM,
        SUM(A.CART_QTY) AS TSELL,
        SUM(A.CART_QTY*B.PROD_PRICE) AS TSALE
FROM    CART A, PROD B
WHERE   SUBSTR(A.CART_NO,1,6) LIKE '200504'
GROUP BY A.CART_PROD, B.PROD_NAME

��ǰ�ڵ�� ����
SELECT  C.PRODNUM AS ��ǰ�ڵ�, 
        D.PRONAM AS ��ǰ��, 
        D.TSELL AS �Ǹż����հ�, 
        D.TSALE AS �Ǹűݾ��հ�
FROM 
(SELECT  B.BPROD AS PRODNUM
FROM   (SELECT  BUY_PROD AS BPROD,
                             SUM(BUY_QTY*BUY_COST) AS BSUM
                     FROM  BUYPROD
                     WHERE BUY_DATE BETWEEN '20050401' AND '20050430'
                     GROUP BY BUY_PROD
                     ORDER BY 2 DESC) B
WHERE ROWNUM <=5) C, 

(SELECT  A.CART_PROD AS CARPROD,
        B.PROD_NAME AS PRONAM,
        SUM(A.CART_QTY) AS TSELL,
        SUM(A.CART_QTY*B.PROD_PRICE) AS TSALE
FROM    CART A, PROD B
WHERE   SUBSTR(A.CART_NO,1,6) LIKE '200504'
GROUP BY A.CART_PROD, B.PROD_NAME) D

WHERE  C.PRODNUM = D.CARPROD 
--AND    C.PRODNUM = E.PROD_ID ;







SELECT  A.CART_PROD AS ��ǰ�ڵ�, 
        B.PROD_NAME AS ��ǰ��, 
        SUM(CART_QTY) AS �Ǹż����հ�, 
        SUM(CART_QTY*PROD_PRICE) AS �Ǹűݾ��հ�
FROM  CART A, PROD B,
(SELECT  BUY_PROD AS PRODNUM
FROM    BUYPROD A , (SELECT  BUY_PROD AS BPROD,
                             SUM(BUY_QTY*BUY_COST) AS BSUM
                     FROM  BUYPROD
                     WHERE BUY_DATE BETWEEN '20050401' AND '20050430'
                     GROUP BY BUY_PROD
                     ORDER BY 2 DESC) B
WHERE ROWNUM <=5;) C
WHERE   C.PRODNUM=A.CART_PROD
AND     C.PRODNUM=B.PROD_ID
GROUP BY  A.CART_PROD, B.PROD_NAME

SELECT  A.CART_PROD AS ��ǰ�ڵ�, 
        B.PROD_NAME AS ��ǰ��, 
        SUM(CART_QTY) AS �Ǹż����հ�, 
        SUM(CART_QTY*PROD_PRICE) AS �Ǹűݾ��հ�
FROM CART Z, 
---------------------------------------------------------------------------------
SELECT  Z.CART_PROD AS ��ǰ�ڵ�, 
        X.PROD_NAME AS ��ǰ��, 
        SUM(Z.CART_QTY) AS �Ǹż����հ�, 
        SUM(Z.CART_QTY*X.PROD_PRICE) AS �Ǹűݾ��հ�
        
FROM    CART Z, PROD X, (SELECT  B.BPROD AS PRODNUM
                         FROM   (SELECT  BUY_PROD AS BPROD,
                                        SUM(BUY_QTY*BUY_COST) AS BSUM
                                 FROM  BUYPROD
                                 WHERE BUY_DATE BETWEEN '20050401' AND '20050430'
                                 GROUP BY BUY_PROD
                                 ORDER BY 2 DESC) B
                         WHERE ROWNUM <=5) Y
WHERE   Y.PRODNUM = Z.CART_PROD
AND     Y.PRODNUM = X.PROD_ID
AND     SUBSTR(CART_NO,1,6) LIKE '200504'
GROUP BY Z.CART_PROD, X.PROD_NAME 
ORDER BY 1;
---------------------------------------------------------------------------------
--rankover�̶�� �Լ��� ���� �ڵ����� ������ �Ű��ش�
--rownum�� �������� rownum�� order by�� ���� ���� ���� 5�� �Ÿ��� �׸��� ������������ �����Ѵ�.
--from���� ���Ǵ� ���������� ��������Ǿ�� �Ѵ�.
--���� ���� �����̱� ������ ���� ���ǿ� �´� �͸� ����� �ش�.

2021-09-03-02)
**���� ��ȯ�Լ�(rank(), dense_rank(), row_number())
-rownum�� �緹 �ڵ�� where ������ ���ǰ� order by ���� ���Ͽ� ����ȭ�� �̷������ ������ ����ȭ�� ���� ������ �ڷḦ ��ȯ ���� �� ����
-���̺��� Ư�� ���� �������� ������ ���Ͽ� ��ȯ�ϱ� ����
1)RANK()
. ���� ���� ���� ������ �ο��ϰ� �� ���� ������ ���� ������ ������ŭ �ǳ� �� ��(����)�� �ο��ϴ� ���
(�������)
SELECT �÷�LIST,
        RANK() OVER(ORDER BY �����÷� DESC) AS �÷���Ī
FROM    ���̺��
 :

��뿹) ȸ�����̺��� ȸ���� ���ϸ��� ������ ���� ������ �ο��Ͻÿ�
SELECT MEM_ID AS ȸ����ȣ,
MEM_NAME AS ȸ����,
MEM_MILEAGE AS ���ϸ���,
RANK() OVER(ORDER BY MEM_MILEAGE desc) AS ����
FROM MEMBER;

RANK() OVER, ROWNUM

��뿹) ������̺��� �� �μ����� ������� �޿��� ���� ������ �ο��Ͻÿ�
alias�� �����ȣ, �����, �μ���, �޿�, ����
select  A.EMPLOYEE_ID AS �����ȣ , 
        A.EMP_NAME AS �����, 
        B.DEPARTMENT_NAME �μ���, 
        A.SALARY �޿�, 
        RANK() OVER(ORDER BY SALARY) AS ����
FROM HR.EMPLOYEES A LEFT OUTER JOIN HR.DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)

select  A.EMPLOYEE_ID AS �����ȣ , 
        A.EMP_NAME AS �����, 
        B.DEPARTMENT_NAME �μ���, 
        A.SALARY �޿�, 
        RANK() OVER(PARTITION BY A.DEPARTMENT_ID 
                    ORDER BY A.SALARY DESC) AS ����
FROM HR.EMPLOYEES A LEFT OUTER JOIN HR.DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)

2) DENSE_RANK()
. ���� ���� ���� ������ �ο��ϰ� �� ���� ������ ���� ������ ������ ������� �� ���� ������ �ο��ϴ� ���
SELECT �÷�LIST,
        DENSE_RANK() OVER(ORDER BY �����÷� DESC) AS �÷���Ī
FROM    ���̺��
 :
 
��뿹) ȸ�����̺��� ȸ���� ���ϸ��� ������ ���� ������ �ο��Ͻÿ�
SELECT MEM_ID AS ȸ����ȣ,
MEM_NAME AS ȸ����,
MEM_MILEAGE AS ���ϸ���,
DENSE_RANK() OVER(ORDER BY MEM_MILEAGE desc) AS ����
FROM MEMBER;
 
3)row_number
-���� ������ �������� ������ �ο���
-select Į������Ʈ,
        row_number() over(order by �����÷� desc) as �÷� ��Ī
from ���̺��

��뿹) ȸ�����̺��� ȸ���� ���ϸ��� ������ ���� ������ �ο��Ͻÿ�
SELECT MEM_ID AS ȸ����ȣ,
MEM_NAME AS ȸ����,
MEM_MILEAGE AS ���ϸ���,
ROW_NUMBER() OVER(ORDER BY MEM_MILEAGE desc) AS ����
FROM MEMBER;

��뿹) ȸ�����̺��� ���ϸ����� ���� ������ �ο��ϵ� ���� ���ϸ����̸� ���̰� � ������ ������ �ο��Ͻÿ�(rank() �Լ�)
SELECT  MEM_ID AS ȸ����ȣ,
        MEM_NAME AS ȸ����,
        MEM_MILEAGE AS ���ϸ���,
        MEM_BIR AS �������,
        Rank() OVER(ORDER BY MEM_MILEAGE desc, MEM_BIR DESC) AS ����
FROM    MEMBER;

RANK�Լ��� �տ� ������ ���ϰ� ���� ���� ������ �ι�° �������� �����Ѵ�

**������ ��������
-�������� ����� �������� ���� ��ȯ�Ǵ� ��������
-���Ǵ� �����ڴ�: IN ANY SOME EXISTS ALL

��뿹) 2005�� 5�� ȸ���� ���űݾ� �հ踦 ���ϵ� 4�� ������ ��� ȸ���� ���űݾ� ���� ���� ȸ������ ��ȸ�Ͻÿ�.
      (MAX�Լ��� ������� ���ÿ�)
      


