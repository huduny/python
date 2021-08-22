2021-08-13 금요일 (D235일)
--INSERT와 SELECT 문
INSERT INTO MEMBER(ID, PWD) VALUES('NEWLEC', '111'); 
SELECT * FROM MEMBER;
INSERT INTO MEMBER(ID, PWD) VALUES('DRAGON', '111'); 
SELECT * FROM MEMBER;
COMMIT;
---------------------------------------------------
SELECT ID AS USER_ID, NAME, PWD FROM MEMBER; --별칭이용, AS는 생략가능
SELECT ID AS "USER ID", NAME, PWD FROM MEMBER; --빈공백을 원한다면 큰따움표로 감싼다

--UPDATE와 DELETE 문
UPDATE MEMBER SET PWD='222';--
ROLLBACK;
SELECT ID AS "USER ID", NAME, PWD FROM MEMBER;--오라클 계정은 접속정보를 다르게 관리해서 섹션마다 데이터 처리가 다르다
UPDATE MEMBER SET PWD='111' WHERE ID='DRAGON';--UPDATE와 DELETE는 WHERE절이 반드시 필요하다
UPDATE MEMBER SET PWD='333',NAME='홍길동' WHERE ID='DRAGON';
INSERT INTO MEMBER(ID, PWD) VALUES('TEST', '111'); 
DELETE MEMBER WHERE ID='TEST';
---------------------------------------------------------------------------------------------------------------
DELETE FROM MEMBER WHERE ID='DRAGON';
SELECT ID AS "USER ID", NAME, PWD FROM MEMBER;
--MEMBER테이블에 DRAGON의 PWD
만 지울수 없나? 
-----
ROLLBACK;
COMMIT;
-----
트랜잭션 (업무 실행단위)
두개의 명령어를 하나의 단위로 묶어서 쓰는 명령어(1.현재 세션을 위한 임시저장소에서 테스트(lock,unlock)(commit은 '결정'과 rollback은 '되돌리기')
commit이나 rollback을 하지 않으면 다른데서 작업을 할 수 없다 락업이 걸려 있어서(무한루프를 해결하기 위해)
---
산술연산자
SELECT HIT FROM NIOTICE;

















