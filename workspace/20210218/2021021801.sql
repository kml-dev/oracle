2021-02-18-01)select 문
 - 자료 검색 명령
 - SQL에서에서 가장 많이 사용되는 명령어
 (사용형식)
 select [distinct] *|[컬럼명1[AS]["]컬럼별칭["],]
        [컬럼명2[AS]["]컬럼별칭["],]
                   :
        [컬럼명n[AS]["]컬럼별칭["],]
   from 테이블명
 [where 조건1
   [and 조건2...]]
[group by 컬럼명1[,컬럼명2,...]]
 having 조건1[,조건2,...]]
[order by 컬럼인덱스 | 컬럼명1[asc|desc][,
          컬럼인데스 | 컬럼명2,...];]
          
          
1. select 절
  - 검색할 컬럼에 관련된 절
  - 실행되는 순서는 가장 늦게 실행(from -> where -> select)
  (사용형식)
  select [distinct] *|[컬럼명1[AS]["]컬럼별칭["],]
        [컬럼명2[AS]["]컬럼별칭["],]
                   :
        [컬럼명n[AS]["]컬럼별칭["],]
    . [distinct] : 중복된 자료를 배제하여 결과를 출력함
    
사용예) 회원테이블에서 회원들 주소지의 종류를 모두 조회하시오.
       Alias는 거주지(광역시 또는 도)
       
       (distinct 미사용)
       select substr(mem_add1, 1, 2)
         from member;
         
      (distinct 사용)
       select substr(mem_add1, 1, 2)
         from member;
         
사용예) 회원테이블에서 회원들이 가지고 있는 취미들을 조회하시오

select distinct mem_like as 취미
  from member;
         
   .'컬럼별칭' : 컬럼에 부여하는 별도의 이름
               해당 컬럼의 제목이나 subquery 사용시 컬럼의 값을 
               참조하기 위하여 사용됨
   . 컬럼별칭에 특수문자(공백이나 기호, 예약어)가 사용될 때에는 ""로
     묶어 사용해야함
   . 'as'는 생략 가능(기술하는 것이 가독성을 위하여 권장됨)
   . 컬럼별칭은 해당 select 문의 where절 등에 사용할 수 없음

사용예)제목줄로 사용
      사원테이블(employees)에서 영업실적(commission_pct)가 null이 아닌
      사원들의 영업실적에 따른 보너스를 조회하시오.
      보너스=급여*영업실적코드
      alias는 사원번호, 사원명, 영업실적코드, 본봉, 보너스이다.
      
select employee_id as 사원번호,
       emp_name as 사원명,
       commission_pct as 영업실적코드,
       salary as 본봉,
       salary * commission_pct as 보너스
  from employees
 where commission_pct is not null;
 
 사용예)제목줄로 사용
      사원테이블(employees)에서 영업실적(commission_pct)가 null이 아닌
      사원들의 영업실적에 따른 보너스를 조회하되 보너스가 3000 이상인 
      사원만 조회하시오.
      보너스=급여*영업실적코드
      alias는 사원번호, 사원명, 영업실적코드, 본봉, 보너스이다.
      
    select employee_id as 사원번호,
           emp_name as 사원명,
           commission_pct as 영업실적코드,
           salary as 본봉,
           salary * commission_pct as 보너스
      from employees
     where commission_pct is not null
       and salary * commission_pct >= 3000
     order by 5 desc;
     
     **group 함수 사용
     사용예) 회원테이블(member)에서 성별 마일리지 합계를 조회하시오 
     
     select case when substr(mem_regno2,1,1)='1' or
                      substr(mem_regno2,1,1)='3' then '남성회원'
                 else '여성회원' end as "구분",
            sum(mem_mileage) as "마일리지 합계"
       from member
   group by case when substr(mem_regno2,1,1)='1' or
                      substr(mem_regno2,1,1)='3' then '남성회원'
                 else '여성회원' end;
                 
사용예) 장바구니테이블(cart)에서 2005년 6월 회원별 구매액을 조회하되
       구매금액이 50만원 이상인 회원정보를 조회하시오
       alias는 회원번호, 회원명, 구매액
       
       select A.cart_member as 회원번호,
              B.mem_name as 회원명,
              sum(A.cart_qty * C.prod_price) as 구매액
              (select)
         from cart A, member B, prod C
        where A.cart_member=B.mem_id --조인 조건
          and A.cart_prod=C.prod_id  --조인 조건
          and substr(A.cart_no,1,6)= '200506'
          --and substr(A.cart_no,1,8) >= '20050601' and substr(A.cart_no,1,8) <= '20050630'
          and A.cart_qty>=(select)
     group by A.cart_member,B.mem_name
   having sum(A.cart_qty*C.prod_price)>=500000
     order by 3 desc;
 
 
