2021/08/16
SELECT * from NOTICE WHERE TITLE LIKE '%-%-%';
010-1234-1242
011-124-2432
016-1423-1243
017-2343-2345
018-2342-2523
019-1423-2523
�� ������ �� ������ ���� �ʹٸ�, �ڸ����� 3�� 4���� �پ��ϰ� ���ڵ� �پ��ϴ�
����Ŭ�δ� ������� ���Խ����δ� �����ϴ�
01[016789]-[0123456789][][][]-[][][][]--�̰Ŵ� ����
01[016-9]-\d\d\d\d-\d\d\d\d]--\d�� [0-9]�� ����
^01[016-9]-\d{3,4}-\d{4}$--\d4�� ������ �����ϴ�. �ݺ��Ǵ� ���� ����{2}2���ݺ�{3,4}�� 3��or4��
--�׻� �����Ҷ��� ^ �������� $�� ǥ���ؾߵȴ�.

[]�ϳ��� ���ڸ� �뺯 OR���� ǥ��
SELECT * from NOTICE WHERE TITLE LIKE '^01[016-9]-\d{3,4}-\d{4}$';--REGEXP_LIKE�Լ��� ����ؾߵȴ�.
SELECT * from NOTICE WHERE REGEXP_LIKE(TITLE,'^01[016-9]-\d{3,4}-\d{4}$');--^�� �׵ڿ��� �ٷ� �Ȱ��� �����ؾߵȴ�. �׷���^��$�� ���ش�.
SELECT * from NOTICE WHERE REGEXP_LIKE(TITLE,'01[016-9]-\d{3,4}-\d{4}');

NANA@NANA.COM
@ . ORG NET COM�� �ִ�.
���ڸ� ��Ÿ���� ��ȣ\w�� [A-Za-z0-9]
\w+@\w.(org|net|come) --���ڰ� �ϳ��̻� ���� @�;ߵȴ� [org]�� �ѱ��ھ� �Ǵ��ؼ� ���� �Ǵ��ϴ� ���� ��ߵȴ�.|alternation�� ��ߵȴ�.
\D\w*@\D\w*.(org|net|come)--\D�� 0-9�� �ƴѰ͸� �ü� �ִ�
---------------------------------------------
���� �����ϱ� ����Ŭ�� ���ʿ� rownum�� �ٴ´�
SELECT * FROM MEMBER WHERE ROWNUM BETWEEN 1 AND 5;
SELECT * FROM MEMBER WHERE ROWNUM BETWEEN 6 AND 10; 1�� �ƴ� 2���� �ص� �ȳ��´� ROWNUM�� �Ϸù�ȣ�� ���� �־��ٸ�
SELECT * FROM (SELECT ROWNUM NUM, MEMBER.*FROM MEMBER )--FROM�ȿ��� �������� ����� �ִ�. NUM�� ��Ī
SELECT * FROM (SELECT ROWNUM NUM, NOTICE.* FROM NOTICE); --���ο� ��� ������ �ȴ�()����
WHERE NUM BETWEEN 1 AND 5;(��Ī�� �̿��ؾߵȴ� �ֳ��ϸ� RONUM�� �ι� ���Ǽ��̴�.
--------------------------------------------------
DISTINCT �ߺ��� �� ����
SELECT * FROM MEMBER;

INSERT ALL INTO MEMBER (ID,PWD,NAME,AGE) VALUES (KIM,111,���ȯ,11)
MEMBER (ID,PWD,NAME,AGE) VALUES (YOU,123,���缮,23)
MEMBER (ID,PWD,NAME,AGE) VALUES (KING,142,ŷ����,124)
MEMBER (ID,PWD,NAME,AGE) VALUES (YODS,412,��A��,35)
MEMBER (ID,PWD,NAME,AGE) VALUES (KANG,242,��ȣ��,100)
SELECT FROM dual;

INSERT INTO MEMBER (ID,PWD,NAME,AGE) VALUES ('KIM','111','���ȯ',11);

INSERT INTO MEMBER (ID,PWD,NAME,AGE) SELECT VALUES ('KING','142','ŷ����',124)
MEMBER (ID,PWD,NAME,AGE) VALUES ('YODS','412','��A��',35)
MEMBER (ID,PWD,NAME,AGE) VALUES ('KANG','242','��ȣ��',100);

INSERT INTO MEMBER (ID,PWD,NAME,AGE) 
SELECT 'KING','142','ŷ����',124 FROM DUAL UNION ALL
SELECT 'YODS','412','��A��',35 FROM DUAL UNION ALL
SELECT 'KANG','242','��ȣ��',100 FROM DUAL;
SELECT * FROM MEMBER;

UPDATE MEMBER SET AGE=35 WHERE ID='NEWLEC'; 
UPDATE MEMBER SET AGE=25 WHERE ID='DRAGON'; 
SELECT * FROM MEMBER;

SELECT AGE FROM MEMBER;

--1�ܿ�
SELECT DISTINCT AGE FROM MEMBER; (�ݺ��Ǵ� ���� �������ش�.)(�ϳ��� �÷������� ��밡��)
SQL-DBMS(�����ͺ��̽� ���� �ý���)-DATABASE(�����͸� ��ƾ���,�����͸� �����ϰ� ����, �ߺ��� ���ּ�)
DML(INSERT, SELECT, UPDATE, DELETE)(CRUD�۾�)
SELECT(�÷� ����, �÷� ����, ��Ī)-���͸�(����,���Խ�,�ߺ�����)
--2�ܿ�
�Լ�, ������ ���� Ÿ�����ϸ鼭 �����ϱ�
�¶��ο� ����Ŭ �Լ� Ʃ�丮���ϱ�
