--��뿹) ������̺��� �μ���ȣ 90�� �μ��� ���� ���������� ����Ͻÿ�
       --ALIAS�� �����ȣ, �����, �Ի���, �μ���ȣ
       /
       SET SERVEROUTPUT ON;
       /
       DECLARE
            -- SCALAR����
            -- V_ID VARCHAR2(20)
            
            --REFERENCE ���� 
            V_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
            V_NAME EMPLOYEES.EMP_NAME%TYPE;
            V_DATE EMPLOYEES.HIRE_DATE%TYPE;
            V_DID EMPLOYEES.DEPARTMENT_ID%TYPE;
            CURSOR CUR
            IS
                SELECT EMPLOYEE_ID AS �����ȣ,
                       EMP_NAME AS �����,
                       HIRE_DATE AS �Ի���,
                       DEPARTMENT_ID AS �μ���ȣ
                  FROM EMPLOYEES
                 WHERE DEPARTMENT_ID = 90; 
       BEGIN
            -- Ŀ���� ���� �޸� �Ҵ� �� ������ ����(���ε�)
            OPEN CUR;
            LOOP 
            FETCH CUR INTO V_ID, V_NAME, V_DATE, V_DID;
            EXIT WHEN CUR%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(V_ID||' '||V_NAME||' '||V_DATE||' '||V_DID);
            END LOOP;
            
            -- Ŀ���� �ݰ� ���ۿ����� ������� �޸𸮸� ��ȯ
            CLOSE CUR;
       END; 
       
-- ȸ���� ���ϸ��� ��Ȳ�� ����ϱ�
-- ��, ������ �ֺ��� ȸ���� ���
-- ALIAS : MEM_NAME, MEM_MILEAGE
-- ���� : MEM_NAME ��������

BEGIN
    FOR CUR_REC IN (SELECT MEM_NAME AS ȸ���̸�,
                           NVL(MEM_MILEAGE,0) AS ���ϸ���
                      FROM MEMBER
                     WHERE MEM_JOB = '�ֺ�' 
                     ORDER BY 1)
    LOOP
        -- CUR_REC.ALIAS��
        DBMS_OUTPUT.PUT_LINE('ȸ���̸� : '||CUR_REC.ȸ���̸�);
        DBMS_OUTPUT.PUT_LINE('���ϸ��� : '||CUR_REC.���ϸ���);
    END LOOP;
END;    

ACCEPT P_JOB PROMPT '������ �Է��ϼ��� : '
BEGIN
    FOR CUR_REC IN (SELECT MEM_NAME,
                           NVL(MEM_MILEAGE,0) AS MEM_MILEAGE 
                      FROM MEMBER
                     WHERE MEM_JOB = '&P_JOB')
    LOOP
        DBMS_OUTPUT.PUT_LINE('ȸ���̸� : '||CUR_REC.MEM_NAME);
        DBMS_OUTPUT.PUT_LINE('���ϸ��� : '||CUR_REC.MEM_MILEAGE);
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
     DBMS_OUTPUT.PUT_LINE('������Ʈ ����');
END;     
       
EXECUTE USP_PROD_TOTALSTOCK_UPDATE('P101000001',10);
SELECT PROD_ID, PROD_TOTALSTOCK FROM PROD WHERE PROD_ID = 'P101000001';

--ȸ�����̵�(MEM_ID) �� ������ �Է¹޾� ���ϸ��� ����(MEM_MILEAGE)��
--������Ʈ�ϴ� ���ν���(USP_MEMBER_UPDATE)�� �����ϱ�
--EXECUTE�� ���� ������(a001)ȸ���� ���ϸ��� ����
--100�� �߰��Ͽ� 5ȸ�� ���� 500���� �ø���.

CREATE OR REPLACE PROCEDURE USP_MEMBER_UPDATE
    (V_ID IN MEMBER.MEM_ID%TYPE,
     V_MILE IN MEMBER.MEM_MILEAGE%TYPE)
IS
BEGIN
    UPDATE MEMBER
       SET MEM_MILEAGE = MEM_MILEAGE + V_MILE
     WHERE MEM_ID = V_ID;
     DBMS_OUTPUT.PUT_LINE('������Ʈ ����');
END;

EXECUTE USP_MEMBER_UPDATE('a001',100);
SELECT MEM_ID, MEM_MILEAGE FROM MEMBER WHERE MEM_ID = 'a001';

       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
     