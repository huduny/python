2021-0909-01) 반복문
- 오라클의 반복문은 LOOP, WHILE, FOR 문이 제공됨
1)LOOP문
- 조건이 없는 단순한 무한루프 기능 제공
- EXIT 문을 사용하여 반복문을 탈출 할 수 있음
- 기타 반복문의 기본 구조제공
(사용형식)
LOOP
 반복처리해야할 명령(들);
 [EXIT WHEN 조건;]
END LOOP;
. 'EXIT WEHN 조건': 조건이 참이면 반복구조를 벗어남

사용예) 구구단의 6단을 출력하는 LOOP문 구성
DECLARE
    V_RESULT NUMBER:=0;--넘버로 잡아둔 변수를 초기화하지 않으면 논리적 오류가 발생해 계속 대기 상태에 있는다.
    V_MESS VARCHAR2(100);
    V_CNT NUMBER:=1;
    
BEGIN
    LOOP
    V_RESULT:=V_CNT*6;
    V_MESS:='6 * '||V_CNT||' = '||V_RESULT;
    EXIT WHEN V_CNT>9;
    DBMS_OUTPUT.PUT_LINE(V_MESS);
    V_CNT:=V_CNT+1;
    END LOOP;
END;

사용예)10~110번 사이의 난수/를 발생시켜 해당 값의 부서의 평균임금/을 구하고 소속 사원 중 평균임금보다 적게 급여를 받는 사원/을 조회하시오.
조회할 내용은 /*사원번호,사원명,급여,부서명*/이다.
--값을 잘 모르고 무조건 반복해야될때는 커서를 사용한다

DECLARE
    V_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE; --부서코드
    V_SAL HR.EMPLOYEES.SALARY%TYPE; -- 평균임금
    V_EID EMPLOYEES.EMPLOYEE_ID%TYPE; --사원번호
    V_ENAME EMPLOYEES.EMP_NAME%TYPE; --사원명
    V_ESAL EMPLOYEES.SALARY%TYPE; --사원급여
    V_DNAME DEPARTMENTS.DEPARTMENT_NAME%TYPE; --부서명
    
    CURSOR CUR_DEPT_SAL(P_AVGSAL NUMBER,P_DID EMPLOYEES.DEPARTMENT_ID%TYPE) IS
    --커서 안에는 커서명(매개변수 타입), 커서는 SELECT문을 수행했더니 출력할 내용이 여러개일때, 여러개를 찍을때 대표적인 컬럼 값을 커서로 출력, 
    --10번에 누구라고 명확히 지정하지 않는이상
        SELECT EMPLOYEE_ID
        FROM    EMPLOYEES
        WHERE   SALARY <= P_AVGSAL
        AND     DEPARTMENT_ID=P_DID;
    --커서가 생산해야되는 뷰, 해당부서 평균급여이하 수령하는 사원번호, 이를 위해서 평균급여계산+해당부서
BEGIN
    V_DID:=TRUNC(DBMS_RANDOM.VALUE(10,110),-1); --부서번호
    
    SELECT AVG(SALARY) INTO V_SAL
    FROM HR.EMPLOYEES
    WHERE   DEPARTMENT_ID = V_DID;
    
    OPEN CUR_DEPT_SAL(V_SAL, V_DID);
    
    LOOP
    FETCH CUR_DEPT_SAL INTO V_EID; --줄단위로 SELECT절을 읽어온다. 페치에서 사원번호 하나를 V_EID에 넣었다. 
    EXIT WHEN CUR_DEPT_SAL%NOTFOUND;
    SELECT A.EMP_NAME, A.SALARY, B.DEPARTMENT_NAME
    INTO   V_ENAME, V_ESAL, V_DNAME
    FROM   EMPLOYEES A, DEPARTMENTS B
    WHERE   A.DEPARTMENT_ID = B.DEPARTMENT_ID
    AND     A.EMPLOYEE_ID = V_EID;
    
    DBMS_OUTPUT.PUT_LINE('사원번호: '||V_EID);
    DBMS_OUTPUT.PUT_LINE('사원명: '||V_ENAME);
    DBMS_OUTPUT.PUT_LINE('급여: '||V_ESAL);
    DBMS_OUTPUT.PUT_LINE('부서코드: '||V_DID);
    DBMS_OUTPUT.PUT_LINE('부서명: '||V_DNAME);
    DBMS_OUTPUT.PUT_LINE('---------------------');
    END LOOP;

END;

사용예) 거래처 중 주거래 은행이 '국민은행'인 거래처를 찾아/ 2005년 3월 해당 거래처들의 매입집계를 조회하시오
alias는 거래처코드, 거래처명, 매입수량, 매입금액이다.
--여러개인 거래처들이 10개라면 10개의 행이 나와야 하니깐 커서를 써야된다. 커서를 출력할려는 것이 아니라 선택해서 매입집게를 조회할 것이다. 
--반복문에서 행 개수 만큼 반복한다.
DECLARE
    V_BID BUYER.BUYER_ID%TYPE; --거래처코드\
    V_BNAME BUYER.BUYER_NAME%TYPE; --거래처명
    V_AMT NUMBER:=0; --매입수량집계
    V_SUM NUMBER:=0; --매입금액집계
    
    CURSOR  CUR_BUYER01 IS  --FETCH하면 한줄씩 ROW씩 읽어온단
    SELECT  BUYER_ID, BUYER_NAME
    FROM    BUYER
    WHERE   BUYER_BANK='국민은행';

BEGIN
    OPEN CUR_BUYER01;
   
    
    LOOP
        FETCH CUR_BUYER01 INTO V_BID,V_BNAME;
        
        EXIT WHEN CUR_BUYER01%NOTFOUND;
         
        SELECT  SUM(BUY_QTY), SUM(BUY_QTY*BUY_COST)
        INTO    V_AMT, V_SUM
        FROM    BUYPROD, PROD --PROD는 바이어 순서대로 집계를 낼려고
        WHERE   BUY_PROD=PROD_ID
        AND     PROD_BUYER=V_BID
        AND   BUY_DATE BETWEEN TO_DATE('20050301') AND TO_DATE('20050331');
        
        DBMS_OUTPUT.PUT_LINE('거래처코드'||V_BID);
        DBMS_OUTPUT.PUT_LINE('거래처명'||V_BNAME);
        DBMS_OUTPUT.PUT_LINE('매입수량집계'||V_AMT);
        DBMS_OUTPUT.PUT_LINE('매입금액집계'||V_SUM);
        DBMS_OUTPUT.PUT_LINE('');
        
    END LOOP;
    CLOSE CUR_BUYER01;
END;

2)WHILE 문
- 개발언어의 WHILE 문과 동일
- 반복처리마다 조건을 확인하여 그 값이 참인경우 반복 수행 및 조건이 거짓이면 반복을 벗어나는 명령
- EXIT문은 사용 가능하고 반복을 벗어나게 함
- CONTINUE는 11G부터 사용 가능
(사용형식)
WHILE 조건 LOOP
반복처리명령문(들);
[EXIT;]
[CONTINUE;]
END LOOP;

사용예) 구구단의 6단을 출력하시오
DECLARE 
    V_CNT NUMBER:=0;
BEGIN
    WHILE V_CNT<9 LOOP
        V_CNT:=V_CNT+1;
        DBMS_OUTPUT.PUT_LINE('6*'||V_CNT||'='||6*V_CNT);
    END LOOP;
END;

사용예)첫날에 100원 그 이후부터 전날의 2배씩 저축하는 경우 최초로 250만원을 넘는 날과 그날까지 저축한 금액을 구하시오

DECLARE 
V_DCURR NUMBER:=100;
V_SUM NUMBER:=0;
V_CNT NUMBER:=0;

BEGIN
WHILE V_SUM<=2500000 LOOP
    V_SUM:=V_SUM+V_DCURR;
    V_DCURR:=V_DCURR*2;
    V_CNT:=V_CNT+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('경과일수'||' '||V_CNT||'일'||'저축금액'||' '||V_SUM);
END;

사용예) 거래처 중 주거래 은행이 '국민은행'인 거래처를 찾아/ 2005년 3월 해당 거래처들의 매입집계를 조회하시오.(WHILE문을 사용)
alias는 거래처코드, 거래처명, 매입수량, 매입금액이다.
DECLARE
    V_BID BUYER.BUYER_ID%TYPE; --거래처코드\
    V_BNAME BUYER.BUYER_NAME%TYPE; --거래처명
    V_AMT NUMBER:=0; --매입수량집계
    V_SUM NUMBER:=0; --매입금액집계
    
    CURSOR  CUR_BUYER01 IS  --FETCH하면 한줄씩 ROW씩 읽어온단
    SELECT  BUYER_ID, BUYER_NAME
    FROM    BUYER
    WHERE   BUYER_BANK='국민은행';

BEGIN
    OPEN CUR_BUYER01;
    
    FETCH CUR_BUYER01 INTO V_BID,V_BNAME;
    
    WHILE CUR_BUYER01%FOUND LOOP
        --페치하지 않으면 해당자료가 있는지 없는지 알 수가 없다 
        --WHILE문은 FETCH없이 와일 조건문이 작성되기 때문에 FETCH가 와일문 밖에서 선언되어야 된다.
         
        SELECT  SUM(BUY_QTY), SUM(BUY_QTY*BUY_COST)
        INTO    V_AMT, V_SUM
        FROM    BUYPROD, PROD --PROD는 바이어 순서대로 집계를 낼려고
        WHERE   BUY_PROD=PROD_ID
        AND     PROD_BUYER=V_BID
        AND   BUY_DATE BETWEEN TO_DATE('20050301') AND TO_DATE('20050331');
        
        DBMS_OUTPUT.PUT_LINE('거래처코드'||V_BID);
        DBMS_OUTPUT.PUT_LINE('거래처명'||V_BNAME);
        DBMS_OUTPUT.PUT_LINE('매입수량집계'||V_AMT);
        DBMS_OUTPUT.PUT_LINE('매입금액집계'||V_SUM);
        DBMS_OUTPUT.PUT_LINE('');
    FETCH CUR_BUYER01 INTO V_BID,V_BNAME;
    END LOOP;
    CLOSE CUR_BUYER01;
END;
--WHILE문을 쓸때에는 FETCH문을 LOOP시작 전1번 LOOP끝나기전 1번을 꼭 써줘야 된다.

--FOR문은 2가지 일반 FOR 커서사용 FOR
3) FOR문
- 반복횟수를 정확히 알고 있거나 반복횟수가 중요한 경우 사용
(일반적 FOR문의 사용형식)
FOR 인덱스명 IN [REVERSE] 초기값...최종값 LOOP
    반복처리할 명령문(들);
END LOOP;
- '인덱스명': 초기값부터 최종갑까지 배정 받아 반복을 제어하는 변수로써  시스템에서 제공함
- 'REVERSE': 역순으로 반복 수행
사용예) 구구단의 6단을 출력하시오
DECLARE

BEGIN
    FOR I IN REVERSE 1..9 LOOP
    DBMS_OUTPUT.PUT_LINE('6 * '||I||'='||6*I);
    END LOOP;
END;

(커서에서 사용한 for문의 사용형식)
FOR 레코드명 IN 커서명|커서정의문 LOOP
반복처리할 명령문(들);
END LOOP;
. '레코드명' : 커서에서 각 행을 기억시킬 레코드명으로 시스템에서 제공 (한행을 전부 보관)
. '커서정의문' : 선언영역의 커서본문(SELECT문)을 인라인 서브쿼리 형식으로 정의
. 커서내의 컬럼을 참조하는 방법: 레코드명.컬럼명
. 커서의 OPEN, FETCH, CLOSE문이 불필요

사용예) 거래처 중 주거래 은행이 '국민은행'인 거래처를 찾아/ 2005년 3월 해당 거래처들의 매입집계를 조회하시오.(FOR 문을 사용)
alias는 거래처코드, 거래처명, 매입수량, 매입금액이다.
DECLARE
    V_AMT NUMBER:=0; --매입수량집계
    V_SUM NUMBER:=0; --매입금액집계
    
    CURSOR  CUR_BUYER01 IS  --FETCH하면 한줄씩 ROW씩 읽어온단
    SELECT  BUYER_ID, BUYER_NAME
    FROM    BUYER
    WHERE   BUYER_BANK='국민은행';

BEGIN

        FOR REC IN CUR_BUYER01 LOOP --REC는 시스템에서 알아서 선언해준다.
         
        SELECT  NVL(SUM(A.BUY_QTY),0), NVL(SUM(A.BUY_QTY*B.PROD_COST),0)
        INTO    V_AMT, V_SUM
        FROM    BUYPROD A, PROD B --PROD는 바이어 순서대로 집계를 낼려고
        WHERE   B.PROD_BUYER=REC.BUYER_ID
        AND     A.BUY_PROD=B.PROD_ID
        AND    A.BUY_DATE BETWEEN TO_DATE('20050301') AND TO_DATE('20050331');
        
        DBMS_OUTPUT.PUT_LINE('거래처코드'||REC.BUYER_ID);
        DBMS_OUTPUT.PUT_LINE('거래처명'||REC.BUYER_NAME);
        DBMS_OUTPUT.PUT_LINE('매입수량집계'||V_AMT);
        DBMS_OUTPUT.PUT_LINE('매입금액집계'||V_SUM);
        DBMS_OUTPUT.PUT_LINE('');

    END LOOP;
END;

(IN LINE CURSOR)
DECLARE
    V_AMT NUMBER:=0; --매입수량집계
    V_SUM NUMBER:=0; --매입금액집계

BEGIN

        FOR REC IN ( SELECT  BUYER_ID, BUYER_NAME
                    FROM    BUYER
                    WHERE   BUYER_BANK='국민은행') -- 가장 많이 사용되는 형식이다.
        LOOP
        SELECT  NVL(SUM(A.BUY_QTY),0), NVL(SUM(A.BUY_QTY*B.PROD_COST),0)
        INTO    V_AMT, V_SUM
        FROM    BUYPROD A, PROD B --PROD는 바이어 순서대로 집계를 낼려고
        WHERE   B.PROD_BUYER=REC.BUYER_ID
        AND     A.BUY_PROD=B.PROD_ID
        AND    A.BUY_DATE BETWEEN TO_DATE('20050301') AND TO_DATE('20050331');
        
        DBMS_OUTPUT.PUT_LINE('거래처코드'||REC.BUYER_ID);
        DBMS_OUTPUT.PUT_LINE('거래처명'||REC.BUYER_NAME);
        DBMS_OUTPUT.PUT_LINE('매입수량집계'||V_AMT);
        DBMS_OUTPUT.PUT_LINE('매입금액집계'||V_SUM);
        DBMS_OUTPUT.PUT_LINE('');

    END LOOP;
END;

2021-0909-02) PROCEDURE -- 함수는 반환값이 있고 SELECT나 WHERE절에 사용 가능 BUT 프로시져는 반환값이 없어서 독립 실행 시켜야 된다. 
- 특정결과를 산출하기 위한 일련의 명령들의 집합으로 컴파일되어 서버에 저장
- 컴파일된 버젼은 프로시져 캐쉬에 저장되므로 처리속도가 빨라짐
- CLIENT 간에 처리 루틴을 공유하여 일관성있는 데이터 변경 보장
- 서버 데이터 보호
- 네트워크 트래픽 감소--프로시져 이름과 매개변수만 가지고 가서 통과하는 자료의 양을 줄일수 있다. 
- 반환값이 없음
(사용형식)
CREATE [OR REPLACE] PROCEDURE 프로시져명 
[(매개변수명 [MORE] 타입명 [:=값,]--매개변수가 없으면 안써도 된다. 타입에 크기를 절대 쓰면 안된다.
:)]
IS
선언부;
BEGIN
실행부;
[EXCEPTION
예외처리부;
]
END;
.'매개변수명' : 보통 'P_'로 시작
. MODE: IN, OUT, INOUT, 생략되면 IN으로 간주
IN: 입력용 --프로시져 입장, 외부에서 데이터를 프로시져 안으로 가지고 올때
OUT: 출력용 --매개변수를 통해서 프로시져 밖으로 전달될 수 있다. 프로시져 이름으로는 반환될수 없다.
INOUT: 입출력 공용(사용 자재)
***'타입명': 데이터 타입만 기술(크기 기술하지 않음)



