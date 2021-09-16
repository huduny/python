SELECT FN_CREATE_CARTNO2('z001') FROM DUAL;
----------------------------------------------------
SELECT FN_CREATE_CARTNO2('e001') FROM DUAL;

CREATE OR REPLACE FUNCTION FN_CREATE_CARTNO2(
    P_MID IN MEMBER.MEM_ID%TYPE)

RETURN VARCHAR2

IS
    V_DATE VARCHAR(9):=TO_CHAR(SYSDATE, 'YYYYMMDD')||'%';
    V_CART_NO CART.CART_NO%TYPE;
    V_CART_MEM MEMBER.MEM_ID%TYPE;
    V_COUNT NUMBER:=0;

BEGIN 
    SELECT CART_MEMBER INTO V_CART_MEM
    FROM  CART
    WHERE CART_NO = (SELECT MAX(CART_NO) FROM CART WHERE CART_NO LIKE V_DATE)
    OR    (SELECT MAX(CART_NO) FROM CART WHERE CART_NO LIKE V_DATE) IS NULL 
    AND   CART_NO LIKE V_DATE
    AND   ROWNUM =1;
    
    SELECT COUNT(*) INTO V_COUNT
    FROM  CART
    WHERE CART_NO = (SELECT MAX(CART_NO) FROM CART WHERE CART_NO LIKE V_DATE);
    
  

    SELECT CART_NO INTO V_CART_NO
    FROM  CART
    WHERE CART_NO = (SELECT MAX(CART_NO) FROM CART WHERE CART_NO LIKE V_DATE)
    AND   CART_NO LIKE V_DATE
    AND   ROWNUM =1;
    
    IF  V_CART_NO IS NULL THEN V_CART_NO:=TO_CHAR(SYSDATE, 'YYYYMMDD')||'00001';
    return V_CART_NO;
    end if;
    
    IF P_MID = V_CART_MEM THEN V_CART_NO:=V_CART_NO;
    ELSIF V_CART_MEM != P_MID THEN V_CART_NO:=TO_CHAR(V_CART_NO+1);

    END IF;
    
    RETURN V_CART_NO ;

    END;