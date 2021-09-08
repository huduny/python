2021-09-08-01
PL/SQL

-PROCEDUAL LANGUAGE SQL
-표준 SQL에 절차적 언어의 특징인 변수, 분기, 반복처리를 가능케하는 도구 제공
-BLOCK 구조로 동시에 여러 SQL문 수행
-모듈화, 캡슐화 기능 수행
-익명블록,함수,프로시져,트리거,패키지,

1. 익명블록(ANONYMOUS BLOCK)
-서버에 저장되지 않고 스크립트에서만 실행되는 블록
-PL/SQL의 기본 구조

(구조)
DECLARE 
선언부(변수,상수,커서) --오라클 상수는 CONSTANT를 붙여주면 된다, 커서는 SQL의 결과에 의해 영향을 받은 행들의 집합 EX)SELECT문의 결과가 커서이고 뷰이다.
                   --출력이 끝나고 나면 커서는 CLOSE된다. 이름이 없어서 그런것이다. 이름을 붙이면 필요할때 불러올수(오픈) 있다.
BEGIN              --SELECT INTO~FROM 형식으로 사용해야된다.
실행부
[EXCEPTION         -- 자바의 TRY CATCH 블록이랑 비슷
    예외처리부]
    END;
    
사용예)키보드로 월을 입력받아 해당월에 태어난 회원의 이름,생년월일,마일리지를 조회하는 익명블록을 작성하시오.
    
    ACCEPT P_MON PROMPT '월을 입력: ' --;을 안 붙인다
    DECLARE
    V_MON  NUMBER:=0; --:=이라는 뜻이다.
    V_NAME MEMBER.MEM_NAME%TYPE;--해당되는 타입과 같은 타입이 만들어 진다
    V_BIR  MEMBER.MEM_BIR%TYPE;
    V_MILE MEMBER.MEM_MILEAGE%TYPE;
    BEGIN
    SELECT MEM_NAME, MEM_BIR, MEM_MILEAGE
    INTO V_NAME, V_BIR, V_MILE --일반변수여서 값이 하나 밖에 저장을 할 수 없다.
    FROM MEMBER
    WHERE EXTRACT(MONTH FROM MEM_BIR)=TO_NUMBER('&P_MON')
    AND ROWNUM=1;--입력받은 값 '&~' 참조한다는 뜻의 규칙이다. 문자열을 숫자로 바꿨다.
                                                            --SELECT INTO FROM WEHRE 순으로 작성, AND ROWNUM=1;하면 1명이; 뜬다.
    DBMS_OUTPUT.PUT_LINE('회원명:' || V_NAME);
    DBMS_OUTPUT.PUT_LINE('생년월일:' || V_BIR);
    DBMS_OUTPUT.PUT_LINE('보유 마일리지:' || V_MILE);
    DBMS_OUTPUT.PUT_LINE('--------------------');
    
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('오류발생:'||SQLERRM);--SYSOUT과 똑같은 기능이다. 나오고 줄바꿈
    END;

1) 변수(상수)선언
-BEGIN 블록에서 사용할 변수(상수)선언
(선언형식)
변수명[CONSTRAINT] 참조타입|타입명[(크기)][:=초기값]; --초기값을 배정할때까지는 변수이지만 초기값이 배정되면 상수가 된다. BEGIN블록을 벗어나면 존립할수 없다.
--초기값이 설정되지 않으면 NULL이 입력되서 반드시 초기값을 넣어주자.

.변수타입: 표준 SQL에서 사용하는 타입, BINARY_INTEGER, PLS_INTEGER, BOOLEAN 사용가능
.참조타입: 테이블명.컬럼명%TYPE =>해당 컬럼타입으로 설정 --TRUE FALSE NULL중에 하나이다
         테이블명%ROWTYPE => 한 행타입으로 선언 (C언어의 STRUCT타입) --한꺼번에 저장하고 싶을때 STRUCT사용(다른 타입도 저장 가능)
         --STRUCT+함수=클래스이다.
2) 커서 선언
- 커서는 SQL문에 의해 영향 받은 행들의 집합
- 묵시적 커서와 명시적 커서가 존재
 (1) 묵시적 커서
 . 커서를 생성하지 않은 SELECT 문의 결과가 묵시적 커서
 . OPEN과 동시에 CLOSE됨(커서결과를 FETCH할 수 없음)--결과가 끝나면 바로 CLOSE된다. CLOSE되면 커서 안으로 들어갈 수 없다.
 . 커서속성--SQL을 커서명으로 쓴다.
 ----------------------------------------------------
 속성                         의미
 SQL%ISOPEN            커서가 열려있으면 TRUE(항상 FALSE)
 SQL%NOTFOUND          커서내 FETCH할 자료가 더 이상 없으면 TRUE --반복문에서 데이터를 찾아올때, 끝나는 조건을 체크할때 사용
 SQL%FOUND             커서내 FETCH할 자료가 있으면 TRUE
 SQL%ROWCOUNT          커서내의 자료 수(행의 수)--커서내의 행의 개수를 파악
 -----------------------------------------------------
 (2) 명시적 커서
 . 커서 선언문의 의해 생성된 커서
 . 사용하기 위해 생성->OPEN->FETCH->CLOSE 되어야함
 ----------------------------------------------------
 속성                         의미
 커서명%ISOPEN            커서가 열려있으면 TRUE(항상 FALSE)
 커서명%NOTFOUND          커서내 FETCH할 자료가 더 이상 없으면 TRUE
 커서명%FOUND             커서내 FETCH할 자료가 있으면 TRUE
 커서명%ROWCOUNT          커서내의 자료 수(행의 수)
 ----------------------------------------------------- 
 (커서 선언)
 
 CURSOR 커서명[(변수명 타입명,...)] IS
 SELECT 문;
 --(변수명 타입명)은 매개변수이다.
 --DECLARE 변수 상수 커서 3가지 선언
 
 사용예) 마일리지가 많은 5명의 회원번호를 커서로 생성
 CURSOR     CUR_MAX_MILE IS
 SELECT     A.MEM_ID
 FROM       (SELECT MEM_ID, MEM_MILEAGE
              FROM  MEMBER
              ORDER BY 2 DESC )A
 WHERE      ROWNUM <= 5;
--------------------------------------------------------------------------------------------------------------------------------
 사용예) 마일리지가 많은 5명의 2005년 5월 회원번호,회원명,구매금액합계 출력
DECLARE
  V_ID MEMBER.MEM_ID%TYPE;--VARIABLE
  V_NAME MEMBER.MEM_NAME%TYPE;
  V_SUM NUMBER:=0;
  
CURSOR     CUR_MAX_MILE IS
  SELECT     A.MEM_ID
  FROM       (SELECT MEM_ID, MEM_MILEAGE
              FROM  MEMBER
              ORDER BY 2 DESC )A
  WHERE      ROWNUM <= 5; 
  
BEGIN --익명블록 시작

OPEN CUR_MAX_MILE;--커서오픈
  
LOOP --반복시작
   
FETCH  CUR_MAX_MILE INTO V_ID;
EXIT WHEN CUR_MAX_MILE%NOTFOUND; -- FALSE면 밑에 문장 지속, TRUE면 밖으로
   
    SELECT SUM(CART_QTY*PROD_PRICE) INTO V_SUM
        FROM CART, PROD
        WHERE CART_NO LIKE '200505%'
        AND  PROD_ID=CART_PROD
        AND  CART_MEMBER=V_ID;
   
    SELECT MEM_NAME INTO V_NAME
        FROM MEMBER
        WHERE MEM_ID=V_ID;
   
DBMS_OUTPUT.PUT_LINE('회원번호: '||V_ID);
DBMS_OUTPUT.PUT_LINE('회원명: '||V_NAME);
DBMS_OUTPUT.PUT_LINE('구매금액합계: '||V_SUM);
DBMS_OUTPUT.PUT_LINE('---------------------');

END LOOP; --반복종료
DBMS_OUTPUT.PUT_LINE('회원수: '||CUR_MAX_MILE%ROWCOUNT);
CLOSE CUR_MAX_MILE; --커서종료
END; --익명블록 끝
-------------------------------------------------------------------------------------------------------------------------------- 
--커서와 같이 쓰이는게 FOR문이고 결합이 안좋은것은 WHILE문이다.
    SELECT SUM(CART_QTY*PROD_PRICE), MEM_NAME  INTO V_SUM, V_NAME
        FROM CART A, PROD B, MEMBER C
        WHERE CART_NO LIKE '200505%'
        AND  B.PROD_ID=A.CART_PROD
        AND  A.CART_MEMBER=V_ID
        AND  C.MEM_ID=V_ID;
----------------------------------------------------------------------   
DECLARE
  V_ID MEMBER.MEM_ID%TYPE;--VARIABLE
  V_NAME MEMBER.MEM_NAME%TYPE;
  V_SUM NUMBER:=0;
  
CURSOR     CUR_MAX_MILE IS
  SELECT     A.MEM_ID
  FROM       (SELECT MEM_ID, MEM_MILEAGE
              FROM  MEMBER
              ORDER BY 2 DESC )A
  WHERE      ROWNUM <= 5; 
  
BEGIN

OPEN CUR_MAX_MILE;
  
LOOP 
   
FETCH  CUR_MAX_MILE INTO V_ID;
EXIT WHEN CUR_MAX_MILE%NOTFOUND; -- FALSE면 밑에 문장 지속, TRUE면 밖으로
   
    SELECT SUM(A.CART_QTY*B.PROD_PRICE), C.MEM_NAME  INTO V_SUM, V_NAME
        FROM CART A, PROD B, MEMBER C
        WHERE CART_NO LIKE '200505%'
        AND  B.PROD_ID=A.CART_PROD
        AND  A.CART_MEMBER=V_ID
        AND  C.MEM_ID=V_ID
        GROUP BY C.MEM_NAME;
   
DBMS_OUTPUT.PUT_LINE('회원번호: '||V_ID);
DBMS_OUTPUT.PUT_LINE('회원명: '||V_NAME);
DBMS_OUTPUT.PUT_LINE('구매금액합계: '||V_SUM);
DBMS_OUTPUT.PUT_LINE('---------------------');

END LOOP;
DBMS_OUTPUT.PUT_LINE('회원수: '||CUR_MAX_MILE%ROWCOUNT);
CLOSE CUR_MAX_MILE;
END;
 
 
 
 




