2021-03-03-01)
**nulló���Լ�
1) IS[NOT]NULL
  - Ư�� �÷��� ���� NULL���� �Ǵ�
  - NULL�� '='��ȣ�� �Ǵ��� �� ����
  (�������)
  �÷��� IS [NOT] NULL
  
��뿹) ������̺��� ���������ڵ�(COMMISSION_PCT)�� NULL�� �ƴ�
       ��������� ��ȸ�Ͻÿ�
       
       SELECT A.EMPLOYEE_ID AS �����ȣ,
              A.EMP_NAME AS �����,
              B.DEPARTMENT_NAME AS �μ���,
              A.COMMISSION_PCT AS ��������,
              A.SALARY AS �޿�
         FROM EMPLOYEES A, DEPARTMENTS B
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
          AND A.COMMISSION_PCT IS NOT NULL;

2) NVL(c, val)
 - NULLó�� �Լ� �� ���� �θ� ���
 - c�÷��� ���� NULL�̸� val���� ��ȯ�ϰ�, NULL�� �ƴϸ� �ڽ��� ���� ��ȯ
 - �ַ� ����Ŀ� ����
 - c�� val�� ������ Ÿ���� ���ƾ� ��
   
��뿹) ������̺��� ���������� ���� ���ʽ��� ����ϰ� �̹��� ���޾��� 
       ��ȸ�Ͻÿ�
       ���ʽ� = �޿� * ��������
       ���޾� = �޿� + ���ʽ�
       ALIAS�� �����ȣ, �̸�, �μ���, ����, ��������, ���ʽ�, ���޾��̴�.
       
       SELECT A.EMPLOYEE_ID AS �����ȣ,
              A.EMP_NAME AS �̸�,
              B.DEPARTMENT_NAME AS �μ���,
              A.SALARY AS ����,
              NVL(TO_CHAR(A.COMMISSION_PCT,'0.00'),'����') AS ��������,
              A.SALARY * NVL(A.COMMISSION_PCT,0) AS ���ʽ�,
              A.SALARY + (A.SALARY * NVL(A.COMMISSION_PCT,0))���޾�
         FROM EMPLOYEES A, DEPARTMENTS B
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        ORDER BY 1
        
3) NVL2(c, val1, val2)
  - c�� ���� NULL�� �ƴϸ� VAL1�� NULL�̸� VAL2�� ���� ��ȯ
  - val1�� val2�� ���� ������ Ÿ���̾�� ��

UPDATE MEMBER
   SET MEM_HP = NULL
 WHERE MEM_ID IN ('d001','f001','r001','p001','s001');

COMMIT;
  
��뿹) ȸ�����̺��� ȸ������ �ڵ�����ȣ�� ��ȸ�Ͻÿ�.
       �ڵ��� ��ȣ�� ������ '����ó ����'�� ����Ͻÿ�(NVL2���)
       ALIAS�� ȸ����ȣ, ȸ����, ����ó�̴�
       
       SELECT MEM_ID AS ȸ����ȣ,
              MEM_NAME AS ȸ����,
              NVL2(MEM_HP,MEM_HP,'����ó ����') AS ����ó
         FROM MEMBER;
         
**
UPDATE MEMBER
   SET MEM_MILEAGE = NULL
 WHERE MEM_ID IN ('d001','f001','r001','p001','s001');
 
��뿹) ȸ�����̺��� ȸ���� ���ϸ����� �˻��Ͽ� null�� �ƴϸ�
       '����ȸ��' null�̸� '��Ȱ�� ȸ��'�� ������ ����Ͻÿ�
    
      SELECT MEM_ID AS ȸ����ȣ,
             MEM_NAME AS ȸ����,
             NVL(MEM_MILEAGE,0) AS ���ϸ���,
             NVL2(TO_CHAR(MEM_MILEAGE),'����ȸ��','��Ȱ�� ȸ��') AS ���
        FROM MEMBER;

**�����Լ�
1. ROLLUP
  - GROUP BY���� ���� ���Ǿ� ������ �հ�� ��ü�հ� ��ȯ
  (�������)
  GROUP BY ROLLUP(�÷���1, �÷���2,..)
  . ������ ������ ���� �÷����� �� + 1������
  . �÷����� ����� ���� �����ʿ��� ���� ���� �������� ����

��뿹) �����ܾ����̺�(KOR_LOAN_STATUS)���� 2011~2013�� ����
       �⵵��, ������ �����ܾ��� ���Ͻÿ�
       ALIAS�� �⵵, ����, �����ܾ��հ�
       
       (ROLLUP �̻��)
       SELECT SUBSTR(PERIOD,1,4) AS �⵵,
              REGION AS ����,
              SUM(LOAN_JAN_AMT) AS �����ܾ��հ�
         FROM KOR_LOAN_STATUS
        WHERE SUBSTR(PERIOD,1,4) BETWEEN '2011' AND '2013'
        GROUP BY SUBSTR(PERIOD,1,4),REGION
        ORDER BY 1;
        
        (ROLLUP ���)
       SELECT SUBSTR(PERIOD,1,4) AS �⵵,
              REGION AS ����,
              SUM(LOAN_JAN_AMT) AS �����ܾ��հ�
         FROM KOR_LOAN_STATUS
        WHERE SUBSTR(PERIOD,1,4) BETWEEN '2011' AND '2013'
        GROUP BY ROLLUP(SUBSTR(PERIOD,1,4),REGION)
        ORDER BY 1;
        
��뿹) �����ܾ����̺�(KOR_LOAN_STATUS)���� 2013�⵵
       ������, ���к�, ���� �����ܾ��� ���Ͻÿ�
       ALIAS�� ����, ���ⱸ��, ��, �����ܾ��հ�
       
       (ROLLUP ������)
       SELECT REGION AS ����,
              GUBUN AS ���ⱸ��,
              SUBSTR(PERIOD,5) AS ��,
              SUM(LOAN_JAN_AMT) AS �����ܾ��հ�
         FROM KOR_LOAN_STATUS
        WHERE SUBSTR(PERIOD,1,4) = '2013'
        GROUP BY REGION, GUBUN,SUBSTR(PERIOD,5)
        ORDER BY 1;
        
       (ROLLUP ����)
       SELECT REGION AS ����,
              GUBUN AS ���ⱸ��,
              SUBSTR(PERIOD,5) AS ��,
              SUM(LOAN_JAN_AMT) AS �����ܾ��հ�
         FROM KOR_LOAN_STATUS
        WHERE SUBSTR(PERIOD,1,4) = '2013'
        GROUP BY ROLLUP(REGION, GUBUN,SUBSTR(PERIOD,5))
        ORDER BY 1;

�κ� ROLLUP
 - GROUP BY ������ �÷����� ROLLUP�ۿ��� ����� ���
        
       (�κ� ROLLUP ����)
       SELECT REGION AS ����,
              GUBUN AS ���ⱸ��,
              SUBSTR(PERIOD,5) AS ��,
              SUM(LOAN_JAN_AMT) AS �����ܾ��հ�
         FROM KOR_LOAN_STATUS
        WHERE SUBSTR(PERIOD,1,4) = '2013'
        GROUP BY ROLLUP(REGION, GUBUN),SUBSTR(PERIOD,5)
        ORDER BY 1; 
 
 2. CUBE
   - ROLLUP�� ��������� ����
   - CUBE ���� '()'�ȿ� ����� �÷��� ������ ��� ����� ����ŭ�� 
     ������ �հ踦 ��ȯ, N���� �÷��� ���� ��� 2�� N�� ������
     �հ� ��ȯ
     
     
 



