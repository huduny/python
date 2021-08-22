2021 08 14 1주정리
1. 오라클
SELECT 컬럼 AS 별칭 FROM 테이블 WHERE 행 비교연산자
CREATE TABLE 테이블 이름(컬럼이름 데이터타입-VARCHAR2,NUMBER,DATE등 NULL여부 DEFAULT여부)
CONSTRAINT 주요키OR외래키//외래키 사용시 
--REFERENCE와REFERENCES의 차이가 있을까?(질문)
변경은 기본적으로 ALTER을 쓴다. 
ALTER TABLE 테이블명 RENAME 컬럼명 기존이름 TO 새로운 이름
ALTER TABLE 테이블명 ADD 컬럼명 컬럼정의/여러개를 추가할때는 ALTER TABLE X ADD(Y D, Z W ...)
ALTER TABLE 테이블명 ADD CONSTRAINT 컬럼명(내가정한) KEY 설정
ALTER TABLE 테이블명 DROP CONSTRAINT 컬럼명(내가정한)
ALTER TABLE 테이블명 DISABLE CONSTRAINT 컬럼명(내가정한) //사용못하게
ALTER TABLE 테이블명 ENABLE CONSTRAINT 컬럼명(내가정한) //사용하게
ALTER TABLE 테이블명 MODIFY 컬럼명(기존) 바꿀값들
ALTER TABLE 테이블명 DROP COLUMN 컬럼명(기존)//이러면 컬럼을 삭제한다.
ALTER TABLE 테이블명 RENAME COLUMN 컬럼명(기존) TO 컬럼명(새로운)
EX) CREATE TABLE 테이블명(
    컬럼명1 데이터타입 눌여부 디폴트여부,
    컬럼명2 데이터타입 눌여부 디폴트여부,
    컬럼명3 데이터타입 눌여부 디폴트여부, 
    CONSTRAINT 컬럼명(내가 정한다)_pk(보통표시해준다) PRIMARY KEY (컬럼명1)등 괄호안에 기존에 있는 컬럼 중에 설정
    CONSTRAINT 컬럼명(내가 정한다)_fk(보통표시해준다) FOREIGN KEY (컬럼명2)등 괄호안에 기존에 있는 컬럼 중에 설정,PK키와 중복 가능 REFERENCES 부모테이블 (참조컬럼명)
--PK와 FK가 중복되는 이유가 있을까 그렇다면 어떻게 설정할까?
PK는 is a single field or combination of fields that uniquely defines a record. None of the fields that are part of the primary key can contain a null value.
     A table can have only one primary key.
FK는 The referenced table is called the parent table while the table with the foreign key is called the child table이다.
------------------------------------끝나면 콤마는 찍지 않는다.
INSERT INTO 테이블명
(컬럼명)
VALUES
(넣을것들); 이렇게 하거나 OR

INSERT INTO 테이블명 --The table to insert the records into.
(컬럼1, column2, ... column_n ) --The columns in the table to insert values.
SELECT 소스테이블에서 가져올 값 expression1, expression2, ... expression_n --The values to assign to the columns in the table. 
FROM source_table --The source table when inserting data from another table.
[WHERE 조건문(행>5000conditions]; --Optional. The conditions that must be met for the records to be inserted.
항상 INSERT문을 시행하기 전에는
SELECT count(*)
FROM customers
WHERE customer_id > 5000;를 실행해서 확인하자
------------------------------------
INSERT INTO clients
(client_id, client_name, client_type)
SELECT supplier_id, supplier_name, 'advertising'
FROM suppliers
WHERE NOT EXISTS (SELECT *
                  FROM clients
                  WHERE clients.client_id = suppliers.supplier_id);
//make sure that you do not insert duplicate information by using the EXISTS condition.   
//NOT EXISTS 를 사용하면 중복된 값을 안 넣는다
INSERT INTO clients
(client_id, client_name, client_type)
SELECT 10345, 'IBM', 'advertising'
FROM dual
WHERE NOT EXISTS (SELECT *
                  FROM clients
                  WHERE clients.client_id = 10345);
//dual table allows you to enter your values in a select statement, even though the values are not currently stored in a table.    
//듀얼 테이블은 내가 직접 값을 넣을 수 있다
--듀얼 테이블을 언제 사용할까?
--------------------------------------
INSERT ALL
  INTO 테이블 (컬럼명, supplier_name) VALUES (넣을값들)
  INTO suppliers (supplier_id, supplier_name) VALUES (2000, 'Microsoft')
  INTO suppliers (supplier_id, supplier_name) VALUES (3000, 'Google')
SELECT * FROM dual;
//여러줄을 집어 넣을때
//컬럼생성시 NOT NULL로 기술된 컬럼은 생략 불가능
---------------------------------------
UPDATE MEMBER SET PWD='111' WHERE ID='DRAGON';--UPDATE와 DELETE는 WHERE절이 반드시 필요하다
----------------------------------------
    CREATE USER 계정명 IDENTIFIED BY 암호;
    GRANT CONNECT, RESOURCE, DBA TO OYK93;
    
    ALTER USER HR ACCOUNT UNLOCK;
    ALTER USER HR IDENTIFIED BY java;
    
    DELETE OYK93.CART
    WHERE CART_NO LIKE '200505%';
    
    UPDATE HR.EMPLOYEES--대상테이블명
    SET RETIRE_DATE = TO_DATE('20191015')--컬럼명
    WHERE EMPLOYEE_ID IN (120, 135); //in이나 out은 값이 포함되거나 포함되지 않은 것을 추출할때 사용된다.
    SELECT *
    FROM TABLE1 
    WHERE COLUMN1 NOT IN (SELECT COLUMN2
                          FROM TABLE2
                          WHERE COLUMN2 IS NOT NULL) //한번더 SUBQUERY를 할 수 있는데 null값은 not과in에서 추출할수 없어서 꼭 is not null
                                                       을 써야된다.
    
    (사용형식)
    SELECT *|[DISTINCT] 컬럼명 [AS 별칭][,]
        컬럼명 [AS 별칭][,]
            -
            -
        컬럼명 [AS 별칭]
    FROM 테이블명
    [WHERE 조건]
    [GROUP BY 컬럼명[,컬럼명,...]]
    [HAVING 조건]
    [ORDER BY 컬럼명|컬럼인덱스 [ASC|DESC][컬럼명|컬럼인덱스 [ASC|DESC],...]];
    CHAR빼고는 다 가변길이다
    
    SELECT job, SUM(sal) "급여합계"
    FROM emp  
    WHERE job != 'SALES'      -- 판매원은 제외
    GROUP BY job              -- 업무별로 Group By 
    HAVING SUM(sal) > 5000     -- 전체 월급이 5000을 초과하는
    ORDER BY SUM(sal) DESC;   -- 월급여 합계로 내림차순 정렬
    //해빙절은 그룹바이 다음에 나온다 그룹바이가 없으면 웨어절과 같이 사용된다
    
    SELECT SUBSTR(COL1,5,3) AS "COL1",
           SUBSTR(COL2,5,3) AS "COL2",
           DBMS_LOB.SUBSTR(COL3, 3,5) AS "COL2"
    FROM TEMP04;
    //SUBSTR는 5번째에서 3글자
    //DBMS SUB는 5글자 3번째부터
    //두번째 세번째 매개변수의 역할이 반대로 되어 있다.
-----------------------------------------------------------

