CREATE TABLE TEMP01(
        COL1 CHAR(20),
        COL2 CHAR(20 BYTE),
        COL3 CHAR(20 CHAR));
        
        INSERT INTO TEMP01 VALUES('무궁화 꽃이 피', 'APPLE PERSIMON', '무궁화 꽃이 피었습니다');
        
        SELECT * FROM TEMP01;
       SELECT  LENGTHB(COL1),
               LENGTHB(COL2),
               LENGTHB(COL3)
          FROM TEMP01;     
               
사용예)
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
               
사용예)
CREATE TABLE TEMP03(
    COL1 VARCHAR2(4000),
    COL2 LONG,
    COL3 LONG);
CREATE TABLE TEMP03(
    COL1 VARCHAR2(4000),
    COL2 LONG);              
INSERT INTO TEMP03 VALUES('대전시 중구 대흥동 500','대전시 중구 대흥동 500');

SELECT * FROM TEMP03;
    
SELECT SUBSTR(COL1,1,10)--글자를 추출한다, 오라클(자릿수) 자바(마지막순번)
       --SUBSTR(COL2,2,6)--위치나 갯수를 나타내는 함수는 일반적으로 못쓴다 그 이유는 너무 큰 바이트가 필요해서
       --CLOB와 BLOB는 DBMS_LOB에서 전용함수가 따로 있다.
FROM TEMP03;    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
               
               
               
               
               
               
