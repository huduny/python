SELECT REGION_ID HIT FROM COUNTRIES;
SELECT 1+'3' FROM DUAL; --오라클은 숫자 우선 +는 숫자만 더한다 ||이것이 문자를 더하는 것이다.
SELECT 10||'3' FROM DUAL;
SELECT COUNTRY_NAME ||'('|| REGION_ID ||')' AS CR_ID_NUM FROM  COUNTRIES;
--이런 더하기 연산자를 쓸때는 별칭을 써서 정리를 해주는게 중요하다

레코드를 뽑아낼때는 비교+관계 연산자를 사용하면 된다
^=같지않다 <>같지않다 !=같지않다--하나만 선택해서 쓰자 !=
SELECT * FROM COUNTRIES WHERE COUNTRY_ID = 'JP';
-- FROM 앞에는 컬럼을 뽑아내는 것이고 WHERE절을 사용하면 레코드를 뽑아낼 수 있다
-- 그렇다면 둘다 뽑아 낼려면 다 사용?
SELECT COUNTRY_NAME FROM COUNTRIES WHERE COUNTRY_ID = 'JP';
--
SELECT * FROM COUNTRIES WHERE REGION_ID != 3;
--비교 연산자는 웨어절에서 사용하면 된다.
SELECT * FROM DEPARTMENTS WHERE MANAGER_ID IS NULL;
--NULL을 검색할때는 항상 IS NULL로, NULL이 아닌 값은 IS NOT NULL을 쓴다 NULL은 특별한 값이므로












