2021-02-22-01)문자열 함수..cont
  6) substr
    - 원본 문자열에서 정의된 길이민큼의 부분문자열을 추출함
    - 결과도 문자열ㅇ미
    (사용형식)
    substr(c,n[,len])
      . 주어진 문자열 c에서 n번째에서 len개수 만큼의 문자열을 추출하여 반환
      . n이 0 또는 1이면 첫번째 글자부터 처리
      . n이 음수이면 뒷자리부터 처리
      . len이 생략되면 n자리 이후 모든 문자열 반환

사용예)  장바구니 테이블에서 2005년 7월 판매자료를 조회하시오
        alias는 판매일자, 구매자, 상품명, 수량
        
        select to_date(substr(cart_no,1,8)) as 판매일자,
               cart_member as 구매자,
               b.prod_name as 상품명,
               cart_qty as 수량
          from cart a, prod b
         where a.cart_prod=b.prod_id --조인 조건
           and substr(cart_no,1,6) = '200507'
         order by to_date(substr(cart_no,1,8)) asc;
    
사용예) 사원테이블(employees)에서 판매관련 직책(sales : SA_XXX)을 
       부여받은 사원정보를 조회하시오
       alias는 사원번호, 사원명, 부서명, 직책코드, 급여이다
       
       select a.employee_id as 사원번호,
              a.emp_name as 사원명,
              b.department_name as 부서명,
              a.job_id as 직책코드,
              a.salary as 급여
         from employees a, departments b
        where a.department_id=b.department_id
          and substr(a.job_id,1,2)='SA'
        order by 5 desc;
    
문제1) 회원테이블에서 김씨성을 가진 회원정보를 출력하시오
      alias는 회원번호, 회원명, 성별, 마일리지이다
      
      select mem_id as 회원번호,
             mem_name as 회원명,
             case when substr(mem_regno2,1,1)='1' or
                       substr(mem_regno2,1,1)='3' then '남성'
                  else '여성' end as "성별",
             mem_mileage as 마일리지
        from member
       where substr(mem_name,1,1)='김'
       -- where mem_name like '김%';
       order by 4 desc;

  7) replace
    - 특정문자열을 찾아 다른 문자열로 대칭시킴
    (사용형식)
    replace(c1,c2[,c3])
     . 주어진 문자열 c1에서 c2문자열을 모두 찾아 c3문자열로 대치
     . c3가 생략되면 찾은 문자열을 제거함(문자열 내부의 공백제거에 사용)
     
사용예)
select '  ILPOSTINO   BOYHOOD',
       trim('  ILPOSTINO   BOYHOOD'),
       replace('  ILPOSTINO   BOYHOOD',' '),
       replace('  ILPOSTINO   BOYHOOD',' ','*')
  from dual
  
문제]사원테이블에서 2005년 이후 입사한 사원의 전화번호 출력형식을 xxx-xxx-xxxx형식으로 출력하시오
    alias는 사원번호, 사원명,전화번호,비고이다
    상태는 '재직중','퇴직' 중 하나를 출력할 것
    
    select employee_id as 사원번호,
           emp_name as 사원명,
           replace(phone_number,'.','-') as 전화번호,
           case when retire_date is null then '재직중'
                else '퇴직' end as 비고
      from employees
     where hire_date>=to_date('20050101');
     
  8) instr
    - 문자열에서 특정 문자열의 위치값(index)을 반환
    (사용형식)
    instr(c1,c2[,m[,n]])
     . 주어진 문자열 c1에서 c2문자열이 처음 출현한 위치 반환
     . m은 검사할 특정위치를 지정할 때 사용되는 index
     . n은 반복되어 표현된 문자열 중 반복된 횟수를 특정하여 검색할 때 
       사용
       
사용예) 
select emp_name,
       instr(emp_name, 'o'),
       instr(emp_name, 'o',3),
       instr(emp_name, 'o',2,2)
  from employees
 where department_id=50;
 
 9) length(c),lengthb(c)
    . length(c) : c문자열 내의 문자의 수
    . lengthb(c) : c문자열의 길이(byte) 수
    . 한글자 한 글자는 3byte로 표현됨  
    

    
        

        
       