2021-09-11)
--직업을 변수로 받아 이름 회원명과 마일리지를 출력하는 커서
--이부분은 SQL이다 
SELECT MEM_NAME,
        MEM_MILEAGE
FROM MEMBER
WHERE   MEM_JOB='회사원';--회사원을 변수로 받겠다.

--PL/SQL로 변경
--DECLARE와 BEGIN 사이에는 변수선언, 예외처리, 커서선언, 컴포지트 변수 선언 
--BEGIN과 END 사이는 구현부이다.
--DECLARE BEGIN END를 쓰는 순간 ANONYMOUS BLOCK이 구현된다
--규칙은 변수를 선언해서 거기에 담아서 출력해야 된다.

/* 
행: ROW RECORD TUPLE
열: COLUMN, FIELD, ATTRIBUTE
2차원 배열을 테이블-릴레이션 관계로 표현

ERD다이어그램: 개체ENTITY와 관계RELATIONSHIP으로 표현
개체와 개체간의; 관계를 릴레이션, 개체가 공통적으로 가지고 있는 성질은 컬럼
물리세계에서 MEMBER가 현실세계(논리세계) 회원이라는 객체가 된다. 회원은 아이디, 비번이라는 속성을 가지고 있다.
즉 논리세계의 현실 속성들이 물리세계에서 TABLE이 된다.

*SQL 구조적 언어
1.DDL: CREATE ALTER DROP --데이터를 담는 공간
2.DML: SELECT UPDATE DELETE INSERT --데이터 조작
3.DCL: GRANT REVOKE --권한 제어
4.TCL: COMMIT ROLLBACK, SAVEPOINT --트랜잭션 원일고지(원자성 일관성 고립성 지속성)

*PL SQL 절차적 언어
분기문(IF, CASE 등):여러갈래로 프로세스의 흐름을 바꾼다
-뻐스타
PACKAGE
USER FUNCTION(중요)
STORED PROCEDURE(중요)
TRIGGER
ANONYMOUS BLOCK--블록이 있어야지 함수와 프로시져를 사용할 수 있다. 집의 주춧돌이라고 생각해야 된다.

CLIENT와 SERVER가 있는데 CLIENT의 SQL문을 서버로 바로 보낸다. PL/SQL은 프로시져 명과 같이 이미 약속해놓은 것을 불러서 실행하는 것이다.
*/
SET SERVEROUTPUT ON;
/

DECLARE
    V_NAME VARCHAR2(90);
    V_MILEAGE NUMBER(10);
BEGIN 
    SELECT MEM_NAME, MEM_MILEAGE INTO V_NAME, V_MILEAGE --문제가 생긴다 왜냐면 결과는 여러건이고 변수는 하나이기 떄문에/ 
                                                        --1. 기본키를 정해주면 된다(기본키는 유일하기 때문에), select 결과가 무조건 한건이 나오면 담을수 있다/ 
                                                        --2.
    FROM MEMBER
    WHERE   1 =1 -- 의미 없다 TRUE이기 때문에 구분을 위해서 쓴것일 뿐
    AND MEM_ID = 'b001'
    and MEM_JOB='회사원';
    DBMS_OUTPUT.PUT_LINE(V_NAME||','|| V_MILEAGE);
END;
-----------------------------------------------------------------------------------------------
DECLARE
    V_NAME VARCHAR2(90);
    V_MILEAGE NUMBER(10);
    
    CURSOR CUR IS --집합에 CUR라는 이름을 붙인다, 이 집합을 주기억 장치에 올린다 BIND한다, OPEN이라는 명령어 사용
    SELECT MEM_NAME, MEM_MILEAGE INTO V_NAME, V_MILEAGE  --다중행을 DECLARE BEGIN 사이에 올린다               
    FROM MEMBER
    WHERE   1 =1
    and MEM_JOB='회사원';
BEGIN 
    OPEN CUR;
    FETCH CUR INTO V_NAME, V_MILEAGE; --CUR라는 애가 FETCH(1행을 바라봐라)가 실행된다
    WHILE CUR%FOUND LOOP
    DBMS_OUTPUT.PUT_LINE(V_NAME||','|| V_MILEAGE);
    FETCH CUR INTO V_NAME, V_MILEAGE; --WHILE은 마지막에 FETCH를 사용한다. 페치를 안써주면 처음 FETCH가 가르킨 부분만 출력된다.
    END LOOP;
    CLOSE CUR;
END;
-----------------------------------------------------------------
DECLARE
    V_NAME VARCHAR2(90);
    V_MILEAGE NUMBER(10);
    
    CURSOR CUR IS --집합에 CUR라는 이름을 붙인다, 이 집합을 주기억 장치에 올린다 BIND한다, OPEN이라는 명령어 사용
    SELECT MEM_NAME, MEM_MILEAGE INTO V_NAME, V_MILEAGE  --다중행을 DECLARE BEGIN 사이에 올린다               
    FROM MEMBER
    WHERE   1 =1
    and MEM_JOB='회사원';
BEGIN 
    OPEN CUR;
    LOOP --루프는 무조건 밑에 페치 실행
    FETCH CUR INTO V_NAME, V_MILEAGE;
    EXIT WHEN CUR%NOTFOUND; --따지는 부분이 필요하다, FETCH후에 데이터가 없으면 빠져나와라, WHILE과 다르게 없으면 빠져나오고 WHILE은 있으면 들어가는 거다
    DBMS_OUTPUT.PUT_LINE(CUR%ROWCOUNT||':'||V_NAME||','|| V_MILEAGE);
    END LOOP;
    CLOSE CUR;
END;
--------------------------------------------------------------------
DECLARE
    V_NAME VARCHAR2(90);
    V_MILEAGE NUMBER(10);
    
    CURSOR CUR(V_JOB VARCHAR2) IS --집합에 CUR라는 이름을 붙인다, 이 집합을 주기억 장치에 올린다 BIND한다, OPEN이라는 명령어 사용
                                  --던지는 것을 받기 위해서 그릇을 만들어 줘야된다. 지역변수여서 위에다 선언할 필요가 없다.
    SELECT MEM_NAME, MEM_MILEAGE INTO V_NAME, V_MILEAGE  --다중행을 DECLARE BEGIN 사이에 올린다               
    FROM MEMBER
    WHERE   1 =1
    and MEM_JOB=V_JOB;
BEGIN 
    OPEN CUR('주부');--메모리에 올라갈때 PARAMETER를 던질수 있다.
    LOOP --루프는 무조건 밑에 페치 실행
    FETCH CUR INTO V_NAME, V_MILEAGE;
    EXIT WHEN CUR%NOTFOUND; --따지는 부분이 필요하다, FETCH후에 데이터가 없으면 빠져나와라, WHILE과 다르게 없으면 빠져나오고 WHILE은 있으면 들어가는 거다
    DBMS_OUTPUT.PUT_LINE(CUR%ROWCOUNT||':'||V_NAME||','|| V_MILEAGE);
    END LOOP;
    CLOSE CUR;
END;
--------------------------------------------------------------------------------
ACCEPT P_JOB PROMPT '직업을 입력하세요: ';
DECLARE
    V_NAME VARCHAR2(90);
    V_MILEAGE NUMBER(10);
    
    CURSOR CUR IS
    SELECT MEM_NAME, MEM_MILEAGE INTO V_NAME, V_MILEAGE              
    FROM MEMBER
    WHERE   1 =1
    and MEM_JOB='&P_JOB'; -- PROMPT창이 뜨면 P_JOB에 들어가고 여기로 오는데 규칙은 &를 꼭 붙여줘야 된다. &는 주소를 말해주는 것이다.
BEGIN 
    OPEN CUR;
    LOOP 
    FETCH CUR INTO V_NAME, V_MILEAGE;
    EXIT WHEN CUR%NOTFOUND; 
    DBMS_OUTPUT.PUT_LINE(CUR%ROWCOUNT||':'||V_NAME||','|| V_MILEAGE);
    END LOOP;
    CLOSE CUR;
END;
-------------------------------------------------------------------------------------
--for문 사용시 open,FETCH이 필요없다. 
ACCEPT P_JOB PROMPT '직업을 입력하세요: ';
DECLARE
    
    CURSOR CUR IS
    SELECT MEM_NAME, MEM_MILEAGE --CUR인데 REC라고 별칭을 주면 한행씩 반복하면 REC에 넣어준다.              
    FROM MEMBER
    WHERE   1 =1 --주석처리가 편하기 위해 사용
    and MEM_JOB='&P_JOB';
BEGIN 
    FOR REC IN CUR LOOP 
    DBMS_OUTPUT.PUT_LINE(CUR%ROWCOUNT||':'||REC.MEM_NAME||','|| REC.MEM_MILEAGE);
    END LOOP;
    CLOSE CUR;
END;
--------------------------------------------------------------------------------------
ACCEPT P_JOB PROMPT '직업을 입력하세요: ';
DECLARE

BEGIN 
    FOR REC IN (SELECT MEM_NAME, MEM_MILEAGE               
                FROM MEMBER
                WHERE   1 =1
                and MEM_JOB='&P_JOB') --이것도 가능하다
    LOOP 
    DBMS_OUTPUT.PUT_LINE(REC.MEM_NAME||','|| REC.MEM_MILEAGE);
    END LOOP;
    CLOSE CUR;
END;
---------------------------------------------------------------------------------------------
--프로시져 접목
// BIND변수: IN/ OUT. 파라미터를 받아주는(보내는) 변수
CREATE OR REPLACE PROCEDURE PROD_GETMEMLIST(P_JOB IN VARCHAR2) --BIND변수라고한다(지역변수를)
IS
BEGIN 
    FOR REC IN (SELECT MEM_NAME, MEM_MILEAGE               
                FROM MEMBER
                WHERE   1 =1
                and MEM_JOB=P_JOB) --변수로 접근
    LOOP 
    DBMS_OUTPUT.PUT_LINE(REC.MEM_NAME||','|| REC.MEM_MILEAGE);
    END LOOP;
END; --컴파일해서 오라클 서버에 캐시메모리에 넣어둔다. 이름만 호출하면 바로 실행이 된다. 
-------------------------------------------------------------------------------------------------
--호출하기
EXEC PROD_GETMEMLIST('학생');









*/