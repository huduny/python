2021-08-27-01)
��뿹) 2005�� 5�� ��ǰ�� ��������հ踦 ���ϵ� ������� �հ谡 20�� �̻��� ��ǰ�� ��ȸ�Ͻÿ�.
SELECT CART_PROD AS ��ǰ,
       SUM(CART_QTY) AS ��������հ�
FROM   CART 
WHERE CART_NO LIKE '200505%'
GROUP BY CART_PROD
HAVING SUM(CART_QTY) >=20
ORDER BY 1;

��뿹) 2005�� 4-6�� ���̿� ȸ������ ������Ȳ�� ��ȸ�Ͻÿ�. �� ���űݾ��� �������� �� ���� 100���� �̻��� ȸ������
ȸ����ȣ, ȸ����, ���űݾ��հ踦 ����Ͻÿ�.

SELECT  B.MEM_ID ȸ����ȣ, 
        B.MEM_NAME ȸ����, 
        SUM(A.CART_QTY*C.PROD_PRICE) ���űݾ��հ�
FROM    CART A, MEMBER B, PROD C
WHERE   SUBSTR(A.CART_NO,1,6) BETWEEN '200504' AND '200506'
AND     (A.CART_MEMBER = B.MEM_ID) --��������
AND     (C.PROD_ID = A.CART_PROD) --��������
GROUP BY B.MEM_ID, B.MEM_NAME --���� ������ ������ ȸ����ȣ�� ���� ������� ������ ȸ�������� ��ƶ�
HAVING  SUM(A.CART_QTY*C.PROD_PRICE) >= 1000000
ORDER BY 3 DESC;


SELECT SALARY+MANAGER_ID FROM EMPLOYEES;

��뿹) 2005�� 5�� ���ż����� ���� ȸ�� 5���� ��ȸ�Ͻÿ�.
SELECT  A.CID AS ȸ����ȣ,
        A.AMT AS ���ż����հ�
FROM   (SELECT      CART_MEMBER AS CID,
                    SUM(CART_QTY) AS AMT
        FROM        CART
        WHERE       CART_NO LIKE '200505%'
        GROUP BY    CART_MEMBER
        ORDER BY    2 DESC) A
WHERE   ROWNUM <=5;

���� īƮ ���̺��� �ҷ����� WHERE������ 5���ڷḦ �̰� �״����� ROWNUM 5���� �̰� īƮ�ɹ������� GROUP BY�ϰ� �װ��� SELECT������ �հ踦 ���� ���������� ORDER BY�� �Ѵ�
�׷��� A��� �ϴ� �������̺� �並 ����� �ش�. �������� �����̴�, ������ ������ �����ϱ� ���ؼ� ����� ��Ī�� ����� �ش�

**ȸ�����̺��� 5�� ���
SELECT MEM_ID, MEM_NAME
FROM MEMBER
WHERE ROWNUM<=5;
--��¥ �÷�

��뿹) 2005�� 5�� ���ż����հ谡�� ���� ���� ȸ�� 1���� ��ȸ�Ͻÿ�.
SELECT  A.CID AS ȸ����ȣ,
        A.AMT AS ���ż����հ�
FROM   (SELECT      CART_MEMBER AS CID,
                    SUM(CART_QTY) AS AMT
        FROM        CART
        WHERE       CART_NO LIKE '200505%'
        GROUP BY    CART_MEMBER
        ORDER BY    2 DESC) A
WHERE   ROWNUM <=1;
MAX(COLUMN) GREATEST(ROW)

SELECT MAX(A.AMT)
FROM  (SUM(CART_OTY) AS AMT) A;

��뿹) 2005�⵵ ���� ȸ���� ������Ȳ(���ż����հ�)�� ��ȸ�Ͻÿ�
SELECT  SUBSTR(CART_NO,1,6) AS ����, 
        CART_MEMBER AS ȸ����, 
        SUM(CART_QTY) AS ���ż����հ�
FROM    CART
WHERE   CART_NO LIKE '2005%'
GROUP BY SUBSTR(CART_NO,1,6),CART_MEMBER
ORDER BY 3 DESC;
1. ������ ��� 2. ȸ������ ��� 3. 05�⵵�� ������ �� ������ SUM�Ѵ�




SELECT MAX(SUM(CART_OTY) AS ���ż����հ�
FROM    CART
WHERE   CART_NO LIKE '200505%';

2) AVG(COL)
    -'COL'�� ���� ��հ��� ��ȯ
��뿹) ������̺��� ����� ��ձ޿��� ��ȸ�Ͻÿ�.
    SELECT ROUND(AVG(SALARY))
    FROM HR.EMPLOYEES;
    
��뿹) ������̺��� �� �μ��� ��ձ޿��� ��ȸ�Ͻÿ�.
    SELECT  DEPARTMENT_ID �μ�, 
            ROUND(AVG(SALARY)) ��ձ޿�,
            SUM(SALARY) �޿��հ�
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
    ORDER BY DEPARTMENT_ID;

��뿹) ������̺��� ��ձ޿����� ���� �޿��� �޴� ����� �����ȣ, �����, ��å�ڵ�, �޿��� ��ȸ�Ͻÿ�.
SELECT  EMPLOYEE_ID �����ȣ, 
        EMP_NAME �����, 
        JOB_ID ��å�ڵ�, 
        SALARY �޿�
FROM    EMPLOYEES
WHERE   SALARY>=(SELECT AVG(SALARY) FROM HR.EMPLOYEES)
ORDER BY 4 DESC;
���� SELECT�� ���� WHERE, ���������� SELECT WHERE������ �ü� �ִ�.
�����Լ��� �Ἥ �ٸ� ���ǿ� ���ϴ� �񱳷ε� ���Ǳ⵵ �Ѵ�.

��뿹) 2005�� �Ǹ��ڷḦ �м��Ͽ� ��ǰ�� ����Ǹż����� ��ȸ�Ͻÿ�
SELECT      A.PROD_ID �з���,
            A.PROD_NAME ��ǰ��,
            ROUND(AVG(B.CART_QTY)) ����Ǹż���
FROM        PROD A, CART B
WHERE       B.CART_PROD = A.PROD_ID
AND         CART_NO LIKE '2005%' 
GROUP BY    A.PROD_ID, A.PROD_NAME
ORDER BY    3 DESC;
AVG�� ���ٴ� ������ ���������� �� ���ؼ� ���� ���ؼ� �����ش�.

SELECT      A.PROD_ID �з���,
            A.PROD_NAME ��ǰ��,
            SUM(B.CART_QTY) �Ǹż���,
            COUNT(*)    �Ǹ�Ƚ��
FROM        PROD A, CART B
WHERE       B.CART_PROD = A.PROD_ID
AND         CART_NO LIKE '2005%' 
GROUP BY    A.PROD_ID, A.PROD_NAME
ORDER BY    3 DESC;

��뿹) ��ǰ���̺��� ��ǰ�з��� ��ո��ϸ����� ���Ͻÿ�
SELECT PROD_LGU ��ǰ�з�,
       ROUND(AVG(PROD_MILEAGE)) ��ո��ϸ���  
FROM    PROD 
GROUP BY PROD_LGU
ORDER BY 2 DESC;

3) COUNT(*|COL)
    -���ǿ� �´� �ڷ��� ����(���� ��)�� ��ȯ
    -�ܺ������� �����ϰ� COUNT�Լ��� '*'�� 'COL'�� �Ű������� ����ص� ����� ����
    -�ܺ������� ��� �ݵ�� 'COL'���� ����ؾ���
    
���������� �����ϴ� �ڷ�, ���� ����Ѵ�. ������ ���� ��� �� ������.
�ܺ������� ��� ���� �� �����ش�. ���ڶ� ���� NULL�� �ִ´�. COUNT�� NULL���� �ֵ� ���� �� ����, COL���� ������ָ� 0�� ��µȴ�.

��뿡) ������̺��� �� �μ��� �ο����� ��ȸ�Ͻÿ�.
SELECT  DEPARTMENT_ID, COUNT(*) �ο���, COUNT(EMP_NAME) �ο���
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID DESC;

��뿡) 2005�� 1-6�� ���� ���Աݾ��հ�� ����Ƚ���� ��ȸ�Ͻÿ�
SELECT      TO_CHAR(BUY_DATE, 'MM') AS ����, 
            SUM(BUY_QTY*BUY_COST) AS ���Աݾ��հ�, 
            COUNT(BUY_QTY) AS ����Ƚ��
FROM        BUYPROD
WHERE       BUY_DATE BETWEEN '20050101' AND '20050630'
GROUP BY    TO_CHAR(BUY_DATE, 'MM')
ORDER BY    1;

��뿹) 2005�� 4-6�� ȸ���� ����Ƚ���� ��ձ��űݾ��� ��ȸ�Ͻÿ�
SELECT      A.CART_MEMBER AS ȸ����,
            COUNT(A.CART_NO) AS ����Ƚ��, 
            --C.MEM_NAME AS ȸ���̸�,
            ROUND(AVG(A.CART_QTY*B.PROD_PRICE)) AS ��ձ��űݾ� 
FROM        CART A, PROD B--, MEMBER C
WHERE       SUBSTR(CART_NO,1,6) BETWEEN '200504' AND '200506'
--AND         A.CART_MEMBER = C.MEM_ID
AND         A.CART_PROD = B.PROD_ID
GROUP BY    A.CART_MEMBER
ORDER BY    2 DESC;
--------------------------------------
SELECT      A.CART_MEMBER AS ȸ����,
            COUNT(A.CART_NO) AS ����Ƚ��, 
            C.MEM_NAME AS ȸ���̸�,
            ROUND(AVG(A.CART_QTY*B.PROD_PRICE)) AS ��ձ��űݾ� 
FROM        CART A, PROD B, MEMBER C
WHERE       SUBSTR(CART_NO,1,6) BETWEEN '200504' AND '200506'
AND         A.CART_MEMBER = C.MEM_ID
AND         A.CART_PROD = B.PROD_ID
GROUP BY    A.CART_MEMBER, C.MEM_NAME, ROLLUP(A.CART_QTY*B.PROD_PRICE)
ORDER BY    4 DESC;

