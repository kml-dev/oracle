2021-03-10-02) PL/SQL
  - Procedural Language sql�� ����
  - ǥ�� sql�� ���α׷��� �帧�� �����ϴ� ��ɰ� �������� �������� ����
  - pl/sql�� �帧������� ����� �����ϰ� ���� ����� �����ϴ�
    ��� ������ ���α׷��� �������Ͽ� ���డ���� ���·� ������ ����
  - BLOCK ������ ����
  - ���ȭ, ĸ��ȭ �������
  - Anonymous Block, Stored Procedure, User Defined Function,
    Package, trigger�� ����
    
1. Anonymous Block
  - �̸��� �ο����� ���� ���
  - pl/sql�� �⺻���� ����
  (����)
  DECLARE
     �����;
    BEGIN  
     �����;
     [EXCEPTION
        ����ó����;
     ]
     END;
     . '�����' : ����ο��� ����� ����, ���, Ŀ�� ����
     . '�����' : SELECT, DML ������� ������ �����Ͻ� ���� ó�� ����
     . '����ó����' : ���� �߻� �� ó���� ��� ���
     
SELECT * FROM LPROD;

��뿹) Ű����� ȸ����ȣ�� �Է¹޾� ȸ�������� ����ϴ� ����� �ۼ�
       ALIAS�� ȸ����ȣ, ȸ����, ���ϸ���
       
       ACCEPT P_ID PROMPT 'ȸ����ȣ : '
       DECLARE
         V_ID MEMBER.MEM_ID%TYPE;
         V_NAME MEMBER.MEM_NAME%TYPE;
         V_MILE NUMBER(5) := 0;
         V_RES VARCHAR2(100);
       BEGIN
         SELECT MEM_ID, MEM_NAME, MEM_MILEAGE INTO V_ID, V_NAME, V_MILE
           FROM MEMBER
          WHERE MEM_ID = '&P_ID';
          
         V_RES := V_ID || ',' || V_NAME || '->' || V_MILE;
       
       --DBMS_OUTPUT.PUT_LINE('------------------------');
         DBMS_OUTPUT.PUT_LINE(V_RES);
         DBMS_OUTPUT.PUT_LINE('------------------------');
       END;
  
  1) ����
    - ���α׷� ���߾���� ������ ���� ����
    - ����ο��� ���
    (��������)
    ������ ������Ÿ��[(ũ��)][:=�ʱⰪ];
    . ������Ÿ�� : ǥ�� sql���� ����ϴ� ������ Ÿ��, BOOLEAN, PLS_INTEGER,
      BINARY_INTEGER �� ������ ��� ���� 
    . PLS_INTEGER, BINARY_INTEGER : 4BYTE ����(-2147483648 ~ 2147483647)
    . ������ : �ش� ���̺��� ��(ROW)�̳� ��(COLUMN)�� ������ Ÿ�� �� ũ�⸦ ����
      ���� ����
      ���̺��.�÷���%TYPE : �÷� ����
      ���̺��%rowtype: �ش� ���̺��� ���� ����
      
      
  2) ���
    - ���α׷����� ������ �ʴ� ���� ǥ��
    - ����� �Ҵ翬������ ����(LEFT VALUE)�� ���Ұ�
    (��������)
    ������ CONSTANT ������Ÿ��[(ũ��)]:=�ʱ갪;
    . �ݵ�� �ʱ�ȭ�� �ʿ�
    
��뿹) ���� �Է¹޾� 2005�� �ش� ���� �������踦 ����ϴ� �͸��� �ۼ�
       ALIAS�� ��ǰ�ڵ�, ��ǰ��, ���Լ���
       
       ACCEPT P_MONTH PROMPT '��(01~12) : ';
       DECLARE
         V_CODE PROD.PROD_ID%TYPE;
         V_NAME PROD.PROD_NAME%TYPE;
         V_QTY_AMT NUMBER:=0;
         V_SDATE CONSTANT DATE:=TO_DATE('2005'||'&P_MONTH'||'01');
         V_EDATE CONSTANT DATE:=LAST_DAY(TO_DATE('2005'||'&P_MONTH'||'01'));
       BEGIN
         SELECT BUY_PROD, PROD_NAME, SUM(BUY_QTY)
           INTO V_CODE, V_NAME, V_QTY_AMT
           FROM BUYPROD, PROD
          WHERE BUY_PROD = PROD_ID
            AND BUY_DATE BETWEEN V_SDATE AND V_EDATE
          GROUP BY BUY_PROD, PROD_NAME;
     
          DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : '||V_CODE);
          DBMS_OUTPUT.PUT_LINE('��ǰ�� : '||V_NAME);
          DBMS_OUTPUT.PUT_LINE('���Լ��� : '||V_QTY_AMT);
          
          EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('���ܹ߻� : '||SQLERRM);
       END;

  3) �б⹮
    - ���߾���� �б⹮(IF ��)�� ���� ��� ����
    (������� - 1)
    IF ���ǽ� THEN
      ��ɹ� - 1;
    [ELSE
      ��ɹ� - 2];
    END IF;
    
    (������� - 2)
    IF ���ǽ�-1 THEN
      ��ɹ� - 1;
    ELSIF ���ǽ�-2 THEN
      ��ɹ� - 2;
    END IF;
    
    (������� - 3)
    IF ���ǽ�-1 THEN
      IF ���ǽ�-2 THEN
         ��ɹ�-1;
    [ELSE 
         ��ɹ�-2];
    [ELSIF ���ǽ�-3 THEN
         ��ɹ�-3
     ELSE
         ��ɹ�-2]];          
    END IF;
    
��뿹) �μ���ȣ 60�� �μ��� ���� ����� �޿��� ��ȸ�Ͽ� �� �μ����� ù��° ��ȸ��
       ����� �޿��� 5000�����̸� '���ӱ� ���', 5001-15000�̸�
       '����ӱ� ���', �� �̻��̸� '���ӱ� ���'�� ����ϴ� ��� �ۼ�
       
DECLARE
  V_DEPT DEPARTMENTS.DEPARTMENT_ID%TYPE:=ROUND(DBMS_RANDOM.VALUE(10,110),-1);
  V_EMP_NAME EMPLOYEES.EMP_NAME%TYPE;
  V_SALARY EMPLOYEES.SALARY%TYPE;
  V_MESSAGE VARCHAR2(100);
BEGIN
  SELECT EMP_NAME, SALARY INTO V_EMP_NAME, V_SALARY
    FROM EMPLOYEES
   WHERE DEPARTMENT_ID = V_DEPT
     AND ROWNUM = 1;
     
  IF V_SALARY <= 5000 THEN
     V_MESSAGE:='���ӱ� ���';
  ELSIF V_SALARY > 15000 THEN
     V_MESSAGE:='���ӱ� ���';
  ELSE
     V_MESSAGE:='����ӱ� ���';
  END IF;
  
  V_MESSAGE:=V_EMP_NAME||'  '||V_SALARY||'-->'||V_MESSAGE;
  DBMS_OUTPUT.PUT_LINE(V_MESSAGE);
END;
     
     
     
     
     
     
     
     
     