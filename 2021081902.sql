20210819-02
4. ��Ÿ������
1) BETWEEN
 - ������ ������ �� ���Ǵ� ������
 - ����� �� �ִ� Ÿ���� ����Ŭ���� ���Ǵ� ��� Ÿ�� ���
 (�������)
 �÷��� BETWEEN ��1 AND ��2 --���迬���ڿ�  AND�� ��ü ����
 
 ��뿹) ������̺��� �޿��� 5000�̸��̸� '���ӱ� ���', 5000-14999�̸� '��� �ӱ� ���', �� �̻��̸� '�� �ӱ� ���'�� 
 �����ȣ, �����, �μ��ڵ�. �޿����� �Բ� ������ ����Ͻÿ�.
 
 SELECT  EMPLOYEE_ID AS �����ȣ, 
         EMP_NAME AS �����, 
         DEPARTMENT_ID AS �μ��ڵ�, 
         SALARY AS �޿�,  
         CASE WHEN SALARY<5000 THEN '���ӱ� ���'
              WHEN SALARY BETWEEN 5000 AND 14999 THEN '��� �ӱ� ���'
              ELSE '�� �ӱ� ���'
         END AS ���
 FROM    HR.EMPLOYEES
 ORDER BY 3;
 
 ��뿹) ȸ�����̺��� ����ȸ���̸鼭 ���ϸ����� 5000�̻��� ȸ���� ȸ����ȣ, ȸ����, ����, ���ϸ����� ����Ͻÿ�.
        ��, ���ϸ����� ���� ȸ������ ����Ͻÿ�.
        
    SELECT
    mem_id ȸ����ȣ,
    mem_name ȸ����,
    mem_job ����,
    mem_mileage ���ϸ���
FROM
    oyk93.member
WHERE
    (
        substr(mem_regno2,1,1) = '2'
        OR    substr(mem_regno2,1,1) = '4'
    ) --Ÿ���� �����ֱ�, NOT AND OR ������� ����
    AND   mem_mileage >= 5000
ORDER BY
    4 DESC;
        --CASE AND THEN �� SELECT ������ � �÷��� ���ؼ� �÷��� ���� ������ ����� �� ���
  
2) LIKE ������
 - ���Ϻ� ������
 - ���ڿ� �� ������(���ڳ� ��¥Ÿ���� ������� ����)
 - '%','_'������ �����Ҷ� ���Ǵ� ���ϵ�ī��
  (1) %
   .'%'�� ���� ��ġ���� �� ���Ŀ� ���� ��� ���ڿ��� ����
   .EX) '��%' : '��'���� �����ϴ� ��� �ܾ�(���ڿ�)�� ����
        '%��' : '��'���� ������ ��� �ܾ�(���ڿ�)�� ����
  (2) _
   .'_'�� ���� ��ġ���� �ѱ��ڿ� ����
   .EX) '��_' : '��'���� �����ϰ� 2���ڷ� ������ ���ڿ��� ����
        '_��' : '��'���� ������ 2���ڷ� ������ ���ڿ��� ����
   (�������)
   EXPR LIKE ���Ϲ��ڿ� --EXPR �÷��� OR ���� ��/����
   
    SELECT *FROM OYK93.MEMBER
    WHERE MEM_NAME
    LIKE '��%';
    
��뿹) ��ǰ���̺��� '�ﺸ��ǻ��'('P10102')���� �ŷ��ϴ� ��ǰ������ ��ȸ�Ͻÿ�.
ALIAS�� ��ǰ�ڵ�, ��ǰ��, ���Դܰ�, ����ܰ�

SELECT PROD_ID ��ǰ�ڵ�, PROD_NAME ��ǰ��, PROD_COST ���Դܰ�, PROD_PRICE ����ܰ�
FROM OYK93.PROD
WHERE PROD_NAME LIKE '�ﺸ��ǻ��%';

��뿹) 2005�� 6�� �Ǹ������� ��ȸ�Ͻÿ�. ����,��ǰ��,����,�ܰ�,�ݾ��̸� ��¥������ ����Ͻÿ�.
SELECT
    TO_DATE(substr(a.cart_no,1,8)) ����,
    b.prod_name ��ǰ��,
    a.cart_qty ����,
    b.prod_price �ܰ�,
    a.cart_qty * b.prod_price �ݾ�
FROM
    cart a,
    prod b
WHERE
    a.cart_prod = b.prod_id --�������� �ܰ��� ��ǰ���� �������� ���ؼ��� ���ƾߵȴ�
--AND SUBSTR(A.CART_NO,1,6)='200506'
    AND   a.cart_no LIKE '200506%' --���ɸ鿡���� LIKE�� ������. �ڷᰡ ������ SUBSTR�� ���� ��Ȯ�ϰ� �������ִ°� ����
ORDER BY
    1;

��뿹) ȸ�����̺��� ȸ������ �������� '����'�� ȸ���� ȸ����ȣ, ȸ����, ����, ����, ���ϸ����� ����Ͻÿ�.
SELECT
    mem_id AS ȸ����ȣ,
    mem_name AS ȸ����,
    CASE
            WHEN (
                substr(mem_regno2,1,1) = '2'
                OR substr(mem_regno2,1,1) = '4'
            ) THEN 'F'
            ELSE 'M'
        END
    AS ����,
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM mem_bir) AS ����,
    mem_mileage AS ���ϸ���
FROM
    member
WHERE
    mem_add1 LIKE '����%';

��뿹) ��ǰ���̺��� ��ǰ�� '�Ｚ'�̶�� �ܾ ���Ե� ��� ��ǰ�� ��ȸ�Ͻÿ�.
ALIAS�� ��ǰ�ڵ�, ��ǰ��, �ŷ�ó�ڵ�, �з��ڵ��̴�.

SELECT PROD_ID AS ��ǰ�ڵ�, 
       PROD_NAME AS ��ǰ��, 
       PROD_BUYER AS �ŷ�ó�ڵ�, 
       PROD_LGU AS �з��ڵ�
FROM PROD
WHERE PROD_NAME LIKE '%�Ｚ%'; --���ڿ� �񱳿��� ����

3)IN ������
 - �־��� ǥ������ ���� ���õ� ���� �� ��� �ϳ��� ��ġ�ϸ� ��ü ������ ���� ������
 - ���õǴ� ���� �������� ��쿡�� ���� BETWEEN�� ����ϰ�, �ҿ������̰ų� ������ ��Ģ��
   ���� ���� ��� IN�����ڸ� ���
 - 'OR' ������, '���迬����ANY(SOME)'���� ġȯ ����
 --ANY�����ڴ� SOME�� �Ȱ��� IN�� ����ϴ�(��� �Ѱ��� ���̸� ���̴�=OR)
 ǥ���� IN(��1[,��2,...��N])
 
 ��뿹) ������̺��� �μ���ȣ 30,90,110���� ���� ��������� ��ȸ�Ͻÿ�
 ALIAS�� EMPLOYEE_ID �����ȣ, EMP_NAME ����� , DEPARTMENT_ID�μ���ȣ, HIRE_DATE �Ի���, JOB_ID �����ڵ�
--OR������
SELECT EMPLOYEE_ID �����ȣ, 
       EMP_NAME ����� , 
       DEPARTMENT_ID �μ���ȣ, 
       HIRE_DATE �Ի���, 
       JOB_ID �����ڵ�
FROM EMPLOYEES
WHERE DEPARTMENT_ID=30 OR DEPARTMENT_ID=90 OR DEPARTMENT_ID=110
ORDER BY 3;
--IN������
SELECT EMPLOYEE_ID �����ȣ, 
       EMP_NAME ����� , 
       DEPARTMENT_ID �μ���ȣ, 
       HIRE_DATE �Ի���, 
       JOB_ID �����ڵ�
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(30, 90, 110)
ORDER BY 3;
--ANY �Ǵ� SOME
SELECT EMPLOYEE_ID �����ȣ, 
       EMP_NAME ����� , 
       DEPARTMENT_ID �μ���ȣ, 
       HIRE_DATE �Ի���, 
       JOB_ID �����ڵ�
FROM EMPLOYEES
WHERE DEPARTMENT_ID=ANY (30, 90, 110)
ORDER BY 3;

 ��뿹) ������̺��� �μ���ȣ 30,90,110�� �̿��� �μ��� ���� ��������� ��ȸ�Ͻÿ�
 ALIAS�� EMPLOYEE_ID �����ȣ, EMP_NAME ����� , DEPARTMENT_ID�μ���ȣ, HIRE_DATE �Ի���, JOB_ID �����ڵ�

SELECT EMPLOYEE_ID �����ȣ, 
       EMP_NAME ����� , 
       DEPARTMENT_ID �μ���ȣ, 
       HIRE_DATE �Ի���, 
       JOB_ID �����ڵ�
FROM EMPLOYEES
WHERE DEPARTMENT_ID NOT IN(30, 90, 110)
ORDER BY 3;

SELECT EMPLOYEE_ID �����ȣ, 
       EMP_NAME ����� , 
       DEPARTMENT_ID �μ���ȣ, 
       HIRE_DATE �Ի���, 
       JOB_ID �����ڵ�
FROM EMPLOYEES
WHERE NOT DEPARTMENT_ID=ANY (30, 90, 110) --NOT�� ���� �ڿ� �ٿ��� �ȴ�.
ORDER BY 3;

4) EXISTS ������
- EXISTS ������ ����� ���� ����� �����ϸ� ���� ������� ������ ������ ��ȯ��
- EXISTS ������ �ݵ�� ���������� ����Ǿ����

(�������)
WHERE EXISTS (��������) --�ִ��� �������� ������. NULL�̸� �����̴�. �����̶� ������ ��ü�� ���̵ȴ�.

��뿹) �ҼӺμ��� ��ձ޿����� ���� �޿��� ���޹޴� ������� �����ϴ� �μ��� �μ���ȣ,�μ����� ����Ͻÿ�
SELECT
    a.department_id �μ���ȣ,
    a.department_name �μ���
FROM
    hr.departments a
WHERE
    EXISTS (
        SELECT
            1 --���� 1�� ��� (������ �����ϸ�), �������������� �ľ��ϱ� ������, �ƹ��ǹ� ���� �ڷ�,������ø�� ����, FROM WHERE�� ��� SELECT���� ���ϴ��� ������ ���� �鿩���⸦ ������
        FROM
            hr.employees b
        WHERE
            b.salary > (
                SELECT
                    AVG(c.salary)
                FROM
                    hr.employees c
                WHERE
                    b.department_id = c.department_id
            )b.department_id = a.department_id
    );                                                    
            AND                                      

** ���ڿ� ������ '||'
-�� ���ڿ��� �����Ͽ� �ϳ��� ���ڿ��� ��ȯ                                                                                                                                                                                                                                                                                   


        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        