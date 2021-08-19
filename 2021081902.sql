20210819-02
4. 기타연산자
1) BETWEEN
 - 범위를 지정할 때 사용되는 연산자
 - 사용할 수 있는 타입은 오라클에서 사용되는 모든 타입 허용
 (사용형식)
 컬럼명 BETWEEN 값1 AND 값2 --관계연산자와  AND로 대체 가능
 
 사용예) 사원테이블에서 급여가 5000미만이면 '저임금 사원', 5000-14999이면 '평균 임금 사원', 그 이상이면 '고 임금 사원'을 
 사원번호, 사원명, 부서코드. 급여값과 함께 비고란에 출력하시오.
 
 SELECT  EMPLOYEE_ID AS 사원번호, 
         EMP_NAME AS 사원명, 
         DEPARTMENT_ID AS 부서코드, 
         SALARY AS 급여,  
         CASE WHEN SALARY<5000 THEN '저임금 사원'
              WHEN SALARY BETWEEN 5000 AND 14999 THEN '평균 임금 사원'
              ELSE '고 임금 사원'
         END AS 비고
 FROM    HR.EMPLOYEES
 ORDER BY 3;
 
 사용예) 회원테이블에서 여성회원이면서 마일리지가 5000이상인 회원의 회원번호, 회원명, 직업, 마일리지를 출력하시오.
        단, 마일리지가 많은 회원부터 출력하시오.
        
    SELECT
    mem_id 회원번호,
    mem_name 회원명,
    mem_job 직업,
    mem_mileage 마일리지
FROM
    oyk93.member
WHERE
    (
        substr(mem_regno2,1,1) = '2'
        OR    substr(mem_regno2,1,1) = '4'
    ) --타입을 맞춰주기, NOT AND OR 순서대로 연산
    AND   mem_mileage >= 5000
ORDER BY
    4 DESC;
        --CASE AND THEN 은 SELECT 절에서 어떤 컬럼을 비교해서 컬럼에 없는 내용을 출력할 때 사용
  
2) LIKE 연산자
 - 패턴비교 연산자
 - 문자열 비교 연산자(숫자나 날짜타이은 사용하지 말것)
 - '%','_'패턴을 구성할때 사용되는 와일드카드
  (1) %
   .'%'이 사용된 위치에서 그 이후에 사용된 모든 문자열과 대응
   .EX) '김%' : '김'으로 시작하는 모든 단어(문자열)과 대응
        '%김' : '김'으로 끝나는 모든 단어(문자열)과 대응
  (2) _
   .'_'이 사용된 위치에서 한글자와 대응
   .EX) '김_' : '김'으로 시작하고 2글자로 구성된 문자열과 대응
        '_김' : '김'으로 끝나고 2글자로 구성된 문자열과 대응
   (사용형식)
   EXPR LIKE 패턴문자열 --EXPR 컬럼명 OR 계산식 참/거짓
   
    SELECT *FROM OYK93.MEMBER
    WHERE MEM_NAME
    LIKE '이%';
    
사용예) 상품테이블에서 '삼보컴퓨터'('P10102')에서 거래하는 제품정보를 조회하시오.
ALIAS는 상품코드, 상품명, 매입단가, 매출단가

SELECT PROD_ID 상품코드, PROD_NAME 상품명, PROD_COST 매입단가, PROD_PRICE 매출단가
FROM OYK93.PROD
WHERE PROD_NAME LIKE '삼보컴퓨터%';

사용예) 2005년 6월 판매정보를 조회하시오. 일자,상품명,수량,단가,금액이며 날짜순으로 출력하시오.
SELECT
    TO_DATE(substr(a.cart_no,1,8)) 일자,
    b.prod_name 상품명,
    a.cart_qty 수량,
    b.prod_price 단가,
    a.cart_qty * b.prod_price 금액
FROM
    cart a,
    prod b
WHERE
    a.cart_prod = b.prod_id --조인조건 단가와 상품명을 가져오기 위해서는 같아야된다
--AND SUBSTR(A.CART_NO,1,6)='200506'
    AND   a.cart_no LIKE '200506%' --성능면에서는 LIKE는 딸린다. 자료가 많으면 SUBSTR과 같이 정확하게 지시해주는게 좋다
ORDER BY
    1;

사용예) 회원테이블에서 회원들의 거주지가 '서울'인 회원의 회원번호, 회원명, 성별, 나이, 마일리지를 출력하시오.
SELECT
    mem_id AS 회원번호,
    mem_name AS 회원명,
    CASE
            WHEN (
                substr(mem_regno2,1,1) = '2'
                OR substr(mem_regno2,1,1) = '4'
            ) THEN 'F'
            ELSE 'M'
        END
    AS 성별,
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM mem_bir) AS 나이,
    mem_mileage AS 마일리지
FROM
    member
WHERE
    mem_add1 LIKE '서울%';

사용예) 상품테이블에서 상품명에 '삼성'이라는 단어가 포함된 모든 상품을 조회하시오.
ALIAS는 상품코드, 상품명, 거래처코드, 분류코드이다.

SELECT PROD_ID AS 상품코드, 
       PROD_NAME AS 상품명, 
       PROD_BUYER AS 거래처코드, 
       PROD_LGU AS 분류코드
FROM PROD
WHERE PROD_NAME LIKE '%삼성%'; --문자열 비교에만 쓰자

3)IN 연산자
 - 주어진 표현식의 값이 제시된 값들 중 어느 하나와 일치하면 전체 조건이 참인 연산자
 - 제시되는 값이 연속적인 경우에는 보통 BETWEEN을 사용하고, 불연속적이거나 일정한 규칙이
   없는 값인 경우 IN연산자를 사용
 - 'OR' 연산자, '관계연산자ANY(SOME)'으로 치환 가능
 --ANY연산자는 SOME은 똑같다 IN도 비슷하다(어느 한값만 참이면 참이다=OR)
 표현식 IN(값1[,값2,...값N])
 
 사용예) 사원테이블에서 부서번호 30,90,110번에 속한 사원정보를 조회하시오
 ALIAS는 EMPLOYEE_ID 사원번호, EMP_NAME 사원명 , DEPARTMENT_ID부서번호, HIRE_DATE 입사일, JOB_ID 직무코드
--OR연산자
SELECT EMPLOYEE_ID 사원번호, 
       EMP_NAME 사원명 , 
       DEPARTMENT_ID 부서번호, 
       HIRE_DATE 입사일, 
       JOB_ID 직무코드
FROM EMPLOYEES
WHERE DEPARTMENT_ID=30 OR DEPARTMENT_ID=90 OR DEPARTMENT_ID=110
ORDER BY 3;
--IN연산자
SELECT EMPLOYEE_ID 사원번호, 
       EMP_NAME 사원명 , 
       DEPARTMENT_ID 부서번호, 
       HIRE_DATE 입사일, 
       JOB_ID 직무코드
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(30, 90, 110)
ORDER BY 3;
--ANY 또는 SOME
SELECT EMPLOYEE_ID 사원번호, 
       EMP_NAME 사원명 , 
       DEPARTMENT_ID 부서번호, 
       HIRE_DATE 입사일, 
       JOB_ID 직무코드
FROM EMPLOYEES
WHERE DEPARTMENT_ID=ANY (30, 90, 110)
ORDER BY 3;

 사용예) 사원테이블에서 부서번호 30,90,110번 이외의 부서에 속한 사원정보를 조회하시오
 ALIAS는 EMPLOYEE_ID 사원번호, EMP_NAME 사원명 , DEPARTMENT_ID부서번호, HIRE_DATE 입사일, JOB_ID 직무코드

SELECT EMPLOYEE_ID 사원번호, 
       EMP_NAME 사원명 , 
       DEPARTMENT_ID 부서번호, 
       HIRE_DATE 입사일, 
       JOB_ID 직무코드
FROM EMPLOYEES
WHERE DEPARTMENT_ID NOT IN(30, 90, 110)
ORDER BY 3;

SELECT EMPLOYEE_ID 사원번호, 
       EMP_NAME 사원명 , 
       DEPARTMENT_ID 부서번호, 
       HIRE_DATE 입사일, 
       JOB_ID 직무코드
FROM EMPLOYEES
WHERE NOT DEPARTMENT_ID=ANY (30, 90, 110) --NOT은 웨어 뒤에 붙여야 된다.
ORDER BY 3;

4) EXISTS 연산자
- EXISTS 다음에 기술된 값의 결과가 존재하면 참을 결과값이 없으면 거짓을 반환함
- EXISTS 다음은 반드시 서브쿼리가 기술되어야함

(사용형식)
WHERE EXISTS (서브쿼리) --있는지 없는지만 따진다. NULL이면 거짓이다. 한행이라도 있으면 전체가 참이된다.

사용예) 소속부서의 평균급여보다 많은 급여를 지급받는 사원들이 존재하는 부서의 부서번호,부서명을 출력하시오
SELECT
    a.department_id 부서번호,
    a.department_name 부서명
FROM
    hr.departments a
WHERE
    EXISTS (
        SELECT
            1 --숫자 1을 출력 (조건을 만족하면), 행이존재유무만 파악하기 때문에, 아무의미 없는 자료,이중중첩된 쿼리, FROM WHERE이 어디 SELECT절에 속하는지 구별을 위해 들여쓰기를 잘하자
        FROM
            hr.employees b
        WHERE
            b.salary > (
                SELECT
                    AVG(c.salary)
                FROM
                    hr.employees c
                WHERE
                    b.department_id = c.department_id
            )b.department_id = a.department_id
    );                                                    
            AND                                      

** 문자열 연산자 '||'
-두 문자열을 결합하여 하나의 문자열을 반환                                                                                                                                                                                                                                                                                   


        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        