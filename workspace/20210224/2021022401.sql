2021-02-24-01)
   **숫자변환 문자열
----------------------------------------------------------------------
  형식문자열                     의미
----------------------------------------------------------------------
     9                   대응되는 데이터가 유효숫자이면 원본자료를 출력하고
                         대응되는 데이터가 무효의 0이면 공백처리
                         (소숫점 이하는 '0'을 출력)
     0                   대응되는 데이터가 유효숫자이면 원본자료를 출력하고
                         대응되는 데이터가 무효의 0이면 '0'을 출력
     $,L(l)              화폐기호를 출력
     MI                  데이터가 음수인 경우 우측에 '-'부호 출력(반드시
                         형식문자열 맨 우측에 기술)
     PR                  데이터가 음수인 경우 '-'부호 대신 '< >'로 묶어 출력
     ,(comma)            3자리마다 자리점 출력
     .(dot)              소숫점 출력
----------------------------------------------------------------------
사용예) 우리나라 대도시별 대출잔액테이블(kor_loan_status)에서
       2013년 11월 정보를 조회하시오
       alias는 시도, 대출구분, 대출잔액이며 대출잔액은 3자리마다 자리점과
       소숫점을 삽입하여 출력하시오
       
       select region as 시도,
              gubun as 대출구분,
              to_char(loan_jan_amt,'9,999,999.99') as 대출잔액1,
              to_char(loan_jan_amt,'0,000,000.00') as 대출잔액2,
              to_char(loan_jan_amt,'L9,999,999.99') as 대출잔액3
         from kor_loan_status
        where period='201311'
        order by 1;

**상품테이블에서 제품번호 'P102000001'과 'P102000002'제품의 할인판매가를 
  매입가격의 90%로 조정하시오
  
  update prod
     set prod_sale = prod_cost * 0.9 
   where prod_id in ('P102000001','P102000002')
      
    select prod_cost, prod_sale
      from prod
     where prod_id in ('P102000001','P102000002')   
     
사용예) 상품테이블에서 거래처가 대우전자(P10201)의 제품정보를 조회하시오
       alias는 상품명, 매입가, 판매가, 할인판매가, 할인판매이익이며
       할인판매이익은 할인판매가-매입가이고,
       음수인 경우 <>안에 출력하시오
       
       select prod_name as 상품명,
              to_char(prod_cost,'9,999,999') as 매입가,
              to_char(prod_price,'9,999,999')  as 판매가,
              to_char(prod_sale,'9,999,999') as 할인판매가,
              to_char(prod_sale - prod_cost,'9,999,999PR') as 할인판매이익
         from prod
        where upper(prod_buyer) = 'P10201'

3. to_number(c[,fmt])
  - 주어진 문자열 c(숫자형식)를 숫자로 변환
  - fmt는 to_char형식과 동일하나 모두 적용되지는 않음
  
사용예)
select to_number('2021'),
       to_number('$1,200','$9,999') + 100,
       to_number('<200,000>','999,999PR') / 10
  from dual;
         
사용예) 오늘이 2005년 4월 1일이라고 가정하고 오철희 회원('k001')이
       상품을 구입하기 위해 쇼핑몰에 로그인할 때 카트번호를
       부여하도록 코딩하시오
       
       select max(cart_no) + 1
         from cart
        where cart_no like '20050401%';
       
       
CREATE OR REPLACE FUNCTION FN_CART_NO(
            P_DATE IN DATE)
        RETURN CHAR
        IS
            V_NUM NUMBER := 0;
            V_COUNT NUMBER := 0;
            V_DAY CHAR(9) := TO_CHAR(P_DATE, 'YYYYMMDD')||'%';
            V_CART_NO CART.CART_NO%TYPE;
        BEGIN
            SELECT COUNT(*) INTO V_COUNT
                FROM CART
            WHERE CART_NO LIKE V_DAY;
            
            V_NUM := V_COUNT + 1;
            V_CART_NO := TO_CHAR(P_DATE, 'YYYYMMDD') || TRIM(TO_CHAR(V_NUM, '00000'));
            
            RETURN V_CART_NO;
        END;
        
    SELECT FN_CART_NO(TO_DATE('20050810')) FROM DUAL;
        
       select to_char(to_date('20050401'),'YYYYMMDD')||
              trim(to_char((max(to_number(substr(cart_no,-5))) + 1),'00000'))
         from cart
        where cart_no like '20050401%';
         
사용예) 오늘이 2005년 8월 10일이라고 가정하고 다음 자료를 입력하시오
       구매회원 : 탁원재('n001')
       상품코드 : 남성용 봄자켓2('P202000014')
       구매수량 : 2
       
insert into cart(cart_member,cart_no,cart_prod,cart_qty)
values('n001',fn_cart_no(to_date('20050810')).'P202000014',2);

select * from cart where cart_no like '200508%';
       
       상품코드 : 남성용 향수('P302000011')
       구매수량 : 5
declare
  v_count number := 0;
begin 
  select count(*) into v_count
    from cart
   where cart_no = fn_cart_no(to_date('20050810'))
     and cart_member = 'n001';
     
    IF v_count = 0 THEN
       INSERT INTO CART
         VALUES('n001',FN_CART_NO(TO_DATE('20050810')),'P202000014',2);
  ELSE
       SELECT CART_NO INTO V_CART_NO
         FROM CART
        WHERE SUBSTR(CART_NO,1,8) = '20050810'
          AND CART_MEMBER = 'n001';
        
       INSERT INTO CART
         VALUES('n001',V_CART_NO,'P302000011',5);
      END IF;
      COMMIT;
END;

SELECT * FROM CART WHERE CART_NO LIKE '200508%';
         
         
         
         
         
