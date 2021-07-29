2021-03-09-02)SEQUENCE ��ü
  - ���������� �����ϴ� ������ �߻�
  - �ٸ� DBMS(MYSQL, SQL_SERVER ��)������ AUTO INCREMENT�� ����
  - ���̺� ���������� ���
  - �⺻Ű�� �����ϱ⿡ ������ �÷��� ���� ���,
    ������ ������ �ʿ��� ���(�Խ����� �۹�ȣ ��)�� �ַ� ���
    
    (�������)
    CREATE SEQUENCE ��������
      [START WITH n]
      [INCREMENT BY n]
      [MAXVALUE n|NOMAXVALUE]
      [MINVALUE n|NOMINVALUE]
      [CYCLE|NOCYCLE]
      [CACHE|NOCACHE]
      [ORDER|NOORDER]
      
     . START WITH n : ���۰�, �⺻���� ������ �� MINVALUE,
                      ������ �� MAXVALUE
     . INCREMENT BY n : ������ 
     . MAXVALUE n : �ִ�(DEFAULT�� 10^27��), 'NOMAXVALUE'�� �⺻
     . MINVALUE n : �ּڰ�(DEFULAT�� 1), 'NOMINVALUE'�� �⺻
     . CYCLE : �ִ� �Ǵ� �ּڰ� ������ �ٽ� ����(�⺻�� NOCYCLE)
     . CACHE : �޸𸮿� �̸� �����Ͽ� �Ҵ��� ����(DEFAULT�� CACHE 20)
     . ORDER : ��û�� ������� ������ ����(DEFAULT�� NOORDER)
     
     * �������� ���
     --------------------------------------------------
       �ǻ��÷�(Pseudo Column)      �ǹ�
     --------------------------------------------------
       ��������.NEXTVAL             ��������ü�� ���� �� ��ȯ
       ��������.CURRVAL             ��������ü�� ���� �� ��ȯ
     **�������� ������ �� ù ��° ����� '��������.NEXTVAL'�� ����Ǿ�� ��
       �� ��������.CURRVAL�� �ش� ���ǿ��� ��������.NEXTVAL�� ���ʷ� ����
       �� �Ŀ��� ������ �� ����
       
��뿹) ��ǰ�з����̺�(LPROD)�� ���� �ڷḦ �߰��Ͻÿ�
       ��, ����(LPROD_ID)�� SEQUENCE�� �����Ͽ� ����Ͻÿ�
       �з��ڵ� : 'P501'
       �з��� : '�ӻ깰'
       �з��ڵ� : 'P502'
       �з��� : '���깰'
       �з��ڵ� : 'P503'
       �з��� : '��깰'
       
SELECT MAX(LPROD_ID) FROM LPROD;
(������ ����)
CREATE SEQUENCE SEQ_LPROD
  START WITH 10;
       
SELECT SEQ_LPROD.CURRVAL FROM DUAL;

INSERT INTO LPROD
  VALUES(SEQ_LPROD.NEXTVAL,'P501','�ӻ깰');

INSERT INTO LPROD
  VALUES(SEQ_LPROD.NEXTVAL,'P502','���깰');
  
INSERT INTO LPROD
  VALUES(SEQ_LPROD.NEXTVAL,'P503','��깰');  
  
SELECT * FROM LPROD;  
SELECT SEQ_LPROD.CURRVAL FROM DUAL;     
     
     
     
     
     
     
     
     
     
     
     
     
     
     