2021-02-18-01)select ��
 - �ڷ� �˻� ���
 - SQL�������� ���� ���� ���Ǵ� ��ɾ�
 (�������)
 select [distinct] *|[�÷���1[AS]["]�÷���Ī["],]
        [�÷���2[AS]["]�÷���Ī["],]
                   :
        [�÷���n[AS]["]�÷���Ī["],]
   from ���̺��
 [where ����1
   [and ����2...]]
[group by �÷���1[,�÷���2,...]]
 having ����1[,����2,...]]
[order by �÷��ε��� | �÷���1[asc|desc][,
          �÷��ε��� | �÷���2,...];]
          
          
1. select ��
  - �˻��� �÷��� ���õ� ��
  - ����Ǵ� ������ ���� �ʰ� ����(from -> where -> select)
  (�������)
  select [distinct] *|[�÷���1[AS]["]�÷���Ī["],]
        [�÷���2[AS]["]�÷���Ī["],]
                   :
        [�÷���n[AS]["]�÷���Ī["],]
    . [distinct] : �ߺ��� �ڷḦ �����Ͽ� ����� �����
    
��뿹) ȸ�����̺��� ȸ���� �ּ����� ������ ��� ��ȸ�Ͻÿ�.
       Alias�� ������(������ �Ǵ� ��)
       
       (distinct �̻��)
       select substr(mem_add1, 1, 2)
         from member;
         
      (distinct ���)
       select substr(mem_add1, 1, 2)
         from member;
         
��뿹) ȸ�����̺��� ȸ������ ������ �ִ� ��̵��� ��ȸ�Ͻÿ�

select distinct mem_like as ���
  from member;
         
   .'�÷���Ī' : �÷��� �ο��ϴ� ������ �̸�
               �ش� �÷��� �����̳� subquery ���� �÷��� ���� 
               �����ϱ� ���Ͽ� ����
   . �÷���Ī�� Ư������(�����̳� ��ȣ, �����)�� ���� ������ ""��
     ���� ����ؾ���
   . 'as'�� ���� ����(����ϴ� ���� �������� ���Ͽ� �����)
   . �÷���Ī�� �ش� select ���� where�� � ����� �� ����

��뿹)�����ٷ� ���
      ������̺�(employees)���� ��������(commission_pct)�� null�� �ƴ�
      ������� ���������� ���� ���ʽ��� ��ȸ�Ͻÿ�.
      ���ʽ�=�޿�*���������ڵ�
      alias�� �����ȣ, �����, ���������ڵ�, ����, ���ʽ��̴�.
      
select employee_id as �����ȣ,
       emp_name as �����,
       commission_pct as ���������ڵ�,
       salary as ����,
       salary * commission_pct as ���ʽ�
  from employees
 where commission_pct is not null;
 
 ��뿹)�����ٷ� ���
      ������̺�(employees)���� ��������(commission_pct)�� null�� �ƴ�
      ������� ���������� ���� ���ʽ��� ��ȸ�ϵ� ���ʽ��� 3000 �̻��� 
      ����� ��ȸ�Ͻÿ�.
      ���ʽ�=�޿�*���������ڵ�
      alias�� �����ȣ, �����, ���������ڵ�, ����, ���ʽ��̴�.
      
    select employee_id as �����ȣ,
           emp_name as �����,
           commission_pct as ���������ڵ�,
           salary as ����,
           salary * commission_pct as ���ʽ�
      from employees
     where commission_pct is not null
       and salary * commission_pct >= 3000
     order by 5 desc;
     
     **group �Լ� ���
     ��뿹) ȸ�����̺�(member)���� ���� ���ϸ��� �հ踦 ��ȸ�Ͻÿ� 
     
     select case when substr(mem_regno2,1,1)='1' or
                      substr(mem_regno2,1,1)='3' then '����ȸ��'
                 else '����ȸ��' end as "����",
            sum(mem_mileage) as "���ϸ��� �հ�"
       from member
   group by case when substr(mem_regno2,1,1)='1' or
                      substr(mem_regno2,1,1)='3' then '����ȸ��'
                 else '����ȸ��' end;
                 
��뿹) ��ٱ������̺�(cart)���� 2005�� 6�� ȸ���� ���ž��� ��ȸ�ϵ�
       ���űݾ��� 50���� �̻��� ȸ�������� ��ȸ�Ͻÿ�
       alias�� ȸ����ȣ, ȸ����, ���ž�
       
       select A.cart_member as ȸ����ȣ,
              B.mem_name as ȸ����,
              sum(A.cart_qty * C.prod_price) as ���ž�
              (select)
         from cart A, member B, prod C
        where A.cart_member=B.mem_id --���� ����
          and A.cart_prod=C.prod_id  --���� ����
          and substr(A.cart_no,1,6)= '200506'
          --and substr(A.cart_no,1,8) >= '20050601' and substr(A.cart_no,1,8) <= '20050630'
          and A.cart_qty>=(select)
     group by A.cart_member,B.mem_name
   having sum(A.cart_qty*C.prod_price)>=500000
     order by 3 desc;
 
 
