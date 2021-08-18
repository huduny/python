2021-08-18-01)검색명령(SELECT 문)
2021-08-18-01)검색명령(SELECT 문)
    -자료 검색기능 수행
    -SELECT절, FROM절, WHERE절(조건기술) 등으로 구성
    -SELECT절: 결과로 출력되어야 할 컬럼 정의
        .컬럼명, 산술식(+-*/), 함수(문자,날짜,집계,형변환 등)(문자열과 숫자상수), 상수 등으로 기술
        .수행순서가 가장 늦다    
    -FROM절: 테이블(뷰) 정의
        .수행순서가 가장 빠르다
    -WHERE절: 조건(일반조건, 조인조건)을 기술
        .FROM다음 SELECT절 보다 앞선 실행 순서
        .SELECT절에서 정의된 컨럼별칭 등을 참조할 수 없다
        .WHERE절은 연산에 참여할 행을 정의
    1. 산술연산자
    -사칙연산자('+','-','/','*')와 '()'로 구성
    사용예) 사원테이블에서 각 사원의 보너스를 계산하여 출력하시오
        보너스=급여*영업실적코드(COMMISSION_PCT)*25%
        지급액=급여+보너스
        Alias는 사원번호, 사원명,급여,보너스,지급액이다
        --표준 SQL은 변수가 없다 구조적 언어여서 반복문도 못쓴다. 
    SELECT EMPLOYEE_ID AS 사원번호,
           EMP_NAME AS 사원명,
           SALARY AS 급여,
           COMMISSION_PCT AS 영업실적코드,
        --데이터베이스가 가지고 있는 단점 NULL이 나오는데 자바에는 전역변수 같은 경우에는 변수를 선언하고 쓰지 않으면 기본초기화 된다. 
        --오라클은 무조건 없으면 NULL로 취급한다. NULL값과 사칙연산한 것들은 결과가 다 NULL이 된다.
        --NULL을 없애는 함수 NVL(값,0)이면 NULL이면 0로 표시
           NVL((SALARY * COMMISSION_PCT * 0.25),0) AS 보너스,
           SALARY + NVL((SALARY * COMMISSION_PCT * 0.25),0) AS 지급액
    FROM HR.EMPLOYEES;
        --조건을 나타내는 것이 없어서 WHERE절을 사용할 필요가 없다
    사용예2)회원테이블에서 회원의 주민등록번호 앞자리 6자리를 이용하여 나이를 계산하여 출력하시오
    ALIAS는 회원번호, 회원명, 주민등록번호, 나이, 마일리지 --LGU(분류코드)local government unit 
    SELECT MEM_ID 회원번호, MEM_NAME 회원명, MEM_REGNO1주민등록번호, 나이, MEM_MILEAGE마일리지
        --이름을 함부로 바꾸면 안된다. 외래키를 사용할때 특히
        --PRICE매출 COST매입단가, 데이터가 일관성을 잃어버리는 요인은 데이터 중복이다. BUY_COST는 BUYPROB에는 없어도 되는 것이다.
        --관계형 데이터베이스에서는 중복을 최소화 시켜야된다.
        --CART_NO카트 번호(연월일 8자리+5자리번호), PRICE*CART_QTY를 해야 지불가격을 알 수 있다, 분류해서 저장하는 것은(정규화)시킨다고 한다(이상현상이 발생하지 않도록)
        --CART는 부모가 MEMBER와PROD 두개이다, 행위테이블(행위에 의해서 결과가 축척되는 것)
        --LPROD는 분류 테이블이다, 매출 집계를 분석하기 위한 것이다, ID(코드) 예외는(단순 순번)일수도 있다. GU(분류코드) NM(분류명)
        --REGNO1(주민번호), ADD1(기본주소)ADD2(상세주소)LIKE(취미)MEMORIAL(기념일종류)DELETE(활동,휴면,탈퇴)
        --OUTLINE(개요), TOTALSTOCK(실제 재고), PROPERSTOCK(적정 재고), UNIT(단위)
        ID NAME LGU BUYER COST PRICE
    사용예2)회원테이블에서 회원의 주민등록번호 앞자리 6자리를 이용하여 나이를 계산하여 출력하시오
    ALIAS는 회원번호, 회원명, 주민등록번호, 나이, 마일리지 --LGU(분류코드)local government unit 
    
    SELECT MEM_ID "회원 번호", 
           MEM_NAME 회원명,  
           MEM_REGNO1||'-'||MEM_REGNO2 주민등록 번호, --||자바의 문자열 붙이는 기능과 같다
           EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2)) 나이, --1번째에서 두번째 글짜 뽑아내기) EXTRACT뽑아내다 뽑은 값은 숫자로 취급
          MEM_MILEAGE 마일리지 --공백이나 명령문을 별칭으로 쓸때는 꼭 쌍따움표
    FROM MEMBER;

**MEMBER 테이블 내용 중 일부 자룔를 변경하시오
    1)회원번호: 'M001'
      MEM_BIR: 1975/03/15 => 2001/03/15
      MEM_REGNO1: 750315 => 010315
      MEM_REGNO2: 255555 => 4555555
    UPDATE MEMBER
    SET    MEM_BIR = TO_DATE('20010315'),
           MEM_REGNO1 = '010315',
           MEM_REGNO2 = '4555555'
    WHERE  MEM_ID=LOWER('MOO1');

    1)회원번호: 't001'
      MEM_BIR: 1976/05/06 => 2000/05/06
      MEM_REGNO1: 760506 => 000506
      MEM_REGNO2: 1454731 => 3454731
    UPDATE MEMBER
    SET    MEM_BIR = TO_DATE('20000506'),
           MEM_REGNO1 = '000506',
           MEM_REGNO2 = '3454731'
    WHERE  MEM_ID = LOWER('TOO1');

    1)회원번호: 'd001'
      MEM_BIR: 1946/04/09 => 2008/04/09
      MEM_REGNO1: 460409 => 080409
      MEM_REGNO2: 1454731 => 3454731
    UPDATE MEMBER
    SET    MEM_BIR = TO_DATE('20080409'),
           MEM_REGNO1 = '080409',
           MEM_REGNO2 = '3454731'
    WHERE  MEM_ID = LOWER('M001');
    
    
    -자료 검색기능 수행
    -SELECT절, FROM절, WHERE절(조건기술) 등으로 구성
    -SELECT절: 결과로 출력되어야 할 컬럼 정의
        .컬럼명, 산술식(+-*/), 함수(문자,날짜,집계,형변환 등)(문자열과 숫자상수), 상수 등으로 기술
        .수행순서가 가장 늦다    
    -FROM절: 테이블(뷰) 정의
        .수행순서가 가장 빠르다
    -WHERE절: 조건(일반조건, 조인조건)을 기술
        .FROM다음 SELECT절 보다 앞선 실행 순서
        .SELECT절에서 정의된 컨럼별칭 등을 참조할 수 없다
        .WHERE절은 연산에 참여할 행을 정의
    1. 산술연산자
    -사칙연산자('+','-','/','*')와 '()'로 구성
    사용예) 사원테이블에서 각 사원의 보너스를 계산하여 출력하시오
        보너스=급여*영업실적코드(COMMISSION_PCT)*25%
        지급액=급여+보너스
        Alias는 사원번호, 사원명,급여,보너스,지급액이다
        --표준 SQL은 변수가 없다 구조적 언어여서 반복문도 못쓴다. 
    SELECT EMPLOYEE_ID AS 사원번호,
           EMP_NAME AS 사원명,
           SALARY AS 급여,
           COMMISSION_PCT AS 영업실적코드,
        --데이터베이스가 가지고 있는 단점 NULL이 나오는데 자바에는 전역변수 같은 경우에는 변수를 선언하고 쓰지 않으면 기본초기화 된다. 
        --오라클은 무조건 없으면 NULL로 취급한다. NULL값과 사칙연산한 것들은 결과가 다 NULL이 된다.
        --NULL을 없애는 함수 NVL(값,0)이면 NULL이면 0로 표시
           NVL((SALARY * COMMISSION_PCT * 0.25),0) AS 보너스,
           SALARY + NVL((SALARY * COMMISSION_PCT * 0.25),0) AS 지급액
    FROM HR.EMPLOYEES;
        --조건을 나타내는 것이 없어서 WHERE절을 사용할 필요가 없다
    사용예2)회원테이블에서 회원의 주민등록번호 앞자리 6자리를 이용하여 나이를 계산하여 출력하시오
    ALIAS는 회원번호, 회원명, 주민등록번호, 나이, 마일리지 --LGU(분류코드)local government unit 
    SELECT MEM_ID 회원번호, MEM_NAME 회원명, MEM_REGNO1주민등록번호, 나이, MEM_MILEAGE마일리지
        --이름을 함부로 바꾸면 안된다. 외래키를 사용할때 특히
        --PRICE매출 COST매입단가, 데이터가 일관성을 잃어버리는 요인은 데이터 중복이다. BUY_COST는 BUYPROB에는 없어도 되는 것이다.
        --관계형 데이터베이스에서는 중복을 최소화 시켜야된다.
        --CART_NO카트 번호(연월일 8자리+5자리번호), PRICE*CART_QTY를 해야 지불가격을 알 수 있다, 분류해서 저장하는 것은(정규화)시킨다고 한다(이상현상이 발생하지 않도록)
        --CART는 부모가 MEMBER와PROD 두개이다, 행위테이블(행위에 의해서 결과가 축척되는 것)
        --LPROD는 분류 테이블이다, 매출 집계를 분석하기 위한 것이다, ID(코드) 예외는(단순 순번)일수도 있다. GU(분류코드) NM(분류명)
        --REGNO1(주민번호), ADD1(기본주소)ADD2(상세주소)LIKE(취미)MEMORIAL(기념일종류)DELETE(활동,휴면,탈퇴)
        --OUTLINE(개요), TOTALSTOCK(실제 재고), PROPERSTOCK(적정 재고), UNIT(단위)
        ID NAME LGU BUYER COST PRICE
    사용예2)회원테이블에서 회원의 주민등록번호 앞자리 6자리를 이용하여 나이를 계산하여 출력하시오
    ALIAS는 회원번호, 회원명, 주민등록번호, 나이, 마일리지 --LGU(분류코드)local government unit 
    
    SELECT MEM_ID "회원 번호", 
           MEM_NAME 회원명,  
           MEM_REGNO1||'-'||MEM_REGNO2 주민등록 번호, --||자바의 문자열 붙이는 기능과 같다
           EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2)) 나이, --1번째에서 두번째 글짜 뽑아내기) EXTRACT뽑아내다 뽑은 값은 숫자로 취급
          MEM_MILEAGE 마일리지 --공백이나 명령문을 별칭으로 쓸때는 꼭 쌍따움표
    FROM MEMBER;

**MEMBER 테이블 내용 중 일부 자룔를 변경하시오
    1)회원번호: 'M001'
      MEM_BIR: 1975/03/15 => 2001/03/15
      MEM_REGNO1: 750315 => 010315
      MEM_REGNO2: 255555 => 4555555
    UPDATE MEMBER
    SET    MEM_BIR = TO_DATE('20010315'),
           MEM_REGNO1 = '010315',
           MEM_REGNO2 = '4555555'
    WHERE  MEM_ID=LOWER('MOO1');

    1)회원번호: 't001'
      MEM_BIR: 1976/05/06 => 2000/05/06
      MEM_REGNO1: 760506 => 000506
      MEM_REGNO2: 1454731 => 3454731
    UPDATE MEMBER
    SET    MEM_BIR = TO_DATE('20000506'),
           MEM_REGNO1 = '000506',
           MEM_REGNO2 = '3454731'
    WHERE  MEM_ID = LOWER('TOO1');

    1)회원번호: 'd001'
      MEM_BIR: 1946/04/09 => 2008/04/09
      MEM_REGNO1: 460409 => 080409
      MEM_REGNO2: 1454731 => 3454731
    UPDATE MEMBER
    SET    MEM_BIR = TO_DATE('20080409'),
           MEM_REGNO1 = '080409',
           MEM_REGNO2 = '3454731'
    WHERE  MEM_ID = LOWER('M001');
    
    
        SELECT MEM_ID "회원 번호", 
           MEM_NAME AS 회원명,  
           MEM_REGNO1||'-'||MEM_REGNO2 AS "주민등록 번호", --||자바의 문자열 붙이는 기능과 같다, ""는 문자열에 공백이 있으면 꼭 쓰기
           CASE WHEN SUBSTR(MEM_REGNO2,1,1)=3 OR
                     SUBSTR(MEM_REGNO2,1,1)=4 THEN
                 EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER('20'||SUBSTR(MEM_REGNO1,1,2))  --1번째에서 두번째 글짜 뽑아내기) EXTRACT뽑아내다 뽑은 값은 숫자로 취급
            ELSE
                 EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2)) 
            END AS 나이,
          MEM_MILEAGE 마일리지 --공백이나 명령문을 별칭으로 쓸때는 꼭 쌍따움표
          FROM MEMBER;
          
    사용예2)회원테이블에서 회원의 주민등록번호 앞자리 6자리를 이용하여 나이를 계산하여 연령대를 출력하시오.
    ALIAS는 회원번호, 회원명, 주민번호, 연령대, 마일리지이다.
    10~19 10대, 20~29 20대, 30~39 30대
     SELECT MEM_ID "회원 번호", 
            MEM_NAME AS 회원명,  
            MEM_REGNO1||'-'||MEM_REGNO2 AS "주민등록 번호", --||자바의 문자열 붙이는 기능과 같다, ""는 문자열에 공백이 있으면 꼭 쓰기
            CASE WHEN SUBSTR(MEM_REGNO2,1,1)=3 OR
                     SUBSTR(MEM_REGNO2,1,1)=4 THEN
                  EXTRACT(YEAR FROM SYSDATE) - 
                    TO_NUMBER('20'||SUBSTR(MEM_REGNO1,1,2))  --1번째에서 두번째 글짜 뽑아내기) EXTRACT뽑아내다 뽑은 값은 숫자로 취급
             ELSE
                  EXTRACT(YEAR FROM SYSDATE) - 
                    TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2)) 
            END 나이,
            TRUNC(CASE WHEN SUBSTR(MEM_REGNO2,1,1)=3 OR
                     SUBSTR(MEM_REGNO2,1,1)=4 THEN
                  EXTRACT(YEAR FROM SYSDATE) - 
                    TO_NUMBER('20'||SUBSTR(MEM_REGNO1,1,2))  --1번째에서 두번째 글짜 뽑아내기) EXTRACT뽑아내다 뽑은 값은 숫자로 취급
             ELSE
                  EXTRACT(YEAR FROM SYSDATE) - 
                    TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2)) 
            END,-1)||'대' AS 연령대,
            MEM_MILEAGE 마일리지 --공백이나 명령문을 별칭으로 쓸때는 꼭 쌍따움표
     FROM MEMBER;
     --TRUNC함수(값,-1)는 절삭이다. 무조건 그자리에서 버림을 해준다. -1의자리는 1의 자리를 무조건 버려라
     --ROUND는 반올림이 되는데 TRUNC는 무조건 버린다
     
     2.관계연산자(OPERAND피연산자 OPERATION연산자)
     -데이터의 크기를 비교하여 참과 거짓을 반환
     ->,<,>=,<=,=,<>(!=)
     -보통 조건식 구성에 사용(WHERE절)--오라클에는 IF문이 없다, WHERE절에서 사용한다
     
     사용예)회원테이블에서 마일리지가 5000이상인 회원을 조회하여 회원번호, 회원명, 주소, 직업, 마일리지를 출력하시오
     SELECT MEM_ID 회원번호, 
            MEM_NAME 회원명, 
            MEM_ADD1||' '||MEM_ADD2 주소, 
            MEM_JOB 직업, 
            MEM_MILEAGE 마일리지
    FROM    MEMBER
    WHERE   MEM_MILEAGE >= 5000
    ORDER BY MEM_MILEAGE ASC; --오라클은 1번부터 카운트 엘리베이트를 10층에서 5층을 가면 내려간다 한다 따라서 내림차순, ASC오름차순
    --1번 프롬절에서 멤버테이블을 메인메모리에 가져오는데 2번 웨어졀로 필터링 3번 오더바이하고 4번으로 디스플레이 해준다
    
    사용예) 매입테이블(BUYPROD)에서 매입금액이 10만원 이하인 자료를 조회하시오
    ALIAS는 날짜, 상품코드, 매입수량, 단가, 금액이며 날짜순(큰값에서 작은값)으로 출력하시오
    SELECT BUY_DATE 날짜, 
           BUY_PROD 상품코드, 
           BUY_QTY 매입수량, 
           BUY_COST 단가, 
           (BUY_QTY*BUY_COST) 금액 
    FROM   BUYPROD
    WHERE  (BUY_QTY*BUY_COST) <= 100000
    ORDER BY BUY_DATE ASC; --컬럼 인덱스는 SELECT절의 해당 순서를 ORDERBY에 쓸수 있다, ASC는 기본이다. 생략되면 자동으로 적용된다
    --SELECT는 WHERE절보다 늦게 실행되서 WHERE에 5를 쓰면
    COMMIT;
    
    사용예)회원테이블에서 거주지가 '대전'인 회원을 조회하여 회원번호, 회원명, 주소, 핸드폰번호를 출력하시오.
    SELECT MEM_ID 회원번호, 
           MEM_NAME 회원명, 
           MEM_ADD1||' '||MEM_ADD2 주소, 
           MEM_HP 핸드폰번호
    FROM   MEMBER
    WHERE  SUBSTR(MEM_ADD1, 1,2) = '대전';
    --WHERE MEM_ADD1 LIKE '대전%';
    
    사용예) 매출테이블(CART)에서 회원별 5-7월 매출현황을 출력하시오
           조회할 내용은 회원번호, 회원명, 구매금액 이며 구매금액이 많은 회원부터 출력하시오
    SELECT A.CART_MEMBER 회원번호, 
           B.MEM_ID 회원명, 
           SUM(A.CART_QTY*C.PROD_PRICE) 구매금액 --SUM 한사용자가 구매한 상품코드와 가격을 더해주는데 그 회원거는 다 더해준다
      FROM CART A, MEMBER B,PROD C --테이블에 별명을 부여한 것이다(테이블 별칭)
     WHERE A.CART_MEMBER=B.MEM_ID
       AND A.CART_PROD=C.PROD_ID --조인조건, 테이블이 적어도 2개 이상 조인조건은 최소한 테이블-1개 만큼 써줘야된다.
       AND (SUBSTR(A.CART_NO,1,6)>='200505' AND SUBSTR(A.CART_NO,1,6)<='200507')
    GROUP BY A.CART_MEMBER, B.MEM_ID
    ORDER BY 3 DESC; --컬럼인덱스를 쓰자
           --SUM AVERAGE COUNT MINIMUM MAXIMUM 집계함수는 일반컬럼과 SELECT절에 있으면 WHERE절 다음에는 GROUP BY가 와야된다, GROUP BY에서 그룹할때는 SELECT 절에
           --일반 컬럼은 다써주고 SUM으로 묶인거는 안 써도 된다.
           --FROM절 실행후 WHERE절을 실행한다, GROUP BY로 회원번호가 같은 사람끼리 모은다, SELECT SUM을 실행한다. 
    
    
    
    
    
    
    
    
    
    
    