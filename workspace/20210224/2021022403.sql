2021-02-24-03) �׷��Լ�
  - �������� ���� ������� ����
  - SUM, AVG, COUNT, MAX, MIN
  - �׷��Լ��� �Ϲ��÷��� SELECT���� ���Ǹ�
    �ݵ�� GROUP BY���� WHERE�� ������ ��� �Ǿ�� ��
    (�������)
    SELECT [�÷���1, ..]
           SUM(�÷���)|AVG(�÷���)|COUNT(�÷���|*)|MAX(�÷���)|MIN(�÷���)
      FROM ���̺��
    [WHERE ����]
    [GROUP BY �÷���[,�÷���,...]]
    [HAVING ����]
    [ORDER BY �÷���|�÷��ε��� [[ASC][DESC],...]];
    
  1. SUM(col)
    - �ڷḦ �׷����� ���� �� �׷� ���� �÷��� ���� �հ踦 ����
    - SELECT���� �Ϲ� �÷����� SUM�Լ��� ���Ǹ� ���̺� ��ü�� 
      �ϳ��� �׷����� ����-GROUP BY �� ����
      
��뿹) ȸ�����̺��� ��� ȸ���� ���ϸ��� �հ踦 ���Ͻÿ�
SELECT SUM(MEM_MILEAGE)
  FROM MEMBER;
  
��뿹) ȸ�����̺��� ȸ������ �������� ���ϸ��� �հ踦 ���Ͻÿ�
SELECT SUBSTR(MEM_ADD1,1,2) AS ������,
       SUM(MEM_MILEAGE) AS ���ϸ����հ�
  FROM MEMBER
 GROUP BY SUBSTR(MEM_ADD1,1,2);
 
��뿹) ������̺��� �μ��� �޿��հ踦 ��ȸ�Ͻÿ�.
       �� �հ谡 30000�̻��� �μ��� ��ȸ
       
       SELECT DEPARTMENT_ID AS �μ��ڵ�,
              SUM(SALARY) AS �޿��հ�
         FROM EMPLOYEES 
        GROUP BY DEPARTMENT_ID
       HAVING SUM(SALARY) >= 30000
        ORDER BY 1;


  
  
  
  
  
  
  
  
  