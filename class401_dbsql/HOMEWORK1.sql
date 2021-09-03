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