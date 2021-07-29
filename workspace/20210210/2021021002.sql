2021-02-10-02)데이터타입
  - 숫자형,문자열,날짜,기타로 구분
  1.날짜형
   - 고정길이 형식(char)
   - 가변길이 형식(varchar,varchar2,long,clob,nvarchar2,nclob)
   1) char
    .고정길이 문자열을 저장
    .기억공간이 남으면 오른쪽에 공백이 삽입되어 저장
    .데이터가 크면 오류 
    .주로 기본키의 데이터 타입으로 사용
    .한글 한 글자는 3byte로 처리
    .최대 2000byte까지 저장 가능
    (사용형식)
    컬럼명 char(크기[byte|char]);
      - 크기 : 1~2000
      - byte|char : '크기'로 지정된 값이 byte값인지 char 갯수인지 지정
        'char'로 지정되더라도 2000byte를 초과할 수 없으며, default값은 byte
        
예)
create table temp01(
    col1 char(20 byte),
    col2 char(20 char),
    col3 char(20)
);

insert into temp01(col1,col2,col3)
  values('무궁화 꽃이','무궁화 꽃이','ABCDEFGHIJKLMN');

insert into temp01(col1,col2,col3)
  values('무궁화 꽃이','무궁화 꽃이 피었습니다. 무궁화 꽃은',
         'ABCDEFGHIJKLMN');
  
select lengthb(col1),
       lengthb(col2),
       lengthb(col3)
  from temp01;
  
  
  2) varchar2
    . 가변길이 문자열을 저장
    . 1~4000 byte 처리 가능
    . 오라클에서만 사용 가능한 데이터 타입(다른 DBMS에서는 varchar를 사용)
    (사용형식)
    컬럼명 varchar2(크기[byte|char]);
      - 크기 : 1~4000
      - byte|char : '크기'로 지정된 값이 byte값인지 char 개수인지 지정
       'char'로 지정되더라도 4000byte를 초과할 수 없으며,
       default값은 byte이다.
       
사용예)
create table temp02(
  col1 varchar2(50),
  col2 varchar2(50 char),
  col3 varchar2(50 byte)
);

insert into temp02(col1,col2,col3)
  values('무궁화 꽃이','무궁화 꽃이','ABCDEFGHIJKLMN');

insert into temp02(col1,col2,col3)
  values('무궁화 꽃이','무궁화 꽃이 피었습니다. 무궁화 꽃은',
         'ABCDEFGHIJKLMN');

select * from temp02;
         
select lengthb(col1),
       lengthb(col2),
       lengthb(col3)
  from temp02;
  
  
  3) nvarchar2, varchar
    . varchar와 varchar2는 동일 기능 제공
    . Oracle사에서는 varchar2 사용 권고
    . nvarchar2는 국제표준코드(다국적 언어)를 사용하여 문자열 저장
    . UTF-8(가변길이), UTF-16(고정길이)형식으로 처리
    
  4) long
    . 대용량 가변길이 자료를 저장
    . 2gb까지 처리 가능
    . 제약사항 : 한 테이블에 한 컬럼만 long타입으로 선언 가능
    . clob 타입으로 대체(long의 현재 기능 개선이 종료됨)
    (사용형식)
    컬럼명 long;
    
사용예)
create table temp03(
    col1 long,
    col2 clob,
    col3 varchar2(3000)
);
 
insert into temp03(col1,col2,col3)
  values('무궁화 꽃이','무궁화 꽃이','ABCDEFGHIJKLMN');

insert into temp03(col1,col2,col3)
  values('무궁화 꽃이','무궁화 꽃이 피었습니다. 무궁화 꽃은',
         'ABCDEFGHIJKLMN');

select * from temp03;
         
select dbms_lob.getlength(col2),
       lengthb(col3)
  from temp03;   
    
  5) clob
    . LOB(Large OBjects)타입
    . 대용량 자료(4GB)를 저장하기 위한 가변길이 데이터 타입
    . 여러 칼럼에서 동시에 사용가능(long타입 개선)
    . 일부기능은 DBMS_LOB API지원을 받아야 함(length, substr 등)
    . 자료의 크기는 문자열 수로 반환(getlength), lengthb는 사용 불가
    (사용형식)
    컬럼명 clob;
    
create table temp04(
    col1 clob,
    col2 clob,
    col3 varchar2(100)
 );

insert into temp04(col1,col2,col3)
  values('무궁화 꽃이','무궁화 꽃이','ABCDEFGHIJKLMN');

insert into temp04(col1,col2,col3)
  values('무궁화 꽃이','무궁화 꽃이 피었습니다. 무궁화 꽃은',
         'ABCDEFGHIJKLMN');

select * from temp04;  

select substr(col3,2,5) from temp04;

select dbms_lob.substr(col2,2,5) from temp04;    

select length(col3) as "데이터 길이",
       length(col2)
  from temp04;
select dbms_lob.getlength(col2) from temp04;

select to_char(sysdate, 'YYYY"년" MM"월" DD"일" AM')
  from dual;

    