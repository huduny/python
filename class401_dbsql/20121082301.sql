2012-08-23-01
9) INSTR(c1, c2[,m[,n]]) --index of string, 주어진 문자열에서 특정 문자가 나타난 위치값,자바에는 charAt() 주어진 문자열에서 문자 반환
    - 주어진 문자열 c1에서 c2문자가 처음 나타나는 위치값(인덱스)을 반환, m은 검색 시작위치 값이고, n은 반복횟수를 정의
    - M과N이 생략되면 처음 나온 위치를 말해준다.

사용예) 
    SELECT  TRIM(INSTR('APPLEPERSIMONBANNAORANGE','A')) A,
            TRIM(INSTR('APPLEPERSIMONBANNAORANGE','A',5)) B,
            TRIM(INSTR('APPLEPERSIMONBANNAORANGE','A',1,2)) C,
            TRIM(INSTR('APPLEPERSIMONBANNAORANGE','A',10,2)) D
    FROM    DUAL;
    
10) LENGTH(c1), LENGTHB(C1)
    -LENGTH(c1) : C1에 포함된 글자수 반환
    -LENGTHB(C1) : C1에 포함된 데이터의 길이(BYTE) 반환
    
사용예)
    SELECT  MEM_ADD1 주소,
            LENGTH(MEM_ADD1) 글자수,
            LTRIM(LENGTHB(MEM_ADD1)) "기억 공간의 크기"
    FROM MEMBER;
    --에러메세지 FROM KEYWORD가 나오면 FROM 절이 잘못 된게 아니라 SELECT 절에 잘못이 없는지 확인 해보자.
    
    SELECT  EMP_NAME 사원명,
            LENGTH(EMP_NAME) 글자수,
            LENGTHB(EMP_NAME) "기억장소 크기"
    FROM    HR.EMPLOYEES
    WHERE   DEPARTMENT_ID=80;

2. 숫자함수
    1) 수학적함수
        - ABS(N), SIGN(N), SQRT(N), POWER(N,E), ...
        (1) ABS(N)
            .N의 절대값 반환 --편차를 구할때 사용
        (2) SIGN(N)
            .N의 부호에 따라 -1, 0, 1을 반환
            .N>0 이면 N의 크기에 관계없이 1을 반환
            .N<0 이면 N의 크기에 관계없이 -1을 반환
            .N=0 이면 N의 크기에 관계없이 0을 반환
        (3) SQRT(N)
            .N의 평방근 값을 반환 --부동산 매물, 전세 어플을 만든다. 405호 공부한 친구가 상권 분석을 할 수 있는 프로젝트, 상권 분석을 위해서는 인구+정보
            --가서 조사할 수 없다. 입지조건을 자동으로 계산, 유동인구가 많아야 되고, 젊은 사람이 많아야된다, 여성인구가 많아야 된다. 공공데이터
            --주택공사에서 각각의 지역마다 실거래 가격을 공개
            --인공지능 부분에서 강화학습을 이용하면 자기학습을 시킬수 있다
        (4) POWER(N,E)
            .N을 E번 거듭곱한 값(즉 N의 E승)
사용예)
    SELECT  ABS(-290) A,
            ABS(-0.0093) B,
            SIGN(100000) C,
            SIGN(0.000001) D,
            SIGN(-290) E,
            SIGN(0) F,
            SQRT(77) G,
            POWER(2,10) H
    FROM    DUAL;
    
    2) GREATEST(N1,N2,[,N3,...]), LEAST(N1,N2,[,N3,...])
    - GREATEST(N1,N2,[,N3,...]): 주어진 값 N1~NM중 가장 큰 값을 반환
    - LEAST(N1,N2,[,N3,...]): 주어진 값 N1~NM중 가장 작은 값을 반환
    --MAX와 MINIMUM은 알지 못하는 값을 구할때 사용, 그룹을 묶고 사용할 때도
    --GREATEST와 LEAST 알고 있는 값 중에
사용예)
    SELECT  PROD_ID,
            PROD_NAME,
            GREATEST(PROD_SALE,PROD_PRICE,PROD_COST) 큰값
    FROM    PROD;        
--종(컬럼)으로 주어졌을때 MAX를 쓴다, GREATEST는 나열된 값에서 가장 큰 값을

    SELECT  MAX(PROD_SALE),
            MAX(PROD_PRICE),
            MAX(PROD_COST)
    FROM    PROD;
    
사용예) GREATEST 함수를 사용하여 사원테이블에서 급여가 2500미만인 사원의 급여를 2500으로 변환하는 SQL를 작성하시오
       ALIAS는 사원번호, 사원명, 원급여, 변경급여
    SELECT  EMPLOYEE_ID 사원번호, 
            EMP_NAME 사원명, 
            SALARY 원급여,
            GREATEST(SALARY, 2500) 변경급여 
    FROM    EMPLOYEES
    WHERE   SALARY < 2500;

    SELECT LEAST('대전시','대천시','천안시','보령시') FROM DUAL;
    --첫글자를 가지고 ASCII값으로 가지고 작은 값을 비교한다.
    
    3) ROUND(N,L), TRUNC(N,L)
        - L이 양수인 경우
        .ROUND: 주어진 수 N에서 소숫점 이하 L+1번째 자리에서 반올림하여 L자리까지 반환
        .TRUNC: 주어진 수 N에서 소숫점 이하 L+1번째 자리에서 절삭하여(자리버림) L자리까지 반환
        - L이 음수인 경우
        .ROUND: 주어진 수 N에서 정수부분 L번째 자리에서 반올림한 결과를 반환
        .TRUNC: 주어진 수 N에서 정수부분 L번째 자리에서 절삭한 결과를 반환
        - L이 생략되면 0으로 간주
        -- 374.456789// ROUND ,2면 300 TRUNC ,2면 200// ROUN , 이면 소수점을 없앤다.
        
사용예) 사원테이블에서 사원들의 지급될 급여를 계산하여 출력하시오. 지급액=급여+보너스-세금. 보너스=급여의 17%. 세금=(급여+보너스)의 6%.
       지급액은 소숫1자리까지 반올림하여 출력하시오
       ALIAS는 사원번호, 입사일, 직무코드, 급여, 보너스, 세금, 지급액
    SELECT  EMPLOYEE_ID 사원번호, 
            HIRE_DATE 입사일, 
            JOB_ID 직무코드,
            SALARY  급여, 
            (SALARY*0.17) 보너스, 
            ROUND((SALARY+SALARY*0.17)*0.06,1) 세금,
           -- ROUND(((SALARY+(SALARY*0.17))-((SALARY+SALARY*0.17)*0.06)),1) 지급액
            TO_CHAR(((SALARY+(SALARY*0.17))-((SALARY+SALARY*0.17)*0.06)),'999,999.0') 지급액
           -- CHAR를 쓰면 + - / *를 더이상 사용할 수 없다.
    FROM    EMPLOYEES; 
   
사용예) 2005년 7월 매출현황을 출력하시오
        출력할 내용은 CART_NO 날짜, 회원명, 제품명, CART_QTY 수량, 금액이며 금액은 십단위에서 절삭하여 출력하시오
        
    SELECT  SUBSTR(A.CART_NO,1,8) 날짜, 
            B.MEM_NAME 회원명, 
            C.PROD_NAME 제품명, 
            A.CART_QTY 수량, 
            A.CART_QTY*C.PROD_PRICE 금액,
           TRUNC(A.CART_QTY*C.PROD_PRICE, -2) 금액1
    FROM    CART A, MEMBER B, PROD C
    WHERE   A.CART_NO LIKE '200507%'
    AND     A.CART_MEMBER=B.MEM_ID
    AND     A.CART_PROD=C.PROD_ID
    ORDER BY 1;
    
4) FLOOR(N), CEIL(N)
    -FLOOR(N): N과 같거나 N보다 작은 수 중 가장 큰 정수 --작은쪽으로 가까운쪽
    -CEIL(N): N과 같거나 N보다 큰 수 중 가장 작은 정수를 반환하는 함수로 급여, 세금과 같은 금액 처리에 주로 사용 --큰쪽으로 가까운쪽
    
사용예) SELECT   FLOOR(268.2345),
                FLOOR(-268.2345),
                CEIL(268.2345),
                CEIL(-268.2345)
       FROM     DUAL;
    -- MOD REMINDER 나머지 구하는 연산
        
5) MOD(N1,N2), REMAINDER(N1,N2)
    -N1을 N2로 나눈 나머지를 반환
    -두 함수는 내부적으로 구현 방법이 다르다
    -REMAINDER는 나머지가 젯수의 50%이상의 값이 되었을 때 그 다음 몫에서 차감할 값을 구함 (피젯수N1:나누기를 당하는 수,젯수N2:나누는 수)
    -MOD(N1,N2)=N1-N2*FLOOR(N1/N2)
    -REMAINDER(N1,N2)=N1-N2*ROUND(N1/N2)
    
    EX) MOD(26,7) = 26-7*FLOOR(26/7)
                  = 26-7*FLOOR(3.7143)
                  = 26-7*3
                  = 26-21
                  = 5
        REMAINDER(26,7) = 26-7*ROUND(26/7)
                        = 26-7*ROUND(3.7143)
                        = 26-7*4
                        = -2
    SELECT MOD(26,7), REMAINDER(26,7) FROM DUAL;
        
6) WIDTH_BUCKET(N,MIN,MAX,B)
    - MIN에서 MAX까지의 수를 B개의 구간으로 나누었을때 주어진 수 N이 그 구간 중 어느 구간에 포함되는지를 반환

사용예) 사원테이블에서 급여를 10개의 구간으로 나누고 각 사원이 어느 구간에 포함되는지를 조회하시오.
       ALIAS는 사원번호, 사원명, 급여, 구간값

    SELECT  EMPLOYEE_ID 사원번호, 
            EMP_NAME 사원명, 
            SALARY 급여, 
            WIDTH_BUCKET(SALARY, 2000,25000, 10) 구간값 --상한값하고 값이 같으면 구간을 넘어서게 된다. 하한값은 포함이 된다.
    FROM    EMPLOYEES;
        
사용예) 회원테이블에서 회원의 마일리지가 1000-9000 구간을 10개로 구분할때 어느 구간에 속하는지를 구하고 그 구간값을 등급란에 출력하시오.
        단, 마일리지가 많은 사람은 작은 등급을 부여하시오
        ALIAS는 회원번호, 회원명, 마일리지, 등급
        SELECT  MEM_ID 회원번호, 
                MEM_NAME 회원명, 
                MEM_MILEAGE 마일리지, 
                WIDTH_BUCKET(MEM_MILEAGE, 9000, 999, 10) 등급
        FROM    MEMBER;
    

