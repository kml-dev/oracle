2021-02-25-01)
  ��뿹) ������̺��� �� �μ��� �޿��հ踦 ���Ͻÿ�.
         alias�� �μ���ȣ, �޿��հ�
         
         select employee_id as �μ���ȣ,
                sum(salary) as �޿��հ�
           from employees
          group by employee_id
         
  ��뿹) 2005�� 1~6������ ����, �ŷ�ó�� ���������� ��ȸ�Ͻÿ�
         alias�� ��, �ŷ�ó�ڵ�, ���Լ�����, ���Աݾ��հ�
         
         SELECT EXTRACT(MONTH FROM BUY_DATE)AS ��,
                C.BUYER_ID AS �ŷ�ó�ڵ�,
                SUM(BUY_QTY) AS ���Լ�����,
                SUM(BUY_COST * BUY_QTY) AS ���Աݾ��հ�
           FROM BUYPROD A, PROD B, BUYER C
          WHERE A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630')
            AND A.BUY_PROD = B.PROD_ID -- ��������
            AND B.PROD_BUYER = C.BUYER_ID -- ��������
          GROUP BY EXTRACT(MONTH FROM A.BUY_DATE), C.BUYER_ID 
          ORDER BY 2;
         
  ��뿹) 2005�� 5�� ȸ���� �Ǹ������� ��ȸ�Ͻÿ�
         alias�� ȸ����, �Ǹż����հ��̸� �Ǹż����� 20�� �̻��� 
         ȸ���� ��ȸ�Ͻÿ�
         
         SELECT B.MEM_NAME AS ȸ����,
                SUM(A.CART_QTY) AS �Ǹż����հ�
           FROM CART A, MEMBER B
          WHERE A.CART_MEMBER = B.MEM_ID --��������
            AND A.CART_NO LIKE '200505%' --�Ϲ�����
          GROUP BY B.MEM_NAME
         HAVING SUM(A.CART_QTY) >= 20
          ORDER BY 2 DESC;
                   
  ��뿹) 2005�� 5�� �Ϻ�, ��ǰ�� �Ǹ������� ��ȸ�Ͻÿ�
         alias�� ����, ��ǰ�ڵ�, �Ǹż����հ�, �Ǹűݾ��հ�
         
         SELECT SUBSTR(B.CART_NO,7,2) AS ����,
                B.CART_PROD AS ��ǰ�ڵ�,
                SUM(CART_QTY) AS �Ǹż����հ�,
                SUM(B.CART_QTY * A.PROD_PRICE)�Ǹűݾ��հ�
           FROM PROD A, CART B
          WHERE B.CART_NO LIKE '200505%'
            AND A.PROD_ID = B.CART_PROD
          GROUP BY SUBSTR(B.CART_NO,7,2),B.CART_PROD
          ORDER BY 1 ASC;
          
           
2. AVG(col)
  - col�� ����� �������� ��հ��� ���Ͽ� ��ȯ
  
��뿹) ȸ�����̺��� ȸ���� ���� ��ո��ϸ����� ��ȸ�Ͻÿ�
       
       SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1'
                     OR SUBSTR(MEM_REGNO2,1,1) = '3' THEN '����ȸ��'
                   ELSE '����ȸ��' END AS ����,
              TRUNC(AVG(MEM_MILEAGE)) AS ��ո��ϸ���
         FROM MEMBER
        GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1'
                        OR SUBSTR(MEM_REGNO2,1,1) = '3' THEN '����ȸ��'
                      ELSE '����ȸ��' END
                           
����) ȸ�����̺��� ȸ���� ���ɴ뺰 ��� ���ϸ����� ���Ͻÿ�
     alias�� ����, ��ո��ϸ����̸� ���п��� '10��','20��'..
     ���� ���� ����Ѵ�
     
     
     SELECT TRUNC(EXTRACT(year from sysdate) - EXTRACT(year from mem_bir),-1)||'��' AS ����,
            ROUND(AVG(MEM_MILEAGE)) AS ��ո��ϸ���
       FROM MEMBER
      GROUP BY TRUNC(EXTRACT(year from sysdate) - EXTRACT(year from mem_bir),-1)||'��'
      ORDER BY 1 ASC;
          
��뿹) ������̺��� ������ ��ձ޿��� �Ҽ������ڸ����� ���Ͽ� ����Ͻÿ�
       alias�� ������, ��ձ޿�
       
       SELECT B.JOB_TITLE AS ������,
              ROUND(AVG(SALARY),1) AS ��ձ޿�
         FROM EMPLOYEES A, JOBS B
        WHERE A.JOB_ID = B.JOB_ID
        GROUP BY B.JOB_TITLE
        ORDER BY 2 DESC;
       
��뿹) �����ܾ����̺��� 2013�� ������ ��մ����ܾ��� ��ȸ�ϵ�
       ��մ����ܾ��� ���� ���� 3�� �õ��� ����Ͻÿ�.
       
       SELECT A.R1 AS ����,
              A.lAVG AS ��մ����ܾ�
         FROM (SELECT REGION AS R1,
                      TO_CHAR(ROUND(AVG(LOAN_JAN_AMT),1),'999,999.9') AS LAVG
                 FROM KOR_LOAN_STATUS
                WHERE PERIOD LIKE '2013%'
                GROUP BY REGION
                ORDER BY 2 DESC) A
        WHERE ROWNUM <= 3;

3. COUNT(*|col)
  - �׷쳻�� �ڷ�(��)�� ���� ��ȯ
  - '*'�� �÷����� ����ص� ���� ��� ��ȯ��
    ��, �ܺ����ο� ����� �� '*'�� ����ؼ� �ȵ�. �ַ� �⺻Ű �÷����� ���
    
��뿹) ������̺��� �μ��� ��� ���� ��ȸ�Ͻÿ�
SELECT DEPARTMENT_ID AS �μ��ڵ�,
       COUNT(*) AS �����,
       COUNT(EMP_NAME) AS �����
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY 1;
 
��뿹) ��ٱ������̺��� ȸ���� ����Ƚ���� ��ȸ�ϵ� ����Ƚ���� 5�̻���
       ȸ���� ����Ͻÿ�
       
       SELECT A.AMEM AS ȸ����ȣ,
              COUNT(*) AS ����Ƚ��
         FROM (SELECT CART_MEMBER AS AMEM,
                      CART_NO AS ANO,
                      COUNT(*) AS CNT
                 FROM CART
                GROUP BY CART_MEMBER, CART_NO) A
        GROUP BY A.AMEM
       HAVING COUNT(*) >= 5
        ORDER BY 1;
        
��뿹) 2005�� 3�� ��� �ŷ�ó�� ��ǰ���԰Ǽ��� ��ȸ�Ͻÿ�.
       alias�� �ŷ�ó �ڵ�, �ŷ�ó��, ���԰Ǽ�
       
       SELECT B.BUYER_ID AS �ŷ�ó�ڵ�,
              B.BUYER_NAME AS �ŷ�ó��,
              COUNT(*) AS ���԰Ǽ�
         FROM BUYPROD A, BUYER B, PROD C
        WHERE C.PROD_ID = A.BUY_PROD(+)
          AND B.BUYER_ID = C.PROD_BUYER(+)
          AND A.BUY_DATE BETWEEN '20050301' AND '20050331'
        GROUP BY B.BUYER_ID, B.BUYER_NAME
        ORDER BY 1;
        
(�ذ���1 - ��������)
SELECT D.BUYER_ID AS �ŷ�ó�ڵ�,
       D.BUYER_NAME AS �ŷ�ó��,
       NVL(TBLA.CNT,0) AS ���԰Ǽ�
  FROM (SELECT B.BUYER_ID AS BCODE,
               COUNT(A.BUY_PROD) AS CNT
          FROM BUYPROD A, BUYER B, PROD C
         WHERE C.PROD_ID = A.BUY_PROD(+)
           AND B.BUYER_ID = C.PROD_BUYER
           AND A.BUY_DATE BETWEEN '20050301' AND '20050331'
         GROUP BY B.BUYER_ID) TBLA, BUYER D
 WHERE D.BUYER_ID = TBLA.BCODE(+)
 ORDER BY 1;
 
 



        
        
        
      
       
         
         