2021-02-24-01)
   **���ں�ȯ ���ڿ�
----------------------------------------------------------------------
  ���Ĺ��ڿ�                     �ǹ�
----------------------------------------------------------------------
     9                   �����Ǵ� �����Ͱ� ��ȿ�����̸� �����ڷḦ ����ϰ�
                         �����Ǵ� �����Ͱ� ��ȿ�� 0�̸� ����ó��
                         (�Ҽ��� ���ϴ� '0'�� ���)
     0                   �����Ǵ� �����Ͱ� ��ȿ�����̸� �����ڷḦ ����ϰ�
                         �����Ǵ� �����Ͱ� ��ȿ�� 0�̸� '0'�� ���
     $,L(l)              ȭ���ȣ�� ���
     MI                  �����Ͱ� ������ ��� ������ '-'��ȣ ���(�ݵ��
                         ���Ĺ��ڿ� �� ������ ���)
     PR                  �����Ͱ� ������ ��� '-'��ȣ ��� '< >'�� ���� ���
     ,(comma)            3�ڸ����� �ڸ��� ���
     .(dot)              �Ҽ��� ���
----------------------------------------------------------------------
��뿹) �츮���� �뵵�ú� �����ܾ����̺�(kor_loan_status)����
       2013�� 11�� ������ ��ȸ�Ͻÿ�
       alias�� �õ�, ���ⱸ��, �����ܾ��̸� �����ܾ��� 3�ڸ����� �ڸ�����
       �Ҽ����� �����Ͽ� ����Ͻÿ�
       
       select region as �õ�,
              gubun as ���ⱸ��,
              to_char(loan_jan_amt,'9,999,999.99') as �����ܾ�1,
              to_char(loan_jan_amt,'0,000,000.00') as �����ܾ�2,
              to_char(loan_jan_amt,'L9,999,999.99') as �����ܾ�3
         from kor_loan_status
        where period='201311'
        order by 1;

**��ǰ���̺��� ��ǰ��ȣ 'P102000001'�� 'P102000002'��ǰ�� �����ǸŰ��� 
  ���԰����� 90%�� �����Ͻÿ�
  
  update prod
     set prod_sale = prod_cost * 0.9 
   where prod_id in ('P102000001','P102000002')
      
    select prod_cost, prod_sale
      from prod
     where prod_id in ('P102000001','P102000002')   
     
��뿹) ��ǰ���̺��� �ŷ�ó�� �������(P10201)�� ��ǰ������ ��ȸ�Ͻÿ�
       alias�� ��ǰ��, ���԰�, �ǸŰ�, �����ǸŰ�, �����Ǹ������̸�
       �����Ǹ������� �����ǸŰ�-���԰��̰�,
       ������ ��� <>�ȿ� ����Ͻÿ�
       
       select prod_name as ��ǰ��,
              to_char(prod_cost,'9,999,999') as ���԰�,
              to_char(prod_price,'9,999,999')  as �ǸŰ�,
              to_char(prod_sale,'9,999,999') as �����ǸŰ�,
              to_char(prod_sale - prod_cost,'9,999,999PR') as �����Ǹ�����
         from prod
        where upper(prod_buyer) = 'P10201'

3. to_number(c[,fmt])
  - �־��� ���ڿ� c(��������)�� ���ڷ� ��ȯ
  - fmt�� to_char���İ� �����ϳ� ��� ��������� ����
  
��뿹)
select to_number('2021'),
       to_number('$1,200','$9,999') + 100,
       to_number('<200,000>','999,999PR') / 10
  from dual;
         
��뿹) ������ 2005�� 4�� 1���̶�� �����ϰ� ��ö�� ȸ��('k001')��
       ��ǰ�� �����ϱ� ���� ���θ��� �α����� �� īƮ��ȣ��
       �ο��ϵ��� �ڵ��Ͻÿ�
       
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
         
��뿹) ������ 2005�� 8�� 10���̶�� �����ϰ� ���� �ڷḦ �Է��Ͻÿ�
       ����ȸ�� : Ź����('n001')
       ��ǰ�ڵ� : ������ ������2('P202000014')
       ���ż��� : 2
       
insert into cart(cart_member,cart_no,cart_prod,cart_qty)
values('n001',fn_cart_no(to_date('20050810')).'P202000014',2);

select * from cart where cart_no like '200508%';
       
       ��ǰ�ڵ� : ������ ���('P302000011')
       ���ż��� : 5
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
         
         
         
         
         
