2021-03-08-02) ���տ�����
  - �����̷п��� �����ϴ� ������(UNION, UNION ALL), ������(INTERSECT),
    ������(MINUS) ������ ����
    (�������)
SELECT �÷�LIST
  FROM ���̺��
[WHERE ����] 
    
UNION|UNION ALL|INTERSECT|MINUS

  SELECT �÷�LIST
    FROM ���̺��
  [WHERE ����] 
[UNION|UNION ALL|INTERSECT|MINUS

  SELECT �÷�LIST
    FROM ���̺��
  [WHERE ����]]
      :
  . �� SELECT ���� �÷��� ������ ���� �� TYPE�� ���ƾ� ��
  . ORDER BY ���� �� ������ SELECT �������� ��� ����
  . CLOB, BLOB, BFILE ���� ��� �Ұ�
  . ����� ������ ù ��° SELECT ����
  
1.UNION, UNION ALL
  - �������� ��� ��ȯ
  - UNION : �ߺ����� ���� ��� ��ȯ
  - UNION ALL : �ߺ��� ���� ��ȯ
  
��뿹) 2005�� 4���� 6���� �Ǹŵ� ��ǰ������ �ߺ����� �ʰ� ��ȸ�Ͻÿ�
       ALIAS�� ��ǰ�ڵ�, ��ǰ��
       
       SELECT DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
              B.PROD_NAME AS ��ǰ��
         FROM CART A, PROD B
        WHERE A.CART_NO LIKE '200504%'
          AND B.PROD_ID = A.CART_PROD
        UNION      
       SELECT DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
              B.PROD_NAME AS ��ǰ��
         FROM CART A, PROD B
        WHERE A.CART_NO LIKE '200506%'
          AND B.PROD_ID = A.CART_PROD
         
��뿹) 2005�� 4���� 6���� �Ǹŵ� ��ǰ������ �ߺ��ǰ� ��ȸ�Ͻÿ�
       ALIAS�� ��ǰ�ڵ�, ��ǰ��
  
       SELECT DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
              B.PROD_NAME AS ��ǰ��
         FROM CART A, PROD B
        WHERE A.CART_NO LIKE '200504%'
          AND B.PROD_ID = A.CART_PROD
        UNION ALL     
       SELECT DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
              B.PROD_NAME AS ��ǰ��
         FROM CART A, PROD B
        WHERE A.CART_NO LIKE '200506%'
          AND B.PROD_ID = A.CART_PROD
          
2.INTERSECT
  - �������� ��� ��ȯ

��뿹) 2005�� 4���� 6���� �� �� ��� �Ǹŵ� ��ǰ������ ��ȸ�Ͻÿ�
       ALIAS�� ��ǰ�ڵ�, ��ǰ��
  
       SELECT DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
              B.PROD_NAME AS ��ǰ��
         FROM CART A, PROD B
        WHERE A.CART_NO LIKE '200504%'
          AND B.PROD_ID = A.CART_PROD
             INTERSECT     
       SELECT DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
              B.PROD_NAME AS ��ǰ��
         FROM CART A, PROD B
        WHERE A.CART_NO LIKE '200506%'
          AND B.PROD_ID = A.CART_PROD;  
         
         
         
3. MINUS(������)
  - A MINUS B: ���� A���� ���� B�� ���� ��Ҹ� ������ ��� ��ȯ
  - B MINUS A: ���� B���� ���� A�� ���� ��Ҹ� ������ ��� ��ȯ

��뿹) 2005�� 4���� �Ǹŵ� ��ǰ �� 6���� �Ǹŵ��� ���� ��ǰ������
       ��ȸ�Ͻÿ�
       ALIAS�� ��ǰ�ڵ�, ��ǰ��
       
       SELECT DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
              B.PROD_NAME AS ��ǰ��
         FROM CART A, PROD B
        WHERE A.CART_NO LIKE '200506%'
          AND B.PROD_ID = A.CART_PROD
        MINUS    
       SELECT DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
              B.PROD_NAME AS ��ǰ��
         FROM CART A, PROD B
        WHERE A.CART_NO LIKE '200504%'
          AND B.PROD_ID = A.CART_PROD;   

**
       SELECT DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
              B.PROD_NAME AS ��ǰ��
         FROM CART A, PROD B
        WHERE A.CART_NO LIKE '200506%'
          AND B.PROD_ID = A.CART_PROD
        UNION    
       SELECT B.LPROD_GU AS �з��ڵ�,
              B.LPROD_NM AS �з���
         FROM LPROD B
        ORDER BY 1; 

  
  
  
  
  
  