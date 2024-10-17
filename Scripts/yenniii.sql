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
  	  