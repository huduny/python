CREATE TABLE TEMP01(
        COL1 CHAR(20),
        COL2 CHAR(20 BYTE),
        COL3 CHAR(20 CHAR));
        
        INSERT INTO TEMP01 VALUES('����ȭ ���� ��', 'APPLE PERSIMON', '����ȭ ���� �Ǿ����ϴ�');
        
        SELECT * FROM TEMP01;
       SELECT  LENGTHB(COL1),
               LENGTHB(COL2),
               LENGTHB(COL3)
          FROM TEMP01;     
               
��뿹)
CREATE TABLE TEMP02(
    COL1 CHAR(2000),
    COL2 VARCHAR2(4000 BYTE),
    COL3 VARCHAR(4000));
    
    INSERT INTO TEMP02
        VALUES('IL POSTINO','IL POSTINO','IL POSTINO');
       SELECT  TRIM(COL1),COL2,COL3
          FROM TEMP02;              
        
       SELECT  LENGTHB(COL1),
               LENGTHB(COL2),
               LENGTHB(COL3)
          FROM TEMP02;         
               
��뿹)
CREATE TABLE TEMP03(
    COL1 VARCHAR2(4000),
    COL2 LONG,
    COL3 LONG);
CREATE TABLE TEMP03(
    COL1 VARCHAR2(4000),
    COL2 LONG);              
INSERT INTO TEMP03 VALUES('������ �߱� ���ﵿ 500','������ �߱� ���ﵿ 500');

SELECT * FROM TEMP03;
    
SELECT SUBSTR(COL1,1,10)--���ڸ� �����Ѵ�, ����Ŭ(�ڸ���) �ڹ�(����������)
       --SUBSTR(COL2,2,6)--��ġ�� ������ ��Ÿ���� �Լ��� �Ϲ������� ������ �� ������ �ʹ� ū ����Ʈ�� �ʿ��ؼ�
       --CLOB�� BLOB�� DBMS_LOB���� �����Լ��� ���� �ִ�.
FROM TEMP03;    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
               
               
               
               
               
               