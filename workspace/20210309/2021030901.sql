2021-03-09-01)VIEW ��ü
  - ������ ���̺�
  - SELECT���� ����� �����Ǵ� ������ ��ü
  - Ư���ڷ��� ������ ������ ��(����), �������� ���̺� �л�� �ڷḦ
    ����� JOIN�� ����� ����� ��, �Ҽ��� �÷��̳� �ุ �ʿ��� �� �ַ� ���
    (�������)
    CREATE[OR REPLACE] VIEW ���̸�[(�÷���1,...)]
    AS
      SELECT ��
      [WITH CHECK OPTION]
      [WITH READ ONLY];
     . '�÷���1,...' : �����Ǵ� �信 �ο��Ǵ� �÷���, �����Ǹ� �������̺���
       �÷����� �����
     . 'WITH CHECK OPTION' : �並 �����ϴ� SELECT������ ������ ���� ���
       �� ���ǿ� �������� �ʴ� DML���(INSERT, UPDATE)�� ������� ����
     . 'WITH READ ONLY' : ���� ����� �����ϸ� �������̺� �Բ� �������� �ʰ�
                          �ϱ� ���� �ɼ�
                          
��뿹) 2005�� 2�� ��ǰ�� ������Ȳ�� ��� �ۼ��Ͻÿ�
       ��� ��ǰ�ڵ�, ��ǰ��, ���Լ������� ����
       
       CREATE OR REPLACE VIEW V_BUYPROD
       AS
         SELECT A.BUY_PROD AS ��ǰ�ڵ�,
                B.PROD_NAME AS ��ǰ��,
                SUM(A.BUY_QTY) AS ���Լ���
           FROM BUYPROD A, PROD B
          WHERE A.BUY_PROD = B.PROD_ID
            AND A.BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201')
          GROUP BY A.BUY_PROD, B.PROD_NAME  
          ORDER BY 1;
          
        SELECT * FROM BUYPROD
         WHERE BUY_PROD = 'P102000006'
           AND BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201')
          
       (VIEW ���� ����)
       ��ǰ�ڵ尡 'P102000006'�� ��ǰ�� ���Լ����� 50���� ����
       
       UPDATE V_BUYPROD
          SET ���Լ��� = 50
        WHERE ��ǰ�ڵ� = 'P102000006';  
       
       (BUYPROD(�������̺�)���� ����)
       ��ǰ�ڵ尡 'P102000006'�� ��ǰ�� ���Լ���(50)�� 10���� ����
       UPDATE BUYPROD
          SET BUY_QTY = 10
        WHERE BUY_PROD = 'P102000006'
          AND BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201');
          
          
       SELECT * FROM V_BUYPROD;
       
��뿹) ȸ�����̺��� ���ϸ����� 5000�̻��� ȸ�������� ��ȸ�ϰ�
       VIEW�� �����Ͻÿ�
       
       CREATE OR REPLACE VIEW V_MEM(MID,MNAME,MILEAGE)
       AS
         SELECT MEM_ID,
                MEM_NAME,
                MEM_MILEAGE
           FROM MEMBER
          WHERE MEM_MILEAGE >= 5000 
           WITH CHECK OPTION;
        
        (VIEW ����Ȯ��)   
        SELECT * FROM V_MEM;
        --V_MEM�信�� ���浿 ȸ���� ���ϸ����� 4300���� ����
        
        UPDATE V_MEM
           SET MILEAGE = 4300
         WHERE MID = 'l001';  
       
       --�������̺��� 'a001'ȸ���� ���ϸ����� 1000���� 6000���� ����
       UPDATE MEMBER
          SET MEM_MILEAGE = 6000
        WHERE MEM_ID = 'a001';  
       
       CREATE OR REPLACE VIEW V_MEM(MID,MNAME,MILEAGE)
       AS
         SELECT MEM_ID,
                MEM_NAME,
                MEM_MILEAGE
           FROM MEMBER
          WHERE MEM_MILEAGE >= 5000 
           WITH READ ONLY;
           
      --�������̺��� 'a001'ȸ���� ���ϸ����� 6000���� 2000���� ����
      UPDATE MEMBER
         SET MEM_MILEAGE = 2000
       WHERE MEM_ID = 'a001'; 
       
      --VIEW(V_MEM)���� 'e001' ���ϸ�����  6500���� 3500���� ����
      UPDATE V_MEM
         SET MILEAGE = 3500
       WHERE MID = 'e001';
       
       
       
       
       
       
       
       