2021-08-13 �ݿ��� (D235��)
--INSERT�� SELECT ��
INSERT INTO MEMBER(ID, PWD) VALUES('NEWLEC', '111'); 
SELECT * FROM MEMBER;
INSERT INTO MEMBER(ID, PWD) VALUES('DRAGON', '111'); 
SELECT * FROM MEMBER;
COMMIT;
---------------------------------------------------
SELECT ID AS USER_ID, NAME, PWD FROM MEMBER; --��Ī�̿�, AS�� ��������
SELECT ID AS "USER ID", NAME, PWD FROM MEMBER; --������� ���Ѵٸ� ū����ǥ�� ���Ѵ�

--UPDATE�� DELETE ��
UPDATE MEMBER SET PWD='222';--
ROLLBACK;
SELECT ID AS "USER ID", NAME, PWD FROM MEMBER;--����Ŭ ������ ���������� �ٸ��� �����ؼ� ���Ǹ��� ������ ó���� �ٸ���
UPDATE MEMBER SET PWD='111' WHERE ID='DRAGON';--UPDATE�� DELETE�� WHERE���� �ݵ�� �ʿ��ϴ�
UPDATE MEMBER SET PWD='333',NAME='ȫ�浿' WHERE ID='DRAGON';
INSERT INTO MEMBER(ID, PWD) VALUES('TEST', '111'); 
DELETE MEMBER WHERE ID='TEST';
---------------------------------------------------------------------------------------------------------------
DELETE FROM MEMBER WHERE ID='DRAGON';
SELECT ID AS "USER ID", NAME, PWD FROM MEMBER;
--MEMBER���̺� DRAGON�� PWD
�� ����� ����? 
-----
ROLLBACK;
COMMIT;
-----
Ʈ����� (���� �������)
�ΰ��� ��ɾ �ϳ��� ������ ��� ���� ��ɾ�(1.���� ������ ���� �ӽ�����ҿ��� �׽�Ʈ(lock,unlock)(commit�� '����'�� rollback�� '�ǵ�����')
commit�̳� rollback�� ���� ������ �ٸ����� �۾��� �� �� ���� ������ �ɷ� �־(���ѷ����� �ذ��ϱ� ����)
---
���������
SELECT HIT FROM NIOTICE;

















