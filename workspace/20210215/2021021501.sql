2021-02-15-01) 자료형
2. 숫자자료형
  - number로 제공
  - 실수, 정수 모두 처리가능
  (사용형식)
  number[(정밀도|*[,스케일])]
  . 표현범위 : 10E-130 ~ 9.9999..9E125
  . 정밀도 : 전체자리수(1~38)
  . 스케일 : 소숫점이하의 자리수
  . '*'는 38자리 이내에서 사용자가 입력한 데이터를 저장할 수 있도록
    시스템이 자리를 확보
  . '스케일'이 생략되면 '0'으로 간주
  . 저장은 스케일+1번째 자리에서 반올림하여 '스케일'자리수까지 저장
  . '스케일'이 음수이면 정수부분에서 반올림이 수행
  
사용예)
  1) 정밀도 > 스케일
    . number;
    . number(*,3);
    . number(10,3);
    . number(10);
------------------------------------------------------------
    입력값             선언               저장값
------------------------------------------------------------
12345678.4567       number(10,2)      12345678.46
12345678.4567       number            12345678.4567
12345678.8567       number(10)        12345679
12345678.4567       number(*,2)       12345678.46
12345678.4567       number(9,2)       오류
  2) 정밀도 < 스케일
    . 정밀도는 '0'이 아닌 유효숫자의 갯수
    . [스케일 - 정밀도] : 소숫점이하에서 맨 처음에 존재하는 '0'의 갯수
    . 스케일 : 소숫점 이하의 자릿수
------------------------------------------------------------
    입력값             선언               저장값
------------------------------------------------------------
123.4567            number(2,4)         오류
0.23                number(3,5)         오류
0.023               number(2,3)         0.023
0.0023              number(2,4)         0.0023
0.0002345           number(3,6)         0.000235


3. 날짜형
  - 날짜자료(년, 월, 일, 시, 분, 초)
  - date(기본형), timestamp(time zone정보 처리)
  1) date
    . 기본 날짜형
    . '+'와 '-'연산이 가능 - 결과는 날짜형으로 반환
    (사용형식)
    컬럼명 date;
      - sysdate : 시스템이 제공하는 날짜데이터를 반환하는 함수
    
    (사용예)
    create table temp05(
        col1 date,
        col2 date,
        col3 date
    );
    
    insert into temp05
      values(sysdate,sysdate-20,sysdate+20);
    
    insert into temp05(col1,col2,col3)
      values(sysdate, '20201223',
             to_date('20210120102345','yyyymmddhh24miss'));
    
    select * from temp05;

    select * from temp05;
    select to_char(col1,'yyyy-mm-dd hh24:mi:ss'),
           to_char(col2,'yyyy-mm-dd hh24:mi:ss'),
           to_char(col3,'yyyy-mm-dd hh24:mi:ss')
      from temp05;
      
 2)timestamp
   . 시간대(time zone)정보와 10억분의 1초 단위의 정교한 시간 정보 저장
   (사용형식)
   컬럼명 timestamp; --시간대 정보 제공하지 않음
   컬럼명 timestamp with time zone;  -- 시간대정보(대륙명/도시명) 정보제공
   컬럼명 timestamp with local time zone; -- 서버가 설치된 시간대정보 제공.
                                         -- 보통 timestamp와 동일
사용예)
  create table temp06(
    col1 date,
    col2 timestamp,
    col3 timestamp with time zone,
    col4 timestamp with local time zone
  );
  
  insert into temp06
    values(sysdate, sysdate, sysdate, sysdate);
    
  select * from temp06
    

    
  
  
    