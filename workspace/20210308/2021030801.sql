2021-03-08-01)
3. ������ ��������
  - ���������� ����� 1���� ������ ������ ���
  - ���迬���ڰ� ���� ���(����)
  
��뿹) ȸ�����̺��� ȸ���� ��� ���ϸ������� ���� ���ϸ����� ������ ȸ������
       alias�� ȸ����ȣ, ȸ����, ���ϸ���, ��� ���ϸ���
       
       SELECT MEM_ID AS ȸ����ȣ,
              MEM_NAME AS ȸ����,
              MEM_MILEAGE AS ���ϸ���,
              (SELECT ROUND(AVG(MEM_MILEAGE))
                 FROM MEMBER) AS "��� ���ϸ���"
         FROM MEMBER
        WHERE (SUBSTR(MEM_REGNO2,1,1),MEM_MILEAGE) IN (SELECT SUBSTR(MEM_REGNO2,1,1),
                                                              AVG(MEM_MILEAGE)
                                                         FROM MEMBER
                                                        GROUP BY SUBSTR(MEM_REGNO2,1,1));
                                                        
��뿹) 2005�� 6�� ��� ȸ���� ������Ȳ�� ��ȸ�Ͻÿ�.
       ALIAS�� ȸ����ȣ, ȸ����, ���ż����հ�, ���űݾ��հ�
       
       SELECT B.MEM_ID AS ȸ����ȣ,
              B.MEM_NAME AS ȸ����,
              NVL(D.SQTY,0) AS ���ż����հ�,
              NVL(D.SAMT,0) AS ���űݾ��հ�
         FROM MEMBER B, (SELECT CART_MEMBER AS DID,
                                SUM(CART_QTY) AS SQTY,
                                SUM(CART_QTY * PROD_PRICE) AS SAMT
                           FROM CART, PROD
                          WHERE CART_PROD = PROD_ID
                            AND CART_NO LIKE '200506%'
                       GROUP BY CART_MEMBER) D --(2005�� 6�� ȸ���� ������Ȳ --��������) D
        WHERE B.MEM_ID = D.DID(+); 
  
        
SELECT CART_MEMBER,
       SUM(CART_QTY) AS SQTY,
       SUM(CART_QTY * PROD_PRICE) AS SAMT
  FROM CART, PROD
 WHERE CART_PROD = PROD_ID
   AND CART_NO LIKE '200506%'
 GROUP BY CART_MEMBER;  
 
4. ������ ��������
  - �������� ����� ��ȯ�ϴ� ��������
  - IN, ANY, EXISTS ���� �����ڿ� ����
  
��뿹) ������̺��� 2007�� ���Ŀ� �Ի��� ��� �� 2004�⵵�� �Ի��� �������
       �޿����� �� ���� �޿��� �޴� ����� ��ȸ�Ͻÿ�.
       ALIAS�� �����ȣ, �����, �Ի���, �޿�, ��å��
       
       SELECT A.EMPLOYEE_ID AS �����ȣ,
              A.EMP_NAME AS �����,
              A.HIRE_DATE AS �Ի���,
              A.SALARY AS �޿�,
              B.JOB_TITLE AS ��å��
         FROM EMPLOYEES A, JOBS B
        WHERE A.HIRE_DATE >= TO_DATE('20070101')
          AND A.SALARY >= ANY(SELECT SALARY
                                FROM EMPLOYEES 
                               WHERE EXTRACT(YEAR FROM HIRE_DATE) = 2004)
          AND A.JOB_ID = B.JOB_ID 
        ORDER BY 1;
        
        
       (EXISTS ������ ���) 
        SELECT A.EMPLOYEE_ID AS �����ȣ,
              A.EMP_NAME AS �����,
              A.HIRE_DATE AS �Ի���,
              A.SALARY AS �޿�,
              B.JOB_TITLE AS ��å��
         FROM EMPLOYEES A, JOBS B
        WHERE A.HIRE_DATE >= TO_DATE('20070101')
          AND EXISTS(SELECT SALARY
                       FROM EMPLOYEES 
                      WHERE EXTRACT(YEAR FROM HIRE_DATE) = 2004
                        AND A.SALARY >= SAL)
          AND A.JOB_ID = B.JOB_ID 
        ORDER BY 1;

����] �μ����̺�� ������̺��� �̿��Ͽ� ���� ������ �ذ��Ͻÿ�.
     �����μ�(PARENT_ID)�� 90���� �����μ��� ���� ���� �� 
     ������ ���� �μ��� ��ձ޿����� ���� �޿��� ���� �޴�
     ������� ��ȸ
     ALIAS�� �����ȣ, �����, �μ���ȣ, �μ���, ��ձ޿�
     ��, INLINE SUBQUERY�� �ۼ��Ͻÿ�.
     
     SELECT A.EMPLOYEE_ID AS �����ȣ,
            A.EMP_NAME AS �����,
            D.DID AS �μ���ȣ,
            D.DNAME AS �μ���,
            A.SALARY AS �޿�,
            ROUND(D.EAVG,1) AS ��ձ޿�
       FROM EMPLOYEES A, (SELECT C.DEPARTMENT_ID AS DID,
                                 C.DEPARTMENT_NAME AS DNAME,
                                 ROUND(AVG(B.SALARY),1) AS EAVG
                            FROM EMPLOYEES B, DEPARTMENTS C
                           WHERE PARENT_ID = 90
                             AND B.DEPARTMENT_ID = C.DEPARTMENT_ID
                           GROUP BY C.DEPARTMENT_ID, C.DEPARTMENT_NAME) D
      WHERE A.DEPARTMENT_ID = D.DID
        AND A.SALARY >= D.EAVG
      ORDER BY 1;  
  
  
      
SELECT C.DEPARTMENT_ID AS DID,
       C.DEPARTMENT_NAME AS DNAME,
       ROUND(AVG(B.SALARY)) AS EAVG
  FROM EMPLOYEES B, DEPARTMENTS C
 WHERE PARENT_ID = '90'
   AND B.DEPARTMENT_ID = C.DEPARTMENT_ID
 GROUP BY C.DEPARTMENT_ID, C.DEPARTMENT_NAME

       







  
       