2021-02-25-01)
  사용예) 사원테이블에서 각 부서별 급여합계를 구하시오.
         alias는 부서번호, 급여합계
         
         select employee_id as 부서번호,
                sum(salary) as 급여합계
           from employees
          group by employee_id
         
  사용예) 2005년 1~6월까지 월별, 거래처별 매입정보를 조회하시오
         alias는 월, 거래처코드, 매입수량합, 매입금액합계
         
         SELECT EXTRACT(MONTH FROM BUY_DATE)AS 월,
                C.BUYER_ID AS 거래처코드,
                SUM(BUY_QTY) AS 매입수량합,
                SUM(BUY_COST * BUY_QTY) AS 매입금액합계
           FROM BUYPROD A, PROD B, BUYER C
          WHERE A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630')
            AND A.BUY_PROD = B.PROD_ID -- 조인조건
            AND B.PROD_BUYER = C.BUYER_ID -- 조인조건
          GROUP BY EXTRACT(MONTH FROM A.BUY_DATE), C.BUYER_ID 
          ORDER BY 2;
         
  사용예) 2005년 5월 회원별 판매정보를 조회하시오
         alias는 회원명, 판매수량합계이며 판매수량이 20개 이상인 
         회원만 조회하시오
         
         SELECT B.MEM_NAME AS 회원명,
                SUM(A.CART_QTY) AS 판매수량합계
           FROM CART A, MEMBER B
          WHERE A.CART_MEMBER = B.MEM_ID --조인조건
            AND A.CART_NO LIKE '200505%' --일반조건
          GROUP BY B.MEM_NAME
         HAVING SUM(A.CART_QTY) >= 20
          ORDER BY 2 DESC;
                   
  사용예) 2005년 5월 일별, 제품별 판매정보를 조회하시오
         alias는 일자, 제품코드, 판매수량합계, 판매금액합계
         
         SELECT SUBSTR(B.CART_NO,7,2) AS 일자,
                B.CART_PROD AS 제품코드,
                SUM(CART_QTY) AS 판매수량합계,
                SUM(B.CART_QTY * A.PROD_PRICE)판매금액합계
           FROM PROD A, CART B
          WHERE B.CART_NO LIKE '200505%'
            AND A.PROD_ID = B.CART_PROD
          GROUP BY SUBSTR(B.CART_NO,7,2),B.CART_PROD
          ORDER BY 1 ASC;
          
           
2. AVG(col)
  - col에 저장된 데이터의 평균값을 구하여 반환
  
사용예) 회원테이블에서 회원의 성별 평균마일리지를 조회하시오
       
       SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1'
                     OR SUBSTR(MEM_REGNO2,1,1) = '3' THEN '남성회원'
                   ELSE '여성회원' END AS 성별,
              TRUNC(AVG(MEM_MILEAGE)) AS 평균마일리지
         FROM MEMBER
        GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1'
                        OR SUBSTR(MEM_REGNO2,1,1) = '3' THEN '남성회원'
                      ELSE '여성회원' END
                           
숙제) 회원테이블에서 회원의 연령대별 평균 마일리지를 구하시오
     alias는 구분, 평균마일리지이며 구분에는 '10대','20대'..
     등의 값을 출력한다
     
     
     SELECT TRUNC(EXTRACT(year from sysdate) - EXTRACT(year from mem_bir),-1)||'대' AS 구분,
            ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
       FROM MEMBER
      GROUP BY TRUNC(EXTRACT(year from sysdate) - EXTRACT(year from mem_bir),-1)||'대'
      ORDER BY 1 ASC;
          
사용예) 사원테이블에서 직무별 평균급여를 소숫점한자리까지 구하여 출력하시오
       alias는 직무명, 평균급여
       
       SELECT B.JOB_TITLE AS 직무명,
              ROUND(AVG(SALARY),1) AS 평균급여
         FROM EMPLOYEES A, JOBS B
        WHERE A.JOB_ID = B.JOB_ID
        GROUP BY B.JOB_TITLE
        ORDER BY 2 DESC;
       
사용예) 대출잔액테이블에서 2013년 지역별 평균대출잔액을 조회하되
       평균대출잔액이 많은 상위 3개 시도만 출력하시오.
       
       SELECT A.R1 AS 지역,
              A.lAVG AS 평균대출잔액
         FROM (SELECT REGION AS R1,
                      TO_CHAR(ROUND(AVG(LOAN_JAN_AMT),1),'999,999.9') AS LAVG
                 FROM KOR_LOAN_STATUS
                WHERE PERIOD LIKE '2013%'
                GROUP BY REGION
                ORDER BY 2 DESC) A
        WHERE ROWNUM <= 3;

3. COUNT(*|col)
  - 그룹내의 자료(행)의 수를 반환
  - '*'나 컬럼명을 기술해도 동일 결과 반환함
    단, 외부조인에 사용할 때 '*'를 사용해선 안됨. 주로 기본키 컬럼명을 사용
    
사용예) 사원테이블에서 부서별 사원 수를 조회하시오
SELECT DEPARTMENT_ID AS 부서코드,
       COUNT(*) AS 사원수,
       COUNT(EMP_NAME) AS 사원수
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY 1;
 
사용예) 장바구니테이블에서 회원별 구매횟수를 조회하되 구매횟수가 5이상인
       회원만 출력하시오
       
       SELECT A.AMEM AS 회원번호,
              COUNT(*) AS 구매횟수
         FROM (SELECT CART_MEMBER AS AMEM,
                      CART_NO AS ANO,
                      COUNT(*) AS CNT
                 FROM CART
                GROUP BY CART_MEMBER, CART_NO) A
        GROUP BY A.AMEM
       HAVING COUNT(*) >= 5
        ORDER BY 1;
        
사용예) 2005년 3월 모든 거래처별 제품매입건수를 조회하시오.
       alias는 거래처 코드, 거래처명, 매입건수
       
       SELECT B.BUYER_ID AS 거래처코드,
              B.BUYER_NAME AS 거래처명,
              COUNT(*) AS 매입건수
         FROM BUYPROD A, BUYER B, PROD C
        WHERE C.PROD_ID = A.BUY_PROD(+)
          AND B.BUYER_ID = C.PROD_BUYER(+)
          AND A.BUY_DATE BETWEEN '20050301' AND '20050331'
        GROUP BY B.BUYER_ID, B.BUYER_NAME
        ORDER BY 1;
        
(해결방법1 - 서브쿼리)
SELECT D.BUYER_ID AS 거래처코드,
       D.BUYER_NAME AS 거래처명,
       NVL(TBLA.CNT,0) AS 매입건수
  FROM (SELECT B.BUYER_ID AS BCODE,
               COUNT(A.BUY_PROD) AS CNT
          FROM BUYPROD A, BUYER B, PROD C
         WHERE C.PROD_ID = A.BUY_PROD(+)
           AND B.BUYER_ID = C.PROD_BUYER
           AND A.BUY_DATE BETWEEN '20050301' AND '20050331'
         GROUP BY B.BUYER_ID) TBLA, BUYER D
 WHERE D.BUYER_ID = TBLA.BCODE(+)
 ORDER BY 1;
 
 



        
        
        
      
       
         
         