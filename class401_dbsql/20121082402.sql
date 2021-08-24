2021-08-24-02
    - 자료의 형(데이터 타입)을 변환하는 함수
    - CAST, TO_CHAR, TO_NUMBER, TO_DATE 제공
    1)CAST(EXPR AS DATA_TYPE) TO_CHAR TO_NUMBER TO_DATE(문자열을 날짜로 바꾼다, 숫자를 날짜로 바꿀수 없다) : 그 위치에서만 변환되고 저장되어 있는 데이터는 변환이 없다.
    - 주어진 데이터 EXPR을 명시적으로 AS 다음 기술된 '데이터타입'으로 변환
    - 원본자료의 형은 불변임
    
    사용예) 2005년 6월 일자별 매출현황을 조회하시오.
    ALIAS는 날짜, 판매수량합계, 판매금액합계이며 날짜순으로 출력하시오.
    
    SELECT  CAST(SUBSTR(A.CART_NO, 1, 8) AS DATE) AS 날짜, 
            SUM(A.CART_QTY) AS 판매수량합계, 
            SUM(A.CART_QTY*B.PROD_PRICE) AS 판매금액합계
    FROM    CART A, PROD B
    WHERE       A.CART_PROD = B.PROD_ID AND //내일 질문하기        
    A.CART_NO LIKE '200506%'
    GROUP BY    SUBSTR(A.CART_NO, 1, 8)
    ORDER BY    1;
    15/1110
사용예) 2005년 5월 일자별 구매회원수를 조회하시오
날짜, 구매회원수 단, COUNT함수를 사용하지 말것
    SELECT  CAST(SUBSTR(CART_NO, 1, 8) AS DATE) AS 날짜,
            MAX(SUBSTR(CART_NO,9)) AS 구매회원수 --9번째에서 나머지 다 3번째 매개변수가 생략되면
    FROM    CART 
    WHERE   CART_NO LIKE '200505%'
    GROUP BY CAST(SUBSTR(CART_NO,1,8) AS DATE)
    ORDER BY 1;
    
    SELECT CAST(SUBSTR(LPROD_GU,2,4) AS NUMBER) FROM LPROD;
    --사용빈도수 TO_CHAR, TO_DATE, TO_NUMBER순
    
2) TO_CHAR(EXPR[,FMT])
    - 'EXPR'데이터를 'FMT'형식에 맞도록 문자열로 변환
    - 'EXPR'은 숫자, 날짜, 문자열(CHAR,CLOB=>VARCHAR2)을 문자열로 변환
    - 날짜형 형식지정문자열(FMT)
    ----------------------------------------------------------------
    FORMAT문자        의미      예
    ----------------------------------------------------------------
    AD, CC, BC      서기,세기       SELECT TO_CHAR(SYSDATE,'CC AD') FROM DUAL;
    Q               분기           SELECT TO_CHAR(SYSDATE, 'BC Q"분기"') FROM DUAL;
    YYYY,YYY,YY,Y   년도           SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;    
                                  SELECT TO_CHAR(SYSDATE, 'YYY-MM-DD') FROM DUAL;  
                                  SELECT TO_CHAR(SYSDATE, 'YY-MM-DD') FROM DUAL;  
    MM, RM          월(01~12)      SELECT TO_CHAR(SYSDATE, 'YY-MM') FROM DUAL;
                      (I~XII)     SELECT TO_CHAR(SYSDATE, 'YY-RM') FROM DUAL;
    MON, MONTH      월(1월~12월)   SELECT TO_CHAR(SYSDATE, 'YY-MON') FROM DUAL;
                                    SELECT TO_CHAR(SYSDATE, 'YY-MONTH') FROM DUAL;
    DD              일(01-30)        SELECT TO_CHAR(SYSDATE, 'YY-MM-DD') FROM DUAL;
    D                주중 일(1-7)      SELECT TO_CHAR(SYSDATE, 'YY-MM-D') FROM DUAL;
    DDD             년중 일(1-365)     SELECT TO_CHAR(SYSDATE, 'YY-MM-DDD') FROM DUAL;
    DAY             주중일을 요일로    SELECT TO_CHAR(SYSDATE, 'YY-MM-DAY') FROM DUAL;
    DL              현재일(요일까지)    SELECT TO_CHAR(SYSDATE, 'DL') FROM DUAL;
    HH, HH12, HH24  시간 
    MI                  분
    SS, SSSSS           초           SELECT TO_CHAR(SYSDATE, 'SSSSS') FROM DUAL;
    --SS 보통 초 표시 SSSSS 0시0분0초부터 지금까지 경과된 초
    W, WW               주
    --W주차 WW 52주
    AM,PM,A.M.,P.M.S    오전,오후      SELECT TO_CHAR(SYSDATE, 'YY-MM-DD AM HH24:MI:SS :SSSSS') FROM DUAL;
    --AM을 써도 오후 시간대면 오후시간이 나온다
    '" " '            사용자가 정의한 문자열은 반드시 ""안에 기술
                                      SELECT TO_CHAR(SYSDATE, 'YY-MM-DD AM"(는)" HH24:MI:SS :SSSSS') FROM DUAL;  
    ------------------------------------------------
     - 숫자형 형식지정문자열(FMT)
    ----------------------------------------------------------------
    FORMAT문자            의미              예
    ----------------------------------------------------------------
    .(DOT),,(COMMA)     소숫점과 자리점       SELECT TO_CHAR(2345678,'99,999,999.99') FROM DUAL; --,가 들어가면 숫자로서의 기능을 잃고 절대로 숫자로 변환이 안된다
    9,0                 9:유효숫자와 대응, 대응되는 데이터가 무효의 0이면 공백처리
                        0:모든 숫자와 대응, 대응되는 데이터가 무효의 0이면 0을 출력
    PR                  음수를 <>안에 표현    SELECT TO_CHAR(-2339,'9999PR'),
                                                  TO_CHAR(239,'999PR')  FROM DUAL
    L,$                 화폐기호 출력         SELECT TO_CHAR(12345,'L99,999') FROM DUAL; -- L은 LOCATION 처음 설정한 국가명으로 설정된다
                                             SELECT TO_CHAR(12345,'$99,999') FROM DUAL;        
    ---------------------------------------------------------------
    SELECT TO_NUMBER(TO_CHAR(12345.789,'99,999.99')) FROM DUAL;
    SELECT (TO_CHAR(12345.789,'999,999.99')) FROM DUAL;
     SELECT TO_NUMBER(TO_CHAR(12345.789,'99999.99')) FROM DUAL;
    --9가 대응되는 숫자를 만나면 숫자를 출력, 반올림, 맨앞은 공백으로 표시
    --9가 0으로 써도 대응되는 숫자를 만나면 숫자를 출력 그러나 맨앞에 0이 0을 만나면 0을 출력한다. 왼편에 있는 데이터의 차이
    --자릿점 때문에 숫자로 변환되지 못했는데 자릿점을 없애면 숫자로 변환이 가능하다.
    --회계에서 장표를 만들때는 -표시를 <>를 선호한다.
    
    
    
    
    