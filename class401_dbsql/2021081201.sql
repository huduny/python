2021-0812-01)
2. UPDATE문
    -테이블에 저장된 자료를 수정할 때 사용(구조를 수정하는 것은 alter이다)
    (사용형식)
    UPDATE 테이블명
        SET 컬럼명=값 [,
            컬럼명=값,
            ...]
    [WHERE 조건];
    --SELECT 문은 검사를 할때 사용(FROM WHERE SELECT)
    --SELECT와 FROM절은 필수다, WHERE이 생략되면 해당 테이블의 모든 행을 의미한다
    
    사용예) SEM계정의 상품테이블에서 P102000004 상품의 매입가격을 990000원을 80000원으로 수정하시오.
    UPDATE OYK93.PROD
    SET    PROD_COST = 800000
    WHERE PROD_ID='P102000004';
    
    SELECT * FROM OYK93.PROD;
    COMMIT

    사용예) HR계정의 사원테이블 (EMPLOYEES)에 새로운 컬럼 'EMP_NAME VARCHAR2(80)'을
           추가하고 각 사원의 이름(FIRST_NAME)과 성(LAST_NAME)을 결합하여 입력 하시오
           ** 컬럼 추가
           ALTER TABLE 테이블명 ADD(컬럼명 데이터타입 [(크기)] [DEFAULT 값]);
           
           ALTER TABLE HR.EMPLOYEES ADD(EMP_NAME VARCHAR2(80));
           ALTER TABLE HR.EMPLOYEES ADD(RETIRE_DATE DATE);
           COMMIT;



    UPDATE HR.EMPLOYEES
        SET EMP_NAME=FIRST_NAME||' '||LAST_NAME;
        --||기호는 붙여라 라는 의미이다
        --WHERE가 생략하면 전부다라는 의미이다

    COMMIT;
       SELECT FIRST_NAME, LAST_NAME, EMP_NAME FROM HR.EMPLOYEES; 
       
    사용예) HR계정의 사원테이블(EMPLOYEES)에서 사원번호(EMPLOYEE_ID)가 120번과 135번
    사원을 2019.10.15일 일자로 퇴직처리 하시오.
    UPDATE HR.EMPLOYEES--대상테이블명
        SET RETIRE_DATE = TO_DATE('20191015')--컬럼명
    WHERE EMPLOYEE_ID IN (120, 135);
    --WHERE는 행을 담당 SET는 컬럼을 담당
    COMMIT
    
    3. DELETE문
    - 테이블의 자료를 삭제시킴
    ---DROP은 집 자체를 즉 테이블을 삭제
    사용형식
    DELETE 테이블명 --ROLLBACK할수 있다.
    
    SELECT * FROM OYK93.PROD;
    사용예) DELETE OYK93.PROD;
    --자식이 있으면 제거할수 없다.
    DELETE OYK93.CART;
    --제목 줄이 출력되었으면 오류가 아니다. 다만 조건에 맞는 결과가 없다.
    ROLLBACK;
    COMMIT;
    
    DELETE OYK93.CART
    WHERE CART_NO LIKE '200505%';
    --LIKE는 정규식을 표현한다.
    --%는 그 자리 뒤에 어떤 자리가 들어와도 다 같다는 뜻이다.
    --즉 2005년 5월달에 판매된 정보
     ROLLBACK;
      COMMIT;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
            
            
            
            
            
            
            
            
            
            
            
