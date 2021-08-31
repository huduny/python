2021-08-31-01)

��뿹) 2005�� 6�� ȸ���� �������踦 ��ȸ�Ͻÿ�
��������� ���ż����հ�� ���űݾ��հ��̸�, ȸ����ȣ, ȸ���� �Բ� ��ȸ�Ͻÿ�.

SELECT      A.CART_MEMBER AS ȸ����ȣ, 
            B.MEM_NAME AS ȸ����, 
            SUM(A.CART_QTY) AS ���ż����հ�, 
            SUM(A.CART_QTY*C.PROD_COST) AS ���űݾ��հ�
FROM        CART A JOIN MEMBER B ON (A.CART_MEMBER = B.MEM_ID) 
            JOIN PROD C ON (A.CART_PROD=C.PROD_ID)
WHERE       SUBSTR(A.CART_NO,1,6)='200506'
GROUP BY    A.CART_MEMBER,B.MEM_NAME
ORDER BY    1;

(ANSI ����)
SELECT      A.CART_MEMBER AS ȸ����ȣ, 
            B.MEM_NAME AS ȸ����, 
            SUM(A.CART_QTY) AS ���ż����հ�, 
            SUM(A.CART_QTY*C.PROD_COST) AS ���űݾ��հ�
FROM        CART A 
INNER       JOIN MEMBER B ON (A.CART_MEMBER = B.MEM_ID AND SUBSTR(A.CART_NO,1,6)='200506') 
INNER       JOIN PROD C ON (A.CART_PROD=C.PROD_ID)
--WHERE       SUBSTR(A.CART_NO,1,6)='200506'
GROUP BY    A.CART_MEMBER,B.MEM_NAME
ORDER BY    1;

��뿹) HR ������ ���̺���� �̿��Ͽ� �̱� �̿��� �μ��� �ٹ��ϴ� ��������� ��ȸ�Ͻÿ�
ALIAS�� �����ȣ, �����, �μ���, ����
EMPLOYEES DEPARTMENTS LOCATIONS COUNTRIES

SELECT  A.EMPLOYEE_ID AS �����ȣ, 
        A.EMP_NAME AS �����, 
        B.DEPARTMENT_NAME AS �μ���, 
        D.COUNTRY_NAME AS ����
FROM    EMPLOYEES A JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
        JOIN LOCATIONS C ON (C.LOCATION_ID = B.LOCATION_ID)
        JOIN COUNTRIES D ON (C.COUNTRY_ID=D.COUNTRY_ID AND D.COUNTRY_ID != 'US'); 
-----------
SELECT * FROM COUNTRIES
WHERE  COUNTRY_ID != 'US';
----------------------------------------------------------
SELECT  A.EMPLOYEE_ID AS �����ȣ, 
        A.EMP_NAME AS �����, 
        B.DEPARTMENT_NAME AS �μ���, 
        E.JOB_TITLE AS ������,
        D.COUNTRY_NAME AS ����
FROM    EMPLOYEES A, DEPARTMENTS B, LOCATIONS C, COUNTRIES D , JOBS E
WHERE   A.DEPARTMENT_ID = B.DEPARTMENT_ID
AND     C.LOCATION_ID = B.LOCATION_ID
AND     C.COUNTRY_ID = D.COUNTRY_ID
AND     A.JOB_ID = E.JOB_ID
AND     D.COUNTRY_ID != 'US';
-----------------------------------------------------
SELECT  A.EMPLOYEE_ID AS �����ȣ, 
        A.EMP_NAME AS �����, 
        B.DEPARTMENT_NAME AS �μ���, 
        E.JOB_TITLE AS ������,
        D.COUNTRY_NAME AS ����
FROM    EMPLOYEES A
INNER JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
INNER JOIN LOCATIONS C ON (C.LOCATION_ID = B.LOCATION_ID)
INNER JOIN COUNTRIES D ON (C.COUNTRY_ID = D.COUNTRY_ID)
INNER JOIN JOBS E ON (A.JOB_ID = E.JOB_ID)
WHERE  D.COUNTRY_ID != 'US';
----------------------------------------------------
SELECT  A.EMPLOYEE_ID AS �����ȣ, 
        A.EMP_NAME AS �����, 
        B.DEPARTMENT_NAME AS �μ���, 
        E.JOB_TITLE AS ������,
        D.COUNTRY_NAME AS ����
FROM    EMPLOYEES A
INNER JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
INNER JOIN LOCATIONS C ON (C.LOCATION_ID = B.LOCATION_ID)
INNER JOIN COUNTRIES D ON (C.COUNTRY_ID = D.COUNTRY_ID AND D.COUNTRY_ID != 'US')
INNER JOIN JOBS E ON (A.JOB_ID = E.JOB_ID)
ORDER BY 1;
------------------------------------------------------------
SELECT  A.EMPLOYEE_ID AS �����ȣ, 
        A.EMP_NAME AS �����, 
        B.DEPARTMENT_NAME AS �μ���, 
        E.JOB_TITLE AS ������,
        D.COUNTRY_NAME AS ����
FROM    EMPLOYEES A
left outer JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
left outer JOIN LOCATIONS C ON (C.LOCATION_ID = B.LOCATION_ID)
left outer JOIN COUNTRIES D ON (C.COUNTRY_ID = D.COUNTRY_ID AND D.COUNTRY_ID != 'US')
left outer JOIN JOBS E ON (A.JOB_ID = E.JOB_ID)
ORDER BY 1;
------------------------------------------
SELECT  A.EMPLOYEE_ID AS �����ȣ, 
        A.EMP_NAME AS �����, 
        B.DEPARTMENT_NAME AS �μ���, 
        E.JOB_TITLE AS ������,
        D.COUNTRY_NAME AS ����
FROM    EMPLOYEES A
right outer JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
right outer JOIN JOBS E ON (A.JOB_ID = E.JOB_ID)
right outer JOIN COUNTRIES D ON (C.COUNTRY_ID = D.COUNTRY_ID AND D.COUNTRY_ID != 'US')
right outer JOIN LOCATIONS C ON (C.LOCATION_ID = B.LOCATION_ID)
ORDER BY 1;
------------------------------------------
��뿹) 2005�⵵ 1�� �ŷ�ó�� ���Աݾ��հ�� ���Լ����հ踦 ��ȸ�Ͻÿ�.
alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��հ�� ���Լ����հ��̰�
���Աݾ��� 500���� �̻��� �ŷ�ó�� ��ȸ�Ͻÿ�

SELECT      A.BUYER_ID �ŷ�ó�ڵ�, 
            A.BUYER_NAME �ŷ�ó��, 
            SUM(B.BUY_QTY) ���Լ����հ�,
            SUM(B.BUY_QTY*B.BUY_COST) ���Աݾ��հ�
FROM        BUYER A, BUYPROD B, PROD C
WHERE       B.BUY_PROD = C.PROD_ID
AND          A.BUYER_ID =C.PROD_BUYER
AND         B.BUY_DATE BETWEEN '20050101' AND '20050131'
HAVING      SUM(B.BUY_QTY*B.BUY_COST) >= 5000000
GROUP BY    A.BUYER_ID, A.BUYER_NAME;

--�ѻ��̿� ���������� �����Ǿ� ���� ������ PROD�� ���ؼ� ���������Ҽ� �ִ�.

SELECT      A.BUYER_ID �ŷ�ó�ڵ�, 
            A.BUYER_NAME �ŷ�ó��, 
            SUM(B.BUY_QTY) ���Լ����հ�,
            SUM(B.BUY_QTY*B.BUY_COST) ���Աݾ��հ�
FROM        BUYER A-- BUYPROD B, PROD C
INNER JOIN PROD C ON  (A.BUYER_ID =C.PROD_BUYER)
INNER JOIN BUYPROD B ON  (B.BUY_PROD = C.PROD_ID)
WHERE        B.BUY_DATE BETWEEN '20050101' AND '20050131'
HAVING      SUM(B.BUY_QTY*B.BUY_COST) >= 5000000
GROUP BY    A.BUYER_ID, A.BUYER_NAME;