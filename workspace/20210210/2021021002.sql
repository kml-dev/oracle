2021-02-10-02)������Ÿ��
  - ������,���ڿ�,��¥,��Ÿ�� ����
  1.��¥��
   - �������� ����(char)
   - �������� ����(varchar,varchar2,long,clob,nvarchar2,nclob)
   1) char
    .�������� ���ڿ��� ����
    .�������� ������ �����ʿ� ������ ���ԵǾ� ����
    .�����Ͱ� ũ�� ���� 
    .�ַ� �⺻Ű�� ������ Ÿ������ ���
    .�ѱ� �� ���ڴ� 3byte�� ó��
    .�ִ� 2000byte���� ���� ����
    (�������)
    �÷��� char(ũ��[byte|char]);
      - ũ�� : 1~2000
      - byte|char : 'ũ��'�� ������ ���� byte������ char �������� ����
        'char'�� �����Ǵ��� 2000byte�� �ʰ��� �� ������, default���� byte
        
��)
create table temp01(
    col1 char(20 byte),
    col2 char(20 char),
    col3 char(20)
);

insert into temp01(col1,col2,col3)
  values('����ȭ ����','����ȭ ����','ABCDEFGHIJKLMN');

insert into temp01(col1,col2,col3)
  values('����ȭ ����','����ȭ ���� �Ǿ����ϴ�. ����ȭ ����',
         'ABCDEFGHIJKLMN');
  
select lengthb(col1),
       lengthb(col2),
       lengthb(col3)
  from temp01;
  
  
  2) varchar2
    . �������� ���ڿ��� ����
    . 1~4000 byte ó�� ����
    . ����Ŭ������ ��� ������ ������ Ÿ��(�ٸ� DBMS������ varchar�� ���)
    (�������)
    �÷��� varchar2(ũ��[byte|char]);
      - ũ�� : 1~4000
      - byte|char : 'ũ��'�� ������ ���� byte������ char �������� ����
       'char'�� �����Ǵ��� 4000byte�� �ʰ��� �� ������,
       default���� byte�̴�.
       
��뿹)
create table temp02(
  col1 varchar2(50),
  col2 varchar2(50 char),
  col3 varchar2(50 byte)
);

insert into temp02(col1,col2,col3)
  values('����ȭ ����','����ȭ ����','ABCDEFGHIJKLMN');

insert into temp02(col1,col2,col3)
  values('����ȭ ����','����ȭ ���� �Ǿ����ϴ�. ����ȭ ����',
         'ABCDEFGHIJKLMN');

select * from temp02;
         
select lengthb(col1),
       lengthb(col2),
       lengthb(col3)
  from temp02;
  
  
  3) nvarchar2, varchar
    . varchar�� varchar2�� ���� ��� ����
    . Oracle�翡���� varchar2 ��� �ǰ�
    . nvarchar2�� ����ǥ���ڵ�(�ٱ��� ���)�� ����Ͽ� ���ڿ� ����
    . UTF-8(��������), UTF-16(��������)�������� ó��
    
  4) long
    . ��뷮 �������� �ڷḦ ����
    . 2gb���� ó�� ����
    . ������� : �� ���̺� �� �÷��� longŸ������ ���� ����
    . clob Ÿ������ ��ü(long�� ���� ��� ������ �����)
    (�������)
    �÷��� long;
    
��뿹)
create table temp03(
    col1 long,
    col2 clob,
    col3 varchar2(3000)
);
 
insert into temp03(col1,col2,col3)
  values('����ȭ ����','����ȭ ����','ABCDEFGHIJKLMN');

insert into temp03(col1,col2,col3)
  values('����ȭ ����','����ȭ ���� �Ǿ����ϴ�. ����ȭ ����',
         'ABCDEFGHIJKLMN');

select * from temp03;
         
select dbms_lob.getlength(col2),
       lengthb(col3)
  from temp03;   
    
  5) clob
    . LOB(Large OBjects)Ÿ��
    . ��뷮 �ڷ�(4GB)�� �����ϱ� ���� �������� ������ Ÿ��
    . ���� Į������ ���ÿ� ��밡��(longŸ�� ����)
    . �Ϻα���� DBMS_LOB API������ �޾ƾ� ��(length, substr ��)
    . �ڷ��� ũ��� ���ڿ� ���� ��ȯ(getlength), lengthb�� ��� �Ұ�
    (�������)
    �÷��� clob;
    
create table temp04(
    col1 clob,
    col2 clob,
    col3 varchar2(100)
 );

insert into temp04(col1,col2,col3)
  values('����ȭ ����','����ȭ ����','ABCDEFGHIJKLMN');

insert into temp04(col1,col2,col3)
  values('����ȭ ����','����ȭ ���� �Ǿ����ϴ�. ����ȭ ����',
         'ABCDEFGHIJKLMN');

select * from temp04;  

select substr(col3,2,5) from temp04;

select dbms_lob.substr(col2,2,5) from temp04;    

select length(col3) as "������ ����",
       length(col2)
  from temp04;
select dbms_lob.getlength(col2) from temp04;

select to_char(sysdate, 'YYYY"��" MM"��" DD"��" AM')
  from dual;

    