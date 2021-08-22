2021-0820-01)함수(FUNCTION)
- DBMS에서 특정 기능을 수행할 수 있는 모듈을 컴파일하여 실행 가능한 상태로 제공하는 서브프로그램
- 컬럼 값이나 데이터 타입을 변경, 숫자 또는 날짜 형식의 출력 형식을 변경, 하나 이상의 행에 대하여 집계처리
-함수 유형
--반환값이 있으면 펑션 반환값이 없으면 프로시젼이라고 한다. 다른 언어에서는 펑션을 하나만 제공 자바(메소드)
--SUBSTR 주어진 문자열에서 사용자가 정의한 문자를 떼어서 그 함수가 사용된 위치에 결과를 반환값
--함수와 프로시저에 따라서 애들을 호출하는 방법이 차이가 많다
--EXEC를 통해 프로시저 호출, 함수는 SELECT에 의해서 호출될 수 있다.
--오라클 객체(저장되어 있다가 불려 오는 것들)
--오라클 함수는 공통적인 것을 미리 DBMS에서 미리 컴파일 해 놓았다. 유저들은 이것을 이름만 부르고 데이터(매개변수)만 정의해서 호출하면 된다
--숫자 문자 날짜 형변환 집계함수로 분류
--문자(문자열함수), 숫자(숫자함수-반올림,절삭,절댓값,로그,지수 등), 날짜함수, 형변환(숫자-문자 등)(CAST, TO_CHAR, T0_NUM, TO_DATE 등), 
--행들을 구분(GROUP)(특정열의 값이 같은 것들끼리) 그룹별로 집계 처리 하는 함수(SUM 등)
(1) 단일행 함수--한번 수행될때 하나의 행만 참여
 . 테이블에 저장된 개별 행을 대상으로 함수를 적용하여 하나의 결과를 반환
 . SELECT, WHERE 절 등에 사용 가능하며, 함수의 중첩 사용이 가능
 . 문자, 숫자, 날짜 처리함수와 형변환 함수가 있음

(2) 복수행 함수--연산에 참여하는 행이 하나의 함수에 여러 행이 참여한다 해서 결과값은 하나뿐이다
 . 여러 행을 그룹화하여 그룹별로 결과를 처리하여 하나의 결과를 반환
 . SUM, AVG, COUNT, MAX, MIN 등의 함수가 제공--중첩해서 쓸수 없다
 . 그룹화하는 경우 GROUP BY 절 및 집계함수의 조건처리에 HAVING절이 사용됨
 
 1. 문자함수
  1) CONCAT(C1,C2) --C문자열 N넘버 D데이터/ 갯수와 순서와 타입이 받는쪽 주는 쪽이 일치해야된다. CONCAT 문자열 합치다
    - 두 문자열 C1, C2를 결합하여 하나의 문자열을 반환 --함수가 사용된 바로 그 위치에 반환된다.
    '||'와 동일

사용예) 회원 테이블에서 마일리지가 3000이상인 회원들의 회원정보(회원번호, 회원명, 주민번호, 마일리지)를 조회하시오. 단, 회원의 주민번호는
'XXXX-XXXX'형식으로 출력하시오

    SELECT MEM_ID 회원번호, MEM_NAME 회원명, CONCAT(CONCAT(MEM_REGNO1,'-'),MEM_REGNO2) 주민번호, MEM_MILEAGE 마일리지
    --MEM_REGNO1||'-'||MEM_REGNO2
    FROM MEMBER
    WHERE MEM_MILEAGE >= 3000;
    
2) CHR(N1), ASCII(C1)
 - CHR(N1): 주어진 정수 'N1'에 해당하는 문자
 - ASC(C1): 주어진 문자열 'C1'에 해당하는 ASCII코드값 --세글자를 집어넣으면 맨 앞에 첫글자만 변환된다
사용예)
    SELECT ASCII('ORACLE'), ASCII('오라클'), --ASCII네트워크 소형피시 등에서 사용하는 표준코드로 사용하는 2진 변환 코드
           CHR(256), CHR(ASCII('A')+2)
    FROM   DUAL;
    
    DECLARE
    BEGIN
        FOR I IN 1..50000 LOOP
            DBMS_OUTPUT.PUT_LINE('ASCII('||I||')='||CHR(I));
       END LOOP;
    END;
 
 3) LOWER(C1), UPPER(C1), INITCAP(C1)
  - LOWER(C1): 주어진 문자열 'C1'의 모든 문자를 소문자로 변환
  - UPPER(C1): 주어진 문자열 'C1'의 모든 문자를 대문자로 변환
  - INITCAP(C1): 주어진 문자열 'C1'의 단어들의 첫 글자를 대문자로 변환
 
 사용예) 
    SELECT MEM_ID, MEM_NAME
    FROM MEMBER
    WHERE UPPER(MEM_ID)='R001';
 
    SELECT LOWER (EMP_NAME),
           UPPER (EMP_NAME),
           INITCAP(LOWER(EMP_NAME)),
           EMP_NAME
    FROM   EMPLOYEES
    WHERE DEPARTMENT_ID=50;
 
 4) LPAD(C1,N[,C2]), RPAD(C1,N[,C2])
 - LPAD(C1,N[,C2]): 주어진 문자열 'C1'을 N만큼의 크기에 저장하고 남는 기억공간은 (왼쪽) 'C2'를 채움. C2가 생략되면 공백이 채워짐--오른쪽을 기준으로 채워나가고 남는 공간엔
 - RPAD(C1,N[,C2]): 주어진 문자열 'C1'을 N만큼의 크기에 저장하고 남는 기억공간은 (오른쪽) 'C2'를 채움. C2가 생략되면 공백이 채워짐 --빈공간이 오른U에, 왼쪽으로 정렬되고
 
 사용예) SELECT LPAD('1,000,000', 12, '*') FROM DUAL;
        SELECT RPAD('1,000,000', 12, '*') FROM DUAL;
 SELECT RPAD('1,000,000', 12, '*'), RPAD(1000000, 5), LPAD('1,000,000', 12, '*'), LPAD(1000000, 5) FROM DUAL;
 
 사용예) 
    DECLARE
        CURSOR cur_temp IS
            SELECT A.CID AS ACID, A.AMT AS AAMT
            FROM  (SELECT CART_MEMBER AS CID, 
                        SUM(CART_QTY*PROD_PRICE) AS AMT
                 FROM CART, PROD
                 WHERE CART_PROD=PROD_ID
                 AND  CART_NO LIKE '200505%'
                 GROUP BY CART_MEMBER
                 ORDER BY 2 DESC) A
            WHERE ROWNUM<=10;
            V_NAME
    BEGIN
     FOR REC IN cur_temp LOOP
     SELECT MEM_NAME, MEM_PASS INTO V_NAME, V_PASS
     FROM MEMBER 
     WHERE MEM_ID=REC.ACID;
     
     DBMS_OUTPUT.PUT_LINE(REC.ACID||' '||V_NAME||' '||LPAD(V_PASS,12)||' '||TO_CHAR(REC.AAMT))
 END LOOP;
 END;
 
 5) LTRIM(C1[,C2]), RTRIM(C1[,C2])
 -LTRIM(C1[,C2]): 주어진 문자열 C1의 왼쪽에서 C2문자열을 찾아 제거, C2가 생략되면 왼쪽의 문자열을 제거 --C2가 생략되면 공백을 제거한다
 -RTRIM(C1[,C2]): 주어진 문자열 C1의 오른쪽에서 C2문자열을 찾아 제거, C2가 생략되면 오른쪽의 공백을 제거
 -단어 내부의 공백은 제거하지 못함(REPLACE 함수를 사용-단어 내부 공백)
 - TRIM(C1[,C2])
 
 사용예)SELECT LTRIM('무궁화 꽃이 피었습니다.','꽃이'), 
              LTRIM('무궁화 꽃이 피었습니다.','무 궁화') 
      FROM DUAL;
 
 **MEMBER테이블의 MEM_LIKE 컬럼을 VARCHAR(40)에서 CHAR(40)으로 변경
 ALTER TABLE MEMBER 
    MODIFY MEM_LIKE CHAR(40);
COMMIT;

사용예) 회원테이블에서 취미가 '독서'인 회원을 조회하시오
     ALIAS는 회원번호, 회원명, 취미, 마일리지
     SELECT MEM_ID AS 회원번호, 
            MEM_NAME AS 회원명, 
           MEM_LIKE AS 취미, 
            MEM_MILEAGE AS 마일리지
     FROM MEMBER
     WHERE MEM_LIKE=' 독서';--어느 한쪽을 명시적으로 공백을 제거하는 함수를 사용했다면 다른한쪽도 TRIM을 써야된다. 자동으로 RTRIM이 안되서 아니면 비교를 할 수없다.

6) TRIM(C1)
- 주어진 문자열 C1의 오른쪽과 왼쪽에 존재하는 무효의 공백을 제거--유효의 공백은 글자와 글자 사이, 무효의 공백은 왼U이나 오른쪽에 존재하는 공백들

7) SUBSTR(C1, START_INDEX[,N])
- 주어진 문자열 C1에서 부분문자열을 추출하여 새로운 문자열 반환
- 문자열 C1에서 START_INDEX 위치부터 N개의 부분문자열 추출
- N이 생략되거나 남은 문자열의 갯수보다 큰 수이면 START_INDEXT위치 이후의 모든 문자열 반환
- START_INDEX이 음수이면 뒤(오른쪽 부터) 처리
- 결과도 문자열이다.--자바는 문자열 중심 오라클은 숫자열 중심의 언어이다. 자바는 SUBSTR쓰면 N이 몇번째가 아니라 마지막순번을 말해준다

사용예) 
SELECT
    substr('IL POSTINO',2,5),
    substr('IL POSTINO',2),
    substr('IL POSTINO',2,15),
    substr('IL POSTINO',-7,15)
FROM
    dual;
    
사용예) 회원테이블에서 40대 회원만 조회하시오(나이는 주민번호컬럼을 이용)
Alias는 회원번호, 회원명, 주민번호, 나이

SELECT
    mem_id 회원번호,
    mem_name 회원명,
    mem_regno1 || '-'|| mem_regno2 주민번호,
    CASE WHEN SUBSTR(MEM_REGNO2,1,1)='3' OR SUBSTR(MEM_REGNO2,1,1)='4' 
    THEN TO_NUMBER(SUBSTR(TO_CHAR(SYSDATE),1,4)) - (TO_NUMBER(SUBSTR(mem_regno1,1,2))+2000) 
    ELSE TO_NUMBER(SUBSTR(TO_CHAR(SYSDATE),1,4)) - (TO_NUMBER(SUBSTR(mem_regno1,1,2))+1900)
    END AS 나이
FROM MEMBER
WHERE TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1)=40;
  --EXTRACT뽑아내다 뽑은 값은 숫자로 취급
WHERE TRUNC(CASE WHEN SUBSTR(MEM_REGNO2,1,1)='3' OR SUBSTR(MEM_REGNO2,1,1)='4' 
    THEN TO_NUMBER(SUBSTR(TO_CHAR(SYSDATE),1,4)) - (TO_NUMBER(SUBSTR(mem_regno1,1,2))+2000) 
    ELSE TO_NUMBER(SUBSTR(TO_CHAR(SYSDATE),1,4)) - (TO_NUMBER(SUBSTR(mem_regno1,1,2))+1900) END,-1)=40;
  --TRUNC함수(값,-1)는 절삭이다. 무조건 그자리에서 버림을 해준다. -1의자리는 1의 자리를 무조건 버려라
  --ROUND는 반올림이 되는데 TRUNC는 무조건 버린다
  
8) REPLACE(C1, C2[,C3])
-주어진 문자열 C1에 포함된 C2문자열을 C3문자열과 치환
-C3가 생략되면 C2를 찾아 삭제한다
-단어 내부에 존재하는 공백 등 처리에 사용

사용예) SELECT PROD_NAME,
        REPLACE(PROD_NAME, '대우', 'APPLE'),
        REPLACE(PROD_NAME, '현주'),
        REPLACE(PROD_NAME, '여'),
        REPLACE(PROD_NAME, ' ')
       FROM PROD;
--RTRIM LTRIM은 왼쪽 오른쪽에서만 찾지만 REPLACE는 중간에 있어도 찾아서 없앨수 있다.





