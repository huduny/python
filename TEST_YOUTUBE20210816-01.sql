2021/08/16
SELECT * from NOTICE WHERE TITLE LIKE '%-%-%';
010-1234-1242
011-124-2432
016-1423-1243
017-2343-2345
018-2342-2523
019-1423-2523
위 패턴을 다 구별해 내고 싶다면, 자리수가 3개 4개로 다양하고 숫자도 다양하다
오라클로는 어렵지만 정규식으로는 가능하다
01[016789]-[0123456789][][][]-[][][][]--이거는 불편
01[016-9]-\d\d\d\d-\d\d\d\d]--\d는 [0-9]와 같다
^01[016-9]-\d{3,4}-\d{4}$--\d4번 나열은 불편하다. 반복되는 수를 지원{2}2번반복{3,4}는 3개or4개
--항상 시작할때는 ^ 끝날떄는 $를 표시해야된다.

[]하나의 글자를 대변 OR으로 표현
SELECT * from NOTICE WHERE TITLE LIKE '^01[016-9]-\d{3,4}-\d{4}$';--REGEXP_LIKE함수를 사용해야된다.
SELECT * from NOTICE WHERE REGEXP_LIKE(TITLE,'^01[016-9]-\d{3,4}-\d{4}$');--^는 그뒤에가 바로 똑같이 시작해야된다. 그래서^와$를 빼준다.
SELECT * from NOTICE WHERE REGEXP_LIKE(TITLE,'01[016-9]-\d{3,4}-\d{4}');

NANA@NANA.COM
@ . ORG NET COM이 있다.
문자를 나타내는 기호\w는 [A-Za-z0-9]
\w+@\w.(org|net|come) --문자가 하나이상 오고 @와야된다 [org]는 한글자씩 판단해서 같이 판단하는 것을 써야된다.|alternation을 써야된다.
\D\w*@\D\w*.(org|net|come)--\D는 0-9가 아닌것만 올수 있다
---------------------------------------------
행을 제한하기 오라클은 왼쪽에 rownum이 붙는다
SELECT * FROM MEMBER WHERE ROWNUM BETWEEN 1 AND 5;
SELECT * FROM MEMBER WHERE ROWNUM BETWEEN 6 AND 10; 1이 아닌 2부터 해도 안나온다 ROWNUM가 일련번호가 원래 있었다면
SELECT * FROM (SELECT ROWNUM NUM, MEMBER.*FROM MEMBER )--FROM안에도 쿼리문을 만들수 있다. NUM은 별칭
SELECT * FROM (SELECT ROWNUM NUM, NOTICE.* FROM NOTICE); --새로운 결과 집합이 된다()안은
WHERE NUM BETWEEN 1 AND 5;(별칭을 이용해야된다 왜냐하면 RONUM이 두번 사용되서이다.
--------------------------------------------------
DISTINCT 중복된 값 제거
SELECT * FROM MEMBER;

INSERT ALL INTO MEMBER (ID,PWD,NAME,AGE) VALUES (KIM,111,김두환,11)
MEMBER (ID,PWD,NAME,AGE) VALUES (YOU,123,유재석,23)
MEMBER (ID,PWD,NAME,AGE) VALUES (KING,142,킹세종,124)
MEMBER (ID,PWD,NAME,AGE) VALUES (YODS,412,기묨암,35)
MEMBER (ID,PWD,NAME,AGE) VALUES (KANG,242,강호동,100)
SELECT FROM dual;

INSERT INTO MEMBER (ID,PWD,NAME,AGE) VALUES ('KIM','111','김두환',11);

INSERT INTO MEMBER (ID,PWD,NAME,AGE) SELECT VALUES ('KING','142','킹세종',124)
MEMBER (ID,PWD,NAME,AGE) VALUES ('YODS','412','기묨암',35)
MEMBER (ID,PWD,NAME,AGE) VALUES ('KANG','242','강호동',100);

INSERT INTO MEMBER (ID,PWD,NAME,AGE) 
SELECT 'KING','142','킹세종',124 FROM DUAL UNION ALL
SELECT 'YODS','412','기묨암',35 FROM DUAL UNION ALL
SELECT 'KANG','242','강호동',100 FROM DUAL;
SELECT * FROM MEMBER;

UPDATE MEMBER SET AGE=35 WHERE ID='NEWLEC'; 
UPDATE MEMBER SET AGE=25 WHERE ID='DRAGON'; 
SELECT * FROM MEMBER;

SELECT AGE FROM MEMBER;

--1단원
SELECT DISTINCT AGE FROM MEMBER; (반복되는 값을 제거해준다.)(하나의 컬럼에서만 사용가능)
SQL-DBMS(데이터베이스 관리 시스템)-DATABASE(데이터를 모아쓰자,데이터를 단일하게 관리, 중복을 없애서)
DML(INSERT, SELECT, UPDATE, DELETE)(CRUD작업)
SELECT(컬럼 선택, 컬럼 연산, 별칭)-필터링(패턴,정규식,중복제거)
--2단원
함수, 나열된 것을 타이핑하면서 공부하기
온라인에 오라클 함수 튜토리얼하기
