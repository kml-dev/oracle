2021-03-02)테이블 조인
  - 관계형데이터베이스의 핵심
  - 여러 테이블에 분산되어 저장된 자료들을 관계(relationship)를 
    이용하여 추출하는 연산
  - 종류
    1) 내부조인, 외부조인
    2) 일반조인, ANSI조인
    3) Cartesian Product, Equi Join, Non-Equi Join, Self Join, etc..
    
1. 내부조인(Inner Join)
  - 조인조건을 만족하는 데이터만 연산의 결과로 반환되고 
    조인조건에 맞지 않는 자료는 무시됨
    (사용형식)
    SELECT 컬럼list,...
      FROM 테이블명1 [테이블별칭1], 테이블명2 [테이블별칭2], 테이블명3 [테이블별칭3],..
     WHERE 조인조건
      [AND 조인조건,...]
      [AND 일반조건,...]
     . 사용되는 테이블의 갯수가 N개일 때 조인조건은 적어도 N-1개 이상이어야 함
     . 조인조건에 사용되는 컬럼은 두 테이블에 존재하는 같은 자료를 저장하고 있는컬럼
       (보통 외래키 관계 활용)
     . 조인조건과 일반조건의 기술 순서는 상관없음  
      
    (사용형식 - ANSI조인)
    SELECT 컬럼list,...
      FROM 테이블명1 [테이블별칭1]
     INNER JOIN 테이블명2 [별칭2] ON(조인조건)
      [AND 일반조건]
     INNER JOIN 테이블명3 [별칭3] ON(조인조건)
      [AND 일반조건]
     WHERE 조인조건

예) 장바구니테이블을 이용하여 2005년 6월 회원별 매출현황을 조회하시오
    ALIAS는 회원번호, 회원명, 구매수량합계이다
    
    SELECT A.CART_MEMBER AS 회원번호,
           B.MEM_NAME AS 회원명,
           SUM(A.CART_QTY) AS 구매수량합계
      FROM CART A, MEMBER B
     WHERE A.CART_MEMBER = B.MEM_ID
       AND CART_NO LIKE '200506%'
     GROUP BY A.CART_MEMBER,B.MEM_NAME
     
2. Cartesian Product
  - 모든 가능 행들의 조합
  - 조인에 참여한 테이블의 행의 곱과 열의 합한 결과 반환
  - 반드시 필요한 경우가 아니면 사용 자제
  - 조인조건을 생략하거나 잘못 적용한 경우 발생
  (사용예)
  SELECT COUNT(*) AS "행의 수"  -- 74*209
    FROM CART, PROD, ZIPTB;
    
3. Equi JOIN
  - 도응조인으로 조인조건에 '=' 연산자 사용되는 조인
  - ANSI에서는 INNER JOIN이라 함
  
사용예) 사원테이블에서 다음 형식을 적용하여 사원을 조회하시오
       ALIAS는 사원번호, 사원명, 부서코드, 부서명, 직책명, 급여
       
       SELECT A.EMPLOYEE_ID AS 사원번호,
              A.EMP_NAME AS 사원명,
              A.DEPARTMENT_ID AS 부서코드,
              B.DEPARTMENT_NAME AS 부서명,
              C.JOB_TITLE AS 직책명,
              A.SALARY AS 급여
         FROM EMPLOYEES A
        INNER JOIN DEPARTMENTS B ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
        INNER JOIN JOBS C ON A.JOB_ID = C.JOB_ID
        ORDER BY 1;
        
사용예) 상품테이블에서 각 분류에 속하는 상품의 수를 조회하시오.
       ALIAS는 분류코드, 분류명, 상품의 수
       
       SELECT A.PROD_LGU AS 분류코드,
              B.LPROD_NM AS 분류명,
              COUNT(*) AS "상품의 수"
         FROM PROD A
        INNER JOIN LPROD B ON(A.PROD_LGU = B.LPROD_GU) --조인 조건
        GROUP BY PROD_LGU,LPROD_NM
        ORDER BY 1;
 
문제1] 장바구니 테이블에서 2005년 7월 상품별 판매현황을 조회하시오
      ALIAS는 상품코드, 상품명, 판매수량, 판매금액
      일반조인형식과 안시조인형식 적용
      
      SELECT A.CART_PROD AS 상품코드,
             B.PROD_NAME AS 상품명,
             SUM(A.CART_QTY) AS 판매수량,
             SUM(A.CART_QTY * B.PROD_PRICE) AS 판매금액
        FROM CART A, PROD B
       WHERE A.CART_PROD = B.PROD_ID
         AND CART_NO LIKE '200507%'
       GROUP BY  A.CART_PROD,B.PROD_NAME 
       ORDER BY 1;
       
       SELECT A.CART_PROD AS 상품코드,
             B.PROD_NAME AS 상품명,
             SUM(A.CART_QTY) AS 판매수량,
             SUM(A.CART_QTY * B.PROD_PRICE) AS 판매금액
        FROM CART A
       INNER JOIN PROD B ON(CART_NO LIKE '200507%')
         AND A.CART_PROD = B.PROD_ID
       GROUP BY  A.CART_PROD,B.PROD_NAME 
       ORDER BY 1;
       
문제2] 2005년2월 거래처별, 상품별 매입현황을 조회하시오
      ALIAS는 거래처코드, 거래처명, 상품명, 매입수량, 매입금액
      일반조인형식과 안시조인형식 적용
      
      SELECT A.BUYER_ID AS 거래처코드,
             A.BUYER_NAME AS 거래처명,
             B.PROD_NAME AS 상품명,
             SUM(C.BUY_QTY) AS 매입수량,
             SUM(C.BUY_QTY * C.BUY_COST) AS 매입금액
        FROM BUYER A, PROD B, BUYPROD C
       WHERE A.BUYER_ID = B.PROD_BUYER
         AND B.PROD_ID = C.BUY_PROD
         AND C.BUY_DATE BETWEEN '20050201' AND '20050228'
       GROUP BY A.BUYER_ID,A.BUYER_NAME,B.PROD_NAME
       ORDER BY 1,3;
       
        SELECT A.BUYER_ID AS 거래처코드,
             A.BUYER_NAME AS 거래처명,
             B.PROD_NAME AS 상품명,
             SUM(C.BUY_QTY) AS 매입수량,
             SUM(C.BUY_QTY * C.BUY_COST) AS 매입금액
        FROM BUYER A
       INNER JOIN PROD B ON(A.BUYER_ID = B.PROD_BUYER)
       INNER JOIN BUYPROD C ON(B.PROD_ID = C.BUY_PROD)
         AND C.BUY_DATE BETWEEN '20050201' AND '20050228'
       GROUP BY A.BUYER_ID, A.BUYER_NAME, B.PROD_NAME
       ORDER BY 1,3;
         
문제3] 2005년 5월 상품별 매입, 매출현황을 조회하시오
      ALIAS는 상품코드, 상품명, 매입금액합계, 판매급액합계
      
      SELECT C.PROD_ID AS 상품코드,
             C.PROD_NAME AS 상품명,
             NVL(SUM(A.BUY_QTY * C.PROD_COST),0) AS 매입금액합계,
             NVL(SUM(B.CART_QTY * C.PROD_PRICE),0)판매급액합계
        FROM BUYPROD A
       RIGHT OUTER JOIN PROD C ON(C.PROD_ID = A.BUY_PROD
         AND A.BUY_DATE BETWEEN '20050501' AND '20050531') --매입
        LEFT OUTER JOIN CART B ON(C.PROD_ID = B.CART_PROD
         AND B.CART_NO LIKE '200505%')--매출
       GROUP BY C.PROD_ID, C.PROD_NAME 
       ORDER BY 1;
         

 
 
     
    