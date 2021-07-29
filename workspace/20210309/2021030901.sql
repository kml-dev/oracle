2021-03-09-01)VIEW 객체
  - 가상의 테이블
  - SELECT문의 결과로 생성되는 독립적 객체
  - 특정자료의 접근을 제한할 때(보안), 복수개의 테이블에 분산된 자료를
    빈번히 JOIN한 결과를 사용할 때, 소수의 컬럼이나 행만 필요할 때 주로 사용
    (사용형식)
    CREATE[OR REPLACE] VIEW 뷰이름[(컬럼명1,...)]
    AS
      SELECT 문
      [WITH CHECK OPTION]
      [WITH READ ONLY];
     . '컬럼명1,...' : 생성되는 뷰에 부여되는 컬럼명, 생략되면 원본테이블의
       컬럼명이 적용됨
     . 'WITH CHECK OPTION' : 뷰를 생성하는 SELECT문에서 조건이 사용된 경우
       그 조건에 부합하지 않는 DML명령(INSERT, UPDATE)을 사용하지 못함
     . 'WITH READ ONLY' : 뷰의 결과를 수정하면 원본테이블도 함께 수정되지 않게
                          하기 위한 옵션
                          
사용예) 2005년 2월 제품별 매입현황을 뷰로 작성하시오
       뷰는 상품코드, 상품명, 매입수량으로 구성
       
       CREATE OR REPLACE VIEW V_BUYPROD
       AS
         SELECT A.BUY_PROD AS 상품코드,
                B.PROD_NAME AS 상품명,
                SUM(A.BUY_QTY) AS 매입수량
           FROM BUYPROD A, PROD B
          WHERE A.BUY_PROD = B.PROD_ID
            AND A.BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201')
          GROUP BY A.BUY_PROD, B.PROD_NAME  
          ORDER BY 1;
          
        SELECT * FROM BUYPROD
         WHERE BUY_PROD = 'P102000006'
           AND BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201')
          
       (VIEW 내용 변경)
       상품코드가 'P102000006'의 상품의 매입수량을 50으로 변경
       
       UPDATE V_BUYPROD
          SET 매입수량 = 50
        WHERE 상품코드 = 'P102000006';  
       
       (BUYPROD(원본테이블)내용 변경)
       상품코드가 'P102000006'의 상품의 매입수량(50)을 10으로 변경
       UPDATE BUYPROD
          SET BUY_QTY = 10
        WHERE BUY_PROD = 'P102000006'
          AND BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201');
          
          
       SELECT * FROM V_BUYPROD;
       
사용예) 회원테이블에서 마일리지가 5000이상인 회원정보를 조회하고
       VIEW로 생성하시오
       
       CREATE OR REPLACE VIEW V_MEM(MID,MNAME,MILEAGE)
       AS
         SELECT MEM_ID,
                MEM_NAME,
                MEM_MILEAGE
           FROM MEMBER
          WHERE MEM_MILEAGE >= 5000 
           WITH CHECK OPTION;
        
        (VIEW 내용확인)   
        SELECT * FROM V_MEM;
        --V_MEM뷰에서 구길동 회원의 마일리지를 4300으로 변경
        
        UPDATE V_MEM
           SET MILEAGE = 4300
         WHERE MID = 'l001';  
       
       --원본테이블에서 'a001'회원의 마일리지를 1000에서 6000으로 변경
       UPDATE MEMBER
          SET MEM_MILEAGE = 6000
        WHERE MEM_ID = 'a001';  
       
       CREATE OR REPLACE VIEW V_MEM(MID,MNAME,MILEAGE)
       AS
         SELECT MEM_ID,
                MEM_NAME,
                MEM_MILEAGE
           FROM MEMBER
          WHERE MEM_MILEAGE >= 5000 
           WITH READ ONLY;
           
      --원본테이블에서 'a001'회원의 마일리지를 6000에서 2000으로 변경
      UPDATE MEMBER
         SET MEM_MILEAGE = 2000
       WHERE MEM_ID = 'a001'; 
       
      --VIEW(V_MEM)에서 'e001' 마일리지를  6500에서 3500으로 변경
      UPDATE V_MEM
         SET MILEAGE = 3500
       WHERE MID = 'e001';
       
       
       
       
       
       
       
       