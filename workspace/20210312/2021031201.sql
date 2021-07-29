--사용예) 사원테이블에서 부서번호 90번 부서에 속한 직원정보를 출력하시오
       --ALIAS는 사원번호, 사원명, 입사일, 부서번호
       /
       SET SERVEROUTPUT ON;
       /
       DECLARE
            -- SCALAR변수
            -- V_ID VARCHAR2(20)
            
            --REFERENCE 변수 
            V_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
            V_NAME EMPLOYEES.EMP_NAME%TYPE;
            V_DATE EMPLOYEES.HIRE_DATE%TYPE;
            V_DID EMPLOYEES.DEPARTMENT_ID%TYPE;
            CURSOR CUR
            IS
                SELECT EMPLOYEE_ID AS 사원번호,
                       EMP_NAME AS 사원명,
                       HIRE_DATE AS 입사일,
                       DEPARTMENT_ID AS 부서번호
                  FROM EMPLOYEES
                 WHERE DEPARTMENT_ID = 90; 
       BEGIN
            -- 커서에 대한 메모리 할당 및 정보를 저장(바인드)
            OPEN CUR;
            LOOP 
            FETCH CUR INTO V_ID, V_NAME, V_DATE, V_DID;
            EXIT WHEN CUR%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(V_ID||' '||V_NAME||' '||V_DATE||' '||V_DID);
            END LOOP;
            
            -- 커서를 닫고 버퍼용으로 사용중인 메모리를 반환
            CLOSE CUR;
       END; 
       
-- 회원의 마일리지 현황을 출력하기
-- 단, 직업이 주부인 회원만 출력
-- ALIAS : MEM_NAME, MEM_MILEAGE
-- 정렬 : MEM_NAME 오름차순

BEGIN
    FOR CUR_REC IN (SELECT MEM_NAME AS 회원이름,
                           NVL(MEM_MILEAGE,0) AS 마일리지
                      FROM MEMBER
                     WHERE MEM_JOB = '주부' 
                     ORDER BY 1)
    LOOP
        -- CUR_REC.ALIAS명
        DBMS_OUTPUT.PUT_LINE('회원이름 : '||CUR_REC.회원이름);
        DBMS_OUTPUT.PUT_LINE('마일리지 : '||CUR_REC.마일리지);
    END LOOP;
END;    

ACCEPT P_JOB PROMPT '직업을 입력하세요 : '
BEGIN
    FOR CUR_REC IN (SELECT MEM_NAME,
                           NVL(MEM_MILEAGE,0) AS MEM_MILEAGE 
                      FROM MEMBER
                     WHERE MEM_JOB = '&P_JOB')
    LOOP
        DBMS_OUTPUT.PUT_LINE('회원이름 : '||CUR_REC.MEM_NAME);
        DBMS_OUTPUT.PUT_LINE('마일리지 : '||CUR_REC.MEM_MILEAGE);
    END LOOP;
END;    
    
CREATE OR REPLACE PROCEDURE USP_PROD_TOTALSTOCK_UPDATE
    (V_PROD IN PROD.PROD_ID%TYPE,
     V_QTY IN PROD.PROD_TOTALSTOCK%TYPE)
IS
BEGIN
    UPDATE PROD
       SET PROD_TOTALSTOCK = PROD_TOTALSTOCK + V_QTY
     WHERE PROD_ID = V_PROD;
     DBMS_OUTPUT.PUT_LINE('업데이트 성공');
END;     
       
EXECUTE USP_PROD_TOTALSTOCK_UPDATE('P101000001',10);
SELECT PROD_ID, PROD_TOTALSTOCK FROM PROD WHERE PROD_ID = 'P101000001';

--회원아이디(MEM_ID) 및 점수를 입력받아 마일리지 점수(MEM_MILEAGE)를
--업데이트하는 프로시저(USP_MEMBER_UPDATE)를 생성하기
--EXECUTE를 통해 김은대(a001)회원의 마일리지 값을
--100씩 추가하여 5회에 걸쳐 500으로 올리기.

CREATE OR REPLACE PROCEDURE USP_MEMBER_UPDATE
    (V_ID IN MEMBER.MEM_ID%TYPE,
     V_MILE IN MEMBER.MEM_MILEAGE%TYPE)
IS
BEGIN
    UPDATE MEMBER
       SET MEM_MILEAGE = MEM_MILEAGE + V_MILE
     WHERE MEM_ID = V_ID;
     DBMS_OUTPUT.PUT_LINE('업데이트 성공');
END;

EXECUTE USP_MEMBER_UPDATE('a001',100);
SELECT MEM_ID, MEM_MILEAGE FROM MEMBER WHERE MEM_ID = 'a001';

       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
     