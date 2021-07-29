2021-03-03-02)
사용예) 거래처테이블(BUYER)을 이용하여 2005년 7월 거래처별
       매출현황을 조회하시오.
       ALIAS는 거래처코드, 거래처명, 판매금액합계이다
       
       SELECT A.BUYER_ID AS 거래처코드,
              A.BUYER_NAME AS 거래처명,
              SUM(B.CART_QTY * C.PROD_PRICE) AS 판매금액합계
         FROM BUYER A, CART B, PROD C     
        WHERE B.CART_NO LIKE '200507%'  
          AND A.BUYER_ID = C.PROD_BUYER
          AND C.PROD_ID = B.CART_PROD
        GROUP BY A.BUYER_ID, A.BUYER_NAME
        ORDER BY 1;
        
**다음 자료를 저장하는 급여등급테이블을 생성하시오
  1)테이블 명 : SAL_GRADE
  2)컬럼명
    GRADE    CHAR(2)    PK
    LSAL     NUMBER(8,2)
    HSAL     NUMBER(8,2)
  3)데이터
  -----------------------------------------------
    GRADE        LSAL         HSAL
  -----------------------------------------------
      01         2000         2999
      02         3000         3999
      03         4000         5999
      04         6000         8999
      05         9000        11999
      06         12000       14999
      07         15000       18999
      08         19000       23999
      09         24000       29999
      10         30000      100000  
   -----------------------------------------------
   
   CREATE TABLE SAL_GRADE(
        GRADE  CHAR(2),
        LSAL   NUMBER(8,2),
        HSAL   NUMBER(8,2),
      CONSTRAINT PK_SAL_GRADE PRIMARY KEY(GRADE)  
   );
   
   INSERT INTO SAL_GRADE VALUES('01',2000,2999);
   INSERT INTO SAL_GRADE VALUES('02',3000,3999);
   INSERT INTO SAL_GRADE VALUES('03',4000,5999);
   INSERT INTO SAL_GRADE VALUES('04',6000,8999);
   INSERT INTO SAL_GRADE VALUES('05',9000,11999);
   INSERT INTO SAL_GRADE VALUES('06',12000,14999);
   INSERT INTO SAL_GRADE VALUES('07',15000,18999);
   INSERT INTO SAL_GRADE VALUES('08',19000,23999);
   INSERT INTO SAL_GRADE VALUES('09',24000,29999);
   INSERT INTO SAL_GRADE VALUES('10',30000,100000);
   
COMMIT;   

SELECT * FROM SAL_GRADE

2. NON-EQUI JOIN
  - 조인조건에 사용된 연산자가 '='이 아닌 조인연산
  - IN, ANY, SOME등이 주로 사용
  
사용예) 사원테이블(EMPLOYEES)과 급여등급테이블(SAL_GRADE)
       을 사용하여 60번 부서에 속한 사원들의 급여와 등급을
       조회하시오
       ALIAS는 사원번호, 사원명, 급여, 등급이다.
       
       SELECT A.EMPLOYEE_ID AS 사원번호,
              A.EMP_NAME AS 사원명,
              A.SALARY AS 급여,
              TO_NUMBER(B.GRADE) AS 등급
         FROM EMPLOYEES A, SAL_GRADE B
        WHERE A.SALARY BETWEEN B.LSAL AND B.HSAL
          AND A.DEPARTMENT_ID = 60
        ORDER BY 3 DESC;
        
사용예) 사원테이블에서 평균급여보다 많은 급여를 지급받는 사원정보를 
       조회하시오
       ALIAS는 사원번호, 사원명, 급여, 부서명, 직책이다
       
       SELECT A.EMPLOYEE_ID AS 사원번호,
              A.EMP_NAME AS 사원명,
              A.SALARY AS 급여,
              D.SAL AS 평균급여,
              B.DEPARTMENT_NAME AS 부서명,
              C.JOB_TITLE AS 직책명
         FROM EMPLOYEES A, DEPARTMENTS B, JOBS C,
              (SELECT ROUND(AVG(SALARY)) AS SAL 
                 FROM EMPLOYEES) D
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
          AND A.JOB_ID = C.JOB_ID
          AND A.SALARY >= D.SAL
        ORDER BY 3 DESC;  
         
        SELECT A.EMPLOYEE_ID AS 사원번호,
              A.EMP_NAME AS 사원명,
              A.SALARY AS 급여,
              (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEES) AS 평균급여,
              B.DEPARTMENT_NAME AS 부서명,
              C.JOB_TITLE AS 직책명
         FROM EMPLOYEES A, DEPARTMENTS B, JOBS C
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
          AND A.JOB_ID = C.JOB_ID
          AND A.SALARY >= (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEES)
        ORDER BY 3 DESC;   
              
   
    
