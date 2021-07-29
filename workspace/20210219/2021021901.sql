2021-02-19-01)
    select mem_id as 회원번호,
           mem_name as 회원이름,
           extract(year from sysdate) - extract(year from mem_bir) as 나이,
           mem_mileage as 마일리지
      from member
     where substr(mem_regno2,1,1) = '2'
       and extract(year from sysdate) - extract(year from mem_bir)
           between 40 and 49;
           
  4) like 연산자
    - 패턴비교시 사용
    - 문자열 자료 비교에 사용되는 연산자
    - 와일드카드 '%'와 '_' 사용
    - '%'는 사용된 위치에서 모든 문자열과 대응
      ex) '박%' : '박'으로 시작하는 모든 문자열과 대응
          '%도' : '도'로 끝나느 모든 문자열과 대응
    - '_'는 사용된 위치에서 한 글자와 대응
      ex) '박_' : '박'으로 시작하고 2글자로 구성된 문자열로 두번째 글자는 
                  모든 문자가 허용된 문자열과 대응
          '_도' : '도'로 끝나고 첫번째 글자는 모든 문자 허용
          
예) 거래처테이블(buyer)에서 주소지가 서울인 거래처를 조회하시오
    alias는 거래처코드, 거래처명, 주소, 담당자
    
    select buyer_id as 거래처코드,
           buyer_name as 거래처명,
           buyer_add1||' '||buyer_add2 as 주소,
           buyer_bankname as 담당자
      from buyer    
    -- where substr(buyer_add1,1,2) = '서울'
     where buyer_add1 like '서울%'

예) 장바구니테이블(cart)에서 2005년 5월 판매현화을 조회하시오
    alias는 날짜, 제품코드, 판매수량이다

select to_date(substr(cart_no,1,8)) as 날짜,
       cart_prod as 제품코드,
       cart_qty as 판매수량
  from cart
 where cart_no like '200505%'
 order by 1;
 
문제] 2005년 3월 제품매입 현황을 조회하시오
     alias는 날짜, 제품코드, 매입수량이다
     날짜순으로 출력하시오
     
     select buy_date as 날짜,
            buy_prod as 제품코드,
            buy_qty as 매입수량
       from buyprod
      --where buy_date like '2005/03/%'
      where buy_date between '20050301'and'20050331'
      order by 1;

** 234567*12345의 값을 구하시오
select 234567 * 12345 from dual;

select sysdate from dual;
           

