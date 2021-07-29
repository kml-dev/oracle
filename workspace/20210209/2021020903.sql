  - '기본키설정명'은 보통 'pk_테이블명'으로 구성
  - '외래키설정명'은 보통 'fk_테이블명_참조테이블명'으로 구성
  
  
예)
1)tb_mem 테이블 생성
CREATE TABLE tb_mem(
  mem_id char(5),
  mem_name varchar2(30) not null,
  mem_addr varchar2(100),
  mem_telno varchar2(20),
  
  constraint pk_tb_mem primary key(mem_id));

2)상품테이블(tb_goods)생성
CREATE TABLE tb_goods(
  good_id char(6), -- primary key(not null이 불필요)
  good_name varchar2(50) not null,
  good_price number(7) default 0,
  
  constraint pk_tb_goods primary key(good_id)
);

3)주문테이블(orders)생성
create table orders(
  order_id number(5), -- primary key(not null이 불필요)
  order_date date default sysdate,
  order_amt number(8),
  order_flag char(1),
  mem_id char(5),  -- foreign key
  
  constraint pk_orders primary key(order_id),
  constraint fk_orders_tb_mem foreign key(mem_id)
    references tb_mem(mem_id)
);

4)주문_상품테이블(orders_goods)생성
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

**tb_mem테이블을 삭제하시오
drop table tb_mem;

commit
