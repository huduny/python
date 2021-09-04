2021-09-04 ����
������_����
�������� ���� SQL�� �ۼ��Ͽ� ����1�� SEM-PC 'D:\��������\ORACLE\HOMEWORK01'�� ����2�� SEM-PC 'D:\��������\ORACLE\HOMEWORK2'�� �����Ͻÿ�

���ϸ�: ���μ���_����1.TXT,���μ���_����2.TXT
��������: 2021�� 9�� 12�ϱ���
------------------------------------------------------------------------------------------------------------
2005�� 5�� ȸ���� ���űݾ� �հ踦 ���ϵ�/ 4�� ������ ��� ȸ���� ���űݾ� ���� ���� ȸ������ ��ȸ�Ͻÿ�.(MAX�Լ��� ������� ���ÿ�)
SELECT
    C.MEM_ID AS ȸ�����̵�,
    C.MEM_NAME AS ȸ���̸�,
    X.SSELL AS ���űݾ��հ�
FROM
    (
        SELECT
            A.CART_MEMBER AS MNA,
            NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS SSELL
        FROM
            CART A
            LEFT OUTER JOIN PROD B ON ( A.CART_PROD = B.PROD_ID
                                        AND SUBSTR(A.CART_NO,1,6) LIKE '200504' )
        GROUP BY
            A.CART_MEMBER
    ) Z
    LEFT OUTER JOIN (
        SELECT
            A.CART_MEMBER AS MNA,
            NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS SSELL
        FROM
            CART A
            LEFT OUTER JOIN PROD B ON ( A.CART_PROD = B.PROD_ID
                                        AND SUBSTR(A.CART_NO,1,6) LIKE '200505' )
        GROUP BY
            A.CART_MEMBER
    ) X ON ( Z.MNA = X.MNA )
    LEFT OUTER JOIN MEMBER C ON ( Z.MNA = C.MEM_ID )
WHERE
    X.SSELL > Z.SSELL   
------------------------------------------------------------------------------------------------------------ 
2. ������̺��� �ڱ�μ��� ��ձ޿����� �޿��� ���̹޴� ������� ��ȸ�Ͻÿ�    
Select
    B.Deptno As �μ���ȣ,
    B.Deptname As �μ���,
    A.Emp_Name As ����̸�,
    A.Salary As �޿�,
    B.Avgsal As �μ���ձ޿�
From
    Employees A
    Left Outer Join (
        Select
            A.Department_Id As Deptno,
            A.Department_Name As Deptname,
            Round(Avg(B.Salary) ) As Avgsal
        From
            Departments A,
            Employees B
        Where
            A.Department_Id = B.Department_Id
        Group By
            A.Department_Id,
            A.Department_Name
    ) B On ( A.Department_Id = B.Deptno )
Where
    A.Salary > B.Avgsal;
------------------------------------------------------------------------------------------------------------
3. ��ġ��/  2005�⵵ 4�� ��� ��ǰ�� ����/���������� ��ȸ�Ͻÿ�
SELECT
    Z.PROD_ID AS ��ǰ��ȣ,
    X.BQ AS ���Լ���,
    X.BQC AS ���Աݾ�,
    C.CQ AS �������,
    C.CPP AS ����ݾ�
FROM
    PROD Z
    LEFT OUTER JOIN (
        SELECT
            A.PROD_ID AS BP,
            NVL(SUM(B.BUY_QTY),0) AS BQ,
            NVL(SUM(B.BUY_QTY * B.BUY_COST),0) AS BQC
        FROM
            PROD A
            LEFT OUTER JOIN BUYPROD B ON ( A.PROD_ID = B.BUY_PROD
                                           AND BUY_DATE BETWEEN '20050401' AND '20050430' )
        GROUP BY
            A.PROD_ID
    ) X ON ( Z.PROD_ID = X.BP )
    LEFT OUTER JOIN (
        SELECT
            C.PROD_ID AS CP,
            NVL(SUM(D.CART_QTY),0) AS CQ,
            NVL(SUM(D.CART_QTY * C.PROD_PRICE),0) AS CPP
        FROM
            PROD C
            LEFT OUTER JOIN CART D ON ( C.PROD_ID = D.CART_PROD
                                        AND SUBSTR(CART_NO,1,6) LIKE '200504' )
        GROUP BY
            C.PROD_ID
    ) C ON ( Z.PROD_ID = C.CP )
ORDER BY
    1;






