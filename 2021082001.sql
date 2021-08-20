2021-0820-01)�Լ�(FUNCTION)
- DBMS���� Ư�� ����� ������ �� �ִ� ����� �������Ͽ� ���� ������ ���·� �����ϴ� �������α׷�
- �÷� ���̳� ������ Ÿ���� ����, ���� �Ǵ� ��¥ ������ ��� ������ ����, �ϳ� �̻��� �࿡ ���Ͽ� ����ó��
-�Լ� ����
--��ȯ���� ������ ��� ��ȯ���� ������ ���ν����̶�� �Ѵ�. �ٸ� ������ ����� �ϳ��� ���� �ڹ�(�޼ҵ�)
--SUBSTR �־��� ���ڿ����� ����ڰ� ������ ���ڸ� ��� �� �Լ��� ���� ��ġ�� ����� ��ȯ��
--�Լ��� ���ν����� ���� �ֵ��� ȣ���ϴ� ����� ���̰� ����
--EXEC�� ���� ���ν��� ȣ��, �Լ��� SELECT�� ���ؼ� ȣ��� �� �ִ�.
--����Ŭ ��ü(����Ǿ� �ִٰ� �ҷ� ���� �͵�)
--����Ŭ �Լ��� �������� ���� �̸� DBMS���� �̸� ������ �� ���Ҵ�. �������� �̰��� �̸��� �θ��� ������(�Ű�����)�� �����ؼ� ȣ���ϸ� �ȴ�
--���� ���� ��¥ ����ȯ �����Լ��� �з�
--����(���ڿ��Լ�), ����(�����Լ�-�ݿø�,����,����,�α�,���� ��), ��¥�Լ�, ����ȯ(����-���� ��)(CAST, TO_CHAR, T0_NUM, TO_DATE ��), 
--����� ����(GROUP)(Ư������ ���� ���� �͵鳢��) �׷캰�� ���� ó�� �ϴ� �Լ�(SUM ��)
(1) ������ �Լ�--�ѹ� ����ɶ� �ϳ��� �ุ ����
 . ���̺� ����� ���� ���� ������� �Լ��� �����Ͽ� �ϳ��� ����� ��ȯ
 . SELECT, WHERE �� � ��� �����ϸ�, �Լ��� ��ø ����� ����
 . ����, ����, ��¥ ó���Լ��� ����ȯ �Լ��� ����

(2) ������ �Լ�--���꿡 �����ϴ� ���� �ϳ��� �Լ��� ���� ���� �����Ѵ� �ؼ� ������� �ϳ����̴�
 . ���� ���� �׷�ȭ�Ͽ� �׷캰�� ����� ó���Ͽ� �ϳ��� ����� ��ȯ
 . SUM, AVG, COUNT, MAX, MIN ���� �Լ��� ����--��ø�ؼ� ���� ����
 . �׷�ȭ�ϴ� ��� GROUP BY �� �� �����Լ��� ����ó���� HAVING���� ����
 
 1. �����Լ�
  1) CONCAT(C1,C2) --C���ڿ� N�ѹ� D������/ ������ ������ Ÿ���� �޴��� �ִ� ���� ��ġ�ؾߵȴ�. CONCAT ���ڿ� ��ġ��
    - �� ���ڿ� C1, C2�� �����Ͽ� �ϳ��� ���ڿ��� ��ȯ --�Լ��� ���� �ٷ� �� ��ġ�� ��ȯ�ȴ�.
    '||'�� ����

��뿹) ȸ�� ���̺��� ���ϸ����� 3000�̻��� ȸ������ ȸ������(ȸ����ȣ, ȸ����, �ֹι�ȣ, ���ϸ���)�� ��ȸ�Ͻÿ�. ��, ȸ���� �ֹι�ȣ��
'XXXX-XXXX'�������� ����Ͻÿ�

    SELECT MEM_ID ȸ����ȣ, MEM_NAME ȸ����, CONCAT(CONCAT(MEM_REGNO1,'-'),MEM_REGNO2) �ֹι�ȣ, MEM_MILEAGE ���ϸ���
    --MEM_REGNO1||'-'||MEM_REGNO2
    FROM MEMBER
    WHERE MEM_MILEAGE >= 3000;
    
2) CHR(N1), ASCII(C1)
 - CHR(N1): �־��� ���� 'N1'�� �ش��ϴ� ����
 - ASC(C1): �־��� ���ڿ� 'C1'�� �ش��ϴ� ASCII�ڵ尪 --�����ڸ� ��������� �� �տ� ù���ڸ� ��ȯ�ȴ�
��뿹)
    SELECT ASCII('ORACLE'), ASCII('����Ŭ'), --ASCII��Ʈ��ũ �����ǽ� ��� ����ϴ� ǥ���ڵ�� ����ϴ� 2�� ��ȯ �ڵ�
           CHR(256), CHR(ASCII('A')+2)
    FROM   DUAL;
    
    DECLARE
    BEGIN
        FOR I IN 1..50000 LOOP
            DBMS_OUTPUT.PUT_LINE('ASCII('||I||')='||CHR(I));
       END LOOP;
    END;
 
 3) LOWER(C1), UPPER(C1), INITCAP(C1)
  - LOWER(C1): �־��� ���ڿ� 'C1'�� ��� ���ڸ� �ҹ��ڷ� ��ȯ
  - UPPER(C1): �־��� ���ڿ� 'C1'�� ��� ���ڸ� �빮�ڷ� ��ȯ
  - INITCAP(C1): �־��� ���ڿ� 'C1'�� �ܾ���� ù ���ڸ� �빮�ڷ� ��ȯ
 
 ��뿹) 
    SELECT MEM_ID, MEM_NAME
    FROM MEMBER
    WHERE UPPER(MEM_ID)='R001';
 
    SELECT LOWER (EMP_NAME),
           UPPER (EMP_NAME),
           INITCAP(LOWER(EMP_NAME)),
           EMP_NAME
    FROM   EMPLOYEES
    WHERE DEPARTMENT_ID=50;
 
 4) LPAD(C1,N[,C2]), RPAD(C1,N[,C2])
 - LPAD(C1,N[,C2]): �־��� ���ڿ� 'C1'�� N��ŭ�� ũ�⿡ �����ϰ� ���� �������� (����) 'C2'�� ä��. C2�� �����Ǹ� ������ ä����--�������� �������� ä�������� ���� ������
 - RPAD(C1,N[,C2]): �־��� ���ڿ� 'C1'�� N��ŭ�� ũ�⿡ �����ϰ� ���� �������� (������) 'C2'�� ä��. C2�� �����Ǹ� ������ ä���� --������� �����U��, �������� ���ĵǰ�
 
 ��뿹) SELECT LPAD('1,000,000', 12, '*') FROM DUAL;
        SELECT RPAD('1,000,000', 12, '*') FROM DUAL;
 SELECT RPAD('1,000,000', 12, '*'), RPAD(1000000, 5), LPAD('1,000,000', 12, '*'), LPAD(1000000, 5) FROM DUAL;
 
 ��뿹) 
    DECLARE
        CURSOR cur_temp IS
            SELECT A.CID AS ACID, A.AMT AS AAMT
            FROM  (SELECT CART_MEMBER AS CID, 
                        SUM(CART_QTY*PROD_PRICE) AS AMT
                 FROM CART, PROD
                 WHERE CART_PROD=PROD_ID
                 AND  CART_NO LIKE '200505%'
                 GROUP BY CART_MEMBER
                 ORDER BY 2 DESC) A
            WHERE ROWNUM<=10;
            V_NAME
    BEGIN
     FOR REC IN cur_temp LOOP
     SELECT MEM_NAME, MEM_PASS INTO V_NAME, V_PASS
     FROM MEMBER 
     WHERE MEM_ID=REC.ACID;
     
     DBMS_OUTPUT.PUT_LINE(REC.ACID||' '||V_NAME||' '||LPAD(V_PASS,12)||' '||TO_CHAR(REC.AAMT))
 END LOOP;
 END;
 
 5) LTRIM(C1[,C2]), RTRIM(C1[,C2])
 -LTRIM(C1[,C2]): �־��� ���ڿ� C1�� ���ʿ��� C2���ڿ��� ã�� ����, C2�� �����Ǹ� ������ ���ڿ��� ���� --C2�� �����Ǹ� ������ �����Ѵ�
 -RTRIM(C1[,C2]): �־��� ���ڿ� C1�� �����ʿ��� C2���ڿ��� ã�� ����, C2�� �����Ǹ� �������� ������ ����
 -�ܾ� ������ ������ �������� ����(REPLACE �Լ��� ���-�ܾ� ���� ����)
 - TRIM(C1[,C2])
 
 ��뿹)SELECT LTRIM('����ȭ ���� �Ǿ����ϴ�.','����'), 
              LTRIM('����ȭ ���� �Ǿ����ϴ�.','�� ��ȭ') 
      FROM DUAL;
 
 **MEMBER���̺��� MEM_LIKE �÷��� VARCHAR(40)���� CHAR(40)���� ����
 ALTER TABLE MEMBER 
    MODIFY MEM_LIKE CHAR(40);
COMMIT;

��뿹) ȸ�����̺��� ��̰� '����'�� ȸ���� ��ȸ�Ͻÿ�
     ALIAS�� ȸ����ȣ, ȸ����, ���, ���ϸ���
     SELECT MEM_ID AS ȸ����ȣ, 
            MEM_NAME AS ȸ����, 
           MEM_LIKE AS ���, 
            MEM_MILEAGE AS ���ϸ���
     FROM MEMBER
     WHERE MEM_LIKE=' ����';--��� ������ ��������� ������ �����ϴ� �Լ��� ����ߴٸ� �ٸ����ʵ� TRIM�� ��ߵȴ�. �ڵ����� RTRIM�� �ȵǼ� �ƴϸ� �񱳸� �� ������.

6) TRIM(C1)
- �־��� ���ڿ� C1�� �����ʰ� ���ʿ� �����ϴ� ��ȿ�� ������ ����--��ȿ�� ������ ���ڿ� ���� ����, ��ȿ�� ������ �ަU�̳� �����ʿ� �����ϴ� �����

7) SUBSTR(C1, START_INDEX[,N])
- �־��� ���ڿ� C1���� �κй��ڿ��� �����Ͽ� ���ο� ���ڿ� ��ȯ
- ���ڿ� C1���� START_INDEX ��ġ���� N���� �κй��ڿ� ����
- N�� �����ǰų� ���� ���ڿ��� �������� ū ���̸� START_INDEXT��ġ ������ ��� ���ڿ� ��ȯ
- START_INDEX�� �����̸� ��(������ ����) ó��
- ����� ���ڿ��̴�.--�ڹٴ� ���ڿ� �߽� ����Ŭ�� ���ڿ� �߽��� ����̴�. �ڹٴ� SUBSTR���� N�� ���°�� �ƴ϶� ������������ �����ش�

��뿹) 
SELECT
    substr('IL POSTINO',2,5),
    substr('IL POSTINO',2),
    substr('IL POSTINO',2,15),
    substr('IL POSTINO',-7,15)
FROM
    dual;
    
��뿹) ȸ�����̺��� 40�� ȸ���� ��ȸ�Ͻÿ�(���̴� �ֹι�ȣ�÷��� �̿�)
Alias�� ȸ����ȣ, ȸ����, �ֹι�ȣ, ����

SELECT
    mem_id ȸ����ȣ,
    mem_name ȸ����,
    mem_regno1 || '-'|| mem_regno2 �ֹι�ȣ,
    CASE WHEN SUBSTR(MEM_REGNO2,1,1)='3' OR SUBSTR(MEM_REGNO2,1,1)='4' 
    THEN TO_NUMBER(SUBSTR(TO_CHAR(SYSDATE),1,4)) - (TO_NUMBER(SUBSTR(mem_regno1,1,2))+2000) 
    ELSE TO_NUMBER(SUBSTR(TO_CHAR(SYSDATE),1,4)) - (TO_NUMBER(SUBSTR(mem_regno1,1,2))+1900)
    END AS ����
FROM MEMBER
WHERE TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1)=40;
  --EXTRACT�̾Ƴ��� ���� ���� ���ڷ� ���
WHERE TRUNC(CASE WHEN SUBSTR(MEM_REGNO2,1,1)='3' OR SUBSTR(MEM_REGNO2,1,1)='4' 
    THEN TO_NUMBER(SUBSTR(TO_CHAR(SYSDATE),1,4)) - (TO_NUMBER(SUBSTR(mem_regno1,1,2))+2000) 
    ELSE TO_NUMBER(SUBSTR(TO_CHAR(SYSDATE),1,4)) - (TO_NUMBER(SUBSTR(mem_regno1,1,2))+1900) END,-1)=40;
  --TRUNC�Լ�(��,-1)�� �����̴�. ������ ���ڸ����� ������ ���ش�. -1���ڸ��� 1�� �ڸ��� ������ ������
  --ROUND�� �ݿø��� �Ǵµ� TRUNC�� ������ ������
  
8) REPLACE(C1, C2[,C3])
-�־��� ���ڿ� C1�� ���Ե� C2���ڿ��� C3���ڿ��� ġȯ
-C3�� �����Ǹ� C2�� ã�� �����Ѵ�
-�ܾ� ���ο� �����ϴ� ���� �� ó���� ���

��뿹) SELECT PROD_NAME,
        REPLACE(PROD_NAME, '���', 'APPLE'),
        REPLACE(PROD_NAME, '����'),
        REPLACE(PROD_NAME, '��'),
        REPLACE(PROD_NAME, ' ')
       FROM PROD;
--RTRIM LTRIM�� ���� �����ʿ����� ã���� REPLACE�� �߰��� �־ ã�Ƽ� ���ټ� �ִ�.





