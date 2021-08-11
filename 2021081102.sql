2021081102)DML (DATA MANIPULATION LANGUAGE)
-INSERT, UPDATE, DELETE
1) INSERT 
    - ���ο� �ڷḦ ���̺� ����(���̺��� ������ ������� �־�� �ȴ�.)
    - �Է¼����� ���̺� �������� ����
        (�������)
        INSERT INTO ���̺�� [(�÷���1,�÷���2,...)]
            VALUES(��1,��2....);
        * ���̺��: ��� ���̺��
        * �÷���: �ڷḦ �Է��� �÷���
          ���������ϸ� ��� �÷����� �����Ǹ� �÷��� ����� ������ ������ �°� VALUES������ ���� ����Ⱦ�� �Ѵ�.
        * �÷���: �÷��� �� �Ϻΰ� ������ �� ����
          �÷����� ����Ǹ� ����� ������ ������ �°� VALUES������ ���� ����Ǿ�� �Ѵ�.(��, �÷������� NOT NULL�� ����� �÷��� ���� �Ұ���)
        
��뿹) TBL_GOODS���̺� ���� �ڷḦ �Է��Ͻÿ�.
-------------------------------------------
��ǰ�ڵ�        ��ǰ��     ����
P1001         �Ŷ��      1200
P1002         �����      1000
P1101         ��������    15000
P1102         
-------------------------------------------
INSERT INTO TBL_GOODS
    VALUES('P1001', '�Ŷ��', 1200);
INSERT INTO TBL_GOODS
    VALUES('P1002', '�����', 1000);  
INSERT INTO TBL_GOODS(G_PRICE, G_NAME, G_ID)
    VALUES(15000,'��������','P1101');  
INSERT INTO TBL_GOODS(G_ID,G_NAME)
    VALUES('P1012', '��¥���');  
INSERT INTO TBL_GOODS(G_ID)
    VALUES('P1102'); 
    SELECT * FROM TBL_GOODS;

��뿹) �����̺� ���� �ڷḦ �Է��Ͻÿ�.
-------------------------------------------    
����ȣ    ����     ��ȭ��ȣ    �ּ�
'A01'       'ȫ�浿'    042-222-8202  '������ �߱� ���ﵿ 500
'B01'       'ȫ���'           
'B02'       '�ڵ��'                  '����� ���ϱ� ������ 400
-------------------------------------------
INSERT INTO TBL_CUSTS
    VALUES('A01','ȫ�浿',042-222-8202,'������ �߱� ���ﵿ 500');

INSERT INTO TBL_CUSTS
    VALUES('B01','ȫ���','','������ �߱� ���ﵿ 500');
    
INSERT INTO TBL_CUSTS
    VALUES('C01','ȫ����','','');

INSERT INTO TBL_CUSTS
    VALUES('D01','ȫ����',213243525,'');   

INSERT INTO TBL_CUSTS
    VALUES('E01','ASDA',NULL,'');   
    
    SELECT * FROM TBL_CUSTS;

��뿹)'BO1'���� ���� 'P1001' ��ǰ�� 5��, 'P1101'��ǰ�� 2�� ������ ��� �ֹ����̺� �ش� ������ �����Ͻÿ�.
�ֹ���ȣ�� ��¥8�ڸ��� ���ʴ�� �ο��ϴ� ��ȣ 4�ڸ��� ����
SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||'0001'
FROM DUAL;

--���� ����
INSERT INTO TBL_ORDERS(OR_ID,C_ID,OR_DATE)
    VALUES(TO_CHAR(SYSDATE,'YYYYMMDD')||'0001','B01',SYSDATE);
    
INSERT INTO TBL_ORDERS_GOODS
    VALUES('P1002',TO_CHAR(SYSDATE,'YYYYMMDD')||'0001',2);
---�ݾ��հ踦 TBL_ORDERS�� �ݾ��÷��� ����
UPDATE TBL_ORDERS C
SET C.OR_AMT=(SELECT SUM(G_OTY*G_PRICE)
                FROM TBL_GOODS A,TBL_ORDERS_GOODS B
                WHERE B.OR_ID=TO_CHAR(SYSDATE,'YYYYMMDD')||'0001'
                AND A.G_ID=B.G_ID)
WHERE C.OR_ID=TO_CHAR(SYSDATE,'YYYYMMDD')||'0001';
