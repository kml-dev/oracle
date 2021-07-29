2021-02-09-01)DML (Data Manipulation Languege)
  - ������ ���۾�
  - insert, update, delete ����� ����
  1. insert ���
    - �����͸� ���̺� �ű� ����� �� ����ϴ� ���
    (�������)
    insert into ���̺��[(�÷���1,�÷���2,...)]
      values(��1,��2,...);
      .(�÷���1,�÷���2,...) : ���� �����ϸ� �����ϸ� ���̺� ������ ������� 
        ����÷��� ������ ������ �µ��� values���� ���� ( )�ȿ� ���� �Ǿ����. 
      .(�÷���1,�÷���2,...)�� ����ϴ� ��� -> ������ �Է��� ���ʿ��� �÷��� ����
        ��, �÷� ��������� not null�� ��� ������ �� ����.
      .����'�÷���'�� ���� '��'�� ������ ������ �ݵ�� ��ġ �ؾ���.
      
��� ��) ���� �ڷḦ ȸ�����̺�(tb_mem)�� �����Ͻÿ�
  [�ڷ�]
  ȸ����ȣ     �̸�             �ּ�             ��ȭ��ȣ
--------------------------------------------------------
   M1001     ȫ�浿      ������ �߱� ���ﵿ     042-222-8202
   M1002     �̱漱      ����� ���ϱ� ��������  02-7654-0987
   M1003     õ���      ��� ��õ�� �ſ���     
   M1004     ������
--------------------------------------------------------

insert into tb_mem
  values('M1001','ȫ�浿','������ �߱� ���ﵿ','042-222-8202');
insert into tb_mem(MEM_ADDR,MEM_ID,mem_name,mem_telno)
  values('����� ���ϱ� ��������','M1002','�̱漱','02-7654-0987');
insert into tb_mem
  values('M1003','õ���','��� ��õ�� �ſ���','');
insert into tb_mem(mem_id,mem_name)
  values('M1004','������');
  
(Ȯ��)  
select * from tb_mem;

����] ���� �ڷḦ ��ǰ���̺�(tb_goods)�� �Է��Ͻÿ� 
��ǰ�ڵ�    ��ǰ��     ����
--------------------------
G11001    ���콺     15,000
G12002    USB(64G)  25,000
G20001    ��Ŀ��     
G21001    ����
--------------------------
insert into tb_goods
  values('G11001','���콺',15000)
insert into tb_goods(good_id,good_name,good_price)
  values('G12002','USB(64G)',25000)
insert into tb_goods
  values('G20001','��Ŀ��',0)    
insert into tb_goods(good_id,good_name)
  values('G21001','����')
  
select * from tb_goods;

����] ���� �ڷḦ �ֹ����̺�(orders)�� �Է��Ͻÿ�
  �ֹ���ȣ : 1
  �ֹ����� : ����
  �ֹ��ݾ� : ?
  ���� : ?
  �ֹ��� : õ���
  
insert into orders(order_id,mem_id)
  values(1,'M1003')

select * from orders

��� ��) ���� �ڷḦ �ֹ������̺�(orders_goods)�� �����Ͻÿ�
  ��ǰ�ڵ�   �ֹ���ȣ   ����
---------------------------
  G12002      1       5
  G21001      1       24
  G20001      1       10
---------------------------

insert into orders_goods
  values('G12002',1,5)
insert into orders_goods
  values('G11001',1,2)
insert into orders_goods
  values('G21001',1,24)
insert into orders_goods
  values('G20001',1,10)

select * from orders_goods 

update orders
  set order_amt=(select sum(good_price*a.qty)
                 from orders_goods a, tb_goods b
                 where a.good_id=b.good_id),
      order_flag='2'
  where order_id=1;
  
select * from orders


















