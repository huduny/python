2021-08-25-01

3)TO_NUMBER(EXPT[,FMT])
-C1���� ����� ���ڿ��� 'FMT' ���Ŀ� �µ��� ���ڷ� ����ȯ
-'FMT'�� ���ڷ� ��ȯ�� �� �ִ� �������� ���ڿ��� ����

��뿹) SELECT TO_NUMBER('3.1415926'),
              TO_NUMBER('31415','99999.99'),
              TO_CHAR('31415','99999.99'),
             --TO_NUMBER('$2,000','9,999')
             TO_NUMBER('<2,000>','9,999PR')
        FROM   DUAL;
        
��뿹) �з����̺� '��Ʈ��' �з��� �߰��Ͻÿ� '��Ʈ��'�� ������ǰ���� 'P1XX'���� �з��ڵ带 �ο��� ��
    
    SELECT 'P'||TO_CHAR(TO_NUMBER(SUBSTR(MAX(LPROD_GU),2))+1) FROM LPROD WHERE LPROD_GU LIKE 'P1%';
    --WHERE,MAX=>P102=>SUBSTR=>102=>TO_NUMBER=>103=>TO_CHAR=>P103
    
    INSERT INTO  LPROD
    SELECT       10,
                 'P'||TO_CHAR(TO_NUMBER(SUBSTR(MAX(LPROD_GU),2))+1),      
                 'LAPTOP'
    FROM         LPROD
    WHERE        LPROD_GU LIKE 'P1%';
    --���������� ������ ��ȣ�� ��ߵǴµ� INSERT�� ������ �����̴�.
    ALTER TABLE LPROD 
    COMMIT;
    
    
    
    
    
    
    