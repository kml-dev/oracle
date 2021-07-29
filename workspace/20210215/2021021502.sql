2021-02-15-02)
 4.기타자료형
  - 2진자료를 저장하기위한 자료형
  - raw, long raw, blob, bfile
   1) raw
     . 상대적으로 작은 2진자료 저장
     . 인덱스 처리가능
     . 최대 2000 byte 처리 가능
     . 오라클에서 해석이나 변환작업이 수행되지 않음
     . 16진수와 2진수로 저장
  (사용형식)
   컬럼명 raw(크기);
   
   2) bfile
     . 2진 자료 저장
     . 대상이되는 2진 자료는 데이터베이스 외부에 저장
     . 경로정보(directory 객체)와 파일명만 테이블에 저장
     . 4gb까지 저장 가능
     (사용형식)
     컬럼명 bfile;
     
     **그림파일 저장순서
      (1) 그림파일이 저장된 경로와 파일확인
      (2) 디렉토리객체 생성(create or replace directory 디렉토리명 as 절대주소)
      (3) 테이블 생성
      (4) 그림파일 삽입
(사용예)
    (1)그림경로 : 'D:\A_TeachingMaterial\2.Oracle\workspace\20210215'
         파일명 : 'sample01.jpg'
    (2)디렉토리객체 생성
       create or replace directory test_dir
           as 'D:\A_TeachingMaterial\2.Oracle\workspace\20210215';
    (3)테이블 생성 
       create table temp07(
         col1 bfile
       );
    (4)그림 삽입
       insert into temp07
         values(bfilename('TEST_DIR','sample01.jpg'));
         
    select * from temp07;
    
  3) blob
    . 2진 자료를 데이터베이스 내부에 저장
    . 4gb까지 저장 가능
    . 해석 및 변환되지 않음
    
    **그림파일 저장순서
      (1) 그림파일이 저장된 경로와 파일확인
      (2) 디렉토리객체 생성(create or replace directory 디렉토리명 as 절대주소)
      (3) 테이블 생성
      create table temp08(
        col1 blob
      );
      
      
      (4) 그림파일 삽입 - procedure를 이용
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

***그림파일 생성

 declare
 
 begin
   proc_img_insert('test_dir','1','sample01.jpg','sample01.jpg');
   proc_img_insert('test_dir','2','sample02.jpg','sample02.jpg');
   proc_img_insert('test_dir','3','sample03.jpg','sample03.jpg');
 end;
        
    
      
           