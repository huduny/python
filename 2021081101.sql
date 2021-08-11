2021-08-11-01)
��뿹) ��ǰ���̺��� �����Ͻÿ�
    1)��ǰ���̺�� : TBL_GOODS
    2)�÷���
-----------------------------------------------------    
    �÷���     ������Ÿ��       N.N     �������
----------------------------------------------------- 
    G_ID      CHAR(5)       N.N     PK
    G_NAME    VARCHAR2(30)
    G_PRICE   NUMBER(6)             DEFAULT 0
-----------------------------------------------------

    CREATE TABLE TBL_GOODS(
    G_ID CHAR(5) NOT NULL,
    G_NAME VARCHAR2(30),
    G_PRICE NUMBER(6) DEFAULT 0,
    
    CONSTRAINT pk_TBL_GOODS PRIMARY KEY(G_ID));

��뿹) ��ǰ���̺��� �����Ͻÿ�
    1)��ǰ���̺�� : TBL_CUSTS
    2)�÷���
-----------------------------------------------------    
    �÷���     ������Ÿ��       N.N     �������
----------------------------------------------------- 
    C_ID      CHAR(3)                  PK
    C_NAME    VARCHAR2(30)   n.n
    C_TEL   NUMBER(20)             
    C_ADDR    VARCHAR2(80)
-----------------------------------------------------
    CREATE TABLE TBL_CUSTS(
    C_ID CHAR(3),
    C_NAME VARCHAR2(30) NOT NULL,
    C_TEL NUMBER(20),
    C_ADDR VARCHAR2(80),
    
    CONSTRAINT pk_TBL_CUSTS PRIMARY KEY(C_ID));
    
��뿹) ��ǰ���̺��� �����Ͻÿ�
    1)��ǰ���̺�� : TBL_ORDERS
    2)�÷���
-----------------------------------------------------    
    �÷���     ������Ÿ��       N.N     �������
----------------------------------------------------- 
    OR_ID   NUMBER(12)                  PK
    C_ID    CHAR(3)                     FK
    OR_DATE DATE                        DEFAULT SYSDATE            
    OR_AMT  NUMBER(8)
-----------------------------------------------------

    CREATE TABLE TBL_ORDERS(
    OR_ID   NUMBER(12),
    C_ID    CHAR(3),
    OR_DATE DATE DEFAULT SYSDATE,
    OR_AMT  NUMBER(8),
    
    CONSTRAINT pk_TBL_ORDERS PRIMARY KEY(OR_ID),
    CONSTRAINT fk_orders_custs FOREIGN KEY(C_ID)
        REFERENCES TBL_CUSTS(C_ID));
        
��뿹) ��ǰ���̺��� �����Ͻÿ�
    1)��ǰ���̺�� : TBL_ORDERS_GOODS
    2)�÷���
-----------------------------------------------------    
    �÷���     ������Ÿ��       N.N     �������
----------------------------------------------------- 
     G_ID       CHAR(5)                 PK/FK
     OR_ID      NUMBER(12)              PK/FK
     G_QTY      NUMBER(3)
-----------------------------------------------------

    CREATE TABLE TBL_ORDERS_GOODS(
        G_ID CHAR(5),
        OR_ID NUMBER(12),
        G_QTY NUMBER(3),
        
            CONSTRAINT pk_ORDERS_GOODS PRIMARY KEY(G_ID,OR_ID),
            CONSTRAINT fk_OG_GOODS FOREIGN KEY(G_ID)
                REFERENCES TBL_GOODS(G_ID),
            CONSTRAINT fk_OG_ORDERS FOREIGN KEY(OR_ID)
                REFERENCES TBL_ORDERS(OR_ID));
        
**�÷��� ����
    ALTER TABLE ���̺��
        RENAME COLUMN �����÷��� TO �ٲ��÷���;
        
��뿹) �ֹ����̺��� �ֹ���ȣ �÷� 'GR_ID'�� ����� ���� 'OR_ID'�� �ٲܷ���
    ALTER TABLE TBL_ORDERS
        RENAME COLUMN 'GR_ID' TO 'OR_ID';
        
**�÷� ����(����Ÿ Ÿ�� �Ǵ� ũ�� ����)
    ALTER TABLE ���̺��
        MODIFY(�÷��� ������Ÿ��[(ũ��)];
��뿹) �ֹ����̺��� �ֹ���ȣ�� NUMBER(12)���� CHAR(12)�� �ٲٽÿ�
    ALTER TABLE TBL_ORDERS_GOODS
        MODIFY(OR_ID CHAR(12));--�⺻Ű�̸鼭 �ܷ�Ű�̱� ������ ������� ����, �����ǰ� �ֱ� �����̴�.
                               --�⺻Ű�̸� �ٲܼ� �ִ�
��뿹) �ֹ����̺��� ������ NUMBER(3)���� NUMBER(5)�� �ٲٽÿ�
    ALTER TABLE TBL_ORDERS_GOODS
        MODIFY(G_QTY NUMBER(5));
        
** ���̺�� ����
ALTER TABLE �������̺� RENAME TO �ٲ� ���̺��;

��) TBL_ORSER�̶�� ���̺��� TBL_ORDER�� �ٲܷ���
    ALTER TABLE TBL_ORSER RENAME TO TBL_ORDER;--
    