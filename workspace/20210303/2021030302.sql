2021-03-03-02)
��뿹) �ŷ�ó���̺�(BUYER)�� �̿��Ͽ� 2005�� 7�� �ŷ�ó��
       ������Ȳ�� ��ȸ�Ͻÿ�.
       ALIAS�� �ŷ�ó�ڵ�, �ŷ�ó��, �Ǹűݾ��հ��̴�
       
       SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
              A.BUYER_NAME AS �ŷ�ó��,
              SUM(B.CART_QTY * C.PROD_PRICE) AS �Ǹűݾ��հ�
         FROM BUYER A, CART B, PROD C     
        WHERE B.CART_NO LIKE '200507%'  
          AND A.BUYER_ID = C.PROD_BUYER
          AND C.PROD_ID = B.CART_PROD
        GROUP BY A.BUYER_ID, A.BUYER_NAME
        ORDER BY 1;
        
**���� �ڷḦ �����ϴ� �޿�������̺��� �����Ͻÿ�
  1)���̺� �� : SAL_GRADE
  2)�÷���
    GRADE    CHAR(2)    PK
    LSAL     NUMBER(8,2)
    HSAL     NUMBER(8,2)
  3)������
  -----------------------------------------------
    GRADE        LSAL         HSAL
  -----------------------------------------------
      01         2000         2999
      02         3000         3999
      03         4000         5999
      04         6000         8999
      05         9000        11999
      06         12000       14999
      07         15000       18999
      08         19000       23999
      09         24000       29999
      10         30000      100000  
   -----------------------------------------------
   
   CREATE TABLE SAL_GRADE(
        GRADE  CHAR(2),
        LSAL   NUMBER(8,2),
        HSAL   NUMBER(8,2),
      CONSTRAINT PK_SAL_GRADE PRIMARY KEY(GRADE)  
   );
   
   INSERT INTO SAL_GRADE VALUES('01',2000,2999);
   INSERT INTO SAL_GRADE VALUES('02',3000,3999);
   INSERT INTO SAL_GRADE VALUES('03',4000,5999);
   INSERT INTO SAL_GRADE VALUES('04',6000,8999);
   INSERT INTO SAL_GRADE VALUES('05',9000,11999);
   INSERT INTO SAL_GRADE VALUES('06',12000,14999);
   INSERT INTO SAL_GRADE VALUES('07',15000,18999);
   INSERT INTO SAL_GRADE VALUES('08',19000,23999);
   INSERT INTO SAL_GRADE VALUES('09',24000,29999);
   INSERT INTO SAL_GRADE VALUES('10',30000,100000);
   
COMMIT;   

SELECT * FROM SAL_GRADE

2. NON-EQUI JOIN
  - �������ǿ� ���� �����ڰ� '='�� �ƴ� ���ο���
  - IN, ANY, SOME���� �ַ� ���
  
��뿹) ������̺�(EMPLOYEES)�� �޿�������̺�(SAL_GRADE)
       �� ����Ͽ� 60�� �μ��� ���� ������� �޿��� �����
       ��ȸ�Ͻÿ�
       ALIAS�� �����ȣ, �����, �޿�, ����̴�.
       
       SELECT A.EMPLOYEE_ID AS �����ȣ,
              A.EMP_NAME AS �����,
              A.SALARY AS �޿�,
              TO_NUMBER(B.GRADE) AS ���
         FROM EMPLOYEES A, SAL_GRADE B
        WHERE A.SALARY BETWEEN B.LSAL AND B.HSAL
          AND A.DEPARTMENT_ID = 60
        ORDER BY 3 DESC;
        
��뿹) ������̺��� ��ձ޿����� ���� �޿��� ���޹޴� ��������� 
       ��ȸ�Ͻÿ�
       ALIAS�� �����ȣ, �����, �޿�, �μ���, ��å�̴�
       
       SELECT A.EMPLOYEE_ID AS �����ȣ,
              A.EMP_NAME AS �����,
              A.SALARY AS �޿�,
              D.SAL AS ��ձ޿�,
              B.DEPARTMENT_NAME AS �μ���,
              C.JOB_TITLE AS ��å��
         FROM EMPLOYEES A, DEPARTMENTS B, JOBS C,
              (SELECT ROUND(AVG(SALARY)) AS SAL 
                 FROM EMPLOYEES) D
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
          AND A.JOB_ID = C.JOB_ID
          AND A.SALARY >= D.SAL
        ORDER BY 3 DESC;  
         
        SELECT A.EMPLOYEE_ID AS �����ȣ,
              A.EMP_NAME AS �����,
              A.SALARY AS �޿�,
              (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEES) AS ��ձ޿�,
              B.DEPARTMENT_NAME AS �μ���,
              C.JOB_TITLE AS ��å��
         FROM EMPLOYEES A, DEPARTMENTS B, JOBS C
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
          AND A.JOB_ID = C.JOB_ID
          AND A.SALARY >= (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEES)
        ORDER BY 3 DESC;   
              
   
    
