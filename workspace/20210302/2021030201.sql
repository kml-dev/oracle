2021-03-02)���̺� ����
  - �����������ͺ��̽��� �ٽ�
  - ���� ���̺� �л�Ǿ� ����� �ڷ���� ����(relationship)�� 
    �̿��Ͽ� �����ϴ� ����
  - ����
    1) ��������, �ܺ�����
    2) �Ϲ�����, ANSI����
    3) Cartesian Product, Equi Join, Non-Equi Join, Self Join, etc..
    
1. ��������(Inner Join)
  - ���������� �����ϴ� �����͸� ������ ����� ��ȯ�ǰ� 
    �������ǿ� ���� �ʴ� �ڷ�� ���õ�
    (�������)
    SELECT �÷�list,...
      FROM ���̺��1 [���̺�Ī1], ���̺��2 [���̺�Ī2], ���̺��3 [���̺�Ī3],..
     WHERE ��������
      [AND ��������,...]
      [AND �Ϲ�����,...]
     . ���Ǵ� ���̺��� ������ N���� �� ���������� ��� N-1�� �̻��̾�� ��
     . �������ǿ� ���Ǵ� �÷��� �� ���̺� �����ϴ� ���� �ڷḦ �����ϰ� �ִ��÷�
       (���� �ܷ�Ű ���� Ȱ��)
     . �������ǰ� �Ϲ������� ��� ������ �������  
      
    (������� - ANSI����)
    SELECT �÷�list,...
      FROM ���̺��1 [���̺�Ī1]
     INNER JOIN ���̺��2 [��Ī2] ON(��������)
      [AND �Ϲ�����]
     INNER JOIN ���̺��3 [��Ī3] ON(��������)
      [AND �Ϲ�����]
     WHERE ��������

��) ��ٱ������̺��� �̿��Ͽ� 2005�� 6�� ȸ���� ������Ȳ�� ��ȸ�Ͻÿ�
    ALIAS�� ȸ����ȣ, ȸ����, ���ż����հ��̴�
    
    SELECT A.CART_MEMBER AS ȸ����ȣ,
           B.MEM_NAME AS ȸ����,
           SUM(A.CART_QTY) AS ���ż����հ�
      FROM CART A, MEMBER B
     WHERE A.CART_MEMBER = B.MEM_ID
       AND CART_NO LIKE '200506%'
     GROUP BY A.CART_MEMBER,B.MEM_NAME
     
2. Cartesian Product
  - ��� ���� ����� ����
  - ���ο� ������ ���̺��� ���� ���� ���� ���� ��� ��ȯ
  - �ݵ�� �ʿ��� ��찡 �ƴϸ� ��� ����
  - ���������� �����ϰų� �߸� ������ ��� �߻�
  (��뿹)
  SELECT COUNT(*) AS "���� ��"  -- 74*209
    FROM CART, PROD, ZIPTB;
    
3. Equi JOIN
  - ������������ �������ǿ� '=' ������ ���Ǵ� ����
  - ANSI������ INNER JOIN�̶� ��
  
��뿹) ������̺��� ���� ������ �����Ͽ� ����� ��ȸ�Ͻÿ�
       ALIAS�� �����ȣ, �����, �μ��ڵ�, �μ���, ��å��, �޿�
       
       SELECT A.EMPLOYEE_ID AS �����ȣ,
              A.EMP_NAME AS �����,
              A.DEPARTMENT_ID AS �μ��ڵ�,
              B.DEPARTMENT_NAME AS �μ���,
              C.JOB_TITLE AS ��å��,
              A.SALARY AS �޿�
         FROM EMPLOYEES A
        INNER JOIN DEPARTMENTS B ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
        INNER JOIN JOBS C ON A.JOB_ID = C.JOB_ID
        ORDER BY 1;
        
��뿹) ��ǰ���̺��� �� �з��� ���ϴ� ��ǰ�� ���� ��ȸ�Ͻÿ�.
       ALIAS�� �з��ڵ�, �з���, ��ǰ�� ��
       
       SELECT A.PROD_LGU AS �з��ڵ�,
              B.LPROD_NM AS �з���,
              COUNT(*) AS "��ǰ�� ��"
         FROM PROD A
        INNER JOIN LPROD B ON(A.PROD_LGU = B.LPROD_GU) --���� ����
        GROUP BY PROD_LGU,LPROD_NM
        ORDER BY 1;
 
����1] ��ٱ��� ���̺��� 2005�� 7�� ��ǰ�� �Ǹ���Ȳ�� ��ȸ�Ͻÿ�
      ALIAS�� ��ǰ�ڵ�, ��ǰ��, �Ǹż���, �Ǹűݾ�
      �Ϲ��������İ� �Ƚ��������� ����
      
      SELECT A.CART_PROD AS ��ǰ�ڵ�,
             B.PROD_NAME AS ��ǰ��,
             SUM(A.CART_QTY) AS �Ǹż���,
             SUM(A.CART_QTY * B.PROD_PRICE) AS �Ǹűݾ�
        FROM CART A, PROD B
       WHERE A.CART_PROD = B.PROD_ID
         AND CART_NO LIKE '200507%'
       GROUP BY  A.CART_PROD,B.PROD_NAME 
       ORDER BY 1;
       
       SELECT A.CART_PROD AS ��ǰ�ڵ�,
             B.PROD_NAME AS ��ǰ��,
             SUM(A.CART_QTY) AS �Ǹż���,
             SUM(A.CART_QTY * B.PROD_PRICE) AS �Ǹűݾ�
        FROM CART A
       INNER JOIN PROD B ON(CART_NO LIKE '200507%')
         AND A.CART_PROD = B.PROD_ID
       GROUP BY  A.CART_PROD,B.PROD_NAME 
       ORDER BY 1;
       
����2] 2005��2�� �ŷ�ó��, ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�
      ALIAS�� �ŷ�ó�ڵ�, �ŷ�ó��, ��ǰ��, ���Լ���, ���Աݾ�
      �Ϲ��������İ� �Ƚ��������� ����
      
      SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
             A.BUYER_NAME AS �ŷ�ó��,
             B.PROD_NAME AS ��ǰ��,
             SUM(C.BUY_QTY) AS ���Լ���,
             SUM(C.BUY_QTY * C.BUY_COST) AS ���Աݾ�
        FROM BUYER A, PROD B, BUYPROD C
       WHERE A.BUYER_ID = B.PROD_BUYER
         AND B.PROD_ID = C.BUY_PROD
         AND C.BUY_DATE BETWEEN '20050201' AND '20050228'
       GROUP BY A.BUYER_ID,A.BUYER_NAME,B.PROD_NAME
       ORDER BY 1,3;
       
        SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
             A.BUYER_NAME AS �ŷ�ó��,
             B.PROD_NAME AS ��ǰ��,
             SUM(C.BUY_QTY) AS ���Լ���,
             SUM(C.BUY_QTY * C.BUY_COST) AS ���Աݾ�
        FROM BUYER A
       INNER JOIN PROD B ON(A.BUYER_ID = B.PROD_BUYER)
       INNER JOIN BUYPROD C ON(B.PROD_ID = C.BUY_PROD)
         AND C.BUY_DATE BETWEEN '20050201' AND '20050228'
       GROUP BY A.BUYER_ID, A.BUYER_NAME, B.PROD_NAME
       ORDER BY 1,3;
         
����3] 2005�� 5�� ��ǰ�� ����, ������Ȳ�� ��ȸ�Ͻÿ�
      ALIAS�� ��ǰ�ڵ�, ��ǰ��, ���Աݾ��հ�, �Ǹű޾��հ�
      
      SELECT C.PROD_ID AS ��ǰ�ڵ�,
             C.PROD_NAME AS ��ǰ��,
             NVL(SUM(A.BUY_QTY * C.PROD_COST),0) AS ���Աݾ��հ�,
             NVL(SUM(B.CART_QTY * C.PROD_PRICE),0)�Ǹű޾��հ�
        FROM BUYPROD A
       RIGHT OUTER JOIN PROD C ON(C.PROD_ID = A.BUY_PROD
         AND A.BUY_DATE BETWEEN '20050501' AND '20050531') --����
        LEFT OUTER JOIN CART B ON(C.PROD_ID = B.CART_PROD
         AND B.CART_NO LIKE '200505%')--����
       GROUP BY C.PROD_ID, C.PROD_NAME 
       ORDER BY 1;
         

 
 
     
    