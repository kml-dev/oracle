  - '�⺻Ű������'�� ���� 'pk_���̺��'���� ����
  - '�ܷ�Ű������'�� ���� 'fk_���̺��_�������̺��'���� ����
  
  
��)
1)tb_mem ���̺� ����
CREATE TABLE tb_mem(
  mem_id char(5),
  mem_name varchar2(30) not null,
  mem_addr varchar2(100),
  mem_telno varchar2(20),
  
  constraint pk_tb_mem primary key(mem_id));

2)��ǰ���̺�(tb_goods)����
CREATE TABLE tb_goods(
  good_id char(6), -- primary key(not null�� ���ʿ�)
  good_name varchar2(50) not null,
  good_price number(7) default 0,
  
  constraint pk_tb_goods primary key(good_id)
);

3)�ֹ����̺�(orders)����
create table orders(
  order_id number(5), -- primary key(not null�� ���ʿ�)
  order_date date default sysdate,
  order_amt number(8),
  order_flag char(1),
  mem_id char(5),  -- foreign key
  
  constraint pk_orders primary key(order_id),
  constraint fk_orders_tb_mem foreign key(mem_id)
    references tb_mem(mem_id)
);

4)�ֹ�_��ǰ���̺�(orders_goods)����
create table orders_goods(
  good_id char(6), -- primary key & foreign key
  order_id number(5), -- primary key & foreign key
  qty number(3) default 0,
  
  constraint pk_orders_goods primary key(good_id, order_id),
  constraint fk_ogoods foreign key (good_id)
    references tb_goods(good_id),
  constraint fk_orders foreign key (order_id)
    references orders(order_id)
);

**tb_mem���̺��� �����Ͻÿ�
drop table tb_mem;

commit
