2021-02-09-01)DML (Data Manipulation Languege)
  - 데이터 조작어
  - insert, update, delete 명령이 포함
  1. insert 명령
    - 데이터를 테이블에 신규 등록할 때 사용하는 명령
    (사용형식)
    insert into 테이블명[(컬럼명1,컬럼명2,...)]
      values(값1,값2,...);
      .(컬럼명1,컬럼명2,...) : 생략 가능하며 생략하면 테이블 생성시 만들어진 
        모든컬럼에 생성된 순서에 맞도록 values절의 값이 ( )안에 정의 되어야함. 
      .(컬럼명1,컬럼명2,...)을 기술하는 경우 -> 데이터 입력이 불필요한 컬럼을 생략
        단, 컬럼 제약사항이 not null인 경우 생략할 수 없다.
      .사용된'컬럼명'의 수와 '값'의 개수와 순번은 반드시 일치 해야함.
      
사용 예) 다음 자료를 회원테이블(tb_mem)에 삽입하시오
  [자료]
  회원번호     이름             주소             전화번호
--------------------------------------------------------
   M1001     홍길동      대전시 중구 대흥동     042-222-8202
   M1002     이길선      서울시 성북구 신장위동  02-7654-0987
   M1003     천상봉      충북 제천시 신월동     
   M1004     강감찬
--------------------------------------------------------

insert into tb_mem
  values('M1001','홍길동','대전시 중구 대흥동','042-222-8202');
insert into tb_mem(MEM_ADDR,MEM_ID,mem_name,mem_telno)
  values('서울시 성북구 신장위동','M1002','이길선','02-7654-0987');
insert into tb_mem
  values('M1003','천상봉','충북 제천시 신월동','');
insert into tb_mem(mem_id,mem_name)
  values('M1004','강감찬');
  
(확인)  
select * from tb_mem;

문제] 다음 자료를 상품테이블(tb_goods)에 입력하시오 
상품코드    상품명     가격
--------------------------
G11001    마우스     15,000
G12002    USB(64G)  25,000
G20001    마커펜     
G21001    볼펜
--------------------------
insert into tb_goods
  values('G11001','마우스',15000)
insert into tb_goods(good_id,good_name,good_price)
  values('G12002','USB(64G)',25000)
insert into tb_goods
  values('G20001','마커펜',0)    
insert into tb_goods(good_id,good_name)
  values('G21001','볼펜')
  
select * from tb_goods;

문제] 다음 자료를 주문테이블(orders)에 입력하시오
  주문번호 : 1
  주문일자 : 오늘
  주문금액 : ?
  상태 : ?
  주문자 : 천상봉
  
insert into orders(order_id,mem_id)
  values(1,'M1003')

select * from orders

사용 예) 다음 자료를 주문상세테이블(orders_goods)에 삽입하시오
  상품코드   주문번호   수량
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


















