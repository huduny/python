2021-09-08-02) 분기문
- 프로그래밍 언어의 분기문과 같은 기능 제공
- IF, CASE WHEN 문 제공

1) IF 문
. 가장 널리 사용되는 분기 명령

(사용형식1)
IF 조건-1 THEN
   명령문-1;
[ELSE
   명령문-2;]
END IF;

(사용형식2)
IF 조건-1 THEN
   명령문-1;
ELSIF 조건-2 THEN
   명령문-2;
   :
ELSE
   명령문-N
END IF;

(사용형식3)
IF 조건-1 THEN--중괄호의 기능이다
 IF 조건-2 THEN
   명령문-2;
 ELSE
   명령문-3;
 END IF;
ELSE
   명령문-1
END IF;

사용예) 년도 하나를 입력 받아 윤년(LEAP YEAR)인지 평년인지 판별하는 블록 작성
윤년=해당년도가 4의 배수이면서 100의 배수가 아닌 해이거나 또는 400의 배수가 되는 해

ACCEPT P_YEAR PROMPT '년도입력: ' 

DECLARE 
    V_YEAR NUMBER(4):=TO_NUMBER('&P_YEAR');--''안에 &변수로 쓰는 것이다. 규칙이다. 문의 끝이 ; 이다.
    V_RES VARCHAR2(100);

BEGIN
    IF 
    (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)!=0) OR MOD(V_YEAR,400)=0 
    THEN
    V_RES:=V_YEAR||'는 윤년입니다.';
    ELSE
    V_RES:=V_YEAR||'는 평년입니다.';
    END IF;
    DBMS_OUTPUT.PUT_LINE('결과: '||V_RES);
END;
--2월달이 29일까지 있으면 윤년입니다.
2) CASE WHEN~ THEN 문
. 표준 SQL문의 SELECT 절에서 사용했던 표현식 CASE WHEN ~THEN과 동일
. 끝이 END CASE 임
(사용형식-1)--SWITCH문과 비슷하다
CASE 변수|수식| 
     WHEN 값1 THEN 
          명령1;
     WHEN 값2 THEN
          명령2;
     ELSE 명령N;
END CASE;
     
(사용형식-2)
CASE WHEN 조건1 THEN 
          명령1;
     WHEN 조건2 THEN
          명령2;
          :
     ELSE 명령N;
END CASE;

사용예) 회원 테이블에서 마일리지를 검사하여 그 값이 5000이상이면 비고난에 'VIP', 2000이상이면 '평범' 그 이하이면 '관리대상'
메시지를 출력하는 SQL을 작성하되 비고난에 출력하는 부분은 함수로 작성하시오
(함수)
CREATE OR REPLACE FUNCTION FN_MILE(
    P_MILE IN NUMBER)--매개변수로는 P_MILE로 타입을 IN 받아들일때 OUT은 내보낼때
    RETURN VARCHAR2--반환데이터 타입
IS
    V_MESS VARCHAR2(100);--실제 데이터 반환해준다. 
BEGIN
    CASE WHEN P_MILE >=5000 THEN
                V_MESS:='VIP';
         WHEN P_MILE >=2000 THEN
                V_MESS:='NORMAL';
         ELSE
                V_MESS:='WARNING';     
END CASE;
RETURN V_MESS;
END;

실행)
SELECT  MEM_ID AS 회원번호,
        MEM_NAME AS 회원명,
        MEM_MILEAGE AS 마일리지,
        FN_MILE(MEM_MILEAGE) AS 비고
FROM MEMBER;
