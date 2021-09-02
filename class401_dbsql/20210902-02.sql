2021-0902-02)��������
    -���������� �ϳ��� SQL�� �ȿ� ������ ���Ǵ� (�߰����) �� �ٸ� SELECT��
    -��������� ����ϴ� �ۿ� �����ϴ� ������ ���� ������ ��
    -����
    
.���������� ������ ���ο� ���� 
    -������ �ִ� �������� VS ������ ���� ��������
    
.���Ǵ� ��ġ�� ����
    -�Ϲݼ�������: SELECT���� ���
    -IN-LINE ��������: FROM���� ���
    -��ø��������: WHERE���� ���
    -������ �����ʿ� ���������� �;ߵȴ�.
.�ݺ��Ǵ� ���� ���� ����
    -������ �������� VS ������ ��������
    -���������� JOIN������ ���̱� ���� ���� �� ����
    -�˷��������� ���ǿ� �ٰ��Ͽ� ���� �˻��ϴ� ��� ����
    -������� �������� ���ϱ� ���ؼ��� =�� �ƴ϶� IN�� ����
    EX) WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM HR.EMPLOYEES WHERE DEPARTMENT_ID=30)

1. ���������� ��������
- ���������� ���� ���̺�� ���������� ���� ���̺� ���̿� JOIN���� ������� ���� ���

��뿡) ������̺��� ����Աݺ��� �޿��� �� ���� ������� ��ȸ�Ͻÿ�
(��������: �޿��� ����ӱݺ��� �� ���� �����
SELECT COUNT(*) AS �����
FROM HR.EMPLOYEES
WHERE SALARY>(����ӱ�);

(��������: ����ӱ�)
SELECT ROUND(AVG(SALARY))
FROM  HR.EMPLOYEES;

(����)
SELECT COUNT(*) AS �����
FROM HR.EMPLOYEES
WHERE SALARY> (SELECT ROUND(AVG(SALARY))
FROM  HR.EMPLOYEES); 107�� ����

(������ �ִ� ��������)(FROM���� ��������)(FROM���� ��������Ǿ� 1���� ����� ����ó�� ���ȴ�)(���������� =�̿ܿ��� �����ڰ� ���ɼ� �ִ�)
SELECT COUNT(*) AS �����
FROM HR.EMPLOYEES A, (SELECT ROUND(AVG(SALARY)) AS SAL
                        FROM  HR.EMPLOYEES) B
WHERE A.SALARY>B.SAL; �������ִ� ��������
--���������� ���������� ����ϴ� �κ��� �������� �˾ƾ� �Ѵ�.

��뿹) ������̺�� �����������̺� �����ȣ�� �����ڵ尡 ������ ����� ��ȸ�Ͻÿ�
ALIAS�� �����ȣ, �����, �����ڵ�

SELECT EMPLOYEE_ID AS �����ȣ,
EMP_NAME AS �����,
JOB_ID AS �����ڵ�
FROM HR.EMPLOYEES
WHERE (EMPLOYEE_ID,JOB_ID)=(�����������̺� �����ȣ�� �����ڵ带 ��ȸ)
--�Ѳ����� �ΰ��� ���ϴ� ��

(�����������̺� �����ȣ�� �����ڵ带 ��ȸ)
SELECT EMPLOYEE_ID, JOB_ID
FROM HR.JOB_HISTORY;
--���°��� �����ȣ ���̺��� ��� �Ȱ��ٸ�

����
SELECT EMPLOYEE_ID AS �����ȣ,
EMP_NAME AS �����,
JOB_ID AS �����ڵ�
FROM HR.EMPLOYEES 
WHERE (EMPLOYEE_ID,JOB_ID)IN(SELECT EMPLOYEE_ID, JOB_ID
                            FROM HR.JOB_HISTORY);
--������ �������̰� �������� �������̸� IN�� ����.
--���� ������ ��� ���� �÷����� ���ؾ� �ȴ�.