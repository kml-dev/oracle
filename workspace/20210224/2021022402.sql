2021-02-24-02) ��¥��ȯ�Լ�
 4. TO_DATE(c[,fmt])
   - ��¥������ ���ڿ� c�� ����� �ڷḦ ��¥������ ��ȯ
   - 'fmt'�� TO_CHAR�Լ��� ���� 
 
��)
SELECT TO_DATE('20051001')
  FROM DUAL;
  
SELECT TO_DATE('2005�� 10�� 01��','yyyy"��" MM"��" DD"��"')
  FROM DUAL;
  
SELECT TO_DATE('20210224 10:10:34','YYYYMMDD HH24:MI:SS') 
  FROM DUAL;
  
  
  