2021-02-22-02)숫자형 함수
  1. 수학적 함수(abs,sign,power,sqrt...등)
    . abs(n) : n의 절댓값
    . sign(n) : n의 부호(음수 : -1, 양수 : 1, 0 : 0)
    . power(n,e) : n의 e승 값 반환
    . sqrt(n) : n의 평방근(root 값)
    
사용예)
select abs(-100),
       abs(0.000001),
       sign(10000000),
       sign(-10000000),
       sign(0.0000001),
       sign(-0.0000001),
       sign(0),
       power(2,10),
       sqrt(1024)
  from dual
       
  2. greatest, least
    . 주어진 자료 중 최댓값과 최솟값을 구함
    (사용형식)
    greatest(n1,n2,....) : n1,n2,.... 중 최댓값 반환
    least(n1,n2,....) : n1,n2,.... 중 최솟값 반환
    
예)
select greatest(20,40,5,70), least(20,40,5,70) from dual;

예) 회원테이블에서 회원들이 보유한 마일리지를 조회하여
    1000미만인 회원들의 마일리지를 1000으로 만드시오.
    alias는 회원번호, 회원명, 보유 마일리지, 수정 마일리지
    
    select mem_id as 회원번호,
           mem_name as 회원명,
           mem_mileage as "보유 마일리지",
           greatest(mem_mileage,1000) as "수정 마일리지"
      from member
     order by 4 desc;

**회원테이블에서 최대 마일리지를 구하시오
select b.mem_name as 회원명,
       a.mile_max as 마일리지
  from (select max(mem_mileage) as mile_max
          from member) a, member b
 where a.mile_max = b.mem_mileage

  3. round, trunc
    . 주어진 숫자자료를 반올림(round) 또는 자리버림(trunc) 연산후
      결괏값 반환
      (사용형식)
      round(n,i) : - i가 양수이면 주어진 자료 n에서 소숫점 이하 i+1번째
                     자리에서 반올림하여 i번째 수까지 반환
                   - i가 음수이면 주어진 자료 n에서 정수부의 i번째
                     자리에서 반올림하여 결과 반환
                   - i를 생략하면 0으로 간주
                    round(202732.2,-3)
                        -6-5-4-3-2-1.1
                   
      trunc(n,i) : - i가 양수이면 주어진 자료 n에서 소숫점 이하 i+1번째
                     자리에서 자리버림하여 i번째 수까지 반환
                   - i가 음수이면 주어진 자료 n에서 정수부의 i번째
                     자리내림하여 결과 반환
                   - i를 생략하면 0으로 간주
                   
예) 사원테이블의 자료를 이용하여 이번달 급여를 조회하시오
   . 이번달에 보너스르 지급함 : 보너스 = 급여의 13%
   . 지급액=본봉+보너스
   alias는 사원번호, 사원명, 본봉, 보너스, 지급액
   단 보너스, 지금액은 소수 첫 자리까지 나타내시오
   
   select employee_id as 사원번호,
          emp_name as 사원명,
          salary as 본봉,
          salary * 0.13 as 보너스1,
          round(salary * 0.13,1) as 보너스2,
          round(salary * 1.13,1) as 지급액
          --round(salary + round(salary * 0.13,1),1) as 지급액
     from employees
    order by 5 desc;
    
update employees
   set salary = salary * 1.17;
   
 예) 사원테이블의 자료를 이용하여 이번달 급여를 조회하시오
   . 이번달에 보너스르 지급함 : 보너스 = 급여의 13%
   . 지급액=본봉+보너스
   alias는 사원번호, 사원명, 본봉, 보너스, 지급액
   단 보너스, 지금액은 일의 자리에서 반올림하시오  
   
  select employee_id as 사원번호,
          emp_name as 사원명,
          salary as 본봉,
          salary * 0.13 as 보너스1,
          round(salary * 0.13,-1) as 보너스2,
          round(salary * 1.13,-1) as 지급액
          --round(salary +(salary * 0.13),-1) as 지급액
     from employees
    order by 5 desc;
    
     예) 사원테이블의 자료를 이용하여 이번달 급여를 조회하시오
   . 이번달에 보너스르 지급함 : 보너스 = 급여의 13%
   . 지급액=본봉+보너스
   alias는 사원번호, 사원명, 본봉, 보너스, 지급액
   단 보너스, 지금액은 일의 자리에서 반올림하시오  
   
  select employee_id as 사원번호,
          emp_name as 사원명,
          salary as 본봉,
          salary * 0.13 as 보너스1,
          trunc(salary * 0.13,-1) as 보너스2,
          trunc(salary * 1.13,-1) as 지급액
          --round(salary +(salary * 0.13),-1) as 지급액
     from employees
    order by 5 desc;
    
    
                  
