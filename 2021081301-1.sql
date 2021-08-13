

CREATE TABLE TEMP04 (
    COL1 VARCHAR2(2000),
    COL2 CLOB,
    COL3 CLOB);
    
    INSERT INTO TEMP04
        VALUES('������ �߱� ���ﵿ 500 ���κ��� 4��',
        '������ �߱� ���ﵿ 500 ���κ��� 4��',
        '������ �߱� ���ﵿ 500 ���κ��� 4��');
        
        SELECT * FROM TEMP04
        --CHAR����� �� �������̴�
        
    
        SELECT LENGTHB(COL1), 
               DBMS_LOB.GETLENGTH(COL2), 
               LENGTH(COL3)
        FROM    TEMP04;
        --LENGTH�� ������ �� LENGTHB�� ����Ʈ ��, ���ڴ� ����Ʈ ���ڼ��� ����
        
    SELECT SUBSTR(COL1,5,3) AS "COL1",
           SUBSTR(COL2,5,3) AS "COL2",
           DBMS_LOB.SUBSTR(COL3, 3,5) AS "COL2"
           FROM TEMP04;
        --SUBSTR�� 5��°���� 3����
        --DBMS SUB�� 5���� 3��°����
        --�ι�° ����° �Ű������� ������ �ݴ�� �Ǿ� �ִ�.
        COMMIT;

2. �����ڷ�
    -������ �Ǽ� ������ ����
    -NUMBER 1���� ����
    -����:�������� �Ҽ��� �Ǽ�:fLOATING POINT 
    -���� �����ϴ� ����� �ٸ��� �����ϴ� ����� �ٸ���
    (�������)
    �÷��� NUMBER [(���е�|*[,������])]
    .'���е�' : ��ü�ڸ� ���� �ǹ�(1~38)
    .'������' : �Ҽ��������� �ڸ���
    .���� ǥ�� ���� : 1.0E-130 ~ 9.999..99E125
    .���е� ��� '*'�� ����ϸ� ��ü�ڸ����� �ý����� Ȯ��
    .'(���е�|*[,������]' : �����Ǹ� ����ڰ� ������ ���� ������ �� �ִ� ������ ������ Ȯ��
    .�������� �����Ǹ� '0'���� ���
    .�������� �����̸� ���κκ��� �ش��ڸ� ������ �ݿø��Ǹ�, ����̸� '������+1'��° �ڸ����� �ݿø��Ǿ� '������'��ġ ���� ����
    .���е�-������=�������ڸ� �� *������ �Ҽ������ϴ� �������̴�. NUMBER�� ���� �ý��ۿ��� �ñ�� ����ȭ�� ������ ���� �������� �Ⱦ��� �����κи� ���´�
    .�������� �����̸� -2�̸� �Ҽ� �տ� �ι�° �ڸ����� �ݿø��� �ȴ� 1234�̸� 1200�̵�
    .�������� ����̸� -2�̸� �Ҽ� 3���� �ڸ����� �ݿø��ȴ� 0.1256�̸� 0.13��
��뿹)
1) ���е� > ������
--------------------------------------
�Է°�         ����          ����Ǵ� ��
--------------------------------------
12345.6789    NUMBER       12345.6789
1234567.89    NUMBER(*,1)  1234567.9  --�����ι��� �˾Ƽ��ϰ� �Ҽ��� 2��°�ڸ����� �ݿø��ؼ� ó������ ����~.9
1234567.89    NUMBER(8)    1234568 
1234567.89    NUMBER(7,2)  ����        --�����ι��� 5�ڸ� �����ι��� ����ڸ��� ������ ������ ������ ª�� ������ �����̴�
1234567.89    NUMBER(8,-2) 1234600    
--------------------------------------    
--�����ι��� ª���� ���� �Ҽ������ϰ� ª���� �ݿø��Ǽ� ���ȴ�   
--����Ŭ�� �ڷḦ ��Ȯ�� �����ߴٰ� �����ϴ� ������ ��Ģ������ ���ϴ� ���� �ƴϴ�

CREATE TABLE TEMP05(
   COL1  NUMBER,   
   COL2  NUMBER(*,1),  
   COL3  NUMBER(8),   
   COL4  NUMBER(7,2), 
   COL5  NUMBER(8,-2));
     
    INSERT INTO TEMP05
        VALUES(12345.6789, 1234567.89, 1234567.89, 4567.89,1234567.89 );
    
    SELECT * FROM TEMP05;
    
COMMIT;

2)���е� < ������
    .���е��� 0�� �ƴ� ��ȿ ������ �ڸ��� 
    .(������-���е�) : �Ҽ������Ͽ� ó������ ��Ÿ������ '0'�� ����
    .������ : �Ҽ��� ������ �������� ��
--------------------------------------
�Է°�         ����          ����Ǵ� ��
--------------------------------------
1.2345         NUMBER(4,5)     ����(5-4=1���� 0�̳��;��Ѵ�)
0.23           NUMBER(3,5)     ����(5-3=2��)
0.012345       NUMBER(2,3)     0.012(��ȿ�ڸ��� 01, ��ü�ڸ�����3(123), 5-3=2���� 0) 
0.0012345      NUMBER(3,5)     0.00124(��ȿ�ڸ���3, ��ü�ڸ���5 00123 0�ǰ���2��)
0.0001234567   NUMBER(3,7)     ����(��ȿ�ڸ��� ��ü�ڸ���:00012345 0�ǰ����� 4��)

3. ��¥�ڷ�
    - ��,��,��,��,��,�� ���� ��¥�� �ð����� ����
    - DATE(�⺻��), TIMESTAMP(Ȯ����)
    
    1)DATE Ÿ��
        .�⺻ ��¥ Ÿ��
        .'+'��'-'�� ������ ��� '*'��'/'�� �ȵȴ�.
         ��¥Ÿ�� + (-) ���� =>'����'���� (����) ��¥ ��ȯ (-10�ϸ� 10���� ��¥)
         ��¥Ÿ�� + (-) ��¥Ÿ�� => �� ��¥������ ��¥�� ��ȯ (�� ��¥ ������ ��¥ ���� ��ȯ�� �ش�. �ϼ�)
         --��¥�� +-�� �ȴٴ� ���� ������ �ŷ����� ���̴�., ��Ʈ�Ͻ� ���� ���� ���� Ȱ���Ҷ� ���ϴ�.
         
         (�������)
         �÷��� DATE;
         .�ý����� �����ϴ� ��¥������ SYSDATE�Լ��� ���Ͽ� ��ȯ ��
         ��뿹)
         CREATE TABLE TEMP06(
            COL1 DATE,
            COL2 DATE);
        INSERT INTO TEMP06
            VALUES(SYSDATE, SYSDATE-20);
        INSERT INTO TEMP06
            VALUES('20200101', TO_DATE('20200101')+20);
            --������ ���Ŀ� �°�, 13���� �Է��ϸ� �������ȴ�. �ú��ʰ� 2�ڸ��� 4�ڸ��� �� ���� �� �ִ�.
            --���ڿ��� ��¥�� �� ��ȯ�� �ȴ�.TO_DATE�� ����ȯ�Լ� ���ڿ��� ��¥�� ��ȯ�ɼ� �ִ�.
      ------------------------------
        ALTER TABLE TEMP06 ADD(COL3 DATE);
        INSERT INTO TEMP06
        (COL3)
        VALUES
        ('20200101');
        UPDATE TEMP06 SET COL3='20190203' WHERE ID='';
        
        ALTER TABLE TEMP06 DROP COLUMN COL3;
    
        ALTER TABLE TEMP06 MODIFY COL3 DATE;
       ------------------------------
        SELECT * FROM TEMP06;            
        COMMIT;
        
        SELECT TO_CHAR(COL1,'YYYY-MM-DD HH24:MI:SS')
        --CHAR�� �ٲ�� COL1�� �ִ� ���� ���ڿ��� �ٲ�� 
            FROM TEMP06;
            
            SELECT * FROM TEMP06
             WHERE COL1='2020/01/01';
            
            SELECT * FROM TEMP06;
            UPDATE TEMP06 SET COL1='2019-02-03' WHERE COL1='2020/01/01';
            --��¥�� -�Ǵ�/���� �ν��� �ȴ�. �̷��� ��ȯ�ؼ� �Է��� �־�� �Ѵ�.
            
            
            
            
            
            
            
            
  -----------------------------------------------------
 ACCEPT P_DATE PROMPT '��¥�Է� (YYYYMMDD) : '
  DECLARE
    V_DAYS NUMBER:=0;
    V_DATE DATE:=TO_DATE('&P_DATE');
    --&�� �����ض��� ���̴�.P_DATE�� ���ڿ��� �Ǽ� TO_DATE�� �ٲ� V_DATE�� �־ 
    V_RES VARCHAR2(50);
    
    BEGIN
        SELECT MOD((TRUNC(V_DATE) - TO_DATE('00010101')-1),7)
        --TRUNC�� �����Ѵ�. ������ �� ������ TRUNC�� ����.
        --MOD�� �������� ���ϴ� �Լ� �̴�. REMIND
        
        INTO V_DAYS
        FROM DUAL;
      
    IF V_DAYS=0 THEN
       V_RES:=V_DATE||'�� �Ͽ��� �Դϴ�';
    ELSIF V_DAYS=1 THEN
       V_RES:=V_DATE||'�� ������ �Դϴ�'; 
    ELSIF V_DAYS=2 THEN
       V_RES:=V_DATE||'�� ȭ���� �Դϴ�'; 
    ELSIF V_DAYS=3 THEN
       V_RES:=V_DATE||'�� ������ �Դϴ�';
    ELSIF V_DAYS=4 THEN
       V_RES:=V_DATE||'�� ����� �Դϴ�';
    ELSIF V_DAYS=5 THEN
       V_RES:=V_DATE||'�� �ݿ��� �Դϴ�';
    ELSIF V_DAYS=6 THEN
       V_RES:=V_DATE||'�� ����� �Դϴ�';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(V_RES);
    END;
    
    COMMIT;

���� ���� -
ORA-06550: line 2, column 18:
PLS-00103: Encountered the symbol ":" when expecting one of the following:

   := . ( @ % ; not null range default character
06550. 00000 -  "line %s, column %s:\n%s"
*Cause:    Usually a PL/SQL compilation error.
*Action: �ذ� ����� LINE2���� DATE�� NUMBER���� SYMBOL ':'�� �ٿ��� �Ἥ �ذ��ߴ�.
    

2) TIMESTAMP Ÿ��
    .�ð���(TIME ZONE)������ 10����� 1�� ������ ������ �ð������� ����
    (�������)
        �÷��� TIMESTAMP --�ð����� ����
        �÷��� TIMESTAMP WITH TIME ZONE --�ð��� ���� ����
        �÷��� TIMESTAMP WITH LOCAL TIME ZONE --������ ��ġ�� �ð��� ����(TIMESTAMP)�� ����)
        
    (��뿹)
        CREATE TABLE TEMP07(
            COL1 TIMESTAMP,
            COL2 TIMESTAMP WITH TIME ZONE,
            COL3 TIMESTAMP WITH LOCAL TIME ZONE);
            
        INSERT INTO TEMP07
            VALUES (SYSDATE,SYSDATE,SYSDATE);
            
        SELECT COL1 FROM TEMP07;
        
    4. ��Ÿ�ڷ�
    - �����ڷḦ �����ϴ� ������ Ÿ��
    - BLOB, RAW, LONG RAW, BFILE ���� �����Ǹ� RAW�� LONG RAW�� BLOB�� ��ü ��
    - ����Ŭ���� �ؼ��̳� ��ȯ�۾��� �������� �ʰ� ����
    
    1) RAW
    .��������� ���� ���� �ڷḦ ����
    .�ִ� 2000BYTE���� ���� ����
    .16������ 2���� ����
    .�ε��� ó�� ���� 
    --������ ���� ������� �ʴ´� �뷮�� �ʹ� ���
    --BLOB BFILE �Ѵ� 4�Ⱑ�� ó��
    --�����ͺ��̽� ����(BLOB) �ۿ� �����ϰ� �����ͺ��̽����� ��θ� ����(BFILE)
    (�������)
    �÷��� RAW(ũ��);
    
    2)BFILE
    .2���ڷḦ �����ͺ��̽� �ܺο� ����
    .��������� ���̺� ����
    .�ִ� 4GB���� ���� ����
    
    (�������)
    �÷��� BFILE;
    
    **���� �ڷḦ �����ϴ� ����
    1)���͸� ��ü ����-�׸��� ����� �����ּҸ� �̿�
        CREATE DIRECTORY ���丮��Ī AS '�����ּ�'
        CREATE DIRECTORY TEST_DIR AS 'F:\A_TeachingMaterial\2.Oracle\workspace';
        --���������� JPEG�� �Ǿ�� �Ѵ�.
    2)��θ� ������ ���̺� ����
        CREATE TABLE TEMP_08(
        COL1 BFILE);
    3)�׸�����
        INSERT INTO TEMP_08
            VALUES(BFILENAME('TEST_DIR', 'SAMPLE1.JPEG'));
    COMMIT;
    SELECT * FROM TEMP_08;
    COMMIT;
--------------------------------------------------------------------------------------------------------------------------------  
    
    
    
    
    
    
    
    
    
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        