2021-03-04-02)�ܺ�����
  - �������ο����� ���������� �������� ���� �ڷ�(��)�� ����
  - �ܺ����ο����� ���������� �������� ���� ���̺� ������ �ุŭ
    NULL ���� ���� ���� �߰� ������ �� ���� ����
  - �������� ������� ������ �ڷḦ ���� �ִ� ���̺� ���� �÷���
    �ܺ����� ������('(+)')�� ���
  - �ΰ� �̻��� �ܺ������� ���ÿ� ����ž� �� ��� �ش�Ǵ� ����
    ���� ��� �ܺ����� ������('(+)')�� ��� �ؾ���
  - �ѹ��� �� ���̺� ���ؼ��� �ܺ������� ���� �� �� �ִ�.
    �� A,B,C���̺��� ���ο� �����ϰ� A�� �������� B�� �ܺ������ϰ�(A=B(+)),
    ���ÿ� C�� �������� B�� �ܺ�����(C=B(+))�� �� ����
  - (+)�����ڰ� ���� ���ǿ��� OR ������ ������
  - (+)�����ڰ� ���� ���ǿ� IN ������ ������
  
(�������)
�Ϲ� OUTER JOIN
SELECT �÷�LIST
  FROM ���̺�LIST
 WHERE �÷���1 = �÷���2(+)
  [AND �Ϲ�����]

ANSI OUTER JOIN
SELECT �÷�LIST
  FROM ���̺�1
FULL|LEFT|RIGHT OUTER JOIN ���̺��2 ON(��������1
  [AND �Ϲ�����])
[WHERE �Ϲ�����];
. LEFT : ���̺��1�� ���̺��2 ���� �� ���� �ڷḦ ������ �ִ� ��� ���
. RIGHT : ���̺��2�� ���̺��1 ���� �� ���� �ڷḦ ������ �ִ� ��� ���
. FULL : ���̺��1, ���̺��2 ��� ������ ���

��) ��ǰ���̺��� ��� �з��� ��ǰ�� ���� ��ȸ�Ͻÿ�
    ALIAS�� �з��ڵ�, �з���, ��ǰ�� ��
    
SELECT B.LPROD_GU AS �з��ڵ�,
       B.LPROD_NM AS �з���,
       COUNT(PROD_ID) AS "��ǰ�� ��"
  FROM PROD A, LPROD B
 WHERE A.PROD_LGU(+) = LPROD_GU
 GROUP BY B.LPROD_GU,B.LPROD_NM
 ORDER BY 1;
 
 (ANSI)
SELECT B.LPROD_GU AS �з��ڵ�,
       B.LPROD_NM AS �з���,
       COUNT(PROD_ID) AS "��ǰ�� ��"
  FROM PROD A
 RIGHT OUTER JOIN LPROD B ON(A.PROD_LGU = LPROD_GU)
 GROUP BY B.LPROD_GU,B.LPROD_NM
 ORDER BY 1;
 
��) 2005�� 2�� ��� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�.
    ALIAS�� ��ǰ�ڵ�, ��ǰ��, ���Լ���, ���Աݾ�
    
    (�Ϲ� OUTER JOIN)
    SELECT B.PROD_ID AS ��ǰ�ڵ�,
           B.PROD_NAME AS ��ǰ��,
           SUM(A.BUY_QTY) AS ���Լ���,
           SUM(A.BUY_QTY * B.PROD_COST)���Աݾ�
      FROM BUYPROD A, PROD B
     WHERE A.BUY_PROD(+) = B.PROD_ID
       AND A.BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201')
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;

     (ANSI OUTER JOIN)
     SELECT B.PROD_ID AS ��ǰ�ڵ�,
           B.PROD_NAME AS ��ǰ��,
           NVL(SUM(A.BUY_QTY),0) AS ���Լ���,
           NVL(SUM(A.BUY_QTY * B.PROD_COST),0)���Աݾ�
      FROM BUYPROD A
     RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID
       AND A.BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201'))
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;
     
     (�������� �̿�)
     SELECT B.PROD_ID AS ��ǰ�ڵ�,
            B.PROD_NAME AS ��ǰ��,
            NVL(A.SQTY,0) AS ���Լ���,
            NVL(A.SAMT,0) AS ���Աݾ�
       FROM PROD B, (SELECT BUY_PROD,
                            SUM(BUY_QTY) AS SQTY,
                            SUM(BUY_QTY * BUY_COST) AS SAMT
                       FROM BUYPROD
                      WHERE BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201')
                      GROUP BY BUY_PROD) A
      WHERE B.PROD_ID = A.BUY_PROD(+)
      ORDER BY 1;
      
��) ������̺��� ��� �μ��� ������� ��ȸ�Ͻÿ�.
    �μ��ڵ�, �μ���, �����
    
    SELECT B.DEPARTMENT_ID AS �μ��ڵ�,
           B.DEPARTMENT_NAME AS �μ���,
           COUNT(A.EMPLOYEE_ID)�����
      FROM EMPLOYEES A, DEPARTMENTS B
     WHERE A.DEPARTMENT_ID(+) = B.DEPARTMENT_ID(+)
     GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
     ORDER BY 1;
     
     (ANSI JOIN)
     SELECT B.DEPARTMENT_ID AS �μ��ڵ�,
           B.DEPARTMENT_NAME AS �μ���,
           COUNT(A.EMPLOYEE_ID)�����
      FROM EMPLOYEES A
      FULL OUTER JOIN DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
     GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
     ORDER BY 1;
     
��) 2005�� 7�� ��� ȸ���� �Ǹ���Ȳ�� ��ȸ�Ͻÿ�
    ALIAS�� ȸ����ȣ, ȸ����, ���ż����հ�, ���űݾ��հ�
    
    (ANSI JOIN)
    SELECT A.MEM_ID AS ȸ����ȣ,
           A.MEM_NAME AS ȸ����,
           NVL(SUM(B.CART_QTY),0)���ż����հ�,
           NVL(SUM(B.CART_QTY * C.PROD_PRICE),0)���űݾ��հ�
      FROM MEMBER A
      LEFT OUTER JOIN CART B ON(A.MEM_ID = B.CART_MEMBER AND B.CART_NO LIKE '200507%')
      LEFT OUTER JOIN PROD C ON(B.CART_PROD = C.PROD_ID)
     GROUP BY A.MEM_ID, A.MEM_NAME
     ORDER BY 1;
     
     SELECT A.MEM_ID,
            A.MEM_NAME,
            NVL(SUM(B.CART_QTY),0) AS ���ż����հ�,
            NVL(SUM(B.CART_QTY * C.PROD_PRICE),0) AS ���ű޾��հ�
       FROM CART B
      INNER JOIN PROD C ON(B.CART_PROD = C.PROD_ID AND B.CART_NO LIKE '200507%')
      RIGHT OUTER JOIN MEMBER A ON(A.MEM_ID = B.CART_MEMBER)
      GROUP BY A.MEM_ID,A.MEM_NAME
      ORDER BY 1;
      
      SELECT A.MEM_ID AS ȸ����ȣ,
             A.MEM_NAME AS ȸ����,
             NVL(D.SQTY,0) AS ���ż����հ�,
             NVL(D.SAMT,0) AS ���űݾ��հ�
        FROM MEMBER A,
             (SELECT B.CART_MEMBER AS BID,
                     SUM(B.CART_QTY) AS SQTY,
                     SUM(B.CART_QTY * C.PROD_PRICE) AS SAMT
                FROM CART B, PROD C
               WHERE B.CART_PROD = C.PROD_ID
                 AND B.CART_NO LIKE '200507%'
               GROUP BY B.CART_MEMBER) D
        WHERE A.MEM_ID = D.BID(+)
        ORDER BY 1;
           





