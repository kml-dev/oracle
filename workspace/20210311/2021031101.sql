2021-03-11-01)
2. case��
  - ���� �б��� ����
  - java�� switch ~ case �� ����
  - ǥ�� SQL������ SELECT������ ����ϳ� PL/SQL������ BEGIN BLOCK����
    �б�������� ���
    (�������-1)
    CASE WHEN ǥ���� THEN
              ���ɹ�1;
         WHEN ǥ���� THEN
              ���ɹ�2;
     END CASE;          
    (�������-1)
    CASE ǥ����
    WHEN ���1 THEN
         ���ɹ�1;
    WHEN ǥ���� THEN
         ���ɹ�2;
         :
    ELSE  
    
    END CASE;
         
��뿹) ������� ���
    �Է��ڷ� : ��뷮(��)
    ��� : 1) ������
    1 ~ 10 : ��� 250��
   11 ~ 20 : ��� 350��
   21 ~ 30 : ��� 500��
   �� �̻�  : ��� 750��
   
   2) �ϼ��� ����
   ��뷮(��) * 150��
   
���� ��� 25���� ����ϸ� 
  ó�� 10�� : 10 * 250 = 2500
  ���� 10�� : 10 * 350 = 3500
  ������ 5�� : 5 * 500 = 2500
------------------------------
                        8500��
  ���̿� �д��(�ϼ��� ����)
              25 * 150 = 3750 
------------------------------
                 �հ� : 12250��

ACCEPT P_AMT PROMPT '���� ��뷮(��) : '
DECLARE
    V_AMT NUMBER :=TO_NUMBER('&P_AMT'); --���� ��뷮
    V_HAP NUMBER:=0; --���
BEGIN
    CASE WHEN V_AMT <= 10 THEN
              V_HAP:=V_AMT*250;
         WHEN V_AMT <= 20 THEN
              V_HAP:=(10*250)+(V_AMT-10)*350;
         WHEN V_AMT <= 30 THEN
              V_HAP:=(10*250)+(10*350)+(V_AMT-20)*500;
         ELSE     
              V_HAP:=(10*250)+(10*350)+(10*500)+(V_AMT-30)*750;
    END CASE;       
    V_HAP:=V_HAP+(V_AMT*150);
    
    DBMS_OUTPUT.PUT_LINE('�� ��뷮 : '||V_AMT||'��');
    DBMS_OUTPUT.PUT_LINE('������� : '||TO_CHAR(V_HAP,'999,999')||'��');
    DBMS_OUTPUT.PUT_LINE('�� ��뷮 : '||V_AMT||'��');
END;    
    




























