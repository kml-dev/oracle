2021-02-23-03) ��ȯ�Լ�
  - �ڷ����� ��ȯ�� ����ϴ� �Լ�
  - cast, to_char, to_number, to_date�� ����
  
  1. cast(expr as type)
   . expr�� ǥ���� ���� type�������� ��ȯ
   
��) 

select mem_id,
       mem_name,
       mem_mileage,
       cast(mem_mileage as char(10))
  from member 
  
select substr(cart_no,1,8),
       cast(substr(cart_no,1,8) as date) as ��¥,
       cast(substr(cart_no,9) as number) as "LOGIN�� ����",
       cart_prod,
       cart_qty
  from cart
 where rownum <= 10;
 
2. to_char(c|d|n [,fmt]) 
  - ��¥, ����, ���� �ڷḦ ������ ������ ���ڿ� �ڷ�� ��ȯ
  �����������ڿ�(fmt)
  -------------------------------------------------
  ������������            �ǹ�
  -------------------------------------------------
  ad, bc, cc            ����       
  yyyy,yyy,yy,y         �⵵
  month,mon,mm,rm       ��
  w,ww,iw               ����
  q                     �б�
  dd,ddd,j              �� (j�� ����� �������� ���ݱ��� ���� ��)
  day, dy, d            ���� ����
  am, pm, A.M., P.M.    ���� ����
  hh,hh12,hh24          �ð�
  mi                    ��
  ss,sssss              ��
  "���ڿ�"               ����� ���� ���ڿ�
  ------------------------------------------------
  select to_char(sysdate,'ad cc bc pm am') from  dual
  select to_char(sysdate,'yyyy month') from dual
  select to_char(sysdate,'yyyy mon') from dual
  select to_char(sysdate,'yyyy mm') from dual
  select to_char(sysdate,'yyyy rm') from dual
  select to_char(to_date('20201020'),'yyyy rm') from dual
  select to_char(sysdate,'yyyy-dd') from dual
  select to_char(sysdate,'yyyy-ddd') from dual
  select to_char(sysdate,'yyyy-j') from dual
  select to_char(sysdate,'yyyy w') from dual;
  select to_char(sysdate,'yyyy ww') from dual;
  select to_char(sysdate,'yyyy iw') from dual;
  
  select to_char(sysdate,'hh24:mi:ss') from dual;
  select to_char(sysdate,'hh24:mi:sssss') from dual;
  
  select to_char(sysdate,'yyyy"��" mm"��" dd"��"') from dual;
  
  select '1234'||trim(to_char(56,'00'))||'78' from dual
  
 
 