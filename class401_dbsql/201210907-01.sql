2021-0907-01) �䰴ü
- ������ ���̺�
- ������ ���̺��̳� �ٸ� �並 �̿��� SELECT ���� ����� ���̺�ó�� ���
- �ʿ��� ������ ���� ���̺� �л�Ǿ� �ִ� ���
- Ư���ڷῡ ���� ������ �����ϰ� ����� ����

(�������)
CREATE [OR REPLACE] VIEW ���̸�[(�÷�LIST)]
AS
    SELECT ��;
    [WITH CHECK OPTION]
    [WITH READ ONLY]
    .WITH ���� ������ ORDER BY�� ��� �Ұ�
    .�䰡 �����Լ�, GROUP BY, DISTINCT�� ����Ͽ� ������ ��� INSERT, UPDATE, DELETE�� ����� �� ����
    .���� Ư�� �÷��� ǥ����(CASE WHEN~THEN, DESCODE ��), �Լ��� ���� ��� �ش��÷��� �߰� �� ���� �Ұ�
    .CURRVAL, NEXTVAL �� �ǻ� �÷����Ұ�
    .ROWID, ROWNUM ���� �ǻ��÷��� ��Ī�� ����ؾ���
--����� ����� �ʿ��� ��쿡 ���� �並 ������ ó���� �� �ִ�.    
--�並 ���̺� ó�� �ҷ��� �� �� �ִ�.
--FROM���� �� �� �ִ�. FROM���� ������ ���������� ���̴�.
--REPLACE�� ��ü�ϴ� ���̴�. LIST�� �÷��� ���� ����Ʈ, �����Ǹ� SELECT���� �÷� ��Ī, SELECT���� ���� �÷� ���� ���ȴ�.
--�並 �����ߴµ� ���������Ͱ� �����ȴ�. �׷��� ���ϰ� �ϴ� ���� READ ONLY�̴�. ���������Ͱ� ���ϸ� �䰡 ��ȭ�ȴ�. �������̺��� ��������� �ٲ�� �׻� �信 ����
--�䰡 �ٲ� �������̺��� �ٲ�� ���� ���ϰ� �ϴ°� WITH READ ONLY�̴�. WITH CHECK OPTION �ڰ��� ����ϴ� ������ �ο��� �� ����. 
--WITH CHECK OPTION�̳� WITH READ ONLY�� ���� ������ ���Ѵ� WITH CHECK OPTION�� �� ū �� �� ����� ������ ���� �ʴ� ������ ��ȭ�� �����ϴ�.

��뿹) ���ϸ����� 3000�̻��� ȸ���� ȸ����ȣ, ȸ����, ����, ���ϸ����� �並 �����Ͻÿ�.

CREATE OR REPLACE VIEW V_MEM01(MID,MNAME,MJOB,MMILE)
AS
    SELECT  MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����, MEM_JOB AS ����, MEM_MILEAGE AS ���ϸ���
    FROM    MEMBER
    WHERE   MEM_MILEAGE>=3000;
    
SELECT * FROM V_MEM01;

(���� �� ����)
UPDATE  V_MEM01
SET     MMILE=10000
WHERE   UPPER(MID)='C001';

SELECT  MEM_ID, MEM_NAME, MEM_MILEAGE
FROM    MEMBER
WHERE   UPPER(MEM_ID)='C001';

CREATE OR REPLACE VIEW V_MEM01(MID,MNAME,MJOB,MMILE)
AS
    SELECT  MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����, MEM_JOB AS ����, MEM_MILEAGE AS ���ϸ���
    FROM    MEMBER
    WHERE   MEM_MILEAGE>=3000
    WITH CHECK OPTION ;   
    
UPDATE  V_MEM01
SET     MMILE=5500
WHERE   UPPER(MID)='C001';    
    
UPDATE  MEMBER
SET     MEM_MILEAGE=3500
WHERE   UPPER(MEM_ID)='C001';
    
2021-0907-02) SEQUENCE ��ü
- ���̺�� �������� ������ ��ȣ�� ����
- �⺻Ű�� ������ �ĺ�Ű�� ���� ���
- �ڵ������� �������� ��ȣ�� �ʿ��� ���
(�������)
CREATE SEQUENCE ��������
[START WITH N] --���� �� �����Ǹ� MINVALUE/10000�̶�� �ϸ� 10000������ ����
[INCREMENT BY N] --����[����] ��
[MAXVALUE N|NOMAXVALUE]-- �ִ밪, �⺻�� NOMAXVALUE�̰� 10^27���� ���
[MINVALUE N|NOMINVALUE]-- �ִ밪, �⺻�� NOMINVALUE�̰� 1�̴�
[CYCLE|NOCYCLE] -- �ִ�[�ּ�]������ ���� �� �ٽ� SEQUENCE �������� �⺻�� NOCYCLE
[CACHE N |NOCACHE]-- ĳ�� ��� ����. �⺻�� CACHE 20 �̴�.
[ORDER | NOORDER] -- ���ǿ� �´� ������ ���� ���� ����, �⺻�� NOORDER

**�������� ����
--------------------------------------------------------------------
�ǻ��÷�(PSEUDO COLUMN)             �ǹ�
--------------------------------------------------------------------
��������.CURRVAL                '������'�� ���簪
��������.NEXTVAL                '������'�� ������
--------------------------------------------------------------------
**������ ���� �� �ش缼�ǿ��� ó�� ������ ����� �ݵ�� '��������.NEXTVAL'�̾�� ��;
--EX) ������� �� ���� ��ȣ;
�����÷�(�����÷�) CURRVAL ���簪�� ���� NEXTVAL�ϳ� ������ ���� ������

 SELECT (10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10) AS "10^27" FROM DUAL;   

**LPROD ���̺��� LPROD_ID�� 10 �̻��� �ڷḦ ��� ���� �Ͻÿ�.
    DELETE  LPROD
    WHERE   LPROD_ID>=10;
    ROLLBACK;
    SELECT * FROM LPROD;
    COMMIT;
    
��뿹) LPROD���̺� ���� �ڷḦ �߰� �����Ͻÿ�
    LPROD_ID: ������ ��
    LPROD_GU: 'P501'
    LPROD_NM: '��깰'
    
    INSERT INTO LPROD 
    VALUES (SEQ_LPROD.CURRVAL, 'P501', '��깰');
    
    LPROD_ID: ������ ��
    LPROD_GU: 'P502'
    LPROD_NM: '���깰'   

    INSERT INTO LPROD 
    VALUES (SEQ_LPROD.NEXTVAL, 'P502', '���깰');
    
    LPROD_ID: ������ ��
    LPROD_GU: 'P503'
    LPROD_NM: '��깰'     
    
    INSERT INTO LPROD 
    VALUES (SEQ_LPROD.NEXTVAL, 'P503', '��깰');
    
(������ ����)    
CREATE SEQUENCE SEQ_LPROD     
START   WITH    10;    

SELECT     SEQ_LPROD.NEXTVAL FROM DUAL;
SELECT     SEQ_LPROD.CURRVAL FROM DUAL;
ROLLBACK;    

��뿹)  CART_NO�� ���������� �ο��ϰ����Ѵ�. �ʿ��� �������� �����Ͻÿ�. CART_NO�� ��¥ 8�ڸ��� ���� 4�ڸ��� 1001������ �ο��ǰ� 9999������
        ���ȴ�. �� ���� ���� 1�̰� ��ȯ����� �� �ִ�.
CREATE SEQUENCE SEQ_CART_NO
INCREMENT BY    1
MINVALUE    1001
MAXVALUE    9999
CYCLE;
        
SELECT     SEQ_CART_NO FROM DUAL;
SELECT     SEQ_LPROD.CURRVAL FROM DUAL;
    
SELECT TO_CHAR(SYSDATE, 'YYYYMMDD')||TO_CHAR(SEQ_CART_NO.NEXTVAL)
FROM DUAL;
    
2021-0709-03)SYNONYM (���Ǿ�) ��ü(���̺�, ��, �ε��� ���)
- ����Ŭ���� �����Ǵ� ��ü���� �� �ٸ� �̸��� �ο�
- ���̺� ��Ī/ �÷��� ��Ī�� �������� ���Ǿ�� ��ü�� ���� ����� ���� �������� �ش� ��ü�� ������ �� ����
- �����ϰ� �� ��ü �������� ª�� ����ϱ� ���� �ܾ�� ����

(�������)
CREATE [OR REPLACE] SYNONYM ���Ǹ� FOR ��ü��;
. '��ü��'�� '���Ǿ��'���� �̸��� �߰� �ο�

��뿡)HR������ EMPLOYEES ���̺��� EMP, DEPARTMENTS ���̺��� DEPT�� �̸��� �ο��Ͽ� ����Ͻÿ�

CREATE OR REPLACE SYNONYM EMP FOR HR.EMPLOYEES;

CREATE OR REPLACE SYNONYM DEPT FOR HR.DEPARTMENTS;

SELECT * FROM EMP;
    
2021-0907-04)INDEX ��ü
- Ư�� �ڷ��� �˻� ȿ���� �����ϱ� ���� ��ü
- SELECT, DML ��ɿ� ���Ǵ� WHERE ������ ����ó���� ȿ���� ���� ���
- ORDER BY, GROUP BY ���� ���� ȿ���� ����
- DBMS�� �δ��� �ٿ� ��ü SQL�� ���� ȿ���� ����
- �ε����� ���� ���� �� ���μ��� �ʿ�
- �������� ������ ����� ��� �ε��� ������ ������ ���� �ð� �ҿ�
(�ε����� �䱸�Ǵ� �÷�)
.WHERE ������ '=' �����ڿ� ���� ���� ó�� --
.PRIMARY KEY
.FOREIGN KEY
.JOIN�� ���� ���Ǵ� �÷�
.ORDER BY ���� ���� ���Ǵ� �÷�

(�ε��� ����)
1) UNIQUE INDEX
.�ߺ����� ������� �ʴ� �ε���
.NULL ���� ��� �����ϳ� �ϳ��� ����(PK,FK �ε��� ����)
2)NON-UNIQUE INDEX
.�ߺ����� ����ϴ� �ε���
.NULL���� ��� ����
3)NORMAL INDEX
.B-TREE INDEX
.�⺻ �ε��� ����
.�÷� ���� ROWID(������ ��ġ����)�� ����Ͽ� ����
4)BITMAP INDEX
.CARDINALITY�� ���� ��� ȿ������ �ε���--�������� ������ ������� ���� ex)����, ��ȥ���� �� 
.�߰�/����/������ ���� ��� ��ȿ����
.�÷� ���� ROWID(������ ��ġ����)�� ���� �������� ���� ����Ͽ� ����
5)FUNCTION-BASED NORMAL INDEX
.�Լ��� ���� �÷����������� �ε��� ����
.WHERE���� �Լ��� ���� ���ǹ��� ���� ���Ǵ� ��� ȿ����
 
(�������)
CREATE [UNIQUE|BITMAP] INDEX �ε�����
ON  ���̺��(�÷���1[,�÷���2,...]) [ASC|DESC]
.'UNIQUE|BITMAP': DEFAULT�� NON-UNIQUE INDEX & NORMAL INDEX
.'���̺��': �ε��� ��� ���̺�
.'[ASC|DESC]': DEFAULT�� ASC

��뿹) ȸ�����̺��� ȸ�������� �ε����� �����Ͻÿ�
CREATE INDEX IDX_MEM_NAME
ON MEMBER(MEM_NAME);
 
��뿹) ȸ�����̺��� ȸ���� �ּ� �� �õ� �κ� 2���ڷ� �ε����� �����Ͻÿ�
CREATE INDEX IDX_MEM_ADDR
ON  MEMBER(SUBSTR((MEM_ADD1),1,2));

SELECT * FROM MEMBER
WHERE  SUBSTR((MEM_ADD1),1,2) = '����'; 

**�ε��� ����
DROP INDEX �ε�����;
DROP INDEX IDX_MEM_ADDR;


    