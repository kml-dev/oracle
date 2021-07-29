2021-02-23) ������ �Լ�
  4. mod, remainder
    - ������ ���� ��ȯ
    1)mod(c,n)
      . �־��� �� c�� n���� ���� ������ ��ȯ
      . java����� %�����ڿ� ���� ���
      
��뿹) 2000�� 2�� 23���� ���� �������� ���Ͻÿ�.
    select case mod((trunc(sysdate)-to_date('00010101')-1),7)
                when 1 then '������'
                when 2 then 'ȭ����'
                when 3 then '������'
                when 4 then '�����'
                when 5 then '�ݿ���'
                when 6 then '�����'
                else '�Ͽ���' end as ����,
           trunc(sysdate)-to_date('00010101')-1 as �ϼ�
      from dual;
    2) remainder(c,n)
      . c�� n���� ���� ������ ��ȯ
      . ���������� mod�� �ٸ� ������� ó���Ͽ� �ٸ� ��� ��ȯ
      . mod : ������ = c - floor(c/n)
        remainder : ������ = c - n * round(c/n)
        
      ��) 13/5�� ������
        i) mod : 13 - 5 * floor(13/5)
                 13 - 5 * floor(2.6)
                 13 - 5 * 2 => 3
        ii) remainder
                 13 - 5 * round(13/5)
                 13 - 5 * round(2.6)
                 13 - 15 => -2
                 
select mod(13,5), remainder(13,5) from dual;    
    
    
  5. ceil(n), floor(n)
    - �־��� �� n�� ���� ������ ������ ��ȯ
    - ceil�� n�� ���ų� ū �� �� ���� ���� ����(�ø�)
    - floor�� n�� ���ų� ���� �� �� ���� ū ����(����)
    ex)ceil(23.56) -> 24, ceil(-23.56) -> -23
       floor(23.56) -> 23, floor(-23.56) -> -24

  6. width_bucket
    - �־��� �ּڰ��� �ִ��� ��� �׷����� ������ ���õ� ���� ��� �׷쿡 ���ϴ����� ��ȯ
    (�������)
    width_bucket(c,min,max,b)
      . c : �־��� ��
      . min : ������ ���� ��
      . max : ������ ���� ��
      . b : ������ ��
      
      
��뿹) ������̺��� ����� �޿��� ���� ����� ���Ͽ� ����Ͻÿ�
       �޿��� 2000���� 20000���� 7�� ������� ������ �޿���
       ���� ����� ���� ����� �ο��޵��� �Ͻÿ�
       alias�� �����ȣ, �����, �޿�, ���
       
       select employee_id as �����ȣ,
              emp_name as �����,
              salary as �޿�,
              -- 11 - width_bucket(salary,2000,22000,10)���
              width_bucket(salary,20000,2000,9)���
         from employees
        order by 3 desc;
        
��) ȸ�����̺��� ȸ������ ���ϸ����� �������� ����� ���ϰ� ����� 1~2���
    ȸ���� 'vipȸ��', 3~5��� ȸ���� '�Ϲ�ȸ��',�� ���� ȸ���� '��ȸ��'
    �̶�� ���ڿ��� ����� ����Ͻÿ�. ��, ������ ���ϸ��� ���� 500���� 
    8000���� 8�� �������� ������ ���ϸ����� ���� ȸ���� ����� ���� ����
    ��Ÿ������ �Ѵ�.
    
    select mem_id as ȸ����ȣ,
           mem_name as ȸ����,
           mem_mileage as ���ϸ���,
           width_bucket(mem_mileage,8000,500,8) as ���,
           case when width_bucket(mem_mileage,8000,500,8) <= 2 then 'vipȸ��'
                when width_bucket(mem_mileage,8000,500,8) between 3 and 5 then '�Ϲ�ȸ��'
                else '��ȸ��' end as ���
      from member
     order by 3 desc;
    
    
    
    

      
    