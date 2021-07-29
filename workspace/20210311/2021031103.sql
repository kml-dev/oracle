2021-03-11-03)
    2) WHILE문
      . 응용프로그램 개발언어의 WHILE과 유사
      (사용형식)
      WHILE 조건 LOOP
        반복처리문(들);
      END LOOP;
        - '조건'의 결과가 FALSE인 경우 반복을 벗어남
    사용예) 구구단의 4단을 출력하시오
    DECLARE
        V_CNT NUMBER:=1;
    BEGIN
        WHILE V_CNT <= 9 LOOP  
          DBMS_OUTPUT.PUT_LINE('4*'||V_CNT||'='||4*V_CNT);
          V_CNT:=V_CNT+1;
        END LOOP;
    END;    
    
DECLARE
    V_ID PROD.PROD_ID%TYPE;
    V_NAME PROD.PROD_NAME%TYPE;
    V_AQTY NUMBER:=0;
    V_AMON NUMBER:=0;
    CURSOR CUR_BUYPROD02
    IS
        SELECT BUY_PROD,
               PROD_NAME, 
               SUM(BUY_QTY),
               SUM(BUY_QTY * PROD_COST)
          FROM BUYPROD, PROD
         WHERE PROD_ID = BUY_PROD
           AND BUY_DATE BETWEEN '20050301' AND '20050331'
         GROUP BY BUY_PROD, PROD_NAME;   
BEGIN
    OPEN CUR_BUYPROD02;
    FETCH CUR_BUYPROD02 INTO V_ID, V_NAME, V_AQTY, V_AMON;
    WHILE CUR_BUYPROD02%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE('순번 : '||CUR_BUYPROD02%ROWCOUNT);
        DBMS_OUTPUT.PUT_LINE('제품명 : '||V_NAME);
        DBMS_OUTPUT.PUT_LINE('매입수량 : '||V_AQTY);
        DBMS_OUTPUT.PUT_LINE('매입금액 : '||V_AMON);
        DBMS_OUTPUT.PUT_LINE('-------------------------');
        FETCH CUR_BUYPROD02 INTO V_ID, V_NAME, V_AQTY, V_AMON;
    END LOOP;
    CLOSE CUR_BUYPROD02;
END; 

숙제] 첫날에 100원, 두 번째 날부터는 전날의 2배씩 저축을 하려 한다.
     최초로 100만원을 넘는 날은 며칠째고 그날까지 저축한 액수를
     구하시오(LOOP와 WHILE문으로 구성할 것)
     
DECLARE
    AMT NUMBER:=100;
    MON NUMBER:=100;
    CNT NUMBER:=1;
BEGIN
   LOOP
        MON:=MON*2;
        AMT:=AMT+(MON);
        CNT:=CNT+1;
        EXIT WHEN AMT > 1000000;
    END LOOP;     
    DBMS_OUTPUT.PUT_LINE('일 수 :'||CNT);
    DBMS_OUTPUT.PUT_LINE('저축금액 :'||AMT);
END; 

DECLARE
    AMT NUMBER:=100;
    MON NUMBER:=100;
    CNT NUMBER:=1;
BEGIN
    WHILE AMT < 1000000 LOOP
        MON:=MON*2;
        AMT:=AMT+(MON*2);
        CNT:=CNT+1;
    END LOOP;     
    DBMS_OUTPUT.PUT_LINE('일 수 :'||CNT);
    DBMS_OUTPUT.PUT_LINE('저축금액 :'||AMT);
END;
















        
        
        
