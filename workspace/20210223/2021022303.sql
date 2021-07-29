2021-02-23-03) 변환함수
  - 자료형의 변환을 담당하는 함수
  - cast, to_char, to_number, to_date가 제공
  
  1. cast(expr as type)
   . expr로 표현된 값을 type형식으로 변환
   
예) 

select mem_id,
       mem_name,
       mem_mileage,
       cast(mem_mileage as char(10))
  from member 
  
select substr(cart_no,1,8),
       cast(substr(cart_no,1,8) as date) as 날짜,
       cast(substr(cart_no,9) as number) as "LOGIN된 순번",
       cart_prod,
       cart_qty
  from cart
 where rownum <= 10;
 
2. to_char(c|d|n [,fmt]) 
  - 날짜, 숫자, 문자 자료를 지정된 형식의 문자열 자료로 변환
  형식지정문자열(fmt)
  -------------------------------------------------
  형식지정문자            의미
  -------------------------------------------------
  ad, bc, cc            세기       
  yyyy,yyy,yy,y         년도
  month,mon,mm,rm       월
  w,ww,iw               주차
  q                     분기
  dd,ddd,j              일 (j는 기원전 언제부터 지금까지 지난 날)
  day, dy, d            주의 요일
  am, pm, A.M., P.M.    오전 오후
  hh,hh12,hh24          시간
  mi                    분
  ss,sssss              초
  "문자열"               사용자 정의 문자열
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
  
  select to_char(sysdate,'yyyy"년" mm"월" dd"일"') from dual;
  
  select '1234'||trim(to_char(56,'00'))||'78' from dual
  
 
 