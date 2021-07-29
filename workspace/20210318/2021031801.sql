--�Լ� ����
--������ ���� ����Ͻÿ�
-- ��ǰ�ڵ�, ��ǰ��, ��з��ڵ�, ��з���
--�Լ��� ���. �Լ����� FN_PRODNM
CREATE OR REPLACE FUNCTION FN_PRODNM(P_LGU IN PROD.PROD_LGU%TYPE)
RETURN VARCHAR2
IS 
    V_NM VARCHAR2(40);
BEGIN
    SELECT LPROD_NM
      INTO V_NM
      FROM LPROD
     WHERE LPROD_GU = P_LGU;
     RETURN V_NM;
END;

SELECT PROD_ID ��ǰ�ڵ�,
       PROD_NAME ��ǰ��,
       PROD_LGU ��з��ڵ�,
       FN_PRODNM(PROD_LGU) ��з���
  FROM PROD
 ORDER BY 1; 
 
--�Լ�����2
--������ ���� ����Ͻÿ�
--��ٱ����ڵ�, ��ǰ�ڵ�, �ǸŰ���, ȸ�����̵�, ȸ����
--�Լ��� ��� �Լ����� FN_GET_MEM_NM

CREATE OR REPLACE FUNCTION FN_GET_MEM_NM(P_ID IN MEMBER.MEM_ID%TYPE)
RETURN VARCHAR2
IS
    V_NAME MEMBER.MEM_NAME%TYPE;
BEGIN
    SELECT MEM_NAME
      INTO V_NAME
      FROM MEMBER
     WHERE MEM_ID = P_ID;
     RETURN V_NAME;
END;

SELECT CART_NO ��ٱ����ڵ�,
       CART_PROD ��ǰ�ڵ�,
       CART_QTY �ǸŰ���,
       FN_GET_MEM_NM(CART_MEMBER) ȸ���̸�
  FROM CART
 ORDER BY 1; 
 
--�Լ�����3
--������ ���� ����Ͻÿ�
-- �Լ��� ��� .�Լ�����
CREATE OR REPLACE FUNCTION FN_GET_CITY(P_ADD IN MEMBER.MEM_ADD1%TYPE)
RETURN VARCHAR2
IS
    V_CITY MEMBER.MEM_ADD1%TYPE;
BEGIN
    SELECT NVL(SUBSTR(P_ADD,1,INSTR(P_ADD,' ')-1),SUBSTR(P_ADD,1,2))
      INTO V_CITY
      FROM DUAL;
    RETURN V_CITY;  
END;

SELECT MEM_ID,
       MEM_NAME,
       FN_GET_CITY(MEM_ADD1)
  FROM MEMBER;     

--�Լ� ����4 
--��ǰ�з� �� ���Ǹűݾ�(SUM(PROD_SALE * CART_QTY))�� ���
CREATE OR REPLACE FUNCTION ALL_SALE_AMT(P_LGU IN LPROD.LPROD_GU%TYPE,
                                        P_YEAR IN NUMBER)
RETURN NUMBER
IS
    V_NUM NUMBER;
BEGIN
    SELECT SUM(A.PROD_SALE * B.CART_QTY)
      INTO V_NUM
      FROM PROD A, CART B
     WHERE PROD_ID = CART_PROD
       AND A.PROD_LGU = P_LGU
       AND B.CART_NO LIKE P_YEAR||'%';
    RETURN V_NUM;   
END;




SELECT LPROD_GU ��ǰ�з��ڵ�,
       LPROD_NM ��ǰ�з���,
       NVL(ALL_SALE_AMT(LPROD_GU, 2005),0) ���Ǹűݾ�
  FROM LPROD;



CREATE OR REPLACE TRIGGER TG_LPROD_IN
AFTER INSERT
ON LPROD
BEGIN
    --LPROD ���̺� �����Ͱ� INSERT(�̺�Ʈ)�� ��(Ÿ�̹�)��
    --������ ���� ���ڿ��� �ֿܼ� �����
    DBMS_OUTPUT.PUT_LINE('��ǰ�з��� �߰��Ǿ����ϴ�.');
END;

SET SERVEROUTPUT ON;

INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
VALUES(22,'P212','�׽�Ʈ2');

CREATE TABLE EMP01(
    EMPNO NUMBER(4) PRIMARY KEY,
    EMPNAME VARCHAR2(45),
    EMPJOB VARCHAR2(60)
);

CREATE TABLE SAL01(
    SALNO NUMBER(4) PRIMARY KEY,
    SAL NUMBER(7,2),
    EMPNO NUMBER(4) REFERENCES EMP01(EMPNO)
);

CREATE SEQUENCE SAL01_SALNO_SEQ
INCREMENT BY 1
START WITH 1;

CREATE OR REPLACE TRIGGER TRG_02
--EMP01���̺� �����Ͱ� INSERT(�̺�Ʈ)EHLS
--��(AFTER Ÿ�̹�)��
AFTER INSERT
ON EMP01
--���Ʈ���� -> ������ ó�� ����
FOR EACH ROW
BEGIN
    --�޿����̺��� �ڵ����� �����͸� INSERT.
    --:NEW => EMP01�� ��� INSERT�� �ٷ� �� ������ �� ��
    --.EMPNO => �� ���� EMPNO �÷��� ��
    INSERT INTO SAL01 VALUES(SAL01_SALNO_SEQ.NEXTVAL, 100, :NEW.EMPNO);
END;    

INSERT INTO EMP01 VALUES(1,'������','���α׷���');
INSERT INTO EMP01 VALUES(2,'�ڸ��','���α׷���');
INSERT INTO EMP01 VALUES(3,'������','���α׷���');
INSERT INTO EMP01 VALUES(4,'����','���α׷���');
INSERT INTO EMP01 VALUES(5,'�޶ѱ�','���α׷���');

SELECT * FROM EMP01;
SELECT * FROM SAL01;


  
 
 
 
 
 
 
 
 
 
 
 
 
 
 