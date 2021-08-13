

CREATE TABLE TEMP04 (
    COL1 VARCHAR2(2000),
    COL2 CLOB,
    COL3 CLOB);
    
    INSERT INTO TEMP04
        VALUES('대전시 중구 대흥동 500 영민빌딩 4층',
        '대전시 중구 대흥동 500 영민빌딩 4층',
        '대전시 중구 대흥동 500 영민빌딩 4층');
        
        SELECT * FROM TEMP04
        --CHAR빼고는 다 가변길이다
        
    
        SELECT LENGTHB(COL1), 
               DBMS_LOB.GETLENGTH(COL2), 
               LENGTH(COL3)
        FROM    TEMP04;
        --LENGTH는 문자의 수 LENGTHB는 바이트 수, 영자는 바이트 문자수가 같다
        
    SELECT SUBSTR(COL1,5,3) AS "COL1",
           SUBSTR(COL2,5,3) AS "COL2",
           DBMS_LOB.SUBSTR(COL3, 3,5) AS "COL2"
           FROM TEMP04;
        --SUBSTR는 5번째에서 3글자
        --DBMS SUB는 5글자 3번째부터
        --두번째 세번째 매개변수의 역할이 반대로 되어 있다.
        COMMIT;

2. 숫자자료
    -정수와 실수 데이터 저장
    -NUMBER 1나만 제공
    -정수:고정길이 소수점 실수:fLOATING POINT 
    -서로 저장하는 방식이 다르고 연산하는 방법도 다르다
    (사용형식)
    컬럼명 NUMBER [(정밀도|*[,스케일])]
    .'정밀도' : 전체자리 수를 의미(1~38)
    .'스케일' : 소수점이하의 자리수
    .값의 표현 범위 : 1.0E-130 ~ 9.999..99E125
    .정밀도 대신 '*'를 사용하면 전체자리수를 시스템이 확보
    .'(정밀도|*[,스케일]' : 생략되면 사용자가 정의한 수를 저장할 수 있는 최적의 기억장소 확보
    .스케일이 생략되면 '0'으로 취급
    .스케일이 음수이면 정부부분의 해당자리 수에서 반올림되며, 양수이면 '스케일+1'번째 자리에서 반올림되어 '스케일'위치 값을 저장
    .정밀도-스케일=정수의자리 수 *를쓰면 소수점이하는 나머지이다. NUMBER만 쓰면 시스템에게 맡기고 최적화된 기억공간 제공 스케일을 안쓰면 정수부분만 나온다
    .스케일이 음수이면 -2이면 소수 앞에 두번째 자리에서 반올림이 된다 1234이면 1200이됨
    .스케일이 양수이면 -2이면 소수 3번쨰 자리에서 반올림된다 0.1256이면 0.13됨
사용예)
1) 정밀도 > 스케일
--------------------------------------
입력값         선언          저장되는 값
--------------------------------------
12345.6789    NUMBER       12345.6789
1234567.89    NUMBER(*,1)  1234567.9  --정수부문은 알아서하고 소수는 2번째자리에서 반올림해서 처음까지 저장~.9
1234567.89    NUMBER(8)    1234568 
1234567.89    NUMBER(7,2)  오류        --정수부문은 5자리 정수부문에 기억자리가 남으면 문제가 없으나 짧게 잡히면 오류이다
1234567.89    NUMBER(8,-2) 1234600    
--------------------------------------    
--정수부문이 짧으면 오류 소수점이하가 짧으면 반올림되서 기억된다   
--오라클은 자료를 정확히 저장했다가 응답하는 것이지 사칙연산을 구하는 것이 아니다

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

2)정밀도 < 스케일
    .정밀도는 0이 아닌 유효 숫자의 자리수 
    .(스케일-정밀도) : 소숫점이하에 처음부터 나타나야할 '0'의 갯수
    .스케일 : 소숫점 이하의 데이터의 수
--------------------------------------
입력값         선언          저장되는 값
--------------------------------------
1.2345         NUMBER(4,5)     오류(5-4=1개의 0이나와야한다)
0.23           NUMBER(3,5)     오류(5-3=2개)
0.012345       NUMBER(2,3)     0.012(유효자리수 01, 전체자리수가3(123), 5-3=2개의 0) 
0.0012345      NUMBER(3,5)     0.00124(유효자리수3, 전체자리수5 00123 0의개수2개)
0.0001234567   NUMBER(3,7)     오류(유효자리수 전체자리수:00012345 0의개수가 4개)

3. 날짜자료
    - 년,월,일,시,분,초 등의 날짜와 시각정보 저장
    - DATE(기본형), TIMESTAMP(확장형)
    
    1)DATE 타입
        .기본 날짜 타입
        .'+'와'-'의 연산의 대상 '*'와'/'는 안된다.
         날짜타입 + (-) 정수 =>'정수'이후 (이전) 날짜 반환 (-10하면 10일전 날짜)
         날짜타입 + (-) 날짜타입 => 두 날짜사이의 날짜수 반환 (둘 날짜 사이의 날짜 수를 반환해 준다. 일수)
         --날짜가 +-가 된다는 것은 굉장히 매력적인 것이다., 피트니스 센터 같은 데서 활용할때 편하다.
         
         (사용형식)
         컬럼명 DATE;
         .시스템이 제공하는 날짜정보는 SYSDATE함수를 통하여 반환 됨
         사용예)
         CREATE TABLE TEMP06(
            COL1 DATE,
            COL2 DATE);
        INSERT INTO TEMP06
            VALUES(SYSDATE, SYSDATE-20);
        INSERT INTO TEMP06
            VALUES('20200101', TO_DATE('20200101')+20);
            --연월일 형식에 맞게, 13월을 입력하면 오류가된다. 시분초가 2자리씩 4자리가 더 들어올 수 있다.
            --문자열이 날짜로 형 변환이 된다.TO_DATE는 형변환함수 문자열만 날짜로 변환될수 있다.
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
        --CHAR로 바꿔라 COL1에 있는 것을 문자열로 바꿔라 
            FROM TEMP06;
            
            SELECT * FROM TEMP06
             WHERE COL1='2020/01/01';
            
            SELECT * FROM TEMP06;
            UPDATE TEMP06 SET COL1='2019-02-03' WHERE COL1='2020/01/01';
            --날짜는 -또는/으로 인식이 된다. 이렇게 변환해서 입력해 주어야 한다.
            
            
            
            
            
            
            
            
  -----------------------------------------------------
 ACCEPT P_DATE PROMPT '날짜입력 (YYYYMMDD) : '
  DECLARE
    V_DAYS NUMBER:=0;
    V_DATE DATE:=TO_DATE('&P_DATE');
    --&는 참조해라라는 뜻이다.P_DATE가 문자열이 되서 TO_DATE로 바뀌어서 V_DATE로 넣어서 
    V_RES VARCHAR2(50);
    
    BEGIN
        SELECT MOD((TRUNC(V_DATE) - TO_DATE('00010101')-1),7)
        --TRUNC는 절삭한다. 절삭을 할 때에는 TRUNC를 쓴다.
        --MOD는 나머지를 구하는 함수 이다. REMIND
        
        INTO V_DAYS
        FROM DUAL;
      
    IF V_DAYS=0 THEN
       V_RES:=V_DATE||'는 일요일 입니다';
    ELSIF V_DAYS=1 THEN
       V_RES:=V_DATE||'는 월요일 입니다'; 
    ELSIF V_DAYS=2 THEN
       V_RES:=V_DATE||'는 화요일 입니다'; 
    ELSIF V_DAYS=3 THEN
       V_RES:=V_DATE||'는 수요일 입니다';
    ELSIF V_DAYS=4 THEN
       V_RES:=V_DATE||'는 목요일 입니다';
    ELSIF V_DAYS=5 THEN
       V_RES:=V_DATE||'는 금요일 입니다';
    ELSIF V_DAYS=6 THEN
       V_RES:=V_DATE||'는 토요일 입니다';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(V_RES);
    END;
    
    COMMIT;

오류 보고 -
ORA-06550: line 2, column 18:
PLS-00103: Encountered the symbol ":" when expecting one of the following:

   := . ( @ % ; not null range default character
06550. 00000 -  "line %s, column %s:\n%s"
*Cause:    Usually a PL/SQL compilation error.
*Action: 해결 방법은 LINE2에서 DATE와 NUMBER에서 SYMBOL ':'를 붙여서 써서 해결했다.
    

2) TIMESTAMP 타입
    .시간대(TIME ZONE)정보와 10억분의 1초 단위의 정교한 시간정보를 저장
    (사용형식)
        컬럼명 TIMESTAMP --시간정보 없음
        컬럼명 TIMESTAMP WITH TIME ZONE --시간대 정보 보유
        컬럼명 TIMESTAMP WITH LOCAL TIME ZONE --서버가 위치한 시간대 정보(TIMESTAMP)와 동일)
        
    (사용예)
        CREATE TABLE TEMP07(
            COL1 TIMESTAMP,
            COL2 TIMESTAMP WITH TIME ZONE,
            COL3 TIMESTAMP WITH LOCAL TIME ZONE);
            
        INSERT INTO TEMP07
            VALUES (SYSDATE,SYSDATE,SYSDATE);
            
        SELECT COL1 FROM TEMP07;
        
    4. 기타자료
    - 이진자료를 저장하는 데이터 타입
    - BLOB, RAW, LONG RAW, BFILE 등이 제공되며 RAW와 LONG RAW는 BLOB로 대체 됨
    - 오라클에서 해석이나 변환작업을 수행하지 않고 저장
    
    1) RAW
    .상대적으로 작은 이진 자료를 저장
    .최대 2000BYTE까지 저장 가능
    .16진수와 2진수 저장
    .인덱스 처리 가능 
    --지금은 많이 사용하지 않는다 용량이 너무 적어서
    --BLOB BFILE 둘다 4기가씩 처리
    --데이터베이스 내부(BLOB) 밖에 보관하고 데이터베이스에는 경로만 저장(BFILE)
    (사용형식)
    컬럼명 RAW(크기);
    
    2)BFILE
    .2진자료를 데이터베이스 외부에 저장
    .경로정보만 테이블에 저장
    .최대 4GB까지 저장 가능
    
    (사용형식)
    컬럼명 BFILE;
    
    **이진 자료를 저장하는 순서
    1)디렉터리 객체 생성-그림이 저장된 절대주소를 이용
        CREATE DIRECTORY 디렉토리별칭 AS '절대주소'
        CREATE DIRECTORY TEST_DIR AS 'F:\A_TeachingMaterial\2.Oracle\workspace';
        --파일형식이 JPEG로 되어야 한다.
    2)경로를 저장할 테이블 생성
        CREATE TABLE TEMP_08(
        COL1 BFILE);
    3)그림삽입
        INSERT INTO TEMP_08
            VALUES(BFILENAME('TEST_DIR', 'SAMPLE1.JPEG'));
    COMMIT;
    SELECT * FROM TEMP_08;
    COMMIT;
--------------------------------------------------------------------------------------------------------------------------------  
    
    
    
    
    
    
    
    
    
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        