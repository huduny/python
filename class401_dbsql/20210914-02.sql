2021-09-14
1) CART_NO 생성함수
    
    CREATE OR REPLACE FUNCTION FN_CREATE_CART_NO (
        P_MID MEMBER.MEM_ID%TYPE)
       --( P_DATE IN VARCHAR2 )
        RETURN VARCHAR2
    IS
        V_CNT NUMBER := 0;
        V_DATE VARCHAR(9) := TO_CHAR( SYSDATE, 'YYYYMMDD') || '%';
        V_CART_NO CART.CART_NO%TYPE;
        V_MID MEMBER.MEM_ID%TYPE;
    BEGIN
        SELECT COUNT(*) INTO V_CNT
          FROM CART
         WHERE CART_NO LIKE V_DATE; -- 오늘 날짜에 로그인한 회원의 수
      
      IF V_CNT = 0 THEN
         V_CART_NO := TO_CHAR ( SYSDATE, 'YYYYMMDD') || '00001';
        RETURN V_CART_NO;  
      ELSE   
        SELECT  A.CID, A.CNO INTO V_MID, V_CART_NO
          FROM ( SELECT CART_MEMBER AS CID,
                        CART_NO AS CNO
                   FROM CART
                  WHERE CART_NO LIKE V_DATE
                  ORDER BY CART_NO DESC) A
         WHERE ROWNUM = 1;
 
           IF P_MID !=  V_MID THEN
              V_CART_NO :=  V_CART_NO +1;
           END IF;
           RETURN V_CART_NO; 
      END IF;
    END;

(1) 트리거 의사레코드 --가상의 레코드, 값이 입력되면 위치값을 :new가 가지고 있어서 그중에 필요한 값을 가져온다. 레코드(행)
- :NEW, :OLD제공 --행단위 트리거에서만 사용가능
-------------------------------------------------------------------------------------------------------
의사레코드               의미
-------------------------------------------------------------------------------------------------------
: NEW                 INSERT, UPDATE 이벤트에서 사용  --기존이 아니라 새로운 데이터를 사용할 때에는 new 사용
                      데이터가 삽입(갱신)되기 위해 새롭게 입력된 값
                      DELETE 시에는 모두 NULL 값
:OLD                    DELETE, UPDATE 이벤트에서 사용 --기존에 저장된 데이터를 사용할 때에는 old사용
                      데이터가 삭제(갱신)되기 위해 저장되어 있던 값
                      INSERT 시에는 모두 NULL값
-------------------------------------------------------------------------------------------------------
(2) 트리거 함수
- 트리거 발생의 원인이된 이벤트의 종류를 판별하기위한 함수
-------------------------------------------------------------------------------------------------------
함수          내용
-------------------------------------------------------------------------------------------------------
INSERING  이벤트가 INSERT이면 참 반환 --if문을 사용해서 판별한다.
UPDATING  이벤트가 UPDATE이면 참 반환
deleting   이벤트가 delete이면 참 반환

새로운 이벤트를 저장하기 위해서는   :NEW  를 사용한다. 트리거에서 참조해서 :new.cart_no하면 새로운 데이터가 참조된다.        
                      
                      
                      
사용예) 오늘 회원 'f001' 회원이 'P202000006' 재품 10개를 구입했을 경우 이자료를 장바구니에 저장하고
재고 수불테이블을 갱신하는 트리거를 작성하시오
(CART에 저장)
INSERT INTO CART
VALUES('f001', FN_CREATE_CART_NO('f001'), 'P202000006', 10);
ROLLBACK;
(트리거 구현)
    CREATE OR REPLACE TRIGGER TG_UPDATE_REMAIN
    AFTER INSERT OR UPDATE OR DELETE ON CART
    FOR EACH ROW --행마다 쓰라고 했다 매번
    DECLARE
        V_QTY NUMBER:=0;
        V_PROD PROD.PROD_ID%TYPE;
    BEGIN
        IF INSERTING THEN
            V_QTY:=:NEW.CART_QTY;
            V_PROD:=:NEW.CART_PROD;
        ELSIF UPDATING THEN
            V_QTY:=:NEW.CART_QTY-:OLD.CART_QTY;
            V_PROD:=:NEW.CART_PROD;
        ELSE 
            V_QTY:=-:OLD.CART_QTY;
            V_PROD:=:OLD.CART_PROD;
        END IF;
        
        UPDATE REMAIN A
        SET    A.REMAIN_O=A.REMAIN_O+V_QTY, --CART는 판매이고 판매는 출고이다
               A.REMAIN_99=A.REMAIN_O-V_QTY,
               A.REMAIN_J_DATE=SYSDATE
        WHERE  A.REMAIN_YEAR='2005'
        AND    A.PROD_ID=V_PROD;
    END;
사용예) 오늘 회원 'f001' 회원이 'P202000006' 재품 5개를 추가 구입했을 경우 이자료를 장바구니에 저장하고 이자료를 장부구니에 재고 수불테이블을 갱신하는
트리거를 작성하시오.
UPDATE CART SET CART_QTY=15 WHERE CART_NO = '2021091400001' AND CART_PROD='P202000006';
COMMIT;
사용예) 오늘 회원 'f001' 회원이 'P202000006' 재품 2개만 남기고 모두 반품했을 경우 이 자료를 장바구니에 저장하고 이자료를 장부구니에 재고 수불테이블을 갱신하는
트리거를 작성하시오.
UPDATE CART SET CART_QTY=2 WHERE CART_NO = '2021091400001' AND CART_PROD='P202000006'; 
사용예) 오늘 회원 'f001' 회원이 'P202000006' 재품을 모두 반품했을 경우 이 자료를 장바구니에 저장하고 이자료를 장부구니에 재고 수불테이블을 갱신하는
트리거를 작성하시오.
DELETE CART WHERE CART_NO = '2021091400001' AND CART_PROD='P202000006'; 

2021-0914-01) 패키지
- 논리적 연관성이 있는 PL/SQL 타입 변수, 상수서브프로그램, 커서 등의 항목을 묶어 놓은 객체
- 컴파일되어 서버에 저장되며, 다른 프로그램(다른 패키지, 서브프로그램, 외부프로그램)에서 패키지내의 항목을 참조, 고유, 실행 할 수 있음
- 패키지 사용의 장점: 모듈화, 프로그램 설계의 용이성, 캡슐화 등을 제공
- 패키지는 선언부와 실행부로 구성됨
1)선언부
 - 패키지에서 사용할 타입, 변수, 상수, 예외, 서브프로그램 등의 프로토 타입(프로그램 골격)을 선언
 (사용형식)--실행코드가 없고 프로그램 골격만 만들어 준다.
 CREATE OR REPLACE PACKAGE 패키지명
 IS
   변수, 상수, 커서, 예외 선언문; 
   
 FUNCTION 함수명 [(매개변수 LIST)]
 RETURN 반환타입; 
 
 PROCEDURE 프로시져명[(매개변수 LIST)];
            :
END 패키지명;
 
2)패키지 실행부(본문)
 - 패키지 선언부에서 선언된 서브프로그램들에 대한 구현 선언
 (사용형식)
 CREATE OR REPLACE PACKAGE BODY 패키지명
 IS
   변수, 상수, 커서, 예외 선언문; 
   
 FUNCTION 함수명 [(매개변수 LIST)]
 RETURN 반환타입
 IS 
 BEGIN
    :
  RETURN EXP;
 END 함수명;
 
 PROCEDURE 프로시져명[(매개변수 LIST)]
 IS
 BEGIN
        :
 END 프로시져명;
        :
END 패키지명; 
--선언부는 프로젝트 시작전 본문부는 프로젝트 중에 만들어진다. 제목만 있는것이 프로토타입이라고 한다.

사용예) 사원관리 패키지를 생성하려 한다. 패키지에는 사원조회, 신규사원입력, 퇴직자 처리를 위한 서브프로그램이 포함되어야 한다. 패키지를 모두 구성하시오.

1)사원조회 : 사원번호를 입력받아 이름과 전화번호를 출력하는 함수로 함수명은 FN_GETINFO
2)신규사원입력 : 사원번호, 이름, 입사일, 직무코드, 부서코드를 입력 받아 사원테이블에 저장하는 프로시져로 이름은 PROC_NEW_EMP
3)퇴직자 처리 : 일자와 사원번호를 입력받아 퇴직일자를 '일자'로 변경하는 프로시져로 프로시져명은 PROC_RETIRE_EMP

패키지명은 DDIT_PKG이다.

(패키지 선언)
CREATE OR REPLACE PACKAGE ddit_pkg
IS
    FUNCTION FN_GETINFO(
                        P_EID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE)
RETURN VARCHAR2;

PROCEDURE  PROC_NEW_EMP(
                        P_NAME IN VARCHAR2, 
                        P_HIRE_DATE IN HR.EMPLOYEES.HIRE_DATE%TYPE, 
                        P_JOB_ID  IN HR.EMPLOYEES.JOB_ID%TYPE, 
                        P_DID IN HR.EMPLOYEES.DEPARTMENT_ID%TYPE,
                        P_MAIN IN HR.EMPLOYEES.EMAIL%TYPE);

PROCEDURE  PROC_RETIRE_EMP(
                           P_DATE IN DATE,
                           P_EID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE); 
END ddit_pkg;

(패키지 실행영역)
CREATE OR REPLACE PACKAGE BODY ddit_pkg
IS
    FUNCTION FN_GETINFO(
                        P_EID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE)
    RETURN VARCHAR2
    IS
        V_NAME EMPLOYEES.EMP_NAME%TYPE;
        V_TEL_NUM EMPLOYEES.PHONE_NUMBER%TYPE;
        
    BEGIN
        SELECT EMP_NAME, PHONE_NUMBER  INTO V_NAME, V_TEL_NUM
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID=P_EID;
        RETURN V_NAME||', '||V_TEL_NUM;
    END FN_GETINFO;
        

    PROCEDURE  PROC_NEW_EMP(
                            P_NAME IN VARCHAR2,
                            P_HIRE_DATE IN HR.EMPLOYEES.HIRE_DATE%TYPE, 
                            P_JOB_ID  IN HR.EMPLOYEES.JOB_ID%TYPE, 
                            P_DID IN HR.EMPLOYEES.DEPARTMENT_ID%TYPE,
                            P_MAIN IN HR.EMPLOYEES.EMAIL%TYPE)
    IS
        V_EID EMPLOYEES.EMPLOYEE_ID%TYPE;
    BEGIN
        SELECT MAX(EMPLOYEE_ID)+1 INTO V_EID FROM EMPLOYEES;
        INSERT INTO EMPLOYEES(EMPLOYEE_ID,FIRST_NAME,LAST_NAME,HIRE_DATE,JOB_ID,DEPARTMENT_ID,EMP_NAME, EMAIL)
        VALUES(V_EID,SUBSTR(P_NAME,1,1),SUBSTR(P_NAME,2),P_HIRE_DATE,P_JOB_ID,P_DID,P_NAME,P_MAIN); COMMIT;
    END PROC_NEW_EMP;
    
    PROCEDURE  PROC_RETIRE_EMP(
                               P_DATE IN DATE,
                               P_EID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE) 
    IS
    BEGIN
        UPDATE EMPLOYEES SET RETIRE_DATE=P_DATE WHERE EMPLOYEE_ID=P_EID; COMMIT;
    END PROC_RETIRE_EMP;                                
END ddit_pkg;

(실행)
1)조회 - 사원번호 116번
SELECT ddit_pkg.FN_GETINFO(116) FROM DUAL;
2)신규사원등록
EXECUTE DDIT_PKG.PROC_NEW_EMP('홍길동', SYSDATE, 'ST_MAN', 70,'ASDASDSA')
3)퇴직자 처리
EXECUTE DDIT_PKG.PROC_RETIRE_EMP(SYSDATE,188);




 
 