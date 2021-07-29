2021-03-10-01)
  4) 인덱스 사용형식
  CREATE [UNIQUE|BITMAP] INDEX 인덱스명
     ON 테이블명(컬러명1,[,컬럼명2,...][ASC|DESC]);
    .'테이블'의 '컬럼'들을 기준으로 오름차순 또는 내림차순으로
      인덱스 생성.(기본은 ASC)
      
사용예) 사원테이블에서 사원명을 기준으로 인덱스를 생성하시오
CREATE INDEX IDX_EMP01
  ON EMPLOYEES(EMP_NAME);
  
CREATE INDEX INDEX_MEM01
  ON MEMBER(SUBSTR(MEM_REGNO2,4));
  
CREATE INDEX IDX_KOR_LOAN
  ON KOR_LOAN_STATUS(PERIOD, REGION);
  
SELECT * 
  FROM KOR_LOAN_STATUS
 WHERE PERIOD = '201111'; --인덱스 생성 효과가 거의 없음

SELECT * 
  FROM KOR_LOAN_STATUS
 WHERE PERIOD = '201111'
   AND REGION IN ('경남', '서울', '대전');  

 5) 인덱스의 재구성
   - 데이터의 삽입, 삭제, 갱신이 발생하면 인덱스는 재구성됨
   - 재구성은 WORK SPACE가 변경되거나 데이터의 삽입 삭제가 다수 발생된 직후
     REBUILD명령으로 수행
     (사용형식)
     ALTER INDEX 인덱스명 REBUILD;
     
ALTER INDEX IDX_KOR_LOAN REBUILD;     











