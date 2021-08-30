2021-08-30-02)��Ÿ �����Լ� ROLLUP�� CUBE

1)ROLLUP(COL1[,COL2,...,COLN])
    - ������ �κ������ ��ü���踦 ��ȯ
    - GROUP BY ���� ���
    - ����� �÷��� COL1~COLN�� �������� ���踦 ��ȯ�� �� �����ʺ��� �ϳ��� �÷������ ������ �������� ���踦 ��ȯ
    - ���������� ��ü����(COL���� ��� ������� ���� ����)�� ��ȯ�ϹǷ� ���� �÷��� N���϶� ������ ������ N+1����
    - ���� ����Ѵ�.
    - 
    
    SELECT  BUY_DATE,
            BUY_PROD,
            SUM(BUY_QTY),
            MAX(BUY_COST)
    FROM    BUYPROD
    GROUP BY ROLLUP(BUY_DATE, BUY_PROD);

��뿹) 2005�⵵ ����, ȸ����, ��ǰ�� �������踦 ��ȸ�Ͻÿ� ��������� ��������հ��̴�.
--ROLL UP �̻�� �κ��հ� ����.
SELECT      SUBSTR(CART_NO, 5, 2) AS ��, 
            CART_MEMBER AS ȸ��, 
            CART_PROD AS ��ǰ, 
            SUM(CART_QTY) ��������հ�
FROM        CART 
WHERE       CART_NO LIKE '2005%'
GROUP BY    ROLLUP(SUBSTR(CART_NO, 5, 2), CART_MEMBER, CART_PROD)
ORDER BY    1, 2 ASC;
-- 3���� ������ �հ� 2���������� �հ� 1���� ������ �հ� EX 4-19-475(198��) ������ ��ü�հ�
-- ���� N+1���� ������ ��� �Ǿ���.
SELECT      SUBSTR(CART_NO, 5, 2) AS ��, 
            CART_MEMBER AS ȸ��, 
            CART_PROD AS ��ǰ, 
            SUM(CART_QTY) ��������հ�
FROM        CART 
WHERE       CART_NO LIKE '2005%'
GROUP BY    GROUPING SETS(SUBSTR(CART_NO, 5, 2), CART_MEMBER, CART_PROD)
ORDER BY    1, 2 ASC;

2)CUBE(COL1[,COL2,...,COLN])
-�÷����� �������� ���հ����� ����� ����ŭ�� ���踦 ��ȯ�� �� ��ü ���踦 ��ȯ
- GROUP BY������ ���
- ����� �÷��� ������ N���̸� ������ ������ 2^N��

SELECT  LISTAGG(CART_MEMBER, ',') WITHIN GROUP(ORDER BY CART_NO DESC) AS NAMES
FROM    CART

GROUP BY 

(�κ� ROLLUP)
SELECT      SUBSTR(CART_NO, 5, 2) AS ��, 
            CART_MEMBER AS ȸ��, 
            CART_PROD AS ��ǰ, 
            SUM(CART_QTY) ��������հ�
FROM        CART 
WHERE       CART_NO LIKE '2005%'
GROUP BY    CART_MEMBER, SUBSTR(CART_NO, 5, 2), ROLLUP(CART_PROD)
--SUBSTR(CART_NO, 5, 2), ROLLUP(CART_MEMBER, CART_PROD)
ORDER BY    1, 2 ASC;
--�̰��� ��ü �հ谡 ����.

2021-08-30-03) ���̺� ����
    -JOIN������ ������ �����ͺ��̽� ���� �� ���� �߿��� ����
    -�� �� �̻��� ���̺��� ���� �÷��� ���Ͽ� ���踦 �ΰ� �ִ� ��� ����
    -�л�� �ڷḦ ���踦 �̿��Ͽ� ��ȸ�Ҷ� ���
    -������ �з�
    1) �Ϲ����� VS ANSI ����
    2) �������� VS �񵿵� ����
    3) �������� VS �ܺ�����
    4) ��Ÿ SELF JOIN, CREATESIAN PRODECT ���� ����
 
1. CARTESIAN PRODUCT
    -���������� ���ų� ���������� �߸� ����� ���
    -������ ��� ������ ����� ��ȯ(N��M�� X A��C�� => (A*N�� M+C��)
    -ANSI ������ CROSS JOIN�� ����
    Ư���� ������ �ƴϸ� ����ؼ��� �ȵ�
��뿹) 
SELECT COUNT(*)
FROM    CART, PROD;

SELECT COUNT(*)
FROM    CART, PROD, BUYPROD;

2. ��������(EQUI-JOIN)
    -ANSI�� INNER JOIN(��������)�� �ش�
    -�������ǿ� '='������ ���Ǵ� ����
    
    (�������: �Ϲ�����)
    SELECT [���̺��.|���̺�Ī.]�÷��� [AS ��Ī]
    ..
    SELECT [���̺��.|���̺�Ī.]�÷��� [AS ��Ī]
FROM ���̺�� [��Ī], ���̺�� [��Ī][,���̺�� [��Ī],...]
WHERE �������� 
[AND �Ϲ�����,...]
--WHERE������ ���� ������ ����Ѵ�. �����̺� ������ ���̺��� �����ؾ� �ȴ�.
(�������: ANSI����)
    SELECT [���̺��.|���̺�Ī.]�÷��� [AS ��Ī]
    ..
    SELECT [���̺��.|���̺�Ī.]�÷��� [AS ��Ī]
FROM ���̺��1 [��Ī1]
INNER JOIN ���̺��2 [��Ī2] ON(��������1 [AND �Ϲ�����1])
[INNER JOIN ���̺��3 [��Ī3] ON(��������2 [AND �Ϲ�����2])
..
[WHERE �Ϲ�����_N];
**���̺��1�� ���̺��2�� �ݵ�� ���� �����ؾ� ��
**��������1�� ���̺��1�� ���̺��2 ������ ��������
**��������2���ʹ� ���� ����� �����Ҷ� ����Ǵ� ��������
**�Ϲ�����1, 2�� �ش� ��ġ���� ����Ǵ� �Ϲ������̰�
  WHERE �Ϲ�����_N�� ��� ���̺� ����Ǵ� �Ϲ�������.
  ���̺��1�� ���̺��2�� ���� ����� ���̺��3�� ���εǾ�����.
  �Ϲ����� 1�� ���̺�� 2���� ����ȴ�.
  
��뿹) �μ��� ����ӱݰ� �ο����� ���
ALIAS�� �μ���ȣ, �μ���, �ο���, ����ӱ�
--�Ϲ�����
SELECT      B.DEPARTMENT_ID AS �μ���ȣ, 
            B.DEPARTMENT_NAME AS �μ���, 
            COUNT(*) AS �ο���, 
            ROUND(AVG(A.SALARY)) AS ����ӱ�
FROM        HR.EMPLOYEES A, HR.DEPARTMENTS B
WHERE       A.DEPARTMENT_ID=B.DEPARTMENT_ID --��������
GROUP BY    B.DEPARTMENT_ID, B.DEPARTMENT_NAME
ORDER BY    1;
--������ ������ �U�� ���������ؼ� NULL���� ��������.(�̳�����)\
--���� �ʿ� ���ߴ� ����(�ƿ��������̴�)

--ANSI����            
SELECT      B.DEPARTMENT_ID AS �μ���ȣ, 
            B.DEPARTMENT_NAME AS �μ���, 
            COUNT(*) AS �ο���, 
            ROUND(AVG(A.SALARY)) AS ����ӱ�
FROM        HR.EMPLOYEES A
INNER JOIN  HR.DEPARTMENTS B ON (A.DEPARTMENT_ID=B.DEPARTMENT_ID) --��������
GROUP BY    B.DEPARTMENT_ID, B.DEPARTMENT_NAME
ORDER BY    1;
