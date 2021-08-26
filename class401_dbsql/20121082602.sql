2021-08-26-02)

02)집계함수
    -데이터를 특정 컬럼을 기준으로 그룹화하고 각 그룹에서 데이터의 집계결과를 반환시키는 함수
    -다중행의 결과를 반환
    -SUM,AVG,COUNT,MAX,MIN 함수제공
    -집계함수는 중첩 사용할 수 없다,
    -SELECT절에 위의 집계함수 이외의 컬럼이 존재하면 반드시 GROUP BY 절이 기술되어야 하고,
    -GROUP BY 절에 집계함수 이외의 컬럼을 기술해야 함
    -집계함수에 조건이 부여된 경우 HAVING 절로 처리 해야함
    
(사용형식)
SELECT  COL1,
        SUM|AVG|MAX|MIN(CO1)|COUNT(*|CO1)[, ..
        
FROM    테이블명
[WHERE 조건]
[GROUP BY COL1[,COL2,...]]
[HAVING 조건]
[ORDER BY 컬럼|컬럼인덱스 [ASC|DESC][,컬럼|컬럼인덱스[ASC|DESC],...]]
--여러 행이 반환되는 것을 다중행 함수라고 한다. 집계함수를 제외하고는 단일행 함수이다.
--집계함수는 SELECT절을 잘 파악해야 된다.
--서브쿼리를 써야된다
--~별이 나오면 그룹바이로 묶어준다 제품별 판매수량 제품코드OR제품명 ~~~별에서 ~~~는 
월별 회원별//월 회원명 구매금액 합계//월이 같은 사람을 모으고, 월 그룹안에서 또 회원명별로 그룹핑을 한다
EX) GROUP BY CART_MEMBER, SUBSTR(CART_NO,1,6)//회원별로 모으고 회원별에서 다시 월별로 그룹핑을 한다
SELECT 절에 없어도 테이블안에 있다면 쓸수는 있으나 거의 안쓴다.

일반조건, 조인조건(테이블 2개이상), 집계함수에 조건이 부여되는 경우(WHERE절로 조건처리를 못해서) 이때 HAVING절을 사용한다.
테이블 전체가 하나가 전체 그룹일때는 그룹바이절이 생략 가능하다 즉 일반 컬럼이 하나도 없을때

1)SUM(EXPR)
-'EXPR'로 기술된 컬럼이나 수식의 합계를 반환

사용예) 사원테이블에서 부서번호 80번부서의 사원들의 급여합계를 조회하시오.
SELECT SUM(SALARY) AS 급여
FROM   HR.EMPLOYEES
WHERE  DEPARTMENT_ID=80;

사용예) 사원테이블에서 부서별 사원들의 급여합계를 조회하시오.
SELECT  DEPARTMENT_ID AS 부서코드,
        SUM(SALARY) AS 급여
FROM    HR.EMPLOYEES
GROUP BY DEPARTMENT_ID;
--전체집계 ROLLUP 큐브라는 함수

사용예) 2005년 1-3월 월별 매입수량 합계와 매입금액 합계를 조회하시오
SELECT      EXTRACT(MONTH FROM BUY_DATE) AS 월별,
            NVL(SUM(BUY_QTY),0) AS 매입수량합계,
            NVL(SUM(BUY_QTY*BUY_COST),0) AS "매입금액 합계" --별칭에 띄어쓰기 하지  말기
FROM        BUYPROD
--WHERE       BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050331')
--WHERE       EXTRACT(MONTH FROM BUY_DATE) BETWEEN '01' AND '03'
WHERE       EXTRACT(MONTH FROM BUY_DATE) IN('01', '02', '03')
GROUP BY    EXTRACT(MONTH FROM BUY_DATE)
ORDER BY    1;



사용예) 2005년 1-3월 제품별 매입수량 합계와 매입금액 합계를 조회하시오
SELECT      BUY_PROD AS 제품별,
            NVL(SUM(BUY_QTY),0) AS 매입수량합계,
            NVL(SUM(BUY_QTY*BUY_COST),0) AS "매입금액 합계" --별칭에 띄어쓰기 하지  말기
FROM        BUYPROD
WHERE       BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050331')
GROUP BY    BUY_PROD
ORDER BY    1;

  

사용예) 상품테이블에서 제품분류별 상품 마일리지합계를 조회하시오
SELECT      PROD_LGU AS 제품분류별,
            SUM(PROD_MILEAGE) AS "상품마일리지 합계"
FROM        PROD
GROUP BY    PROD_LGU
ORDER BY    1;
            











