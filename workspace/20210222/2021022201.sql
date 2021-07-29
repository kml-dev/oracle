2021-02-22-01)���ڿ� �Լ�..cont
  6) substr
    - ���� ���ڿ����� ���ǵ� ���̹�ŭ�� �κй��ڿ��� ������
    - ����� ���ڿ�����
    (�������)
    substr(c,n[,len])
      . �־��� ���ڿ� c���� n��°���� len���� ��ŭ�� ���ڿ��� �����Ͽ� ��ȯ
      . n�� 0 �Ǵ� 1�̸� ù��° ���ں��� ó��
      . n�� �����̸� ���ڸ����� ó��
      . len�� �����Ǹ� n�ڸ� ���� ��� ���ڿ� ��ȯ

��뿹)  ��ٱ��� ���̺��� 2005�� 7�� �Ǹ��ڷḦ ��ȸ�Ͻÿ�
        alias�� �Ǹ�����, ������, ��ǰ��, ����
        
        select to_date(substr(cart_no,1,8)) as �Ǹ�����,
               cart_member as ������,
               b.prod_name as ��ǰ��,
               cart_qty as ����
          from cart a, prod b
         where a.cart_prod=b.prod_id --���� ����
           and substr(cart_no,1,6) = '200507'
         order by to_date(substr(cart_no,1,8)) asc;
    
��뿹) ������̺�(employees)���� �ǸŰ��� ��å(sales : SA_XXX)�� 
       �ο����� ��������� ��ȸ�Ͻÿ�
       alias�� �����ȣ, �����, �μ���, ��å�ڵ�, �޿��̴�
       
       select a.employee_id as �����ȣ,
              a.emp_name as �����,
              b.department_name as �μ���,
              a.job_id as ��å�ڵ�,
              a.salary as �޿�
         from employees a, departments b
        where a.department_id=b.department_id
          and substr(a.job_id,1,2)='SA'
        order by 5 desc;
    
����1) ȸ�����̺��� �达���� ���� ȸ�������� ����Ͻÿ�
      alias�� ȸ����ȣ, ȸ����, ����, ���ϸ����̴�
      
      select mem_id as ȸ����ȣ,
             mem_name as ȸ����,
             case when substr(mem_regno2,1,1)='1' or
                       substr(mem_regno2,1,1)='3' then '����'
                  else '����' end as "����",
             mem_mileage as ���ϸ���
        from member
       where substr(mem_name,1,1)='��'
       -- where mem_name like '��%';
       order by 4 desc;

  7) replace
    - Ư�����ڿ��� ã�� �ٸ� ���ڿ��� ��Ī��Ŵ
    (�������)
    replace(c1,c2[,c3])
     . �־��� ���ڿ� c1���� c2���ڿ��� ��� ã�� c3���ڿ��� ��ġ
     . c3�� �����Ǹ� ã�� ���ڿ��� ������(���ڿ� ������ �������ſ� ���)
     
��뿹)
select '  ILPOSTINO   BOYHOOD',
       trim('  ILPOSTINO   BOYHOOD'),
       replace('  ILPOSTINO   BOYHOOD',' '),
       replace('  ILPOSTINO   BOYHOOD',' ','*')
  from dual
  
����]������̺��� 2005�� ���� �Ի��� ����� ��ȭ��ȣ ��������� xxx-xxx-xxxx�������� ����Ͻÿ�
    alias�� �����ȣ, �����,��ȭ��ȣ,����̴�
    ���´� '������','����' �� �ϳ��� ����� ��
    
    select employee_id as �����ȣ,
           emp_name as �����,
           replace(phone_number,'.','-') as ��ȭ��ȣ,
           case when retire_date is null then '������'
                else '����' end as ���
      from employees
     where hire_date>=to_date('20050101');
     
  8) instr
    - ���ڿ����� Ư�� ���ڿ��� ��ġ��(index)�� ��ȯ
    (�������)
    instr(c1,c2[,m[,n]])
     . �־��� ���ڿ� c1���� c2���ڿ��� ó�� ������ ��ġ ��ȯ
     . m�� �˻��� Ư����ġ�� ������ �� ���Ǵ� index
     . n�� �ݺ��Ǿ� ǥ���� ���ڿ� �� �ݺ��� Ƚ���� Ư���Ͽ� �˻��� �� 
       ���
       
��뿹) 
select emp_name,
       instr(emp_name, 'o'),
       instr(emp_name, 'o',3),
       instr(emp_name, 'o',2,2)
  from employees
 where department_id=50;
 
 9) length(c),lengthb(c)
    . length(c) : c���ڿ� ���� ������ ��
    . lengthb(c) : c���ڿ��� ����(byte) ��
    . �ѱ��� �� ���ڴ� 3byte�� ǥ����  
    

    
        

        
       