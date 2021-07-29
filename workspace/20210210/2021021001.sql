2021-02-10-01)
2.update문
  - 해당 자료가 테이블에 존재
  - 필요한 컬럼의 값을 변경
  (사용형식)
  update 테이블명
     set 컬럼명1=값1[,]
        [컬럼명2=값2,]
              :
        [컬럼명n=값n]
  [where 조건];
  .'where 조건'절이 생략되면 모든 행의 값을 변경함  

예) 사원테이블(EMPLOYEES)에서 부서번호가 50번 부서에 속한 사원의 급여를
    20% 추가하여 저장하시오
  select emp_name as 사원명,
         department_id as 부서번호,
         salary+(salary*0.2) as 급여
    from employees
   where department_id=50;
   
(데이터 변경)
update employees
   set salary=salary+(salary*0.2)
 where department_id=50;
 
select emp_name,salary from employees where department_id=50;
rollback;   

사용 예) 회원테이블(member)에서 회원번호'f001'회원의 주민등록번호
        (mem_regno1,mem_regno2)와 생년월일(mem_bir)을 다음 자료로
        변경하시오
        1) 주민번호1 : 751228 => 021228
           주민번호2 : 1459919 => 3459919
        2)  생년월일 : 1972/11/04 => 2002/12/28
update member
   set mem_regno1='021228',
       mem_regno2='3459919',
       mem_bir= to_date('20021228')
 where mem_id='f001';
 
select mem_id,mem_regno1,mem_regno2,mem_bir from member where mem_id='f001'

3.delete문
  - 테이블에 저장된 자료를  삭제
  - where 절이 생략되면 해당테이블의 모든 행을 삭제->빈 테이블을 만듦
  (사용형식)
  delete 테이블명
  [where 조건];
  .delete문은 rollback의 대상임

rollback;
사용 예)장바구니테이블(cart) 'k001' 회원자료를 삭제하시오.
delete cart
 where cart_member='k001';
rollback;
select * from cart where cart_member='k001';
commit;

   