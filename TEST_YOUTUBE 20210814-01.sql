SELECT * FORM NOICE WHERE HIT=0 OR HIT =2 OR HIT =1; ���ӵ��� ���� �� ȿ����
SELECT * FORM NOICE WHERE 0<=HIT AND HIT<=2; �ε�ȣ�� �ٸ� ��
SELECT * FORM NOICE WHERE HIT BETWEEN 0 AND 2; ������ ���Եɶ��� ���

SELECT * FORM NOICE WHERE HIT=2 OR HIT =0 OR HIT =7; ���ӵ��� ���� �� ȿ���� �׷��� ������ ����
SELECT * FORM NOICE WHERE HIT IN (0,2,7); ���ӵ��� ���� ������ ���ϰ� OR �϶��� IN�� �������
SELECT * FORM NOICE WHERE HIT NOT IN (0,2,7); IN���� ���� ����

--���Ϻ񱳿�����
LIKE % _
SELECT * FROM MEMBER WHERE NAME = '��%'; �̰Ŵ� ���� ��%�� ã�Ե�
SELECT * FROM MEMBER WHERE NAME LIKE '��%'; ������ ���Ҷ��� LIKE�� �Ѵ�

SELECT * FROM NOTICE;
SELECT * FROM NOTICE WHERE TITLE LIKE 'J%'; %�� �ѱ��� �̻��� �ǹ�
SELECT * FROM NOTICE WHERE TITLE LIKE 'J_'; _�� �ѱ��� ���ڼ� ���� ���� ___�� 3����

SELECT * FORM NOTICE WHERE TITLE NOT LIKE '��%'; �ھ� ���� �ƴ� ���
SELECT * FROM NOTICE WHERE TITLE LIKE '%��%'; �̸��� ���ڰ� �� ���





