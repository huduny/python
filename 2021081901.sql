20210819-01
3. 논리연산자
    - 복수개(2개)의 조건들을 결합할 때 사용
    - not, and, or
    - 우선순위는 : NOT AND OR 순이다.
    ---------------------------------
    입력             |  출력(AND)  출력(OR)
    A       B       |
    ---------------------------------
    0       0       |    0        0
    0       1       |    0        1
    1       0       |    0        1
    1       1       |    1        1
    
    --지우개 툴은 AND연산 채우기 툴은 OR연산 사용
    --AND는 논리곱 OR는 논리합이다.
                    
    사용예) 사원테이블에서 근무지가 미국이고 급여가 8000이상인 사원의 사원번호, 사원명, 부서번호, 급여를 출력하시오
    SELECT A.EMPLOYEE_ID 사원번호, 
           A.EMP_NAME 사원명, 
           B.DEPARTMENT_ID 부서번호, 
           A.SALARY 급여
    FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C
   WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
     AND C.COUNTRY_ID='US'
     AND B.LOCATION_ID=C.LOCATION_ID
     AND A.SALARY>=8000
 ORDER BY 3; --3번째 순서로
 
 SELECT * FROM EMPLOYEES;
    --DEPARTMENT_ID=DEPARTMENT_ID하면 EMPLOYEES껀지 DEPARTEMENTS꺼인지 알수 없어서 오류가 뜬다. 그래서 소속을 나타내야 한다.
    
    사용예) 2005년 1-3월 제품별 매입현황을 조회하시오
    ALIAS는 제품코드,매입수량,매입금액
    --같은건 합해서 노출할거면 그룹바이
    
    SELECT BUY_PROD 제품코드,
           SUM(BUY_QTY) 매입수량,
           SUM(BUY_QTY*BUY_COST) 매입금액
    FROM   BUYPROD
    WHERE  BUY_DATE >= TO_DATE('20050101') AND BUY_DATE <= TO_DATE('20050331')
    -- BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050331') BETWEEN연산자 A와 B 사이에 구간을 정할때 쓴다
    GROUP BY BUY_PROD;
    
    --날짜 문자 타입 구분해야된다. SUBSTR는 문자열 함수
    --IN ANY SUM연산자를 사용하여 날짜를 뽑을 수 있다.