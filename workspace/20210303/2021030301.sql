2021-03-03-01)
**null처리함수
1) IS[NOT]NULL
  - 특정 컬럼의 값이 NULL인지 판단
  - NULL은 '='기호로 판단할 수 없음
  (사용형식)
  컬럼명 IS [NOT] NULL
  
사용예) 사원테이블에서 영업실적코드(COMMISSION_PCT)가 NULL이 아닌
       사원정보를 조회하시오
       
       SELECT A.EMPLOYEE_ID AS 사원번호,
              A.EMP_NAME AS 사원명,
              B.DEPARTMENT_NAME AS 부서명,
              A.COMMISSION_PCT AS 영업실적,
              A.SALARY AS 급여
         FROM EMPLOYEES A, DEPARTMENTS B
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
          AND A.COMMISSION_PCT IS NOT NULL;

2) NVL(c, val)
 - NULL처리 함수 중 가장 널리 사용
 - c컬럼에 값이 NULL이면 val값을 반환하고, NULL이 아니면 자신의 값을 반환
 - 주로 연산식에 사용됨
 - c와 val의 데이터 타입이 같아야 함
   
사용예) 사원테이블에서 영업실적에 따른 보너스를 계산하고 이번달 지급액을 
       조회하시오
       보너스 = 급여 * 영업실적
       지급액 = 급여 + 보너스
       ALIAS는 사원번호, 이름, 부서명, 본봉, 영업실적, 보너스, 지급액이다.
       
       SELECT A.EMPLOYEE_ID AS 사원번호,
              A.EMP_NAME AS 이름,
              B.DEPARTMENT_NAME AS 부서명,
              A.SALARY AS 본봉,
              NVL(TO_CHAR(A.COMMISSION_PCT,'0.00'),'없음') AS 영업실적,
              A.SALARY * NVL(A.COMMISSION_PCT,0) AS 보너스,
              A.SALARY + (A.SALARY * NVL(A.COMMISSION_PCT,0))지급액
         FROM EMPLOYEES A, DEPARTMENTS B
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        ORDER BY 1
        
3) NVL2(c, val1, val2)
  - c의 값이 NULL이 아니면 VAL1을 NULL이면 VAL2를 각각 반환
  - val1과 val2는 같은 데이터 타입이어야 함

UPDATE MEMBER
   SET MEM_HP = NULL
 WHERE MEM_ID IN ('d001','f001','r001','p001','s001');

COMMIT;
  
사용예) 회원테이블에서 회원들의 핸드폰번호를 조회하시오.
       핸드폰 번호가 없으면 '연락처 없음'을 출력하시오(NVL2사용)
       ALIAS는 회원번호, 회원명, 연락처이다
       
       SELECT MEM_ID AS 회원번호,
              MEM_NAME AS 회원명,
              NVL2(MEM_HP,MEM_HP,'연락처 없음') AS 연락처
         FROM MEMBER;
         
**
UPDATE MEMBER
   SET MEM_MILEAGE = NULL
 WHERE MEM_ID IN ('d001','f001','r001','p001','s001');
 
사용예) 회원테이블에서 회원의 마일리지를 검사하여 null이 아니면
       '정상회원' null이면 '비활동 회원'을 비고란에 출력하시오
    
      SELECT MEM_ID AS 회원번호,
             MEM_NAME AS 회원명,
             NVL(MEM_MILEAGE,0) AS 마일리지,
             NVL2(TO_CHAR(MEM_MILEAGE),'정상회원','비활동 회원') AS 비고
        FROM MEMBER;

**집계함수
1. ROLLUP
  - GROUP BY절과 같이 사용되어 레벨별 합계와 전체합계 반환
  (사용형식)
  GROUP BY ROLLUP(컬럼명1, 컬러명2,..)
  . 집계의 종류는 사용된 컬럼명의 수 + 1가지임
  . 컬럼명이 기술된 순서 오른쪽에서 왼쪽 순의 레벨별로 집계

사용예) 대출잔액테이블(KOR_LOAN_STATUS)에서 2011~2013년 까지
       년도별, 지역별 대출잔액을 구하시오
       ALIAS는 년도, 지역, 대출잔액합계
       
       (ROLLUP 미사용)
       SELECT SUBSTR(PERIOD,1,4) AS 년도,
              REGION AS 지역,
              SUM(LOAN_JAN_AMT) AS 대출잔액합계
         FROM KOR_LOAN_STATUS
        WHERE SUBSTR(PERIOD,1,4) BETWEEN '2011' AND '2013'
        GROUP BY SUBSTR(PERIOD,1,4),REGION
        ORDER BY 1;
        
        (ROLLUP 사용)
       SELECT SUBSTR(PERIOD,1,4) AS 년도,
              REGION AS 지역,
              SUM(LOAN_JAN_AMT) AS 대출잔액합계
         FROM KOR_LOAN_STATUS
        WHERE SUBSTR(PERIOD,1,4) BETWEEN '2011' AND '2013'
        GROUP BY ROLLUP(SUBSTR(PERIOD,1,4),REGION)
        ORDER BY 1;
        
사용예) 대출잔액테이블(KOR_LOAN_STATUS)에서 2013년도
       지역별, 구분별, 월별 대출잔액을 구하시오
       ALIAS는 지역, 대출구분, 월, 대출잔액합계
       
       (ROLLUP 미적용)
       SELECT REGION AS 지역,
              GUBUN AS 대출구분,
              SUBSTR(PERIOD,5) AS 월,
              SUM(LOAN_JAN_AMT) AS 대출잔액합계
         FROM KOR_LOAN_STATUS
        WHERE SUBSTR(PERIOD,1,4) = '2013'
        GROUP BY REGION, GUBUN,SUBSTR(PERIOD,5)
        ORDER BY 1;
        
       (ROLLUP 적용)
       SELECT REGION AS 지역,
              GUBUN AS 대출구분,
              SUBSTR(PERIOD,5) AS 월,
              SUM(LOAN_JAN_AMT) AS 대출잔액합계
         FROM KOR_LOAN_STATUS
        WHERE SUBSTR(PERIOD,1,4) = '2013'
        GROUP BY ROLLUP(REGION, GUBUN,SUBSTR(PERIOD,5))
        ORDER BY 1;

부분 ROLLUP
 - GROUP BY 절에서 컬럼명이 ROLLUP밖에서 기술된 경우
        
       (부분 ROLLUP 적용)
       SELECT REGION AS 지역,
              GUBUN AS 대출구분,
              SUBSTR(PERIOD,5) AS 월,
              SUM(LOAN_JAN_AMT) AS 대출잔액합계
         FROM KOR_LOAN_STATUS
        WHERE SUBSTR(PERIOD,1,4) = '2013'
        GROUP BY ROLLUP(REGION, GUBUN),SUBSTR(PERIOD,5)
        ORDER BY 1; 
 
 2. CUBE
   - ROLLUP과 사용형식은 동일
   - CUBE 다음 '()'안에 기술된 컬럼을 조합한 모든 경우의 수만큼의 
     종류의 합계를 반환, N개의 컬럼이 사용된 경우 2의 N승 가지의
     합계 반환
     
     
 



