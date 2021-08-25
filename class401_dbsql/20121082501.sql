2021-08-25-01

3)TO_NUMBER(EXPT[,FMT])
-C1으로 기술된 문자열을 'FMT' 형식에 맞도록 숫자로 형변환
-'FMT'는 숫자로 변환될 수 있는 형식지정 문자열만 적용

사용예) SELECT TO_NUMBER('3.1415926'),
              TO_NUMBER('31415','99999.99'),
              TO_CHAR('31415','99999.99'),
             --TO_NUMBER('$2,000','9,999')
             TO_NUMBER('<2,000>','9,999PR')
        FROM   DUAL;
        
사용예) 분류테이블에 '노트북' 분류를 추가하시오 '노트북'은 전자제품류로 'P1XX'대의 분류코드를 부여할 것
    
    SELECT 'P'||TO_CHAR(TO_NUMBER(SUBSTR(MAX(LPROD_GU),2))+1) FROM LPROD WHERE LPROD_GU LIKE 'P1%';
    --WHERE,MAX=>P102=>SUBSTR=>102=>TO_NUMBER=>103=>TO_CHAR=>P103
    
    INSERT INTO  LPROD
    SELECT       10,
                 'P'||TO_CHAR(TO_NUMBER(SUBSTR(MAX(LPROD_GU),2))+1),      
                 'LAPTOP'
    FROM         LPROD
    WHERE        LPROD_GU LIKE 'P1%';
    --서브쿼리는 무조건 괄호를 써야되는데 INSERT를 쓸때는 예외이다.
    ALTER TABLE LPROD 
    COMMIT;
    
    
    
    
    
    
    