2021-08-24-01
��뿹) EXTRACT
��� ���̺��� �Ի����� �̿��Ͽ� �ټӳ���� ���ϰ� �ټӳ���� 15�� �̻��� ����鿡�� Ư�� �󿩱��� �����Ϸ��Ѵ�.
�󿩱��� �޿��� 35%�̴�. ��� ������� �����ȣ, �̸�, �Ի���, �ټӳ��, �޿�, �󿩱�, ���޾��� ����Ͻÿ�.
��, �޿�, �󿩱�, ���޾��� �Ҽ� 1�ڸ����� ���

    SELECT  EMPLOYEE_ID �����ȣ, 
            EMP_NAME �̸�, 
            HIRE_DATE �Ի���, 
            EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE) �ټӳ��, 
            SALARY �޿�, 
            CASE WHEN (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE))>=15 
            THEN ROUND(SALARY*0.35,1)
            ELSE 0
            END AS �󿩱�, 
            CASE WHEN EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE)>=15 
            THEN ROUND(SALARY+SALARY*0.35,1)
            ELSE SALARY
            END AS  ���޾�
    FROM    HR.EMPLOYEES;

��뿹) ȸ�����̺��� �̹��� ������ ȸ���� ��ȸ�Ͻÿ�
ALIAS�� ȸ����ȣ, ȸ����, �������

SELECT      MEM_ID AS ȸ����ȣ, 
            MEM_NAME AS ȸ����, 
            MEM_BIR AS �������
FROM        MEMBER
WHERE       EXTRACT(MONTH FROM SYSDATE)-1 = EXTRACT(MONTH FROM MEM_BIR);

    3) NEXT_DAY(D1, C1), LAST_DAY(D1)
        - NEXT_DAY: D1���� ������ ��¥ ���� C1���μ����� ������ ��¥ ��ȯ
                    C1�� ��, ������, ȭ, ȭ����,...��, �Ͽ��� ������ ���� ����
        - LAST_DAY(D1): D1���� ������ ��¥�� �ش���� ������ ��¥ ��ȯ
                    ���� 2�� ���������� ��ȯ�� �ַ� ���(���� OR ��� ����)
     --��¥�� ���õ� ��� ������ �ѱ���� �Ǿ� �־ C1�� �ѱ۷� �Է��ؾߵȴ�.
                    
��뿹)  SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;
        SELECT LAST_DAY(SYSDATE) FROM DUAL; --�ַ� 2������ �������� ������� �����Ҷ� �ַ� ���� ����Ѵ�.
        
        SELECT NEXT_DAY(SYSDATE, 'ȭ����'),
               NEXT_DAY(SYSDATE, '������'),
               LAST_DAY(SYSDATE)
        FROM    DUAL;

��뿹) 2005�� 2�� ��ǰ�� �������踦 ��ȸ�Ͻÿ�.
ALIAS�� ��ǰ�ڵ�, �����հ�, ���Աݾ��հ�
    SELECT  BUY_PROD AS ��ǰ�ڵ�, 
            SUM(BUY_QTY) AS �����հ�, 
            SUM(BUY_QTY*BUY_COST) AS ���Աݾ��հ�
    FROM    BUYPROD
    WHERE   BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
    GROUP BY BUY_PROD
    ORDER BY 1;
--�Ⱓ�� ���������� ���
--�׷���̴� ��ǰ�ڵ�� �����ϸ� �� �ڵ尡 ���� �ͳ��� �� ���ļ� SUM ����� ��µȴ�

    4) ADD_MONTHS(D1, N1)
    - ��¥ D1�� ���� N1 ���� ���� ��¥ ��ȯ
    
��뿹) SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

��뿹) ������̺��� HIRE_DATE�� �ӽ� ��볯¥��� �����ϰ� �� ������� �ӽð���� ���� 3���� ���ΰ�� ���� 30, 50, 110 �μ��� ����鿡 ����
���� �Ի����� ��ȸ�Ͻÿ�.
    ALIAS�� �����ȣ,�����,�μ��ڵ�,�����ڵ�,�ӽð����,�����Ի���
    SELECT  EMPLOYEE_ID AS �����ȣ,
            EMP_NAME AS �����,
            DEPARTMENT_ID AS �μ��ڵ�,
            JOB_ID AS �����ڵ�,
            HIRE_DATE AS �ӽð����,
            ADD_MONTHS(HIRE_DATE, 3) AS �����Ի���
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID IN(30, 50, 110)
    ORDER BY DEPARTMENT_ID;

    5) MONTHS_BETWEEN(D1,D2)
    - �� ��¥ �ڷ� D1�� D2������ �޼��� �����ڷ�� ��ȯ
    
��뿹) SELECT   MEM_ID AS ȸ����ȣ,
                MEM_NAME AS ȸ����,
                MEM_BIR AS �������,
                EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS ����1,
                TRUNC(MONTHS_BETWEEN(SYSDATE, MEM_BIR)/12)||'�� '||
                ROUND(MOD(MONTHS_BETWEEN(SYSDATE, MEM_BIR),12))||'����' AS ����2
        FROM    MEMBER;






