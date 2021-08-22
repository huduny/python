SELECT * FORM NOICE WHERE HIT=0 OR HIT =2 OR HIT =1; 연속되지 않을 때 효과적
SELECT * FORM NOICE WHERE 0<=HIT AND HIT<=2; 부등호가 다를 때
SELECT * FORM NOICE WHERE HIT BETWEEN 0 AND 2; 범위가 포함될때는 사용

SELECT * FORM NOICE WHERE HIT=2 OR HIT =0 OR HIT =7; 연속되지 않을 때 효과적 그러나 귀찮아 진다
SELECT * FORM NOICE WHERE HIT IN (0,2,7); 연속되지 않은 값들을 비교하고 OR 일때는 IN을 사용하자
SELECT * FORM NOICE WHERE HIT NOT IN (0,2,7); IN안의 값을 제외

--패턴비교연산자
LIKE % _
SELECT * FROM MEMBER WHERE NAME = '박%'; 이거는 정말 박%로 찾게됨
SELECT * FROM MEMBER WHERE NAME LIKE '박%'; 패턴을 비교할때는 LIKE를 한다

SELECT * FROM NOTICE;
SELECT * FROM NOTICE WHERE TITLE LIKE 'J%'; %는 한글자 이상을 의미
SELECT * FROM NOTICE WHERE TITLE LIKE 'J_'; _는 한글자 글자수 제한 가능 ___는 3글자

SELECT * FORM NOTICE WHERE TITLE NOT LIKE '박%'; 박씨 성이 아닌 사람
SELECT * FROM NOTICE WHERE TITLE LIKE '%도%'; 이름에 도자가 들어간 사람





