2021-0812-01)
2. UPDATE��
    -���̺� ����� �ڷḦ ������ �� ���(������ �����ϴ� ���� alter�̴�)
    (�������)
    UPDATE ���̺��
        SET �÷���=�� [,
            �÷���=��,
            ...]
    [WHERE ����];
    --SELECT ���� �˻縦 �Ҷ� ���(FROM WHERE SELECT)
    --SELECT�� FROM���� �ʼ���, WHERE�� �����Ǹ� �ش� ���̺��� ��� ���� �ǹ��Ѵ�
    
    ��뿹) SEM������ ��ǰ���̺��� P102000004 ��ǰ�� ���԰����� 990000���� 80000������ �����Ͻÿ�.
    UPDATE OYK93.PROD
    SET    PROD_COST = 800000
    WHERE PROD_ID='P102000004';
    
    SELECT * FROM OYK93.PROD;
    COMMIT

    ��뿹) HR������ ������̺� (EMPLOYEES)�� ���ο� �÷� 'EMP_NAME VARCHAR2(80)'��
           �߰��ϰ� �� ����� �̸�(FIRST_NAME)�� ��(LAST_NAME)�� �����Ͽ� �Է� �Ͻÿ�
           ** �÷� �߰�
           ALTER TABLE ���̺�� ADD(�÷��� ������Ÿ�� [(ũ��)] [DEFAULT ��]);
           
           ALTER TABLE HR.EMPLOYEES ADD(EMP_NAME VARCHAR2(80));
           ALTER TABLE HR.EMPLOYEES ADD(RETIRE_DATE DATE);
           COMMIT;



    UPDATE HR.EMPLOYEES
        SET EMP_NAME=FIRST_NAME||' '||LAST_NAME;
        --||��ȣ�� �ٿ��� ��� �ǹ��̴�
        --WHERE�� �����ϸ� ���δٶ�� �ǹ��̴�

    COMMIT;
       SELECT FIRST_NAME, LAST_NAME, EMP_NAME FROM HR.EMPLOYEES; 
       
    ��뿹) HR������ ������̺�(EMPLOYEES)���� �����ȣ(EMPLOYEE_ID)�� 120���� 135��
    ����� 2019.10.15�� ���ڷ� ����ó�� �Ͻÿ�.
    UPDATE HR.EMPLOYEES--������̺��
        SET RETIRE_DATE = TO_DATE('20191015')--�÷���
    WHERE EMPLOYEE_ID IN (120, 135);
    --WHERE�� ���� ��� SET�� �÷��� ���
    COMMIT
    
    3. DELETE��
    - ���̺��� �ڷḦ ������Ŵ
    ---DROP�� �� ��ü�� �� ���̺��� ����
    �������
    DELETE ���̺�� --ROLLBACK�Ҽ� �ִ�.
    
    SELECT * FROM OYK93.PROD;
    ��뿹) DELETE OYK93.PROD;
    --�ڽ��� ������ �����Ҽ� ����.
    DELETE OYK93.CART;
    --���� ���� ��µǾ����� ������ �ƴϴ�. �ٸ� ���ǿ� �´� ����� ����.
    ROLLBACK;
    COMMIT;
    
    DELETE OYK93.CART
    WHERE CART_NO LIKE '200505%';
    --LIKE�� ���Խ��� ǥ���Ѵ�.
    --%�� �� �ڸ� �ڿ� � �ڸ��� ���͵� �� ���ٴ� ���̴�.
    --�� 2005�� 5���޿� �Ǹŵ� ����
     ROLLBACK;
      COMMIT;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
            
            
            
            
            
            
            
            
            
            
            