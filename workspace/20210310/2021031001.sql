2021-03-10-01)
  4) �ε��� �������
  CREATE [UNIQUE|BITMAP] INDEX �ε�����
     ON ���̺��(�÷���1,[,�÷���2,...][ASC|DESC]);
    .'���̺�'�� '�÷�'���� �������� �������� �Ǵ� ������������
      �ε��� ����.(�⺻�� ASC)
      
��뿹) ������̺��� ������� �������� �ε����� �����Ͻÿ�
CREATE INDEX IDX_EMP01
  ON EMPLOYEES(EMP_NAME);
  
CREATE INDEX INDEX_MEM01
  ON MEMBER(SUBSTR(MEM_REGNO2,4));
  
CREATE INDEX IDX_KOR_LOAN
  ON KOR_LOAN_STATUS(PERIOD, REGION);
  
SELECT * 
  FROM KOR_LOAN_STATUS
 WHERE PERIOD = '201111'; --�ε��� ���� ȿ���� ���� ����

SELECT * 
  FROM KOR_LOAN_STATUS
 WHERE PERIOD = '201111'
   AND REGION IN ('�泲', '����', '����');  

 5) �ε����� �籸��
   - �������� ����, ����, ������ �߻��ϸ� �ε����� �籸����
   - �籸���� WORK SPACE�� ����ǰų� �������� ���� ������ �ټ� �߻��� ����
     REBUILD������� ����
     (�������)
     ALTER INDEX �ε����� REBUILD;
     
ALTER INDEX IDX_KOR_LOAN REBUILD;     











