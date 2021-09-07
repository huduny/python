2021-0907-01) 뷰객체
- 가상의 테이블
- 기존의 테이블이나 다른 뷰를 이용한 SELECT 문의 결과를 테이블처럼 사용
- 필요한 정보가 여러 테이블에 분산되어 있는 경우
- 특정자료에 대한 접근을 제한하고 결과만 제공

(사용형식)
CREATE [OR REPLACE] VIEW 뷰이름[(컬럼LIST)]
AS
    SELECT 문;
    [WITH CHECK OPTION]
    [WITH READ ONLY]
    .WITH 절이 있으면 ORDER BY절 사용 불가
    .뷰가 집계함수, GROUP BY, DISTINCT를 사용하여 생성된 경우 INSERT, UPDATE, DELETE를 사용할 수 없음
    .뷰의 특정 컬럼이 표현식(CASE WHEN~THEN, DESCODE 등), 함수가 사용된 경우 해당컬럼의 추가 및 수정 불가
    .CURRVAL, NEXTVAL 등 의사 컬럼사용불가
    .ROWID, ROWNUM 등의 의사컬럼은 별칭을 사용해야함
--모듈의 결과가 필요한 경우에 만든 뷰를 가지고 처리할 수 있다.    
--뷰를 테이블 처럼 불러서 쓸 수 있다.
--FROM절에 쓸 수 있다. FROM절에 나오는 서브쿼리가 뷰이다.
--REPLACE는 대체하는 것이다. LIST는 컬럼에 사용될 리스트, 생략되면 SELECT절의 컬럼 별칭, SELECT절에 사용된 컬럼 명이 사용된다.
--뷰를 수정했는데 원본데이터가 수정된다. 그렇게 못하게 하는 것이 READ ONLY이다. 원본데이터가 변하면 뷰가 변화된다. 원본테이블은 자유자재로 바뀌고 항상 뷰에 영향
--뷰가 바뀔때 원본테이블이 바뀌는 것을 못하게 하는게 WITH READ ONLY이다. WITH CHECK OPTION 자격을 상실하는 조건을 부여할 수 없다. 
--WITH CHECK OPTION이나 WITH READ ONLY는 같이 사용되지 못한다 WITH CHECK OPTION은 더 큰 값 즉 결과에 영향을 주지 않는 범위는 변화가 가능하다.

사용예) 마일리지가 3000이상인 회원의 회원번호, 회원명, 직업, 마일리지로 뷰를 생성하시오.

CREATE OR REPLACE VIEW V_MEM01(MID,MNAME,MJOB,MMILE)
AS
    SELECT  MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_JOB AS 직업, MEM_MILEAGE AS 마일리지
    FROM    MEMBER
    WHERE   MEM_MILEAGE>=3000;
    
SELECT * FROM V_MEM01;

(뷰의 값 변경)
UPDATE  V_MEM01
SET     MMILE=10000
WHERE   UPPER(MID)='C001';

SELECT  MEM_ID, MEM_NAME, MEM_MILEAGE
FROM    MEMBER
WHERE   UPPER(MEM_ID)='C001';

CREATE OR REPLACE VIEW V_MEM01(MID,MNAME,MJOB,MMILE)
AS
    SELECT  MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_JOB AS 직업, MEM_MILEAGE AS 마일리지
    FROM    MEMBER
    WHERE   MEM_MILEAGE>=3000
    WITH CHECK OPTION ;   
    
UPDATE  V_MEM01
SET     MMILE=5500
WHERE   UPPER(MID)='C001';    
    
UPDATE  MEMBER
SET     MEM_MILEAGE=3500
WHERE   UPPER(MEM_ID)='C001';
    
2021-0907-02) SEQUENCE 객체
- 테이블과 독립적인 연속적 번호를 생성
- 기본키로 설정할 후보키가 없는 경우
- 자동적으로 순차적인 번호가 필요한 경우
(사용형식)
CREATE SEQUENCE 시퀀스명
[START WITH N] --시작 값 생략되면 MINVALUE/10000이라고 하면 10000번부터 시작
[INCREMENT BY N] --증가[감소] 값
[MAXVALUE N|NOMAXVALUE]-- 최대값, 기본은 NOMAXVALUE이고 10^27까지 사용
[MINVALUE N|NOMINVALUE]-- 최대값, 기본은 NOMINVALUE이고 1이다
[CYCLE|NOCYCLE] -- 최대[최소]값까지 도달 후 다시 SEQUENCE 생성여부 기본은 NOCYCLE
[CACHE N |NOCACHE]-- 캐쉬 사용 설정. 기본은 CACHE 20 이다.
[ORDER | NOORDER] -- 조건에 맞는 시퀀스 생성 보장 여부, 기본은 NOORDER

**시퀀스값 참조
--------------------------------------------------------------------
의사컬럼(PSEUDO COLUMN)             의미
--------------------------------------------------------------------
시퀀스명.CURRVAL                '시퀀스'의 현재값
시퀀스명.NEXTVAL                '시퀀스'의 다음값
--------------------------------------------------------------------
**시퀀스 생성 후 해당세션에서 처음 수행할 명령은 반드시 '시퀀스명.NEXTVAL'이어야 함;
--EX) 계시판의 글 순서 번호;
수도컬럼(가상컬럼) CURRVAL 현재값을 참조 NEXTVAL하나 증가된 값을 참조함

 SELECT (10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10) AS "10^27" FROM DUAL;   

**LPROD 테이블에서 LPROD_ID가 10 이상인 자료를 모두 제거 하시오.
    DELETE  LPROD
    WHERE   LPROD_ID>=10;
    ROLLBACK;
    SELECT * FROM LPROD;
    COMMIT;
    
사용예) LPROD테이블에 다음 자료를 추가 삽입하시오
    LPROD_ID: 시퀸스 값
    LPROD_GU: 'P501'
    LPROD_NM: '농산물'
    
    INSERT INTO LPROD 
    VALUES (SEQ_LPROD.CURRVAL, 'P501', '농산물');
    
    LPROD_ID: 시퀸스 값
    LPROD_GU: 'P502'
    LPROD_NM: '수산물'   

    INSERT INTO LPROD 
    VALUES (SEQ_LPROD.NEXTVAL, 'P502', '수산물');
    
    LPROD_ID: 시퀸스 값
    LPROD_GU: 'P503'
    LPROD_NM: '축산물'     
    
    INSERT INTO LPROD 
    VALUES (SEQ_LPROD.NEXTVAL, 'P503', '축산물');
    
(시퀀스 생성)    
CREATE SEQUENCE SEQ_LPROD     
START   WITH    10;    

SELECT     SEQ_LPROD.NEXTVAL FROM DUAL;
SELECT     SEQ_LPROD.CURRVAL FROM DUAL;
ROLLBACK;    

사용예)  CART_NO를 다음과같이 부여하고자한다. 필요한 시퀀스를 생성하시오. CART_NO는 날짜 8자리와 순번 4자리로 1001번부터 부여되고 9999번까지
        사용된다. 또 증가 값은 1이고 순환적용될 수 있다.
CREATE SEQUENCE SEQ_CART_NO
INCREMENT BY    1
MINVALUE    1001
MAXVALUE    9999
CYCLE;
        
SELECT     SEQ_CART_NO FROM DUAL;
SELECT     SEQ_LPROD.CURRVAL FROM DUAL;
    
SELECT TO_CHAR(SYSDATE, 'YYYYMMDD')||TO_CHAR(SEQ_CART_NO.NEXTVAL)
FROM DUAL;
    
2021-0709-03)SYNONYM (동의어) 객체(테이블, 뷰, 인덱스 등등)
- 오라클에서 지원되는 객체에서 또 다른 이름을 부여
- 테이블 별칭/ 컬럼의 별칭과 차이점은 동의어는 객체로 현재 연결된 세션 내에서는 해당 객체를 참조할 수 있음
- 복잡하고 긴 객체 참조명을 짧고 사용하기 쉬운 단어로 정의

(사용형식)
CREATE [OR REPLACE] SYNONYM 동의명 FOR 객체명;
. '객체명'을 '동의어명'으로 이름을 추가 부여

사용에)HR계정의 EMPLOYEES 테이블을 EMP, DEPARTMENTS 테이블을 DEPT로 이름을 부여하여 사용하시오

CREATE OR REPLACE SYNONYM EMP FOR HR.EMPLOYEES;

CREATE OR REPLACE SYNONYM DEPT FOR HR.DEPARTMENTS;

SELECT * FROM EMP;
    
2021-0907-04)INDEX 객체
- 특정 자료의 검색 효율을 제고하기 위한 객체
- SELECT, DML 명령에 사용되는 WHERE 절에서 조건처리의 효율을 위해 사용
- ORDER BY, GROUP BY 절의 수행 효율성 제고
- DBMS의 부담을 줄여 전체 SQL의 수행 효율성 제고
- 인덱스를 위한 공간 및 프로세스 필요
- 데이터의 변동이 빈번한 경우 인덱스 파일의 유지에 많은 시간 소요
(인덱스가 요구되는 컬럼)
.WHERE 절에서 '=' 연산자에 의한 조건 처리 --
.PRIMARY KEY
.FOREIGN KEY
.JOIN에 자주 사용되는 컬럼
.ORDER BY 절에 자주 사용되는 컬럼

(인덱스 종류)
1) UNIQUE INDEX
.중복값을 허용하지 않는 인덱스
.NULL 값은 사용 가능하나 하나만 허용됨(PK,FK 인덱스 제외)
2)NON-UNIQUE INDEX
.중복값을 허용하는 인덱스
.NULL값은 사용 가능
3)NORMAL INDEX
.B-TREE INDEX
.기본 인덱스 형태
.컬럼 값과 ROWID(물리적 위치정보)를 사용하여 저장
4)BITMAP INDEX
.CARDINALITY가 적은 경우 효율적인 인덱스--도메인의 차수가 적은경우 유리 ex)나이, 결혼여부 등 
.추가/수정/삭제가 많은 경우 비효율적
.컬럼 값과 ROWID(물리적 위치정보)의 값을 이진으로 조합 사용하여 저장
5)FUNCTION-BASED NORMAL INDEX
.함수가 사용된 컬럼을기준으로 인덱스 구성
.WHERE절에 함수가 사용된 조건문이 자주 사용되는 경우 효율적
 
(사용형식)
CREATE [UNIQUE|BITMAP] INDEX 인덱스명
ON  테이블명(컬럼명1[,컬럼명2,...]) [ASC|DESC]
.'UNIQUE|BITMAP': DEFAULT는 NON-UNIQUE INDEX & NORMAL INDEX
.'테이블명': 인덱스 대상 테이블
.'[ASC|DESC]': DEFAULT는 ASC

사용예) 회원테이블에서 회원명으로 인덱스를 구성하시오
CREATE INDEX IDX_MEM_NAME
ON MEMBER(MEM_NAME);
 
사용예) 회원테이블에서 회원의 주소 중 시도 부분 2글자로 인덱스를 구성하시오
CREATE INDEX IDX_MEM_ADDR
ON  MEMBER(SUBSTR((MEM_ADD1),1,2));

SELECT * FROM MEMBER
WHERE  SUBSTR((MEM_ADD1),1,2) = '대전'; 

**인덱스 삭제
DROP INDEX 인덱스명;
DROP INDEX IDX_MEM_ADDR;


    