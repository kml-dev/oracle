2021-02-18-02) 연산자
 - 4칙 연산자(+,-,*,/)
 - 나머지 값은 mod()와 remainder()함수로 제공
 - 관계연산자(>, >=, <, <=, =, !=(<>))
 - 논리연산자(and, or, not)
 1. 기타 연산자
  1) in 연산자
    - 주어진 값 중 어느 하나와 일치하면 전체가 참(true)가 되는 연산자
    - or연산자로 바꾸어 쓸 수 있다.
    (사용형식)
    컬럼명 in (값1,값2,...값n)
    . where 절의 조건 구성에 사용
    
사용예) 사원테이블에서 부서가 60, 40, 20번 부서에 속한 사원정보를 조회하시오
       alias는 사원번호, 사원명, 부서번호, 입사일이다
       
       select employee_id as 사원번호,
              emp_name as 사원명,
              department_id as 부서번호,
              hire_date as 입사일
         from employees
        where department_id in (60, 40, 20)
     order by 3;
     
     [or 연산자 사용]
     select employee_id as 사원번호,
              emp_name as 사원명,
              department_id as 부서번호,
              hire_date as 입사일
         from employees
        where department_id = 60
           or department_id = 40
           or department_id = 20
     order by 3;
     
   2) any(some) 연산자
     - 기능은 in 연산자와 동일함
     (사용형식)
     컬럼명 관계연산자 any|some (값1, 값2,...값n)
    
사용예) 
       select employee_id as 사원번호,
              emp_name as 사원명,
              department_id as 부서번호,
              hire_date as 입사일
         from employees
       -- where department_id = any(60,40,20)       
        where department_id = some(60,40,20)       
     order by 3;     
     
     3) between 연산자 
       - 범위를 지정하여 비교할 때 사용
       - and 연산자로 변환가능
     (사용형식)
     컬럼명 between a and b
     . 컬럼에 저장된 값의 범위가 a ~ b 사이 값이면 참(true) 반환
예) 매입테이블(buyprod)에서 2005년 2월 5일부터 16일 사이에 입고된 상품정보를 조회하시오
    alias는 날짜, 상품코드, 수량, 단가, 금액이다.
    
    select buy_date as 날짜,
           buy_prod as 상품코드,
           buy_qty as 수량,
           buy_cost as 단가,
           buy_qty*buy_cost as 금액
      from buyprod
     where buy_date between '20050205' and '20050216';
     
     
     
문제] 회원테이블에서 40대 여성 회원의 보유마일리지를 조회하시오
    
    select mem_id as 회원번호,
           mem_name as 회원명,
           2021 - (1900+to_number(substr(mem_regno1,1,2))) as 나이,
           mem_mileage as 마일리지
      from member
     where 2021 - (1900+to_number(substr(mem_regno1,1,2))) between 40 and 49
       and substr(mem_regno2,1,1) = '2';
