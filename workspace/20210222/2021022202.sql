2021-02-22-02)������ �Լ�
  1. ������ �Լ�(abs,sign,power,sqrt...��)
    . abs(n) : n�� ����
    . sign(n) : n�� ��ȣ(���� : -1, ��� : 1, 0 : 0)
    . power(n,e) : n�� e�� �� ��ȯ
    . sqrt(n) : n�� ����(root ��)
    
��뿹)
select abs(-100),
       abs(0.000001),
       sign(10000000),
       sign(-10000000),
       sign(0.0000001),
       sign(-0.0000001),
       sign(0),
       power(2,10),
       sqrt(1024)
  from dual
       
  2. greatest, least
    . �־��� �ڷ� �� �ִ񰪰� �ּڰ��� ����
    (�������)
    greatest(n1,n2,....) : n1,n2,.... �� �ִ� ��ȯ
    least(n1,n2,....) : n1,n2,.... �� �ּڰ� ��ȯ
    
��)
select greatest(20,40,5,70), least(20,40,5,70) from dual;

��) ȸ�����̺��� ȸ������ ������ ���ϸ����� ��ȸ�Ͽ�
    1000�̸��� ȸ������ ���ϸ����� 1000���� ����ÿ�.
    alias�� ȸ����ȣ, ȸ����, ���� ���ϸ���, ���� ���ϸ���
    
    select mem_id as ȸ����ȣ,
           mem_name as ȸ����,
           mem_mileage as "���� ���ϸ���",
           greatest(mem_mileage,1000) as "���� ���ϸ���"
      from member
     order by 4 desc;

**ȸ�����̺��� �ִ� ���ϸ����� ���Ͻÿ�
select b.mem_name as ȸ����,
       a.mile_max as ���ϸ���
  from (select max(mem_mileage) as mile_max
          from member) a, member b
 where a.mile_max = b.mem_mileage

  3. round, trunc
    . �־��� �����ڷḦ �ݿø�(round) �Ǵ� �ڸ�����(trunc) ������
      �ᱣ�� ��ȯ
      (�������)
      round(n,i) : - i�� ����̸� �־��� �ڷ� n���� �Ҽ��� ���� i+1��°
                     �ڸ����� �ݿø��Ͽ� i��° ������ ��ȯ
                   - i�� �����̸� �־��� �ڷ� n���� �������� i��°
                     �ڸ����� �ݿø��Ͽ� ��� ��ȯ
                   - i�� �����ϸ� 0���� ����
                    round(202732.2,-3)
                        -6-5-4-3-2-1.1
                   
      trunc(n,i) : - i�� ����̸� �־��� �ڷ� n���� �Ҽ��� ���� i+1��°
                     �ڸ����� �ڸ������Ͽ� i��° ������ ��ȯ
                   - i�� �����̸� �־��� �ڷ� n���� �������� i��°
                     �ڸ������Ͽ� ��� ��ȯ
                   - i�� �����ϸ� 0���� ����
                   
��) ������̺��� �ڷḦ �̿��Ͽ� �̹��� �޿��� ��ȸ�Ͻÿ�
   . �̹��޿� ���ʽ��� ������ : ���ʽ� = �޿��� 13%
   . ���޾�=����+���ʽ�
   alias�� �����ȣ, �����, ����, ���ʽ�, ���޾�
   �� ���ʽ�, ���ݾ��� �Ҽ� ù �ڸ����� ��Ÿ���ÿ�
   
   select employee_id as �����ȣ,
          emp_name as �����,
          salary as ����,
          salary * 0.13 as ���ʽ�1,
          round(salary * 0.13,1) as ���ʽ�2,
          round(salary * 1.13,1) as ���޾�
          --round(salary + round(salary * 0.13,1),1) as ���޾�
     from employees
    order by 5 desc;
    
update employees
   set salary = salary * 1.17;
   
 ��) ������̺��� �ڷḦ �̿��Ͽ� �̹��� �޿��� ��ȸ�Ͻÿ�
   . �̹��޿� ���ʽ��� ������ : ���ʽ� = �޿��� 13%
   . ���޾�=����+���ʽ�
   alias�� �����ȣ, �����, ����, ���ʽ�, ���޾�
   �� ���ʽ�, ���ݾ��� ���� �ڸ����� �ݿø��Ͻÿ�  
   
  select employee_id as �����ȣ,
          emp_name as �����,
          salary as ����,
          salary * 0.13 as ���ʽ�1,
          round(salary * 0.13,-1) as ���ʽ�2,
          round(salary * 1.13,-1) as ���޾�
          --round(salary +(salary * 0.13),-1) as ���޾�
     from employees
    order by 5 desc;
    
     ��) ������̺��� �ڷḦ �̿��Ͽ� �̹��� �޿��� ��ȸ�Ͻÿ�
   . �̹��޿� ���ʽ��� ������ : ���ʽ� = �޿��� 13%
   . ���޾�=����+���ʽ�
   alias�� �����ȣ, �����, ����, ���ʽ�, ���޾�
   �� ���ʽ�, ���ݾ��� ���� �ڸ����� �ݿø��Ͻÿ�  
   
  select employee_id as �����ȣ,
          emp_name as �����,
          salary as ����,
          salary * 0.13 as ���ʽ�1,
          trunc(salary * 0.13,-1) as ���ʽ�2,
          trunc(salary * 1.13,-1) as ���޾�
          --round(salary +(salary * 0.13),-1) as ���޾�
     from employees
    order by 5 desc;
    
    
                  
