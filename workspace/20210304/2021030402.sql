2021-03-04-02)외부조인
  - 내부조인에서는 조인조건을 만족하지 않은 자료(행)을 무시
  - 외부조인에서는 조인조건을 만족하지 않은 테이블에 부족한 행만큼
    NULL 값을 갖는 행을 추가 삽입한 후 조인 수행
  - 조인조건 기술에서 부족한 자료를 갖고 있는 테이블에 속한 컬럼명
    외부조인 연산자('(+)')를 기술
  - 두개 이상의 외부조인이 동시에 수행돼야 할 경우 해당되는 조인
    조건 모두 외부조인 연산자('(+)')를 기술 해야함
  - 한번에 한 테이블에 대해서만 외부조인을 수행 할 수 있다.
    즉 A,B,C테이블이 조인에 참여하고 A를 기준으로 B를 외부조인하고(A=B(+)),
    동시에 C를 기준으로 B를 외부조인(C=B(+))할 수 없다
  - (+)연산자가 붙은 조건에는 OR 연산자 사용금지
  - (+)연산자가 붙은 조건에 IN 연산자 사용금지
  
(사용형식)
일반 OUTER JOIN
SELECT 컬럼LIST
  FROM 테이블LIST
 WHERE 컬럼명1 = 컬럼명2(+)
  [AND 일반조건]

ANSI OUTER JOIN
SELECT 컬럼LIST
  FROM 테이블1
FULL|LEFT|RIGHT OUTER JOIN 테이블명2 ON(조인조건1
  [AND 일반조건])
[WHERE 일반조건];
. LEFT : 테이블명1이 테이블명2 보다 더 많은 자료를 가지고 있는 경우 사용
. RIGHT : 테이블명2가 테이블명1 보다 더 많은 자료를 가지고 있는 경우 사용
. FULL : 테이블명1, 테이블명2 모두 부족한 경우

예) 상품테이블에서 모든 분류별 상품의 수를 조회하시오
    ALIAS는 분류코드, 분류명, 상품의 수
    
SELECT B.LPROD_GU AS 분류코드,
       B.LPROD_NM AS 분류명,
       COUNT(PROD_ID) AS "상품의 수"
  FROM PROD A, LPROD B
 WHERE A.PROD_LGU(+) = LPROD_GU
 GROUP BY B.LPROD_GU,B.LPROD_NM
 ORDER BY 1;
 
 (ANSI)
SELECT B.LPROD_GU AS 분류코드,
       B.LPROD_NM AS 분류명,
       COUNT(PROD_ID) AS "상품의 수"
  FROM PROD A
 RIGHT OUTER JOIN LPROD B ON(A.PROD_LGU = LPROD_GU)
 GROUP BY B.LPROD_GU,B.LPROD_NM
 ORDER BY 1;
 
예) 2005년 2월 모든 상품별 매입현황을 조회하시오.
    ALIAS는 상품코드, 상품명, 매입수량, 매입금액
    
    (일반 OUTER JOIN)
    SELECT B.PROD_ID AS 상품코드,
           B.PROD_NAME AS 상품명,
           SUM(A.BUY_QTY) AS 매입수량,
           SUM(A.BUY_QTY * B.PROD_COST)매입금액
      FROM BUYPROD A, PROD B
     WHERE A.BUY_PROD(+) = B.PROD_ID
       AND A.BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201')
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;

     (ANSI OUTER JOIN)
     SELECT B.PROD_ID AS 상품코드,
           B.PROD_NAME AS 상품명,
           NVL(SUM(A.BUY_QTY),0) AS 매입수량,
           NVL(SUM(A.BUY_QTY * B.PROD_COST),0)매입금액
      FROM BUYPROD A
     RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID
       AND A.BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201'))
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;
     
     (서브쿼리 이용)
     SELECT B.PROD_ID AS 상품코드,
            B.PROD_NAME AS 상품명,
            NVL(A.SQTY,0) AS 매입수량,
            NVL(A.SAMT,0) AS 매입금액
       FROM PROD B, (SELECT BUY_PROD,
                            SUM(BUY_QTY) AS SQTY,
                            SUM(BUY_QTY * BUY_COST) AS SAMT
                       FROM BUYPROD
                      WHERE BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201')
                      GROUP BY BUY_PROD) A
      WHERE B.PROD_ID = A.BUY_PROD(+)
      ORDER BY 1;
      
예) 사원테이블에서 모든 부서별 사원수를 조회하시오.
    부서코드, 부서명, 사원수
    
    SELECT B.DEPARTMENT_ID AS 부서코드,
           B.DEPARTMENT_NAME AS 부서명,
           COUNT(A.EMPLOYEE_ID)사원수
      FROM EMPLOYEES A, DEPARTMENTS B
     WHERE A.DEPARTMENT_ID(+) = B.DEPARTMENT_ID(+)
     GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
     ORDER BY 1;
     
     (ANSI JOIN)
     SELECT B.DEPARTMENT_ID AS 부서코드,
           B.DEPARTMENT_NAME AS 부서명,
           COUNT(A.EMPLOYEE_ID)사원수
      FROM EMPLOYEES A
      FULL OUTER JOIN DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
     GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
     ORDER BY 1;
     
예) 2005년 7월 모든 회원별 판매현황을 조회하시오
    ALIAS는 회원번호, 회원명, 구매수량합계, 구매금액합계
    
    (ANSI JOIN)
    SELECT A.MEM_ID AS 회원번호,
           A.MEM_NAME AS 회원명,
           NVL(SUM(B.CART_QTY),0)구매수량합계,
           NVL(SUM(B.CART_QTY * C.PROD_PRICE),0)구매금액합계
      FROM MEMBER A
      LEFT OUTER JOIN CART B ON(A.MEM_ID = B.CART_MEMBER AND B.CART_NO LIKE '200507%')
      LEFT OUTER JOIN PROD C ON(B.CART_PROD = C.PROD_ID)
     GROUP BY A.MEM_ID, A.MEM_NAME
     ORDER BY 1;
     
     SELECT A.MEM_ID,
            A.MEM_NAME,
            NVL(SUM(B.CART_QTY),0) AS 구매수량합계,
            NVL(SUM(B.CART_QTY * C.PROD_PRICE),0) AS 구매급액합계
       FROM CART B
      INNER JOIN PROD C ON(B.CART_PROD = C.PROD_ID AND B.CART_NO LIKE '200507%')
      RIGHT OUTER JOIN MEMBER A ON(A.MEM_ID = B.CART_MEMBER)
      GROUP BY A.MEM_ID,A.MEM_NAME
      ORDER BY 1;
      
      SELECT A.MEM_ID AS 회원번호,
             A.MEM_NAME AS 회원명,
             NVL(D.SQTY,0) AS 구매수량합계,
             NVL(D.SAMT,0) AS 구매금액합계
        FROM MEMBER A,
             (SELECT B.CART_MEMBER AS BID,
                     SUM(B.CART_QTY) AS SQTY,
                     SUM(B.CART_QTY * C.PROD_PRICE) AS SAMT
                FROM CART B, PROD C
               WHERE B.CART_PROD = C.PROD_ID
                 AND B.CART_NO LIKE '200507%'
               GROUP BY B.CART_MEMBER) D
        WHERE A.MEM_ID = D.BID(+)
        ORDER BY 1;
           





