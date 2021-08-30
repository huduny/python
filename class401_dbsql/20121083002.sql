2021-08-30-02)기타 집계함수 ROLLUP과 CUBE

1)ROLLUP(COL1[,COL2,...,COLN])
    - 레벨별 부분집계와 전체집계를 반환
    - GROUP BY 절에 사용
    - 기술된 컬럼명 COL1~COLN을 기준으로 집계를 반환한 후 오른쪽부터 하나의 컬럼명들을 제거한 기준으로 집계를 반환
    - 최종적으로 전체집계(COL들을 모두 사용하지 않은 형태)을 반환하므로 사용된 컬럼이 N개일때 집계의 종류는 N+1개임
    - 많이 사용한다.
    - 
    
    SELECT  BUY_DATE,
            BUY_PROD,
            SUM(BUY_QTY),
            MAX(BUY_COST)
    FROM    BUYPROD
    GROUP BY ROLLUP(BUY_DATE, BUY_PROD);

사용예) 2005년도 월별, 회원별, 상품별 매출집계를 조회하시오 매출집계는 매출수량합계이다.
--ROLL UP 미사용 부분합계 없다.
SELECT      SUBSTR(CART_NO, 5, 2) AS 월, 
            CART_MEMBER AS 회원, 
            CART_PROD AS 상품, 
            SUM(CART_QTY) 매출수량합계
FROM        CART 
WHERE       CART_NO LIKE '2005%'
GROUP BY    ROLLUP(SUBSTR(CART_NO, 5, 2), CART_MEMBER, CART_PROD)
ORDER BY    1, 2 ASC;
-- 3개를 가지고 합계 2개를가지고 합계 1개를 가지고 합계 EX 4-19-475(198행) 마지막 전체합계
-- 따라서 N+1개의 조합이 출력 되었다.
SELECT      SUBSTR(CART_NO, 5, 2) AS 월, 
            CART_MEMBER AS 회원, 
            CART_PROD AS 상품, 
            SUM(CART_QTY) 매출수량합계
FROM        CART 
WHERE       CART_NO LIKE '2005%'
GROUP BY    GROUPING SETS(SUBSTR(CART_NO, 5, 2), CART_MEMBER, CART_PROD)
ORDER BY    1, 2 ASC;

2)CUBE(COL1[,COL2,...,COLN])
-컬럼명을 기준으로 조합가능한 경우의 수만큼의 집계를 반환한 후 전체 집계를 반환
- GROUP BY절에서 기술
- 사용한 컬럼의 개수가 N개이면 집계의 종류는 2^N개

SELECT  LISTAGG(CART_MEMBER, ',') WITHIN GROUP(ORDER BY CART_NO DESC) AS NAMES
FROM    CART

GROUP BY 

(부분 ROLLUP)
SELECT      SUBSTR(CART_NO, 5, 2) AS 월, 
            CART_MEMBER AS 회원, 
            CART_PROD AS 상품, 
            SUM(CART_QTY) 매출수량합계
FROM        CART 
WHERE       CART_NO LIKE '2005%'
GROUP BY    CART_MEMBER, SUBSTR(CART_NO, 5, 2), ROLLUP(CART_PROD)
--SUBSTR(CART_NO, 5, 2), ROLLUP(CART_MEMBER, CART_PROD)
ORDER BY    1, 2 ASC;
--이것은 전체 합계가 없다.

2021-08-30-03) 테이블 조인
    -JOIN연산은 관계형 데이터베이스 연산 중 가장 중요한 연산
    -두 개 이상의 테이블이 동일 컬럼을 통하여 관계를 맺고 있는 경우 수행
    -분산된 자료를 관계를 이용하여 조회할때 사용
    -조인의 분류
    1) 일반조인 VS ANSI 조인
    2) 동등조인 VS 비동등 조인
    3) 내부조인 VS 외부조인
    4) 기타 SELF JOIN, CREATESIAN PRODECT 등이 있음
 
1. CARTESIAN PRODUCT
    -조인조건이 없거나 조인조건을 잘못 기술한 경우
    -가능한 모든 조합을 결과로 반환(N행M열 X A행C열 => (A*N행 M+C열)
    -ANSI 조인의 CROSS JOIN과 같음
    특별한 목적이 아니면 사용해서는 안됨
사용예) 
SELECT COUNT(*)
FROM    CART, PROD;

SELECT COUNT(*)
FROM    CART, PROD, BUYPROD;

2. 동등조인(EQUI-JOIN)
    -ANSI의 INNER JOIN(내부조인)에 해당
    -조인조건에 '='연산자 사용되는 조인
    
    (사용형식: 일반조인)
    SELECT [테이블명.|테이블별칭.]컬럼명 [AS 별칭]
    ..
    SELECT [테이블명.|테이블별칭.]컬럼명 [AS 별칭]
FROM 테이블명 [별칭], 테이블명 [별칭][,테이블명 [별칭],...]
WHERE 조인조건 
[AND 일반조건,...]
--WHERE절에는 조인 조건을 기술한다. 두테이블에 공통적 테이블이 존재해야 된다.
(사용형식: ANSI조인)
    SELECT [테이블명.|테이블별칭.]컬럼명 [AS 별칭]
    ..
    SELECT [테이블명.|테이블별칭.]컬럼명 [AS 별칭]
FROM 테이블명1 [별칭1]
INNER JOIN 테이블명2 [별칭2] ON(조인조건1 [AND 일반조건1])
[INNER JOIN 테이블명3 [별칭3] ON(조인조건2 [AND 일반조건2])
..
[WHERE 일바조건_N];
**테이블명1과 테이블명2는 반드시 조인 가능해야 함
**조인조건1은 테이블명1과 테이블명2 사이의 조인조건
**조인조건2부터는 위의 결과와 조인할때 적용되는 조인조건
**일반조건1, 2는 해당 텡치블에만 적용되는 일반조건이고
  WHERE 일반조건_N는 모든 테이블에 적용되는 일반조건임.
  테이블명1과 테이블명2의 조인 결과와 테이블명3이 조인되어진다.
  일반조건 1은 테이블명 2에만 적용된다.
  
사용예) 부서별 평균임금과 인원수를 출력
ALIAS는 부서번호, 부서명, 인원수, 평균임금
--일반조인
SELECT      B.DEPARTMENT_ID AS 부서번호, 
            B.DEPARTMENT_NAME AS 부서명, 
            COUNT(*) AS 인원수, 
            ROUND(AVG(A.SALARY)) AS 평균임금
FROM        HR.EMPLOYEES A, HR.DEPARTMENTS B
WHERE       A.DEPARTMENT_ID=B.DEPARTMENT_ID --조인조건
GROUP BY    B.DEPARTMENT_ID, B.DEPARTMENT_NAME
ORDER BY    1;
--양쪽의 부족한 쪾을 기준으로해서 NULL값은 버려졌다.(이너조인)\
--많은 쪽에 맞추는 것은(아우터조인이다)

--ANSI조인            
SELECT      B.DEPARTMENT_ID AS 부서번호, 
            B.DEPARTMENT_NAME AS 부서명, 
            COUNT(*) AS 인원수, 
            ROUND(AVG(A.SALARY)) AS 평균임금
FROM        HR.EMPLOYEES A
INNER JOIN  HR.DEPARTMENTS B ON (A.DEPARTMENT_ID=B.DEPARTMENT_ID) --조인조건
GROUP BY    B.DEPARTMENT_ID, B.DEPARTMENT_NAME
ORDER BY    1;
