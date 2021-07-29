2021-02-15-02)
 4.��Ÿ�ڷ���
  - 2���ڷḦ �����ϱ����� �ڷ���
  - raw, long raw, blob, bfile
   1) raw
     . ��������� ���� 2���ڷ� ����
     . �ε��� ó������
     . �ִ� 2000 byte ó�� ����
     . ����Ŭ���� �ؼ��̳� ��ȯ�۾��� ������� ����
     . 16������ 2������ ����
  (�������)
   �÷��� raw(ũ��);
   
   2) bfile
     . 2�� �ڷ� ����
     . ����̵Ǵ� 2�� �ڷ�� �����ͺ��̽� �ܺο� ����
     . �������(directory ��ü)�� ���ϸ� ���̺� ����
     . 4gb���� ���� ����
     (�������)
     �÷��� bfile;
     
     **�׸����� �������
      (1) �׸������� ����� ��ο� ����Ȯ��
      (2) ���丮��ü ����(create or replace directory ���丮�� as �����ּ�)
      (3) ���̺� ����
      (4) �׸����� ����
(��뿹)
    (1)�׸���� : 'D:\A_TeachingMaterial\2.Oracle\workspace\20210215'
         ���ϸ� : 'sample01.jpg'
    (2)���丮��ü ����
       create or replace directory test_dir
           as 'D:\A_TeachingMaterial\2.Oracle\workspace\20210215';
    (3)���̺� ���� 
       create table temp07(
         col1 bfile
       );
    (4)�׸� ����
       insert into temp07
         values(bfilename('TEST_DIR','sample01.jpg'));
         
    select * from temp07;
    
  3) blob
    . 2�� �ڷḦ �����ͺ��̽� ���ο� ����
    . 4gb���� ���� ����
    . �ؼ� �� ��ȯ���� ����
    
    **�׸����� �������
      (1) �׸������� ����� ��ο� ����Ȯ��
      (2) ���丮��ü ����(create or replace directory ���丮�� as �����ּ�)
      (3) ���̺� ����
      create table temp08(
        col1 blob
      );
      
      
      (4) �׸����� ���� - procedure�� �̿�
      create or replace procedure proc_img_insert(
        p_dir in  varchar2,
        p_id in varchar2,
        p_photo_name varchar2)
      is
        v_source bfile;
        v_dept   blob;
        v_length number:=0;
      begin
        v_source:=bfilename(p_dir,p_photo_name);
        insert into temp08(col1)
          values(empty_blob())
          returning blobdate into v_dept;
          
          select blobdate into v_dept
            from temp08
           where 
          
        dbms_lob.fileopen(v_source,dbms_lob.file_readonly);
        v_length:=dbms_lob.getlength(v_source);
        dbms_lob.loadfromfile(v_dept,v_source,v_length);
        dbms_lob.fileclose(v_source);
        commit;
        end;

***�׸����� ����

 declare
 
 begin
   proc_img_insert('test_dir','1','sample01.jpg','sample01.jpg');
   proc_img_insert('test_dir','2','sample02.jpg','sample02.jpg');
   proc_img_insert('test_dir','3','sample03.jpg','sample03.jpg');
 end;
        
    
      
           