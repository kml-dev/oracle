2021-02-18-02) ������
 - 4Ģ ������(+,-,*,/)
 - ������ ���� mod()�� remainder()�Լ��� ����
 - ���迬����(>, >=, <, <=, =, !=(<>))
 - ��������(and, or, not)
 1. ��Ÿ ������
  1) in ������
    - �־��� �� �� ��� �ϳ��� ��ġ�ϸ� ��ü�� ��(true)�� �Ǵ� ������
    - or�����ڷ� �ٲپ� �� �� �ִ�.
    (�������)
    �÷��� in (��1,��2,...��n)
    . where ���� ���� ������ ���
    
��뿹) ������̺��� �μ��� 60, 40, 20�� �μ��� ���� ��������� ��ȸ�Ͻÿ�
       alias�� �����ȣ, �����, �μ���ȣ, �Ի����̴�
       
       select employee_id as �����ȣ,
              emp_name as �����,
              department_id as �μ���ȣ,
              hire_date as �Ի���
         from employees
        where department_id in (60, 40, 20)
     order by 3;
     
     [or ������ ���]
     select employee_id as �����ȣ,
              emp_name as �����,
              department_id as �μ���ȣ,
              hire_date as �Ի���
         from employees
        where department_id = 60
           or department_id = 40
           or department_id = 20
     order by 3;
     
   2) any(some) ������
     - ����� in �����ڿ� ������
     (�������)
     �÷��� ���迬���� any|some (��1, ��2,...��n)
    
��뿹) 
       select employee_id as �����ȣ,
              emp_name as �����,
              department_id as �μ���ȣ,
              hire_date as �Ի���
         from employees
       -- where department_id = any(60,40,20)       
        where department_id = some(60,40,20)       
     order by 3;     
     
     3) between ������ 
       - ������ �����Ͽ� ���� �� ���
       - and �����ڷ� ��ȯ����
     (�������)
     �÷��� between a and b
     . �÷��� ����� ���� ������ a ~ b ���� ���̸� ��(true) ��ȯ
��) �������̺�(buyprod)���� 2005�� 2�� 5�Ϻ��� 16�� ���̿� �԰�� ��ǰ������ ��ȸ�Ͻÿ�
    alias�� ��¥, ��ǰ�ڵ�, ����, �ܰ�, �ݾ��̴�.
    
    select buy_date as ��¥,
           buy_prod as ��ǰ�ڵ�,
           buy_qty as ����,
           buy_cost as �ܰ�,
           buy_qty*buy_cost as �ݾ�
      from buyprod
     where buy_date between '20050205' and '20050216';
     
     
     
����] ȸ�����̺��� 40�� ���� ȸ���� �������ϸ����� ��ȸ�Ͻÿ�
    
    select mem_id as ȸ����ȣ,
           mem_name as ȸ����,
           2021 - (1900+to_number(substr(mem_regno1,1,2))) as ����,
           mem_mileage as ���ϸ���
      from member
     where 2021 - (1900+to_number(substr(mem_regno1,1,2))) between 40 and 49
       and substr(mem_regno2,1,1) = '2';
