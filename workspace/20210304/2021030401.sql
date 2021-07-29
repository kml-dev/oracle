2021-03-04-01)
3. SELF JOIN
  - 하나의 테이블에 2개 이상의 테이블 별칭을 부여하여 서로 다른
    테이블로 간주하여 조인연산 수행

사용예) 회원테이블에서 직업이 '주부'인 회원들의 평균 마일리지보다
       많은 마일리지를 보유한 회원을 조회하시오
       ALIAS는 회원번호, 회원명, 직업, 마일리지
       
       SELECT A.MEM_ID AS 회원번호,
              A.MEM_NAME AS 회원명,
              A.MEM_JOB AS 직업,
              B.AMILE AS 평균마일리지,
              A.MEM_MILEAGE AS 마일리지
         FROM MEMBER A, (SELECT ROUND(AVG(MEM_MILEAGE),2) AS AMILE
                           FROM MEMBER
                          WHERE MEM_JOB = '주부') B
        WHERE A.MEM_MILEAGE >= B.AMILE;
          
사용예) 사원테이블에서 직책이 영업관리자(SA_MAN)DLS 145번 사원보다
       급여를 많이 받는 사원을 조회하시오
       ALIAS는 사원번호, 사원명, 입사일, 직책코드, 급여
       
       SELECT A.EMPLOYEE_ID AS 사원번호,
              A.EMP_NAME AS 사원명,
              A.HIRE_DATE AS 입사일,
              A.JOB_ID AS 직책코드,
              A.SALARY AS 급여
         FROM EMPLOYEES A, EMPLOYEES B
        WHERE B.EMPLOYEE_ID = 145
          AND A.SALARY >= B.SALARY
       
          