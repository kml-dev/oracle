2021-02-05)DDL(Data Definition languege) - 테이블 생성
 1. CREATE
   - 오라클 객체를 생성
   (테이블 생성 형식)
   CREATE TABLE 테이블명(
     컬럼명 데이터타입 [(크기)][default 값][NOT NULL]|[NULL]],
     컬럼명 데이터타입 [(크기)][default 값][NOT NULL]|[NULL]],
            :
     컬럼명 데이터타입 [(크기)][default 값][NOT NULL]|[NULL]][,]
     
     [constraint 기본키설정명 PRIMARY KEY(컬럼명[컬럼명[,컬럼명,...]])[,]]
     [constraint 외래키설정명 FOREIGN KEY(컬럼명[컬럼명[,컬럼명,...]])
       REFERENCES 테이블명(컬럼명[,컬럼명,...])[,]
     [constraint 외래키설정명 FOREIGN KEY(컬럼명[컬럼명[,컬럼명,...]])
       REFERENCES 테이블명(컬럼명[,컬럼명,...])];
       
     - '기본키설정명'과'외래키설정명'은 반드시 유일한 이름이어야함
     - '기본키설정명'은 보통 'pk_테이블명'으로 구성
     - '외래키설정명'은 보통 'fk_테이블명_참조테이블명'으로 구성
     