2021-08-26-01
4) TO_DATE(c1 [,fmt])
    -�־��� ���ڿ� C1�� 'fmt'���Ŀ� �´� ��¥ �ڷ�� ���� ��ȯ ��Ŵ
    -'fmt'�� TO-CHAR �Լ��� ��¥ ��ȯ���� ���� ���ڿ��� ������ ��¥ �ڷ������� ����� �� �ִ� ���ڿ��� Ȱ��
    
��뿹) ��ٱ��� ���̺��� 2005�� 6�� �Ǹ���Ȳ�� ��ȸ�Ͻÿ�
    Alias�� ����, ��ǰ�ڵ�, �Ǹż��� �̴�.
    SELECT  TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,8)), 'MM-DD') ����, 
            CART_PROD ��ǰ�ڵ�, 
            CART_QTY �Ǹż���
    FROM    CART
    WHERE   CART_NO LIKE '200506%'
    ORDER BY 1;

**NULL ó���Լ�
�ΰ��� ���������͸� �ı���ų�� �ִ�.
����Ŭ�� ���� �Է����� ������ ������ ���� �Էµȴ�. �׷��� �� ���Ŀ� ������ �Ҷ� ������ �ȴ�.
-�����Ͱ� NULL ������ �ʱ�ȭ �� ��� ������ ����� ��� NULL�� ��
-Ư�� �ڷᰡ NULL�������� �Ǵ��Ͽ� NULL�� ���� ������� ó���ϴ� �Լ�
-NVL,NVL2,NULLIF ���� ����

1)NVL(COL1, VAL)
    -'COL'�� ���� NULL�̸� 'VAL'���� ��ȯ�ϰ�, NULL�� �ƴϸ� 'COL1'���� ��ȯ
    -���� ���� ���
    -'CPL1'�� 'VAL'�� �ڷ�Ÿ���� �����ؾ���

��뿹) ������̺��� �������� �ڵ带 ��ȸ�Ͽ� NULL�� ��쿡 '������������'�� NULL�� �ƴ� ��쿡 ���� ���� �ڵ带 ����� ����Ͻÿ�.
ALIAS�� �����ȣ, �����, ��å�ڵ�, ���
    SELECT      EMPLOYEE_ID �����ȣ, 
                EMP_NAME �����, 
                JOB_ID ��å�ڵ�, 
                COMMISSION_PCT ��������,
                LPAD(NVL(TO_CHAR(COMMISSION_PCT,'0.99'), '�������� ����'),14) ��� --COL�� VAL�� ���� �ڷ�Ÿ���� �����ؾߵȴ�.
    FROM        EMPLOYEES;

    
��뿹) ��ǰ���̺��� 'P301'�� ���� ��ǰ�� ���� �ǸŰ��� ���԰��� ������ ������ �����Ͻÿ�.
    UPDATE  PROD 
    SET     PROD_SALE=PROD_COST
    WHERE   PROD_ID LIKE 'P301%';
    --�����ߴ� �������� �Ȱڴ� ������ �ȾƼ� ó���� �����ڴ�.
    
2)NVL2(COL,VAL1,VAL2)
    -'COL'�� ���� NULL�̸� 'VAL2'���� ��ȯ�ϰ�, NULL�� �ƴϸ� 'VAL1'���� ��ȯ ��
    -'VAL1','VAL2' �� ���� Ÿ���� ��ġ�ؾ� ��
    
��뿹)��ǰ���̺��� ��ǰ�� ũ��(PROD_SIZE)�� NULL�̸� ��ǰ�� ���ϸ����� ���԰��� 10%�� NULL�� �ƴϸ� ��ǰ�� ���ϸ����� �ǸŰ��� 10%�� ����Ͽ�
�����Ͻÿ�

SELECT   PROD_ID AS ��ǰ��,
         PROD_SIZE AS ũ��,
         PROD_COST AS ���԰�,
         PROD_PRICE AS �ǸŰ�,
         ROUND(NVL2(PROD_SIZE,PROD_PRICE*0.001,PROD_COST*0.001)) AS ���ϸ��� 
FROM     OYK93.PROD;
        
UPDATE   PROD 
SET      PROD_MILEAGE = ROUND(NVL2(PROD_SIZE,PROD_PRICE*0.001,PROD_COST*0.001));
    
3)NULLIF(COL1,COL2)
-'COL1'��'COL2'�� ���� ������ NULL�� ���� ������ 'COL1'�� ��ȯ

��뿹) ��ǰ���̺��� ���԰��� ���ΰ��� ������ '������ǰ'�� ���� ���� �ƴϸ� '�����ǰ'�� ����� ����Ͻÿ�
ALIAS�� ��ǰ�ڵ�, ��ǰ��, ���԰�, ���Ⱑ, �����ǸŰ�, ���
    



COMMIT;
SELECT      PROD_ID AS ��ǰ�ڵ�, 
            PROD_NAME AS ��ǰ��, 
            PROD_COST AS ���԰�, 
            PROD_PRICE AS ���Ⱑ, 
            PROD_SALE AS �����ǸŰ�, 
            NVL2(NULLIF(PROD_COST, PROD_SALE),'�����ǰ','������ǰ') AS ���
FROM        PROD;

----------------------------------
ALTER TABLE PROD ADD REMARK VARCHAR2(25);
ROLLBACK;   

UPDATE      PROD
SET         REMARK = NVL2(NULLIF(PROD_COST, PROD_SALE),'�����ǰ','������ǰ');

ROLLBACK;
--�ѹ��� �÷��� �� ��������

ALTER TABLE PROD
DROP COLUMN REMARK;
ROLLBACK;

DELETE : ���̺��� �����͸� �� ������ ����
DROP : ���̺��� ���İ� ��� ������ ����
TRUNCATE - ���̺��� ��� �����͸� ����

4) IS NULL, IS NOT NULL
    -Ư�� �÷��� ����� ���� NULL���� �Ǵ��� �� '='�����ڴ� ����� �� ����
    
��뿹) ������̺��� ���������� NULL�� �ƴ� ����� ��ȸ�Ͻÿ�
        ALIAS�� �����ȣ, �����, ��������, �μ��ڵ�
        
        SELECT  EMPLOYEE_ID �����ȣ, EMP_NAME �����, COMMISSION_PCT ��������, DEPARTMENT_ID �μ��ڵ�
        FROM    EMPLOYEES
        WHERE   COMMISSION_PCT IS NOT NULL
                AND DEPARTMENT_ID IS NOT NULL;
                
                
                