SELECT REGION_ID HIT FROM COUNTRIES;
SELECT 1+'3' FROM DUAL; --����Ŭ�� ���� �켱 +�� ���ڸ� ���Ѵ� ||�̰��� ���ڸ� ���ϴ� ���̴�.
SELECT 10||'3' FROM DUAL;
SELECT COUNTRY_NAME ||'('|| REGION_ID ||')' AS CR_ID_NUM FROM  COUNTRIES;
--�̷� ���ϱ� �����ڸ� ������ ��Ī�� �Ἥ ������ ���ִ°� �߿��ϴ�

���ڵ带 �̾Ƴ����� ��+���� �����ڸ� ����ϸ� �ȴ�
^=�����ʴ� <>�����ʴ� !=�����ʴ�--�ϳ��� �����ؼ� ���� !=
SELECT * FROM COUNTRIES WHERE COUNTRY_ID = 'JP';
-- FROM �տ��� �÷��� �̾Ƴ��� ���̰� WHERE���� ����ϸ� ���ڵ带 �̾Ƴ� �� �ִ�
-- �׷��ٸ� �Ѵ� �̾� ������ �� ���?
SELECT COUNTRY_NAME FROM COUNTRIES WHERE COUNTRY_ID = 'JP';
--
SELECT * FROM COUNTRIES WHERE REGION_ID != 3;
--�� �����ڴ� ���������� ����ϸ� �ȴ�.
SELECT * FROM DEPARTMENTS WHERE MANAGER_ID IS NULL;
--NULL�� �˻��Ҷ��� �׻� IS NULL��, NULL�� �ƴ� ���� IS NOT NULL�� ���� NULL�� Ư���� ���̹Ƿ�












