20210819-01
3. ��������
    - ������(2��)�� ���ǵ��� ������ �� ���
    - not, and, or
    - �켱������ : NOT AND OR ���̴�.
    ---------------------------------
    �Է�             |  ���(AND)  ���(OR)
    A       B       |
    ---------------------------------
    0       0       |    0        0
    0       1       |    0        1
    1       0       |    0        1
    1       1       |    1        1
    
    --���찳 ���� AND���� ä��� ���� OR���� ���
    --AND�� ���� OR�� �����̴�.
                    
    ��뿹) ������̺��� �ٹ����� �̱��̰� �޿��� 8000�̻��� ����� �����ȣ, �����, �μ���ȣ, �޿��� ����Ͻÿ�
    SELECT A.EMPLOYEE_ID �����ȣ, 
           A.EMP_NAME �����, 
           B.DEPARTMENT_ID �μ���ȣ, 
           A.SALARY �޿�
    FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C
   WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
     AND C.COUNTRY_ID='US'
     AND B.LOCATION_ID=C.LOCATION_ID
     AND A.SALARY>=8000
 ORDER BY 3; --3��° ������
 
 SELECT * FROM EMPLOYEES;
    --DEPARTMENT_ID=DEPARTMENT_ID�ϸ� EMPLOYEES���� DEPARTEMENTS������ �˼� ��� ������ ���. �׷��� �Ҽ��� ��Ÿ���� �Ѵ�.
    
    ��뿹) 2005�� 1-3�� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�
    ALIAS�� ��ǰ�ڵ�,���Լ���,���Աݾ�
    --������ ���ؼ� �����ҰŸ� �׷����
    
    SELECT BUY_PROD ��ǰ�ڵ�,
           SUM(BUY_QTY) ���Լ���,
           SUM(BUY_QTY*BUY_COST) ���Աݾ�
    FROM   BUYPROD
    WHERE  BUY_DATE >= TO_DATE('20050101') AND BUY_DATE <= TO_DATE('20050331')
    -- BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050331') BETWEEN������ A�� B ���̿� ������ ���Ҷ� ����
    GROUP BY BUY_PROD;
    
    --��¥ ���� Ÿ�� �����ؾߵȴ�. SUBSTR�� ���ڿ� �Լ�
    --IN ANY SUM�����ڸ� ����Ͽ� ��¥�� ���� �� �ִ�.