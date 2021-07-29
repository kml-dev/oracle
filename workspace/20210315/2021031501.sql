SET SERVEROUTPUT ON;
--���ν��� ��������1
CREATE TABLE PROCTEST(
    PROC_SEQ NUMBER,
    PROC_CONTENT VARCHAR2(100),
    CONSTRAINT PK_PROCTEST PRIMARY KEY(PROC_SEQ)
);

CREATE SEQUENCE SEQPROC1
START WITH 1
INCREMENT BY 1;

--1-1)���ν��� PROC_TEST1����

CREATE OR REPLACE PROCEDURE PROC_TEST1
IS
BEGIN
    INSERT INTO PROCTEST(PROC_SEQ,PROC_CONTENT)
    VALUES(SEQPROC1.NEXTVAL,'������');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('���� �߻� : '||SQLERRM);
END;            
    
EXECUTE PROC_TEST1;

SELECT * FROM PROCTEST;   

--1-2) ���ν��� PROC_TEST2�� ����.

CREATE OR REPLACE PROCEDURE PROC_TEST2
IS 
    DEL_ERROR EXCEPTION;
    V_SEQ NUMBER;
BEGIN 
    DELETE FROM PROCTEST
     WHERE PROC_SEQ = (SELECT MAX(PROC_SEQ)
                         FROM PROCTEST);
    
    --PL/SQL���� SELECT�� ���Ǹ� INTO�� ������ ���Ǿ�� ��                     
    SELECT COUNT(PROC_SEQ) INTO V_SEQ FROM PROCTEST;                          
    
    IF V_SEQ < 1 THEN
        --�ý��� ������ �ƴ� �������� �������� ���ܸ� �߻���
        RAISE DEL_ERROR;
    END IF;    
     
    EXCEPTION
       WHEN DEL_ERROR THEN
           DBMS_OUTPUT.PUT_LINE('������ �����Ͱ� �����ϴ�.'||SQLERRM);
END;            

EXECUTE PROC_TEST2;

SELECT * FROM PROCTEST;

--1-3) ȸ��ID�� �Ű������� �Ͽ� 
--�ش� ȸ���� ���ϸ����� 100�� �߰��ϴ�
--PROCEDURE�� �����ϱ�(PROC_TEST3)

CREATE OR REPLACE PROCEDURE PROC_TEST3
             (V_ID MEMBER.MEM_ID%TYPE,
              V_MILE MEMBER.MEM_MILEAGE%TYPE)
IS
    NOTFOUND_ERROR EXCEPTION;
    V_TEMP NUMBER;
BEGIN 
    UPDATE MEMBER
       SET MEM_MILEAGE = MEM_MILEAGE + V_MILE
     WHERE MEM_ID = V_ID;
     
     SELECT COUNT(*) INTO V_TEMP
       FROM MEMBER
      WHERE MEM_ID = V_ID;                          
    
    IF V_TEMP < 1 THEN
        RAISE NOTFOUND_ERROR;
    END IF;  
     
     EXCEPTION
       WHEN NOTFOUND_ERROR THEN
           DBMS_OUTPUT.PUT_LINE('�ش� ȸ�������� �����ϴ�.'||SQLERRM);
END; 

EXECUTE PROC_TEST3('a001',400);

SELECT MEM_MILEAGE
  FROM MEMBER
 WHERE MEM_ID = 'a001';
    
--ȸ�����̵� �Է¹޾� �̸��� ��̸� OUT�Ű������� ó��

CREATE OR REPLACE PROCEDURE USP_MEMBERID
    (P_MEM_ID IN MEMBER.MEM_ID%TYPE,
     P_MEM_NAME OUT MEMBER.MEM_NAME%TYPE,
     P_MEM_LIKE OUT MEMBER.MEM_LIKE%TYPE)
IS
BEGIN 
    SELECT MEM_NAME,
           MEM_LIKE
      INTO P_MEM_NAME,
           P_MEM_LIKE
      FROM MEMBER
     WHERE MEM_ID = P_MEM_ID;
END;

VAR MEM_NAME VARCHAR2(20)
VAR MEM_LIKE VARCHAR2(20)

EXECUTE USP_MEMBERID('a001',:mem_name,:mem_like);
PRINT MEM_NAME
PRINT MEM_LIKE;
     
--��ǰ �ڵ�� ���� �Է��ϸ� �ش� ���� ����
--�ش� ��ǰ�� �԰�,
--��� ó���� ȭ�鿡 ����Ͻÿ�.
--(���ν�����: USP_PROD_INFO,
--�� �Է������� 'YYYYMM'�̶� ����,
--�԰� �� ���� OUT �Ű������� ó��.)
--�÷����� : PROD_ID, EXTRACT(MONTH FROM BUY_DATE),
--          SUM(BUY_QTY), SUM(CART_QTY)
-- ALIAS : ��ǰ�ڵ�, ��, �԰�����հ�, �������հ�

CREATE OR REPLACE PROCEDURE USP_PROD_INFO
    (V_ID IN PROD.PROD_ID%TYPE,
     V_DATE IN VARCHAR2,
     V_BSUM OUT NUMBER,
     V_CSUM OUT NUMBER)
IS
BEGIN
    SELECT SUM(A.BQTY),
           SUM(B.CQTY)
      INTO V_BSUM, V_CSUM       
      FROM (SELECT BUY_QTY AS BQTY
              FROM BUYPROD
             WHERE TO_CHAR(BUY_DATE,'YYYYMM') LIKE V_DATE||'%'
               AND BUY_PROD = V_ID ) A,
           (SELECT CART_QTY AS CQTY
              FROM CART
             WHERE CART_NO LIKE V_DATE||'%'
               AND CART_PROD = V_ID) B;
END;
    
VAR PROD_IN NUMBER
VAR PROD_OUT NUMBER
EXECUTE USP_PROD_INFO('P202000001','200504',:PROD_IN,:PROD_OUT)
PRINT PROD_IN
PRINT PROD_OUT;
    
    
    
    
    
    
    
    
    