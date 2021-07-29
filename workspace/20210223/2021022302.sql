2021-02-23-02) 날짜함수
 1. sysdate
   - 시스템에서 제공하는 날짜(년,월,일) 및 시간정보(시,분,초)를 반환
   - 덧셈과 뺄셈의 대상이 됨, 연산결과는 날수 또는 날짜 자료
   
사용예)
select sysdate + 25, sysdate - 25, trunc(sysdate) - to_date('20200223') from dual

  2. add_months(d,n)
    - 주어진 날짜데이터 d에 n개월을 더한 날짜 반환

select add_months(sysdate,10) + 10 from dual;    

3. next_day(d,c)
  - 주어진 날짜 데이터 d 이후 처음 만나는(가장 빠른) c요일의 날짜 반환
  - c는 '월요일' 또는 '월' 등으로 기술
    (monday등은 사용 불가 -> 현재의 환경설정 하에서..)
    
사용예) select next_day(sysdate,'월'),
              next_day(sysdate,'일요일'),
              next_day(sysdate,'화'),
              next_day(sysdate,'금요일')
         from dual
   
  4. last_day(d)
    - 주어진 날짜 데이터 d에서 해당 월의 마지막 날짜 반환
    (사용예)
    select last_day(to_date('20070210')) from dual;
    
  5. extract(fmt,from d)
    - 주어진 날짜데이터 d에서 fmt로 정의된 결과를 반환
    - fmt는 year, month, day, hour, minute, second이며 숫자로 취급
 
사용예) 회원테이블에서 회원들의 생년월일을 기준으로 생일날 축하 문자를 전송하려한다.
       오늘 보내야할 회원목록을 출력하시오.
       alias는 회원번호, 회원명, 생일, 핸드폰번호, 이메일주소
       
       select mem_id as 회원번호,
              mem_name as 회원명,
              mem_bir as 생일,
              mem_hp as 핸드폰번호,
              mem_mail as 이메일주소
         from member
        where extract(month from to_date('20210115')) = extract(month from mem_bir)
          and extract(day from sysdate) = extract(day from mem_bir);
            
사용예) 회원테이블에서 회원들의 생년월일을 기준으로 생일날 일주일 전
       축하 문자를 전송하려한다.
       오늘 보내야할 회원목록을 출력하시오.
       alias는 회원번호, 회원명, 생일, 핸드폰번호, 이메일주소
       
       select mem_id as 회원번호,
              mem_name as 회원명,
              mem_bir as 생일,
              mem_hp as 핸드폰번호,
              mem_mail as 이메일주소
         from member
        where to_char(mem_bir,'mmdd') = to_char(sysdate+7,'mmdd');
        
사용예) 회원테이블에서 회원들의 생년월일을 기준으로 생일날 축하 문자를 전송하려한다.
       생일인 회원을 조회하시오
       alias는 회원번호, 회원명, 생일, 핸드폰번호, 이메일주소
       
       select mem_id as 회원번호,
              mem_name as 회원명,
              mem_bir as 생일,
              mem_hp as 핸드폰번호,
              mem_mail as 이메일주소
         from member
        where extract(month from sysdate) = extract(month from mem_bir);
          
    update member
       set mem_bir = to_date(to_char(extract(year from mem_bir))||
                     trim(to_char(extract(month from sysdate+7),'00'))||
                     trim(to_char(extract(day from sysdate+7),'00')))
     where mem_id in ('q001','w001');
     
     
                     
        
        
