2021-02-19-02)함수(function)
  - 미리 구성하여 컴파일 한 실행가능한 모듈
  - 함수는 중첩 사용이 가능
  - 단일행 함수: 테이블에 저장된 개별 행을 대상으로 함수를 적용하여 
               하나의 결과를 반환
  - 복수행 함수: 여러 행을 그룹화하여 결과를 처리한 후 하나의 결과를 
               반환하는 함수. 그룹함수(sum,avg,count,min,max 등)
               
1. 문자열 함수
 1) 문자열 결합 연산자 
   - '||' (자바와 문자열 결합연산자 '+'와 동일 기능)
   - 문자열 결합함수 concat()와 같은 기능
   (사용형식)
   문자열 || 문자열
   
사용예) 회원테이블에서 남성회원이면서 마일리지가 2000이상 보유한 회원을 조회하시오.
       alias는 회원번호, 회원명, 주민번호, 마일리지
       단, 주민번호는 'XXXXXX-XXXXXXX'형식으로 출력하시오
       
       select mem_id as 회원번호,
              mem_name as 회원명,
              mem_regno1||'-'||mem_regno2 as 주민번호,
              mem_mileage as 마일리지
         from member
        where mem_mileage>=2000
          and substr(mem_regno2,1,1) in ('1','3');

  2) concat
    - 주어진 두 문자열을 결합하여 하나의 문자열을 반환
    - '||'와 같은 기능 
    (사용형식)
    concat(s1,s2)
    
    select mem_id as 회원번호,
              mem_name as 회원명,
              concat(concat(mem_regno1,'-'),mem_regno2) as 주민번호,
              mem_mileage as 마일리지
         from member
        where mem_mileage>=2000
          and substr(mem_regno2,1,1) in ('1','3');
          
  3) lower(s), upper(s), initcap(s)
    - 'lower' : 주어진 문자열 내의 자료 중 대문자를 모두 소문자로 변환
    - 'upper' : 주어진 문자열 내의 자료 중 소문자를 모두 대문자로 변환
    - 'initcap' : 주어진 문자열 내의 자료 중 단어의 첫 글자만 대문자로 변환
    
사용예) 상품테이블(prod)에서 분류코드가 'p201'에 속한 자료를 조회하시오
       alias는 상품코드, 상품명, 분류코드, 판매가격
       
    select prod_id as 상품코드,
           prod_name as 상품명,
           prod_lgu as 분류코드,
           prod_price as 판매가격
      from prod
     where lower(prod_lgu)='p201';
     
사용예) 사원테이블에서 email컬럼의 값을 소문자로 변환하시오.
    select employee_id,
           emp_name,
           lower(email),
           initcap(email)
      from employees;
      
  4) lpad(c1,n[,c2]),rpad
    - 지정된 길이르 n만큼 확보하여 c1을 채우고 남는 공간(왼쪽:lpad,오른쪽:rpad)을 c2로 채움
    - c2가 생략되면 공백으로 채움
    
사용예) 상품테이블에서 상품명을 30바이트로 출력하되 남는 기억간(오른쪽)에
       '^'문자를 삽입하여 출력하시오
       
       select prod_id,
              rpad(prod_name,30,'^') as 상품명1,
              lpad(prod_name,30,'^') as 상품명2
         from prod
        where rownum <= 10;
       
사용예) 상품테이블에서 분류코드 'p101'에 속한 상품정보를 출력하시오.
       alias는 상품명, 매입가격, 매출가격, 거래처코드
       단 금액은 3자리마다 자리점(',')을 삽입하고 15자리에 출력할것
       
       select prod_name as 상품명,
              lpad(to_char(prod_cost, '9,999,999'),15) as 매입가격,
              --lpad(to_char(prod_price,'9,999,999'),15) as 매출가격,
              to_char(prod_price,'999,999,999,999') as 매출가격,
              prod_buyer as 거래처코드
         from prod
        where lower(prod_lgu)='p101';
        
  5) ltrim(c1[,c2]),rtrim(c1,[,c2]),trim(c1)
    - 주어진 문자열 자료 c1에서 왼쪽에서(ltrim)또는 오른쪽에서(rtrim)
      c2를 찾아 삭제
    - c2가 생략되면 공백을 찾아 삭제
    - trim은 양쪽 공백을 모두 삭제
    - 단, 단어 내부(문자열 내부)의 공백은 삭제할 수 없음(replace함수 사용)
    
예) 사원테이블에서 사원명(emp_name)의 데이터 타입을 varchar2에서 char로 
    변경하시오
    
    alter table employees modify(emp_name char(80)); 
     
    사원명 출력
    select rtrim(emp_name) from employees;
    
    update employees
       set emp_name=rtrim(emp_name);
    
    alter table employees modify(emp_name varchar2(80));
       
    commit;
    
사용예) 상품테이블에서 상품명 중 '여성'이라는 문자열을 왼쪽에서 찾아 삭제하시오

      select prod_id as 상품코드,
             prod_name as 상품명1,
             ltrim(prod_name,'여성 ') as 상품명2,
             rtrim(prod_name,'자켓 1') as 상품명3
        from prod;

   
   
















