2021-02-23) 숫자형 함수
  4. mod, remainder
    - 나머지 값을 반환
    1)mod(c,n)
      . 주어진 수 c를 n으로 나눈 나머지 반환
      . java언어의 %연산자와 같은 기능
      
사용예) 2000년 2월 23일이 무슨 요일인지 구하시오.
    select case mod((trunc(sysdate)-to_date('00010101')-1),7)
                when 1 then '월요일'
                when 2 then '화요일'
                when 3 then '수요일'
                when 4 then '목요일'
                when 5 then '금요일'
                when 6 then '토요일'
                else '일요일' end as 요일,
           trunc(sysdate)-to_date('00010101')-1 as 일수
      from dual;
    2) remainder(c,n)
      . c를 n으로 나눈 나머지 반환
      . 내부적으로 mod와 다른 방법으로 처리하여 다른 결과 반환
      . mod : 나머지 = c - floor(c/n)
        remainder : 나머지 = c - n * round(c/n)
        
      예) 13/5의 나머지
        i) mod : 13 - 5 * floor(13/5)
                 13 - 5 * floor(2.6)
                 13 - 5 * 2 => 3
        ii) remainder
                 13 - 5 * round(13/5)
                 13 - 5 * round(2.6)
                 13 - 15 => -2
                 
select mod(13,5), remainder(13,5) from dual;    
    
    
  5. ceil(n), floor(n)
    - 주어진 수 n에 가장 근접한 정수를 반환
    - ceil은 n과 같거나 큰 수 중 가장 작은 정수(올림)
    - floor는 n과 같거나 작은 수 중 가장 큰 정수(버림)
    ex)ceil(23.56) -> 24, ceil(-23.56) -> -23
       floor(23.56) -> 23, floor(-23.56) -> -24

  6. width_bucket
    - 주어진 최솟값과 최댓값을 몇개의 그룹으로 나누고 제시된 값이 어느 그룹에 속하는지를 반환
    (사용형식)
    width_bucket(c,min,max,b)
      . c : 주어진 수
      . min : 구간의 하한 값
      . max : 구간의 상한 값
      . b : 구간의 수
      
      
사용예) 사원테이블에서 사원의 급여에 따른 등급을 구하여 출력하시오
       급여를 2000부터 20000까지 7개 등급으로 나누고 급여가
       많은 사원이 작은 등급을 부여받도록 하시오
       alias는 사원번호, 사원명, 급여, 등급
       
       select employee_id as 사원번호,
              emp_name as 사원명,
              salary as 급여,
              -- 11 - width_bucket(salary,2000,22000,10)등급
              width_bucket(salary,20000,2000,9)등급
         from employees
        order by 3 desc;
        
예) 회원테이블에서 회원들의 마일리지를 기준으로 등급을 구하고 등급이 1~2등급
    회원은 'vip회원', 3~5등급 회원은 '일반회원',그 이하 회원은 '준회원'
    이라는 문자열을 비고난에 출력하시오. 단, 구간은 마일리지 값을 500에서 
    8000까지 8개 구간으로 나누고 마일리지가 많은 회원의 등급이 작은 값을
    나타내도록 한다.
    
    select mem_id as 회원번호,
           mem_name as 회원명,
           mem_mileage as 마일리지,
           width_bucket(mem_mileage,8000,500,8) as 등급,
           case when width_bucket(mem_mileage,8000,500,8) <= 2 then 'vip회원'
                when width_bucket(mem_mileage,8000,500,8) between 3 and 5 then '일반회원'
                else '준회원' end as 비고
      from member
     order by 3 desc;
    
    
    
    

      
    