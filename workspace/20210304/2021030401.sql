2021-03-04-01)
3. SELF JOIN
  - �ϳ��� ���̺� 2�� �̻��� ���̺� ��Ī�� �ο��Ͽ� ���� �ٸ�
    ���̺�� �����Ͽ� ���ο��� ����

��뿹) ȸ�����̺��� ������ '�ֺ�'�� ȸ������ ��� ���ϸ�������
       ���� ���ϸ����� ������ ȸ���� ��ȸ�Ͻÿ�
       ALIAS�� ȸ����ȣ, ȸ����, ����, ���ϸ���
       
       SELECT A.MEM_ID AS ȸ����ȣ,
              A.MEM_NAME AS ȸ����,
              A.MEM_JOB AS ����,
              B.AMILE AS ��ո��ϸ���,
              A.MEM_MILEAGE AS ���ϸ���
         FROM MEMBER A, (SELECT ROUND(AVG(MEM_MILEAGE),2) AS AMILE
                           FROM MEMBER
                          WHERE MEM_JOB = '�ֺ�') B
        WHERE A.MEM_MILEAGE >= B.AMILE;
          
��뿹) ������̺��� ��å�� ����������(SA_MAN)DLS 145�� �������
       �޿��� ���� �޴� ����� ��ȸ�Ͻÿ�
       ALIAS�� �����ȣ, �����, �Ի���, ��å�ڵ�, �޿�
       
       SELECT A.EMPLOYEE_ID AS �����ȣ,
              A.EMP_NAME AS �����,
              A.HIRE_DATE AS �Ի���,
              A.JOB_ID AS ��å�ڵ�,
              A.SALARY AS �޿�
         FROM EMPLOYEES A, EMPLOYEES B
        WHERE B.EMPLOYEE_ID = 145
          AND A.SALARY >= B.SALARY
       
          