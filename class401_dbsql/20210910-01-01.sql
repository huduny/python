2005년도 상품별 총 입고수량을 출력하는 커서
--LIKE에 사용되는 %_는 와일드카드이다.
--집계함수(SUM, AVG, MAX, MIN, COUNT)
/
SET SERVEROUTPUT ON;
/
DECLARE
    V_PROD  VARCHAR2(30);
    V_QTY   NUMBER(10);
CURSOR  CUR IS
    SELECT    BUY_PROD,
              SUM(BUY_QTY)
    FROM      BUYPROD
    WHERE     BUY_DATE LIKE '2005%'
    GROUP BY  BUY_PROD
    ORDER BY  BUY_PROD;
BEGIN
    OPEN CUR;--메모리에 올리다
    FETCH CUR INTO V_PROD,V_QTY;--CUR을 페치해서 바라보게 해준다.    --페따출:페치 따지고 출력
    
    WHILE(CUR%FOUND)
     LOOP
        DBMS_OUTPUT.PUT_LINE(V_PROD||V_QTY);
        FETCH CUR INTO V_PROD,V_QTY;
     END LOOP;
    CLOSE CUR;
END;
--DECLARE BEGIN END를 쓰면 PL/SQL문으로 변경된다.\
/--슬러시를 지정해두면 CTRL+ENTER하면 실행이 된다.

DROP TABLE BUYPROD_2;
COMMIT;