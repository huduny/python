2021 08 14 1������
1. ����Ŭ
SELECT �÷� AS ��Ī FROM ���̺� WHERE �� �񱳿�����
CREATE TABLE ���̺� �̸�(�÷��̸� ������Ÿ��-VARCHAR2,NUMBER,DATE�� NULL���� DEFAULT����)
CONSTRAINT �ֿ�ŰOR�ܷ�Ű//�ܷ�Ű ���� 
--REFERENCE��REFERENCES�� ���̰� ������?(����)
������ �⺻������ ALTER�� ����. 
ALTER TABLE ���̺�� RENAME �÷��� �����̸� TO ���ο� �̸�
ALTER TABLE ���̺�� ADD �÷��� �÷�����/�������� �߰��Ҷ��� ALTER TABLE X ADD(Y D, Z W ...)
ALTER TABLE ���̺�� ADD CONSTRAINT �÷���(��������) KEY ����
ALTER TABLE ���̺�� DROP CONSTRAINT �÷���(��������)
ALTER TABLE ���̺�� DISABLE CONSTRAINT �÷���(��������) //�����ϰ�
ALTER TABLE ���̺�� ENABLE CONSTRAINT �÷���(��������) //����ϰ�
ALTER TABLE ���̺�� MODIFY �÷���(����) �ٲܰ���
ALTER TABLE ���̺�� DROP COLUMN �÷���(����)//�̷��� �÷��� �����Ѵ�.
ALTER TABLE ���̺�� RENAME COLUMN �÷���(����) TO �÷���(���ο�)
EX) CREATE TABLE ���̺��(
    �÷���1 ������Ÿ�� ������ ����Ʈ����,
    �÷���2 ������Ÿ�� ������ ����Ʈ����,
    �÷���3 ������Ÿ�� ������ ����Ʈ����, 
    CONSTRAINT �÷���(���� ���Ѵ�)_pk(����ǥ�����ش�) PRIMARY KEY (�÷���1)�� ��ȣ�ȿ� ������ �ִ� �÷� �߿� ����
    CONSTRAINT �÷���(���� ���Ѵ�)_fk(����ǥ�����ش�) FOREIGN KEY (�÷���2)�� ��ȣ�ȿ� ������ �ִ� �÷� �߿� ����,PKŰ�� �ߺ� ���� REFERENCES �θ����̺� (�����÷���)
--PK�� FK�� �ߺ��Ǵ� ������ ������ �׷��ٸ� ��� �����ұ�?
PK�� is a single field or combination of fields that uniquely defines a record. None of the fields that are part of the primary key can contain a null value.
     A table can have only one primary key.
FK�� The referenced table is called the parent table while the table with the foreign key is called the child table�̴�.
------------------------------------������ �޸��� ���� �ʴ´�.
INSERT INTO ���̺��
(�÷���)
VALUES
(�����͵�); �̷��� �ϰų� OR

INSERT INTO ���̺�� --The table to insert the records into.
(�÷�1, column2, ... column_n ) --The columns in the table to insert values.
SELECT �ҽ����̺��� ������ �� expression1, expression2, ... expression_n --The values to assign to the columns in the table. 
FROM source_table --The source table when inserting data from another table.
[WHERE ���ǹ�(��>5000conditions]; --Optional. The conditions that must be met for the records to be inserted.
�׻� INSERT���� �����ϱ� ������
SELECT count(*)
FROM customers
WHERE customer_id > 5000;�� �����ؼ� Ȯ������
------------------------------------
INSERT INTO clients
(client_id, client_name, client_type)
SELECT supplier_id, supplier_name, 'advertising'
FROM suppliers
WHERE NOT EXISTS (SELECT *
                  FROM clients
                  WHERE clients.client_id = suppliers.supplier_id);
//make sure that you do not insert duplicate information by using the EXISTS condition.   
//NOT EXISTS �� ����ϸ� �ߺ��� ���� �� �ִ´�
INSERT INTO clients
(client_id, client_name, client_type)
SELECT 10345, 'IBM', 'advertising'
FROM dual
WHERE NOT EXISTS (SELECT *
                  FROM clients
                  WHERE clients.client_id = 10345);
//dual table allows you to enter your values in a select statement, even though the values are not currently stored in a table.    
//��� ���̺��� ���� ���� ���� ���� �� �ִ�
--��� ���̺��� ���� ����ұ�?
--------------------------------------
INSERT ALL
  INTO ���̺� (�÷���, supplier_name) VALUES (��������)
  INTO suppliers (supplier_id, supplier_name) VALUES (2000, 'Microsoft')
  INTO suppliers (supplier_id, supplier_name) VALUES (3000, 'Google')
SELECT * FROM dual;
//�������� ���� ������
//�÷������� NOT NULL�� ����� �÷��� ���� �Ұ���
---------------------------------------
UPDATE MEMBER SET PWD='111' WHERE ID='DRAGON';--UPDATE�� DELETE�� WHERE���� �ݵ�� �ʿ��ϴ�
----------------------------------------
    CREATE USER ������ IDENTIFIED BY ��ȣ;
    GRANT CONNECT, RESOURCE, DBA TO OYK93;
    
    ALTER USER HR ACCOUNT UNLOCK;
    ALTER USER HR IDENTIFIED BY java;
    
    DELETE OYK93.CART
    WHERE CART_NO LIKE '200505%';
    
    UPDATE HR.EMPLOYEES--������̺��
    SET RETIRE_DATE = TO_DATE('20191015')--�÷���
    WHERE EMPLOYEE_ID IN (120, 135); //in�̳� out�� ���� ���Եǰų� ���Ե��� ���� ���� �����Ҷ� ���ȴ�.
    SELECT *
    FROM TABLE1 
    WHERE COLUMN1 NOT IN (SELECT COLUMN2
                          FROM TABLE2
                          WHERE COLUMN2 IS NOT NULL) //�ѹ��� SUBQUERY�� �� �� �ִµ� null���� not��in���� �����Ҽ� ��� �� is not null
                                                       �� ��ߵȴ�.
    
    (�������)
    SELECT *|[DISTINCT] �÷��� [AS ��Ī][,]
        �÷��� [AS ��Ī][,]
            -
            -
        �÷��� [AS ��Ī]
    FROM ���̺��
    [WHERE ����]
    [GROUP BY �÷���[,�÷���,...]]
    [HAVING ����]
    [ORDER BY �÷���|�÷��ε��� [ASC|DESC][�÷���|�÷��ε��� [ASC|DESC],...]];
    CHAR����� �� �������̴�
    
    SELECT job, SUM(sal) "�޿��հ�"
    FROM emp  
    WHERE job != 'SALES'      -- �Ǹſ��� ����
    GROUP BY job              -- �������� Group By 
    HAVING SUM(sal) > 5000     -- ��ü ������ 5000�� �ʰ��ϴ�
    ORDER BY SUM(sal) DESC;   -- ���޿� �հ�� �������� ����
    //�غ����� �׷���� ������ ���´� �׷���̰� ������ �������� ���� ���ȴ�
    
    SELECT SUBSTR(COL1,5,3) AS "COL1",
           SUBSTR(COL2,5,3) AS "COL2",
           DBMS_LOB.SUBSTR(COL3, 3,5) AS "COL2"
    FROM TEMP04;
    //SUBSTR�� 5��°���� 3����
    //DBMS SUB�� 5���� 3��°����
    //�ι�° ����° �Ű������� ������ �ݴ�� �Ǿ� �ִ�.
-----------------------------------------------------------

