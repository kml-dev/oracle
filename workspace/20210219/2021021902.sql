2021-02-19-02)�Լ�(function)
  - �̸� �����Ͽ� ������ �� ���డ���� ���
  - �Լ��� ��ø ����� ����
  - ������ �Լ�: ���̺� ����� ���� ���� ������� �Լ��� �����Ͽ� 
               �ϳ��� ����� ��ȯ
  - ������ �Լ�: ���� ���� �׷�ȭ�Ͽ� ����� ó���� �� �ϳ��� ����� 
               ��ȯ�ϴ� �Լ�. �׷��Լ�(sum,avg,count,min,max ��)
               
1. ���ڿ� �Լ�
 1) ���ڿ� ���� ������ 
   - '||' (�ڹٿ� ���ڿ� ���տ����� '+'�� ���� ���)
   - ���ڿ� �����Լ� concat()�� ���� ���
   (�������)
   ���ڿ� || ���ڿ�
   
��뿹) ȸ�����̺��� ����ȸ���̸鼭 ���ϸ����� 2000�̻� ������ ȸ���� ��ȸ�Ͻÿ�.
       alias�� ȸ����ȣ, ȸ����, �ֹι�ȣ, ���ϸ���
       ��, �ֹι�ȣ�� 'XXXXXX-XXXXXXX'�������� ����Ͻÿ�
       
       select mem_id as ȸ����ȣ,
              mem_name as ȸ����,
              mem_regno1||'-'||mem_regno2 as �ֹι�ȣ,
              mem_mileage as ���ϸ���
         from member
        where mem_mileage>=2000
          and substr(mem_regno2,1,1) in ('1','3');

  2) concat
    - �־��� �� ���ڿ��� �����Ͽ� �ϳ��� ���ڿ��� ��ȯ
    - '||'�� ���� ��� 
    (�������)
    concat(s1,s2)
    
    select mem_id as ȸ����ȣ,
              mem_name as ȸ����,
              concat(concat(mem_regno1,'-'),mem_regno2) as �ֹι�ȣ,
              mem_mileage as ���ϸ���
         from member
        where mem_mileage>=2000
          and substr(mem_regno2,1,1) in ('1','3');
          
  3) lower(s), upper(s), initcap(s)
    - 'lower' : �־��� ���ڿ� ���� �ڷ� �� �빮�ڸ� ��� �ҹ��ڷ� ��ȯ
    - 'upper' : �־��� ���ڿ� ���� �ڷ� �� �ҹ��ڸ� ��� �빮�ڷ� ��ȯ
    - 'initcap' : �־��� ���ڿ� ���� �ڷ� �� �ܾ��� ù ���ڸ� �빮�ڷ� ��ȯ
    
��뿹) ��ǰ���̺�(prod)���� �з��ڵ尡 'p201'�� ���� �ڷḦ ��ȸ�Ͻÿ�
       alias�� ��ǰ�ڵ�, ��ǰ��, �з��ڵ�, �ǸŰ���
       
    select prod_id as ��ǰ�ڵ�,
           prod_name as ��ǰ��,
           prod_lgu as �з��ڵ�,
           prod_price as �ǸŰ���
      from prod
     where lower(prod_lgu)='p201';
     
��뿹) ������̺��� email�÷��� ���� �ҹ��ڷ� ��ȯ�Ͻÿ�.
    select employee_id,
           emp_name,
           lower(email),
           initcap(email)
      from employees;
      
  4) lpad(c1,n[,c2]),rpad
    - ������ ���̸� n��ŭ Ȯ���Ͽ� c1�� ä��� ���� ����(����:lpad,������:rpad)�� c2�� ä��
    - c2�� �����Ǹ� �������� ä��
    
��뿹) ��ǰ���̺��� ��ǰ���� 30����Ʈ�� ����ϵ� ���� ��ﰣ(������)��
       '^'���ڸ� �����Ͽ� ����Ͻÿ�
       
       select prod_id,
              rpad(prod_name,30,'^') as ��ǰ��1,
              lpad(prod_name,30,'^') as ��ǰ��2
         from prod
        where rownum <= 10;
       
��뿹) ��ǰ���̺��� �з��ڵ� 'p101'�� ���� ��ǰ������ ����Ͻÿ�.
       alias�� ��ǰ��, ���԰���, ���Ⱑ��, �ŷ�ó�ڵ�
       �� �ݾ��� 3�ڸ����� �ڸ���(',')�� �����ϰ� 15�ڸ��� ����Ұ�
       
       select prod_name as ��ǰ��,
              lpad(to_char(prod_cost, '9,999,999'),15) as ���԰���,
              --lpad(to_char(prod_price,'9,999,999'),15) as ���Ⱑ��,
              to_char(prod_price,'999,999,999,999') as ���Ⱑ��,
              prod_buyer as �ŷ�ó�ڵ�
         from prod
        where lower(prod_lgu)='p101';
        
  5) ltrim(c1[,c2]),rtrim(c1,[,c2]),trim(c1)
    - �־��� ���ڿ� �ڷ� c1���� ���ʿ���(ltrim)�Ǵ� �����ʿ���(rtrim)
      c2�� ã�� ����
    - c2�� �����Ǹ� ������ ã�� ����
    - trim�� ���� ������ ��� ����
    - ��, �ܾ� ����(���ڿ� ����)�� ������ ������ �� ����(replace�Լ� ���)
    
��) ������̺��� �����(emp_name)�� ������ Ÿ���� varchar2���� char�� 
    �����Ͻÿ�
    
    alter table employees modify(emp_name char(80)); 
     
    ����� ���
    select rtrim(emp_name) from employees;
    
    update employees
       set emp_name=rtrim(emp_name);
    
    alter table employees modify(emp_name varchar2(80));
       
    commit;
    
��뿹) ��ǰ���̺��� ��ǰ�� �� '����'�̶�� ���ڿ��� ���ʿ��� ã�� �����Ͻÿ�

      select prod_id as ��ǰ�ڵ�,
             prod_name as ��ǰ��1,
             ltrim(prod_name,'���� ') as ��ǰ��2,
             rtrim(prod_name,'���� 1') as ��ǰ��3
        from prod;

   
   
















