CREATE TABLE department (
	deptno INTEGER NOT NULL,
	deptname VARCHAR(10),
	floor INTEGER,
	PRIMARY KEY (deptno)
);

INSERT INTO department VALUES(1, '영업', 8);
INSERT INTO department VALUES(2, '기획', 10);

SELECT *
	FROM department;

    -- 릴레이션 생성하기

    -- 고객 릴레이션 생성
    -- 고객 릴레이션은 고객아이디, 고객이름, 나이, 등급, 적립금 속성으로 구성된다.
	-- 고객아이디 속성이 기본키이다.
	-- 적립금 속성은 입력하지 않으면 0을 입력된다.

CREATE TABLE customer ( --SNAKE 표기법 사용
    customer_id	  VARCHAR(20) NOT NULL, --CUSTOMER_ID, customerId --> CUSTOMERID
    customer_name VARCHAR(10) NOT NULL,
    age 		  INTEGER,
    grade 		  VARCHAR(10) NOT NULL,
    job_title 	  VARCHAR(20),
    saved_money	  INTEGER DEFAULT 0,
    PRIMARY KEY (customer_id)
);

INSERT INTO customer
VALUES ('apple', '정소화', 20, 'gold', '학생', 1000);
INSERT INTO customer
VALUES ('banana', '김선우', 25, 'vip', '간호사', 2500);
INSERT INTO customer
VALUES ('carrot', '고명석', 28, 'gold', '교사', 4500);
INSERT INTO customer
VALUES ('orange', '김용욱', 22, 'silver', '학생', 0);
INSERT INTO customer
VALUES ('melon', '성원용', 35, 'gold', '회사원', 5000);
INSERT INTO customer
VALUES ('peach', '오형준', NULL, 'silver', '의사', 300);
INSERT INTO customer
VALUES ('pear', '채광주', 31, 'silver', '회사원', 500);

SELECT *
  FROM customer;

 
	-- 제품 릴레이션 생성
	-- 제품 릴레이션은 제품 번호, 제품명, 재고량, 단가, 제조업체 속성으로 구성된다.
	-- 제품번호 속성이 기본키이다.
	-- 재고량은 0개 이상, 10000개 이하이다.
 
CREATE TABLE product (
	product_no VARCHAR(5) NOT NULL,
	product_name VARCHAR(20),
	stock INTEGER ,
	unit_price INTEGER,
	manufacturer VARCHAR(20),
	PRIMARY KEY (product_no),
	CHECK (stock >= 0 AND stock <= 10000) -- 제약 조건
);

DROP TABLE product;

ALTER TABLE product ALTER column product_name TYPE VARCHAR(20);

INSERT INTO product
VALUES ('p01', '그냥만두', 5000, 4500, '대한식품');
INSERT INTO product
VALUES ('p02', '매운쫄면', 2500, 5500, '민국푸드');
INSERT INTO product
VALUES ('p03', '쿵떡파이', 3600, 2600, '한밭제과');
INSERT INTO product
VALUES ('p04', '맛난초콜릿', 1250, 2500, '한밭제과');
INSERT INTO product
VALUES ('p05', '얼큰라면', 2200, 1200, '대한식품');
INSERT INTO product
VALUES ('p06', '통통우동', 1000, 1550, '민국푸드');
INSERT INTO product
VALUES ('p07', '달콤비스킷', 1650, 1500, '한밭제과');

	-- 주문 릴레이션 생성
	-- 주문 릴레이션은 주문번호, 주문고객, 주문제품, 수량, 배송지, 주문일자 속성으로 구성된다.
	-- 주문번호 속성이 기본키이다.
	-- 주문고객 속성이 외래키이다. 

CREATE TABLE porder (
	order_no VARCHAR(5) NOT NULL,
	customer_id VARCHAR(20) NOT NULL,
	product_no VARCHAR(5) NOT NULL,
	quantity INTEGER,
	destination VARCHAR(30),
	order_date DATE,
	PRIMARY KEY (order_no),
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY (product_no) REFERENCES product(product_no)
);

INSERT INTO porder
VALUES ('o01', 'apple', 'p03', 10, '서울시 마포구', '2022-01-01');
INSERT INTO porder
VALUES ('o02', 'melon', 'p01', 5, '인천시 계양구', '2022-01-10');
INSERT INTO porder
VALUES ('o03', 'banana', 'p06', 45, '경기도 부천시', '2022-01-11');
INSERT INTO porder
VALUES ('o04', 'carrot', 'p02', 8, '부산시 금정구', '2022-02-01');
INSERT INTO porder
VALUES ('o05', 'melon', 'p06', 36, '경기도 용인시', '2022-02-20');
INSERT INTO porder
VALUES ('o06', 'banana', 'p01', 19, '충청북도 보은군', '2022-03-02');
INSERT INTO porder
VALUES ('o07', 'apple', 'p03', 22, '서울시 영등포구', '2022-03-15');
INSERT INTO porder
VALUES ('o08', 'pear', 'p02', 50, '강원도 춘천시', '2022-04-10');
INSERT INTO porder
VALUES ('o09', 'banana', 'p04', 15, '전라남도 목포시', '2022-04-11');
INSERT INTO porder
VALUES ('o10', 'carrot', 'p03', 20, '경기도 안양시', '2022-05-22');

-- INSERT INTO porder
-- VALUES ('o11', 'carrot', 'p11', 20, '경기도 안양시', '2022-05-22');


-- 릴레이션 삭제하기
DROP TABLE department;

-- 릴레이션 변경하기

-- 고객 릴레이션 가입날짜 추가
ALTER TABLE customer ADD join_date DATE; --COLUMN 속성 추가

-- 고객 릴레이션 가입날짜 삭제
ALTER TABLE customer DROP COLUMN join_date;

-- 새로운 제약 조건 추가
ALTER TABLE customer ADD CONSTRAINT chk_age CHECK(age >= 18); -- 제약 조건의 이름을 지정한 후 추가

-- 기존 제약 조건 삭제
ALTER TABLE customer DROP CONSTRAINT chk_age; -- 제약 조건의 이름을 통해 조건을 삭제함


-- 데이터 검색하기 : SELECT

-- 기본 검색

-- 1. 고객 릴레이션에서 고객아이디, 고객이름, 등급 속성을 검색하시오.
SELECT customer_id , customer_name, grade 
	FROM customer;

-- 2. 고객 릴레이션에서 모든 속성을 검색하시오.
 SELECT customer_id, customer_name, age, grade, job_title, saved_money 
  	FROM customer;

SELECT *
	FROM customer;

-- 3. 제품 릴레이션에서 제조업체 속성을 검색하시오.
-- 릴레이션 -> 집합 -> 중복이 없음 => 릴레이션 -> 릴레이션
SELECT manufacturer
	FROM product;

SELECT ALL manufacturer
	FROM product;

SELECT DISTINCT manufacturer
	FROM product;

-- 4. 제품 테이블에서 제품명과 단가를 검색하시오.
-- 단가(unit_price)를 가격이라는 새 이름으로 출력하시오.
SELECT product_name, unit_price AS "가격"
	FROM product;

-- 5. 제품 테이블에서 제품명과 단가를 검색하시오.
-- unit_price를 단가라는 새 이름으로 출력하시오.
-- 단가에 500원을 더한 "조정 단가"라는 새 이름으로 출력하시오. 
SELECT product_name, unit_price AS "단가", unit_price + 500 AS "조정 단가"
	FROM product;
	

-- 조건 검색

-- 6. 제품 테이블에서 한밭제과가 제조한 제품의 제품명, 재고량, 단가를 검색하시오.
SELECT product_name, stock, unit_price
  FROM product
 WHERE manufacturer = '한밭제과';


-- 7. apple 고객이 15개 이상 주문한 주문제품번호, 수량, 주문일자를 검색하시오.
SELECT product_no, quantity, order_date 
  FROM porder
 WHERE customer_id = 'apple'
   AND quantity >= 15;

 -- 7-2. apple 고객이 주문했거나, 15개 이상 주문한 고객아이디, 주문제품번호, 수량, 주문일자를 검색하시오.
SELECT customer_id, product_no, quantity, order_date 
  FROM porder
 WHERE customer_id = 'apple'
    OR quantity >= 15;

-- 8. 단가가 2000원 이상, 3000원 이하인 제품의 제품명, 단가, 제조업체를 검색하시오.
   SELECT product_name, unit_price, manufacturer
     FROM product
    WHERE unit_price >= 2000 AND unit_price <= 3000;
   
--BETWEEN
   SELECT product_name, unit_price, manufacturer
     FROM product
    WHERE unit_price BETWEEN 2000 AND 3000;
   
-- 9. 고객 테이블에서 '김선우' 고객의 고객이름, 나이, 등급, 적립금을 검색하시오.
   SELECT customer_name, age, grade, saved_money
     FROM customer
    WHERE customer_name = '김선우';
   
-- 9-2. 고객 테이블에서 '김선우' 또는 '김용욱' 고객의 고객이름, 나이, 등급, 적립금을 검색하시오.
   SELECT customer_name, age, grade, saved_money
     FROM customer
    WHERE customer_name = '김선우' OR customer_name = '김용욱';
   
   SELECT *
     FROM customer;

-- LIKE
-- 9-3. 고객 테이블에서 성이 '김'씨인 고객의 고객이름, 나이, 등급, 적립금을 검색하시오.
   SELECT customer_name, age, grade, saved_money
     FROM customer
    WHERE customer_name LIKE '김%'; --김인 걸 모두 찾음.
   
   SELECT customer_name, age, grade, saved_money
     FROM customer
    WHERE customer_name LIKE '김_'; --첫번째 글자가 김, 두번째 글자는 _ (외자)
    
   SELECT customer_name, age, grade, saved_money
     FROM customer
    WHERE customer_name LIKE '김__'; --김__의 이름(외자는 못 찾음)

-- 이름에 '용'이 들어가는 고객 
    SELECT *
     FROM customer; --'김용욱', '성원용'
    
    SELECT customer_name 
      FROM customer
     WHERE customer_name LIKE '%용%'; --권장하지 않는 방법
 
-- 10. 고객아이디가 5자인 고객의 아이디, 이름, 등급을 검색하시오.
	SELECT customer_id, customer_name, grade
  	  FROM customer
  	 WHERE customer_id LIKE '______'; --밑줄 다섯개
   
  	 
-- 11. 고객 테이블에서 나이가 입력되지 않은 고객의 이름을 검색하시오.
-- NULL : 값없음, 아직 입력되지 않음, 모름, ...
  	 SELECT customer_name
  	   FROM customer 
  	  WHERE age IS NULL;
  	 
-- 12. 고객 테이블에서 나이가 입력되지 않은 고객의 이름을 검색하시오.
  	 SELECT customer_name
  	   FROM customer 
  	  WHERE age IS NOT NULL; 	 
  	 
  	 SELECT customer_name
  	   FROM customer 
  	  WHERE age NOTNULL; -- 쓰지마세요

-- 정렬 검색
  	  
-- 13. 고객 테이블에서 이름, 등급, 나이를 검색하시오.
-- 나이의 내림차순으로 정렬하시오.
  	  SELECT customer_name, grade, age
  	    FROM customer
  	   ORDER BY age DESC;
  	   
-- 14.수량이 10개 이상인 주문의 주문고객아이디, 주문제품번호, 수량, 주문일자를 검색하시오.
-- 제품번호 순으로 정렬하시오.
-- 동일 제품의 경우 주문 수량의 내림차순으로 정렬하시오.
  	  SELECT customer_id, product_no, quantity, order_date
  	    FROM porder
  	   WHERE quantity >= 10
  	   ORDER BY product_no ASC, quantity DESC;
  	  
-- 집계 함수
-- 15. 제품테이블에서 모든 제품의 평균 단가를 구하시오.
	SELECT AVG(unit_price)
	  FROM product;
	 
	 
-- 16. 한밭제과가 제조한 제품의 재고량을 검색하시오.
	 --SELECT SUM(stock) AS "재고량합계"
	 SELECT SUM(stock) AS sum_stock
	   FROM product
	  WHERE manufacturer = '한밭제과';
	  
-- 17. 고객 테이블에 고객이 몇 명 등록되어 있는지 검색하시오. -> COUNT
	 SELECT COUNT(customer_id)
	   FROM customer;
	  
	 SELECT COUNT(customer_name)
	   FROM customer;
	
	 SELECT COUNT(age)
	   FROM customer;
	  
	 SELECT COUNT(*) -- 가장 많이 쓰는 표현
	   FROM customer;
	 
     SELECT COUNT(1) -- 튜플의 개수를 세는 또다른 방식.
       FROM customer;
       
-- 18. 제품테이블에서 제조업체 수를 검색하시오.
      SELECT COUNT(manufacturer)
        FROM product;
       
      SELECT COUNT(DISTINCT manufacturer) AS "제조업체수" -- 중복을 제거한 카운트. 연습 필요.
        FROM product;
        
-- 19. 주문테이블에서 주문 수량의 합계를 검색하시오.
       SELECT SUM(quantity)
         FROM porder;
        
-- 19-1. 주문테이블에서 주문 제품별 주문 수량의 합계를 검색하시오.
       SELECT product_no, SUM(quantity)
         FROM porder
     GROUP BY product_no
     ORDER BY product_no;
        
-- 20. 제품 테이블에서 제조업체별로 제조한 제품의 개수와 최고가를 검색하시오.
    SELECT manufacturer, COUNT(*) AS "제품수", MAX(unit_price) AS "최고가"
      FROM product
     GROUP BY manufacturer;
  
-- 21. 제품 테이블에서 제조업체별로 제조한 제품의 개수와 최고가를 검색하시오.
 -- 제품의 개수가 3개 이상인 것만 포함 -> 그룹화를 한 결과에 대해 조건을 붙이는 것. -> HAVING
    SELECT manufacturer, COUNT(*) AS "제품수", MAX(unit_price) AS "최고가"
      FROM product
     GROUP BY manufacturer
    HAVING COUNT(*) >= 3; -- 여기엔 별명 못 붙임!
    
-- 22. 고객테이블에서 적립금 평균이 1000원 이상인 등급에 대해
 -- 등급별 고객수와 적립금 평균을 검색하시오.
    SELECT grade, COUNT(*) AS "고객수", AVG(saved_money)
      FROM customer
     GROUP BY grade
    HAVING AVG(saved_money) >= 1000;
   
-- 23. 주문테이블에서 각 고객이 주문한 제품의 총 주문수량을 검색하시오.
    SELECT customer_id, SUM(quantity) AS "총주문수량"
      FROM porder
     GROUP BY customer_id;
    
-- 23-1. 주문테이블에서 각 고객이 주문한 제품	별의 총 주문수량을 검색하시오.
    SELECT customer_id, product_no, SUM(quantity) AS "총주문수량"
      FROM porder
     GROUP BY customer_id, product_no
     ORDER BY customer_id, product_no; -- 결과를 한 눈에 보자.
     
    SELECT product_no, customer_id, SUM(quantity) AS "총주문수량"
      FROM porder
     GROUP BY product_no, customer_id -- 순서 바뀌어도 상관없음. 통채로 묶어서 처리하기 때문
     ORDER BY product_no, customer_id; -- 순서가 의미가 있음. 앞에 있는 제품 번호를 먼저 정렬한 후 고객 아이디로 정렬.
     
 -- 조인 검색
 
 -- 24. banana 고객이 주문한 제품의 이름을 검색하시오.
     SELECT product_name
       FROM porder, product
      WHERE porder.product_no = product.product_no -- 조인 조건
        AND customer_id = 'banana'; -- 일반 검색 조건
        
 -- 25. 나이가 30세 이상인 고객이 주문한 제품의 주문제품번호와 주문일자를 검색하시오.
     SELECT customer_name, product_no, order_date
       FROM customer, porder
      WHERE customer.customer_id = porder.customer_id
        AND age >= 30;
        
-- 테이블 이름 명시
	 SELECT customer.customer_name, porder.product_no, porder.order_date
       FROM customer, porder
      WHERE customer.customer_id = porder.customer_id
        AND customer.age >= 30;

-- 약자를 사용 / 룰은 없으나 테이블명 첫글자를 쓰는 사례가 많음
	 SELECT C.customer_name, PO.product_no, PO.order_date
       FROM customer C, porder PO --중복이 있어 PO로. 또는 O
      WHERE C.customer_id = PO.customer_id
        AND C.age >= 30;
        
-- 25. 나이가 30세 이상인 고객이 주문한 제품의 
-- 고객명, 주문제품명과 주문일자를 검색하시오.
      SELECT C.customer_name, P.product_name, O.order_date 
        FROM customer C, porder O, product P
       WHERE C.customer_id = O.customer_id
         AND O.product_no = P.product_no 
         AND C.age >= 30;
      
-- 자체조인(셀프조인, self join)

ALTER TABLE customer ADD recommender VARCHAR(20);

ALTER TABLE customer ADD CONSTRAINT chk_recommender
	FOREIGN KEY (recommender) REFERENCES customer(customer_id);

UPDATE customer
   SET recommender = 'orange'
 WHERE customer_id = 'apple';

-- 27. 고객과 추천인의 이름을 검색하시오. (자체 조인)
SELECT C.customer_name AS "고객이름", R.customer_name AS "추천인이름"
  FROM customer C, customer R -- 자체 조인에서는 별명 필수
 WHERE C.recommender = R.customer_id;

-- 삭제
ALTER TABLE customer DROP CONSTRAINT chk_recommender;
ALTER TABLE customer DROP COLUMN recommender;

-- INNER JOIN
-- 28. 나이가 30세 이상인 고객이 주문한 제품의 주문제품번호와 주문일자를 검색하시오.

SELECT C.customer_name, O.product_no, O.order_date
  FROM customer C
  	   INNER JOIN porder O ON C.customer_id  = O.customer_id -- 연결할 것을 명시.
 WHERE C.age >= 30;

-- 외부 조인(OUTER JOIN)
-- 29. 주문하지 않은 고객을 포함해서
-- 주문 고객이름, 주문제품번호, 주문일자를 검색하시오.
 SELECT C.customer_name, O.product_no, O.order_date
  FROM customer C --방향 설정 필요. 왼쪽을 종종 씀.
  	   LEFT OUTER JOIN porder O ON C.customer_id  = O.customer_id;
  	 
-- 같은 결과. 오른쪽 외부 조인 
 SELECT C.customer_name, O.product_no, O.order_date
  FROM porder O 
  	   RIGHT OUTER JOIN customer C ON C.customer_id  = O.customer_id;

-- 같은 결과. FULL 외부 조인. 거의 안 씀. 성능 저하 이
--SELECT C.customer_name, O.product_no, O.order_date
--  FROM porder O 
--  	   FULL OUTER JOIN customer C ON C.customer_id  = O.customer_id;

  	  
-- 부속질의(subquery)
-- 30. 달콤비스킷을 생산한 제조업체가 만든 제품들의 제품명과 단가를 검색하시오.
-- 30-1. 달콤비스킷을 생산한 제조업체 명을 검색하시오.
SELECT manufacturer 
  FROM product
 WHERE product_name = '달콤비스킷';
 
-- 30-2. 한밭제과가 제조한 제품들의 제품명과 단가를 검색하시오.
SELECT product_name, unit_price
  FROM product
 WHERE manufacturer = '한밭제과';
 
-- 30-3. 달콤비스킷을 생산한 제조업체가 만든 제품들의 제품명과 단가를 검색하시오.
SELECT product_name, unit_price
  FROM product
 WHERE manufacturer = (SELECT manufacturer 
  						 FROM product
 						WHERE product_name = '달콤비스킷');
 						
-- 31. 적립금이 가장 많은 고객의 고객 이름과 적립금을 검색하시오.
-- 31-1. 가장 많은 적립금을 검색하시오.
SELECT MAX(saved_money)
  FROM customer;
 
-- 31-2. 고객 이름과 적립금을 검색하시오.
SELECT customer_name, saved_money
  FROM customer;

SELECT customer_name, saved_money
  FROM customer
 WHERE saved_money = (SELECT MAX(saved_money)
  FROM customer);
  
-- 32. banana 고객이 주문한 제품의 제품명과 제조업체를 검색하시오.
-- 부속질의를 사용할 것
 
-- 32-1. banana 고객이 주문한 제품의 제품번호를 검색하시오.
SELECT product_no 
  FROM porder
 WHERE customer_id = 'banana';
 
-- 32-3. banana 고객이 주문한 제품의 제품명과 제조업체를 검색하시오.
SELECT product_name, manufacturer
  FROM product
 WHERE product_no IN (SELECT product_no 
  					   FROM porder
 	 				  WHERE customer_id = 'banana');

-- 33. banana 고객이 주문하지 않은 제품의 제품명과 제조업체를 검색하시오.
SELECT product_name, manufacturer
  FROM product
 WHERE product_no NOT IN (SELECT product_no 
  					   FROM porder
 	 				  WHERE customer_id = 'banana');
 	 				 
-- 34. 대한식품이 제조한 모든 제품의 단가보다 비싼 제품의
-- 제품명, 단가, 제조업체를 검색하시오.
 	 				 
-- 대한식품이 제조한 제품의 단가를 검색하시오.
SELECT unit_price
  FROM product
 WHERE manufacturer = '대한식품';

-- 34. 대한식품이 제조한 모든 제품의 단가보다 비싼 제품의 제품명, 단가, 제조업체를 검색하시오.
SELECT product_name, unit_price, manufacturer
  FROM product
 WHERE unit_price > ALL (SELECT unit_price
  					    FROM product
 					   WHERE manufacturer = '대한식품');

-- 35. 2022년 3월 15일에 제품을 주문한 고객의 고객이름을 검색하시오.
-- 상관 중첩 질의 (correlated nested query)
SELECT *
  FROM porder
 WHERE order_date = '2022-03-15';

SELECT customer_name
  FROM customer
 WHERE EXISTS (SELECT *
  FROM porder
 WHERE order_date = '2022-03-15'
   AND porder.customer_id = customer.customer_id);
 
 
 	 				 