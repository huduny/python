2021-09-02-01)
1)�ܺ�����
- ���������� ���������� �����ϴ� �ڷḸ ���꿡 ����
- �ܺ������� ������ ���� ���̺� null�� ä���� ���� ������ �� ���ο��� ����
(�Ϲ� �ܺ����� �������)
SELECT  �÷� LIST
FROM    ���̺��1, ���̺��2 ....
WHERE   ���̺��1.�÷���[(+)]=���̺��2.�÷���[(+)]

. �ڷ��� ������ ���� ���� �������ǿ� �ܺ����� ������ '(+)'�� ��� --���̳� ������ ������ �ƴ϶� ������ �Ǵ��ؼ� �����ʿ� +�� ���δ�
. �������� �������ǿ� �ܺ������� �ʿ��ϸ� ��� '(+)'�� ����ؾ���
. ������ ���̺� A,B,C�� ���꿡 �����ϰ� A�� �������� B�� Ȯ��Ǿ� ���εʰ� ���ÿ� C�� �������� �ٽ� B�� �ܺ����� �� �� ����
  ��, A=B(+) AND C=B(+)�� ������ �ʴ´�. --�ϰ����� ��� ������ �ʴ´�
. '(+)'�����ڿ� OR �����ڴ� ���� ����� �� ����.
. �Ϲ����ǰ� �ܺ����������� ���� ���� ��� �ܺ����� ����� ��ȯ���� ����->ANSI�ܺ����� �Ǵ� ���������� �ذ�
-- �̳������� ���������� ���� ���εǰ� ��ġ�°� ������
-- �ܺ������� 
-- A=B(+) AND A=C(+)�ǳ���?
(ANSI�ܺ����� �������)
SELECT �÷� LIST
FROM   ���̺��1
FULL|LEFT|RIGHT OUTER JOIN ���̺��2 ON(�������� [AND �Ϲ�����])

[WHERE �Ϲ�����]
. ���̺��1�� ���̺��2�� �ݵ�� ���� ������ ������ ���̺� �̾�� ��
. ���̺��3���ʹ� �ٷ� ���� ����� ����
. FULL OUTER: �������̺� ��� �����Ͱ� ���� ������ ���
. LEFT OUTER: FROM���� ����� ���̺��1�� ���̺��2���� �� ���� ������ �ڷᰡ �ִ� ���
. RIGHT OUTER: FROM���� ����� ���̺��2�� ���̺��1���� �� ���� ������ �ڷᰡ �ִ� ���

��뿹)
��ǰ���̺��� ��� ��ǰ�з��� ��ǰ�� ���� ��ȸ�Ͻÿ� ALIAS�� �з��ڵ�, �з���, ��ǰ�� ��
LPROD(���� ����� Ű�̴�, �ܷ�Ű�� �ϳ��� �������� �ʴ�);
SELECT      B.LPROD_GU AS �з��ڵ�, 
            B.LPROD_NM AS �з���, 
            COUNT(A.PROD_UNIT) AS "��ǰ�� ��"
FROM        PROD A, LPROD B
WHERE       A.PROD_LGU(+)=B.LPROD_GU
GROUP BY    B.LPROD_GU, B.LPROD_NM
ORDER BY    1;

SELECT COUNT(DISTINCT(PROD_LGU)) AS "��ǰ�ڵ� ��"--�ߺ��� �����ϰ� 
FROM PROD
ORDER BY 1;
--�ܺ����νÿ� ī��Ʈ�� ��ȣ�� *�� �ϸ� �ȵǰ� ��ø� ����� �ȴ�.

��뿹)
2005�⵵ 2�� ��� ��ǰ�� ���������� ��ȸ�Ͻÿ�
(��������)
SELECT      B.PROD_ID AS ��ǰ�ڵ�,--���ʿ� ��� �����ϴ� �÷��̸� �� ū ������ ���� ����� 
            SUM(A.BUY_QTY) AS ���Լ���, 
            SUM(A.BUY_QTY*A.BUY_COST) AS ���Աݾ�
FROM        BUYPROD A, PROD B
WHERE       A.BUY_PROD = B.PROD_ID
AND         BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
GROUP BY    B.PROD_ID
ORDER BY    1;
--��ǰ�� GROUP BY ��
--��¥ �Ⱓ���� �Ϲ� �������� ó��
--���� ��� OUTER����
(2005�� 2���� ���Ե� ��ǰ�� ����)
SELECT DISTINCT(BUY_PROD)
FROM    BUYPROD
WHERE   BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
-------------------------------------------------------------
SELECT      B.PROD_ID AS ��ǰ�ڵ�,--���ʿ� ��� �����ϴ� �÷��̸� �� ū ������ ���� ����� 
            SUM(A.BUY_QTY) AS ���Լ���, 
            SUM(A.BUY_QTY*A.BUY_COST) AS ���Աݾ�
FROM        BUYPROD A, PROD B
WHERE       A.BUY_PROD(+) = B.PROD_ID
AND         BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
GROUP BY    B.PROD_ID
ORDER BY    1;
-----------------------------------------------------------
SELECT      B.PROD_ID AS ��ǰ�ڵ�,--���ʿ� ��� �����ϴ� �÷��̸� �� ū ������ ���� ����� 
            NVL(SUM(A.BUY_QTY),0) AS ���Լ���, 
            NVL(SUM(A.BUY_QTY*A.BUY_COST),0) AS ���Աݾ�
FROM        PROD B LEFT OUTER JOIN BUYPROD A ON ( A.BUY_PROD = B.PROD_ID AND BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201')))
--WHERE �ϰ� �������� ������ �ƿ��������� �ƴ϶� �̳��������� �νĵȴ�. ���� AND�� �ؼ� ������ �ȿ� �־���� �ȴ�.
--WHERE���� ������ FROM������ �����Ͱ� 74�� �����ٰ� WHERE���� ���ؼ� 24�Ǹ� ������ �ȴ�.
GROUP BY    B.PROD_ID
ORDER BY    1;
----------------------------------------------------------------
SELECT      B.LPROD_GU AS �з��ڵ�, 
            B.LPROD_NM AS �з���, 
            COUNT(A.PROD_UNIT) AS "��ǰ�� ��"
FROM        PROD A RIGHT OUTER JOIN LPROD B ON ( A.PROD_LGU=B.LPROD_GU)--���� ���� �������̴ϱ� RIGHT OUTER�����̴�
GROUP BY    B.LPROD_GU, B.LPROD_NM
ORDER BY    1;
-----------------------------------------------------------------
(SUBQUERY)
SELECT      PROD_ID AS ��ǰ�ڵ�, --�����ʰ��� ���
            NVL(TBLA.QAMT,0) AS ���Լ���,
            NVL(TBLA.CAMT,0) AS ���Աݾ�
FROM        (SELECT      B.PROD_ID AS PID,
                        SUM(A.BUY_QTY) AS QAMT, 
                        SUM(A.BUY_QTY*A.BUY_COST) AS CAMT
            FROM        BUYPROD A, PROD B
            WHERE       A.BUY_PROD = B.PROD_ID
            AND         BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
            GROUP BY    B.PROD_ID) TBLA, PROD
WHERE       TBLA.PID(+)=PROD_ID
ORDER BY    1;
--WHERE�� �ϳ��� ��ġ�� �ȵǼ� ���� ó���ؾߵȴ�.
---------------------------------------------------------------------------------------------------
(��뿹)
��� �μ��� ������� ��ȸ�Ͻÿ�.
SELECT   A.DEPARTMENT_ID AS �μ��ڵ�,
         A.DEPARTMENT_NAME AS �μ���,
         COUNT(B.EMPLOYEE_ID) AS �����
FROM    DEPARTMENTS A FULL OUTER JOIN EMPLOYEES B ON (A.DEPARTMENT_ID=B.DEPARTMENT_ID)
GROUP BY A.DEPARTMENT_NAME, A.DEPARTMENT_ID
ORDER BY 3 DESC;
--COUNT�Լ��� ���� COUNT�ϱ� ������ (*)�� �ϸ� �ȵȴ�
--EMPLOYEES���̺����� 11���� ���̺� ���ǰ� DEPARTMENT���̺����� 27���� �ֱ� ������ EMPLOYEES�� �������� �ϸ� 16���� �ΰ��� ���´�
----------------------------------------------------------------------------------------
SELECT   A.DEPARTMENT_NAME AS �μ���,
         COUNT(B.EMPLOYEE_ID) AS �����
FROM    DEPARTMENTS A, EMPLOYEES B 
WHERE   A.DEPARTMENT_ID=B.DEPARTMENT_ID(+)
GROUP BY A.DEPARTMENT_NAME;
-------------------------------------------------------------------------------------------
��뿹)
2005�⵵ 4�� ��� ��ǰ�� ���������� ��ȸ�Ͻÿ�
SELECT      B.PROD_ID AS ��ǰ�ڵ�, 
            B.PROD_NAME AS ��ǰ��, 
            NVL(SUM(A.CART_QTY),0)  AS �������,
            NVL(SUM(A.CART_QTY*B.PROD_SALE),0) AS �����
FROM        PROD B LEFT OUTER JOIN CART A ON (B.PROD_ID=A.CART_PROD AND SUBSTR(CART_NO,1,6) LIKE '200504')
GROUP BY    B.PROD_ID, B.PROD_NAME
ORDER BY    3 DESC;

SELECT  COUNT(PROD_ID)
FROM    PROD;
 
SELECT  TBLB.PROD_ID AS ��ǰ�ڵ�,
        TBLB.PROD_NAME   AS ��ǰ��,
        NVL(TBLA.TCQTY,0) AS �����,
        NVL(TBLA.TSALE,0)  AS �����
FROM (      
            SELECT      B.PROD_ID AS CARTNUMBER, 
                        B.PROD_NAME AS CARTNAME, 
                        NVL(SUM(A.CART_QTY),0)  AS TCQTY,
                        NVL(SUM(A.CART_QTY*B.PROD_SALE),0) AS TSALE
            FROM        PROD B, CART A 
            WHERE       B.PROD_ID=A.CART_PROD 
            AND         SUBSTR(CART_NO,1,6) LIKE '200504'
            GROUP BY    B.PROD_ID, B.PROD_NAME) TBLA, PROD TBLB
WHERE      TBLB.PROD_ID = TBLA.CARTNUMBER(+)
ORDER BY  4 DESC;

SELECT  DISTINCT(CART_PROD),
        COUNT(DISTINCT(CART_PROD))--�ߺ�����
FROM    CART
WHERE   CART_NO LIKE '200504%'
GROUP BY CART_PROD;

SELECT      B.PROD_ID AS ��ǰ�ڵ�, 
            B.PROD_NAME AS ��ǰ��, 
            NVL(SUM(A.CART_QTY),0)  AS �������,
            NVL(SUM(A.CART_QTY*B.PROD_SALE),0) AS �����
FROM        PROD B LEFT OUTER JOIN CART A ON (B.PROD_ID=A.CART_PROD AND SUBSTR(CART_NO,1,6) LIKE '200504')
GROUP BY    B.PROD_ID, B.PROD_NAME
ORDER BY    3 DESC;

��뿹)
2005�⵵ 4�� ��� ��ǰ�� ����/���������� ��ȸ�Ͻÿ�
��뿹)
������̺��� �ڱ�μ��� ��ձ޿����� �޿��� ���̹޴� ������� ��ȸ�Ͻÿ�
SELECT      B.PROD_ID AS ��ǰ�ڵ�,
            B.PROD_NAME AS ��ǰ��,
            NVL(SUM(A.BUY_QTY),0) AS ���Լ���, 
            NVL(SUM(A.BUY_QTY*A.BUY_COST),0) AS ���Աݾ�
FROM        PROD B LEFT OUTER JOIN BUYPROD A ON ( A.BUY_PROD = B.PROD_ID AND BUY_DATE BETWEEN TO_DATE('20050401') AND LAST_DAY(TO_DATE('20050401')))

GROUP BY    B.PROD_ID,B.PROD_NAME
ORDER BY    1;
UNION ALL
SELECT      B.PROD_ID AS ��ǰ�ڵ�, 
            B.PROD_NAME AS ��ǰ��, 
            NVL(SUM(A.CART_QTY),0)  AS �������,
            NVL(SUM(A.CART_QTY*B.PROD_SALE),0) AS �����
FROM        PROD B LEFT OUTER JOIN CART A ON (B.PROD_ID=A.CART_PROD AND SUBSTR(CART_NO,1,6) LIKE '200504')
GROUP BY    B.PROD_ID, B.PROD_NAME
ORDER BY    1;
------------------------------------------
�������� ���� SQL�� �ۼ��Ͽ� ����1�� SEM-PC 'D:\��������\ORACLE\HOMEWORK01'�� ����2�� SEM-PC 'D:\��������\ORACLE\HOMEWORK2'�� �����Ͻÿ�

���ϸ�: ���μ���_����1.TXT,���μ���_����2.TXT
��������: 2021�� 9�� 12�ϱ���
----------------------------------------
��뿹)
2005�⵵ 4�� ��� ��ǰ�� ����/���������� ��ȸ�Ͻÿ�
WITH SALEA AS (SELECT        B.PROD_ID AS PROCODE, 
                             B.PROD_NAME AS PRONAME, 
                             NVL(SUM(A.CART_QTY),0)  AS SUMSALE,
                             NVL(SUM(A.CART_QTY*B.PROD_SALE),0) AS ALLSALE
                FROM         PROD B LEFT OUTER JOIN CART A ON (B.PROD_ID=A.CART_PROD AND SUBSTR(CART_NO,1,6) LIKE '200504')
                GROUP BY     B.PROD_ID, B.PROD_NAME),
WITH COSTA AS   (SELECT      B.PROD_ID AS PROCODE,
                             B.PROD_NAME AS PRONAME,
                             NVL(SUM(A.BUY_QTY),0) AS SUMCOST, 
                             NVL(SUM(A.BUY_QTY*A.BUY_COST),0) AS ALLCOST
                FROM        PROD B LEFT OUTER JOIN BUYPROD A ON ( A.BUY_PROD = B.PROD_ID AND BUY_DATE BETWEEN TO_DATE('20050201') 
                            AND LAST_DAY(TO_DATE('20050201'))))
SELECT      COSTA.SUMCOST AS ���Լ���,
            COSTA.ALLCOST AS ���Աݾ�,
            SALEA.SUMSALE AS �������,
            SALEA.ALLSALE AS ����ݾ�
FROM        SALEA, COSTA
WHERE       SALEA.PROCODE = COSTA.PROCODE;
-------------------------------------------------------------------------------------
��뿹)
2005�⵵ 4�� ��� ��ǰ�� ����/���������� ��ȸ�Ͻÿ�
SELECT      A.PROD_ID AS ��ǰ�ڵ�, A.PROD_NAME AS ��ǰ��, 
            NVL(SUM(C.BUY_QTY),0) AS ���Լ���, NVL(SUM(C.BUY_QTY*C.BUY_COST),0) AS ���Աݾ�, 
            NVL(SUM(B.CART_QTY),0) AS �������, NVL(SUM(B.CART_QTY*A.PROD_PRICE),0) AS ����ݾ�
FROM        PROD A LEFT OUTER JOIN CART B ON (A.PROD_ID=B.CART_PROD AND SUBSTR(CART_NO,1,6) LIKE '200504')
            JOIN BUYPROD C ON (A.PROD_ID=C.BUY_PROD AND SUBSTR(CART_NO,1,6) LIKE '200504')
GROUP BY     A.PROD_ID, A.PROD_NAME
ORDER BY    1;
----------------------------------------------------------------------------------------------------------------------
2005�⵵ 4�� ��� ��ǰ�� ����/���������� ��ȸ�Ͻÿ�
SELECT      A.PROD_ID AS ��ǰ�ڵ�, A.PROD_NAME AS ��ǰ��, 
            NVL(SUM(C.BUY_QTY),0) AS ���Լ���, NVL(SUM(C.BUY_QTY*A.PROD_COST),0) AS ���Աݾ�, 
            NVL(SUM(B.CART_QTY),0) AS �������, NVL(SUM(B.CART_QTY*A.PROD_PRICE),0) AS ����ݾ�
FROM        PROD A LEFT OUTER JOIN CART B ON (A.PROD_ID=B.CART_PROD AND SUBSTR(CART_NO,1,6) LIKE '200504')
            LEFT OUTER JOIN BUYPROD C ON (A.PROD_ID=C.BUY_PROD AND SUBSTR(CART_NO,1,6) LIKE '200504')
GROUP BY     A.PROD_ID, A.PROD_NAME
ORDER BY    1;
----------------------------------------------------------------------------------------------------------------------
��뿹)
������̺��� �ڱ�μ��� ��ձ޿����� �޿��� ���̹޴� ������� ��ȸ�Ͻÿ�
������̺�
���
�ڱ�μ�
�ڱ�μ��� ��ձ޿����� ����

SELECT      DEPARTMENT_ID �μ���ȣ, DEPARTMENT_NAME �μ���, SALARY �޿�, �μ���ձ޿�
FROM        DEPARTMENTS A, EMPLOYEES B;

�μ� ��� �޿�
SELECT    A.DEPARTMENT_ID AS �μ���ȣ, 
          ROUND(AVG(B.SALARY)) AS �μ���ձ޿�
FROM      DEPARTMENTS A, EMPLOYEES B
WHERE     A.DEPARTMENT_ID= B.DEPARTMENT_ID  
GROUP BY  A.DEPARTMENT_ID;

��ġ��
SELECT      B.DEPTNO AS �μ���ȣ, B.DEPTNAME AS �μ���, A.EMP_NAME AS ����̸� ,A.SALARY AS �޿�, B.AVGSAL AS �μ���ձ޿�
FROM        EMPLOYEES A LEFT OUTER JOIN (SELECT      A.DEPARTMENT_ID AS DEPTNO, 
                                      A.DEPARTMENT_NAME AS DEPTNAME,
                                      ROUND(AVG(B.SALARY)) AS AVGSAL
                            FROM      DEPARTMENTS A, EMPLOYEES B
                            WHERE     A.DEPARTMENT_ID= B.DEPARTMENT_ID  
                            GROUP BY  A.DEPARTMENT_ID, A.DEPARTMENT_NAME) B ON (A.DEPARTMENT_ID = B.DEPTNO)
WHERE       A.SALARY > B.AVGSAL;
--