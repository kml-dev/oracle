2021-02-19-01)
    select mem_id as ȸ����ȣ,
           mem_name as ȸ���̸�,
           extract(year from sysdate) - extract(year from mem_bir) as ����,
           mem_mileage as ���ϸ���
      from member
     where substr(mem_regno2,1,1) = '2'
       and extract(year from sysdate) - extract(year from mem_bir)
           between 40 and 49;
           
  4) like ������
    - ���Ϻ񱳽� ���
    - ���ڿ� �ڷ� �񱳿� ���Ǵ� ������
    - ���ϵ�ī�� '%'�� '_' ���
    - '%'�� ���� ��ġ���� ��� ���ڿ��� ����
      ex) '��%' : '��'���� �����ϴ� ��� ���ڿ��� ����
          '%��' : '��'�� ������ ��� ���ڿ��� ����
    - '_'�� ���� ��ġ���� �� ���ڿ� ����
      ex) '��_' : '��'���� �����ϰ� 2���ڷ� ������ ���ڿ��� �ι�° ���ڴ� 
                  ��� ���ڰ� ���� ���ڿ��� ����
          '_��' : '��'�� ������ ù��° ���ڴ� ��� ���� ���
          
��) �ŷ�ó���̺�(buyer)���� �ּ����� ������ �ŷ�ó�� ��ȸ�Ͻÿ�
    alias�� �ŷ�ó�ڵ�, �ŷ�ó��, �ּ�, �����
    
    select buyer_id as �ŷ�ó�ڵ�,
           buyer_name as �ŷ�ó��,
           buyer_add1||' '||buyer_add2 as �ּ�,
           buyer_bankname as �����
      from buyer    
    -- where substr(buyer_add1,1,2) = '����'
     where buyer_add1 like '����%'

��) ��ٱ������̺�(cart)���� 2005�� 5�� �Ǹ���ȭ�� ��ȸ�Ͻÿ�
    alias�� ��¥, ��ǰ�ڵ�, �Ǹż����̴�

select to_date(substr(cart_no,1,8)) as ��¥,
       cart_prod as ��ǰ�ڵ�,
       cart_qty as �Ǹż���
  from cart
 where cart_no like '200505%'
 order by 1;
 
����] 2005�� 3�� ��ǰ���� ��Ȳ�� ��ȸ�Ͻÿ�
     alias�� ��¥, ��ǰ�ڵ�, ���Լ����̴�
     ��¥������ ����Ͻÿ�
     
     select buy_date as ��¥,
            buy_prod as ��ǰ�ڵ�,
            buy_qty as ���Լ���
       from buyprod
      --where buy_date like '2005/03/%'
      where buy_date between '20050301'and'20050331'
      order by 1;

** 234567*12345�� ���� ���Ͻÿ�
select 234567 * 12345 from dual;

select sysdate from dual;
           

