2021-09-08-02) �б⹮
- ���α׷��� ����� �б⹮�� ���� ��� ����
- IF, CASE WHEN �� ����

1) IF ��
. ���� �θ� ���Ǵ� �б� ���

(�������1)
IF ����-1 THEN
   ��ɹ�-1;
[ELSE
   ��ɹ�-2;]
END IF;

(�������2)
IF ����-1 THEN
   ��ɹ�-1;
ELSIF ����-2 THEN
   ��ɹ�-2;
   :
ELSE
   ��ɹ�-N
END IF;

(�������3)
IF ����-1 THEN--�߰�ȣ�� ����̴�
 IF ����-2 THEN
   ��ɹ�-2;
 ELSE
   ��ɹ�-3;
 END IF;
ELSE
   ��ɹ�-1
END IF;

��뿹) �⵵ �ϳ��� �Է� �޾� ����(LEAP YEAR)���� ������� �Ǻ��ϴ� ��� �ۼ�
����=�ش�⵵�� 4�� ����̸鼭 100�� ����� �ƴ� ���̰ų� �Ǵ� 400�� ����� �Ǵ� ��

ACCEPT P_YEAR PROMPT '�⵵�Է�: ' 

DECLARE 
    V_YEAR NUMBER(4):=TO_NUMBER('&P_YEAR');--''�ȿ� &������ ���� ���̴�. ��Ģ�̴�. ���� ���� ; �̴�.
    V_RES VARCHAR2(100);

BEGIN
    IF 
    (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)!=0) OR MOD(V_YEAR,400)=0 
    THEN
    V_RES:=V_YEAR||'�� �����Դϴ�.';
    ELSE
    V_RES:=V_YEAR||'�� ����Դϴ�.';
    END IF;
    DBMS_OUTPUT.PUT_LINE('���: '||V_RES);
END;
--2������ 29�ϱ��� ������ �����Դϴ�.
2) CASE WHEN~ THEN ��
. ǥ�� SQL���� SELECT ������ ����ߴ� ǥ���� CASE WHEN ~THEN�� ����
. ���� END CASE ��
(�������-1)--SWITCH���� ����ϴ�
CASE ����|����| 
     WHEN ��1 THEN 
          ���1;
     WHEN ��2 THEN
          ���2;
     ELSE ���N;
END CASE;
     
(�������-2)
CASE WHEN ����1 THEN 
          ���1;
     WHEN ����2 THEN
          ���2;
          :
     ELSE ���N;
END CASE;

��뿹) ȸ�� ���̺��� ���ϸ����� �˻��Ͽ� �� ���� 5000�̻��̸� ����� 'VIP', 2000�̻��̸� '���' �� �����̸� '�������'
�޽����� ����ϴ� SQL�� �ۼ��ϵ� ����� ����ϴ� �κ��� �Լ��� �ۼ��Ͻÿ�
(�Լ�)
CREATE OR REPLACE FUNCTION FN_MILE(
    P_MILE IN NUMBER)--�Ű������δ� P_MILE�� Ÿ���� IN �޾Ƶ��϶� OUT�� ��������
    RETURN VARCHAR2--��ȯ������ Ÿ��
IS
    V_MESS VARCHAR2(100);--���� ������ ��ȯ���ش�. 
BEGIN
    CASE WHEN P_MILE >=5000 THEN
                V_MESS:='VIP';
         WHEN P_MILE >=2000 THEN
                V_MESS:='NORMAL';
         ELSE
                V_MESS:='WARNING';     
END CASE;
RETURN V_MESS;
END;

����)
SELECT  MEM_ID AS ȸ����ȣ,
        MEM_NAME AS ȸ����,
        MEM_MILEAGE AS ���ϸ���,
        FN_MILE(MEM_MILEAGE) AS ���
FROM MEMBER;
