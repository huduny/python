2021-08-26-02)

02)�����Լ�
    -�����͸� Ư�� �÷��� �������� �׷�ȭ�ϰ� �� �׷쿡�� �������� �������� ��ȯ��Ű�� �Լ�
    -�������� ����� ��ȯ
    -SUM,AVG,COUNT,MAX,MIN �Լ�����
    -�����Լ��� ��ø ����� �� ����,
    -SELECT���� ���� �����Լ� �̿��� �÷��� �����ϸ� �ݵ�� GROUP BY ���� ����Ǿ�� �ϰ�,
    -GROUP BY ���� �����Լ� �̿��� �÷��� ����ؾ� ��
    -�����Լ��� ������ �ο��� ��� HAVING ���� ó�� �ؾ���
    
(�������)
SELECT  COL1,
        SUM|AVG|MAX|MIN(CO1)|COUNT(*|CO1)[, ..
        
FROM    ���̺��
[WHERE ����]
[GROUP BY COL1[,COL2,...]]
[HAVING ����]
[ORDER BY �÷�|�÷��ε��� [ASC|DESC][,�÷�|�÷��ε���[ASC|DESC],...]]
--���� ���� ��ȯ�Ǵ� ���� ������ �Լ���� �Ѵ�. �����Լ��� �����ϰ�� ������ �Լ��̴�.
--�����Լ��� SELECT���� �� �ľ��ؾ� �ȴ�.
--���������� ��ߵȴ�
--~���� ������ �׷���̷� �����ش� ��ǰ�� �Ǹż��� ��ǰ�ڵ�OR��ǰ�� ~~~������ ~~~�� 
���� ȸ����//�� ȸ���� ���űݾ� �հ�//���� ���� ����� ������, �� �׷�ȿ��� �� ȸ������ �׷����� �Ѵ�
EX) GROUP BY CART_MEMBER, SUBSTR(CART_NO,1,6)//ȸ������ ������ ȸ�������� �ٽ� ������ �׷����� �Ѵ�
SELECT ���� ��� ���̺�ȿ� �ִٸ� ������ ������ ���� �Ⱦ���.

�Ϲ�����, ��������(���̺� 2���̻�), �����Լ��� ������ �ο��Ǵ� ���(WHERE���� ����ó���� ���ؼ�) �̶� HAVING���� ����Ѵ�.
���̺� ��ü�� �ϳ��� ��ü �׷��϶��� �׷�������� ���� �����ϴ� �� �Ϲ� �÷��� �ϳ��� ������

1)SUM(EXPR)
-'EXPR'�� ����� �÷��̳� ������ �հ踦 ��ȯ

��뿹) ������̺��� �μ���ȣ 80���μ��� ������� �޿��հ踦 ��ȸ�Ͻÿ�.
SELECT SUM(SALARY) AS �޿�
FROM   HR.EMPLOYEES
WHERE  DEPARTMENT_ID=80;

��뿹) ������̺��� �μ��� ������� �޿��հ踦 ��ȸ�Ͻÿ�.
SELECT  DEPARTMENT_ID AS �μ��ڵ�,
        SUM(SALARY) AS �޿�
FROM    HR.EMPLOYEES
GROUP BY DEPARTMENT_ID;
--��ü���� ROLLUP ť���� �Լ�

��뿹) 2005�� 1-3�� ���� ���Լ��� �հ�� ���Աݾ� �հ踦 ��ȸ�Ͻÿ�
SELECT      EXTRACT(MONTH FROM BUY_DATE) AS ����,
            NVL(SUM(BUY_QTY),0) AS ���Լ����հ�,
            NVL(SUM(BUY_QTY*BUY_COST),0) AS "���Աݾ� �հ�" --��Ī�� ���� ����  ����
FROM        BUYPROD
--WHERE       BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050331')
--WHERE       EXTRACT(MONTH FROM BUY_DATE) BETWEEN '01' AND '03'
WHERE       EXTRACT(MONTH FROM BUY_DATE) IN('01', '02', '03')
GROUP BY    EXTRACT(MONTH FROM BUY_DATE)
ORDER BY    1;



��뿹) 2005�� 1-3�� ��ǰ�� ���Լ��� �հ�� ���Աݾ� �հ踦 ��ȸ�Ͻÿ�
SELECT      BUY_PROD AS ��ǰ��,
            NVL(SUM(BUY_QTY),0) AS ���Լ����հ�,
            NVL(SUM(BUY_QTY*BUY_COST),0) AS "���Աݾ� �հ�" --��Ī�� ���� ����  ����
FROM        BUYPROD
WHERE       BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050331')
GROUP BY    BUY_PROD
ORDER BY    1;

  

��뿹) ��ǰ���̺��� ��ǰ�з��� ��ǰ ���ϸ����հ踦 ��ȸ�Ͻÿ�
SELECT      PROD_LGU AS ��ǰ�з���,
            SUM(PROD_MILEAGE) AS "��ǰ���ϸ��� �հ�"
FROM        PROD
GROUP BY    PROD_LGU
ORDER BY    1;
            











