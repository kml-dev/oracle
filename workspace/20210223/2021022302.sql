2021-02-23-02) ��¥�Լ�
 1. sysdate
   - �ý��ۿ��� �����ϴ� ��¥(��,��,��) �� �ð�����(��,��,��)�� ��ȯ
   - ������ ������ ����� ��, �������� ���� �Ǵ� ��¥ �ڷ�
   
��뿹)
select sysdate + 25, sysdate - 25, trunc(sysdate) - to_date('20200223') from dual

  2. add_months(d,n)
    - �־��� ��¥������ d�� n������ ���� ��¥ ��ȯ

select add_months(sysdate,10) + 10 from dual;    

3. next_day(d,c)
  - �־��� ��¥ ������ d ���� ó�� ������(���� ����) c������ ��¥ ��ȯ
  - c�� '������' �Ǵ� '��' ������ ���
    (monday���� ��� �Ұ� -> ������ ȯ�漳�� �Ͽ���..)
    
��뿹) select next_day(sysdate,'��'),
              next_day(sysdate,'�Ͽ���'),
              next_day(sysdate,'ȭ'),
              next_day(sysdate,'�ݿ���')
         from dual
   
  4. last_day(d)
    - �־��� ��¥ ������ d���� �ش� ���� ������ ��¥ ��ȯ
    (��뿹)
    select last_day(to_date('20070210')) from dual;
    
  5. extract(fmt,from d)
    - �־��� ��¥������ d���� fmt�� ���ǵ� ����� ��ȯ
    - fmt�� year, month, day, hour, minute, second�̸� ���ڷ� ���
 
��뿹) ȸ�����̺��� ȸ������ ��������� �������� ���ϳ� ���� ���ڸ� �����Ϸ��Ѵ�.
       ���� �������� ȸ������� ����Ͻÿ�.
       alias�� ȸ����ȣ, ȸ����, ����, �ڵ�����ȣ, �̸����ּ�
       
       select mem_id as ȸ����ȣ,
              mem_name as ȸ����,
              mem_bir as ����,
              mem_hp as �ڵ�����ȣ,
              mem_mail as �̸����ּ�
         from member
        where extract(month from to_date('20210115')) = extract(month from mem_bir)
          and extract(day from sysdate) = extract(day from mem_bir);
            
��뿹) ȸ�����̺��� ȸ������ ��������� �������� ���ϳ� ������ ��
       ���� ���ڸ� �����Ϸ��Ѵ�.
       ���� �������� ȸ������� ����Ͻÿ�.
       alias�� ȸ����ȣ, ȸ����, ����, �ڵ�����ȣ, �̸����ּ�
       
       select mem_id as ȸ����ȣ,
              mem_name as ȸ����,
              mem_bir as ����,
              mem_hp as �ڵ�����ȣ,
              mem_mail as �̸����ּ�
         from member
        where to_char(mem_bir,'mmdd') = to_char(sysdate+7,'mmdd');
        
��뿹) ȸ�����̺��� ȸ������ ��������� �������� ���ϳ� ���� ���ڸ� �����Ϸ��Ѵ�.
       ������ ȸ���� ��ȸ�Ͻÿ�
       alias�� ȸ����ȣ, ȸ����, ����, �ڵ�����ȣ, �̸����ּ�
       
       select mem_id as ȸ����ȣ,
              mem_name as ȸ����,
              mem_bir as ����,
              mem_hp as �ڵ�����ȣ,
              mem_mail as �̸����ּ�
         from member
        where extract(month from sysdate) = extract(month from mem_bir);
          
    update member
       set mem_bir = to_date(to_char(extract(year from mem_bir))||
                     trim(to_char(extract(month from sysdate+7),'00'))||
                     trim(to_char(extract(day from sysdate+7),'00')))
     where mem_id in ('q001','w001');
     
     
                     
        
        
