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




































































    
