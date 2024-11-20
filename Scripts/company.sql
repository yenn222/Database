DROP TABLE works_for;
DROP TABLE project;
DROP TABLE employee;
DROP TABLE department;


-- I1. DEPARTMENT 릴레이션을 생성하고 주어진 데이터를 삽입하시오.

CREATE TABLE department
(
    deptno   INTEGER       NOT NULL,
    deptname VARCHAR(10) NOT NULL,
    floor    INTEGER       NOT NULL,
    PRIMARY KEY (deptno)
);

INSERT INTO department(deptno, deptname, floor)
VALUES (1, '영업', 8);
INSERT INTO department(deptno, deptname, floor)
VALUES (2, '기획', 10);
-- postgresql에서 제공하는 문법 ,로 나열을 해 여러개 한번에 INSERT 가능.
-- 키 충돌이나 올바르지 않은 조건 사용 조심해야함.
INSERT INTO department(deptno, deptname, floor)
VALUES (3, '개발', 9)
      ,(4, '총무', 7);


-- I2. EMPLOYEE 릴레이션을 생성하고 주어진 데이터를 삽입하시오.

CREATE TABLE employee
(
    empno    INTEGER       NOT NULL,
    empname  VARCHAR(10) NOT NULL,
    title    VARCHAR(10) NOT NULL,
    manager  INTEGER, -- 사원 아이디
    salary   INTEGER       NOT NULL, --급여
    hiredate DATE         NOT NULL, -- 고용일
    dno      INTEGER       NOT NULL, -- 부서 번호
    PRIMARY KEY (empno),
    FOREIGN KEY (manager) REFERENCES employee (empno),
    FOREIGN KEY (dno) REFERENCES department (deptno)
);

INSERT INTO employee(empno, empname, title, salary, hiredate, dno)
VALUES (4377, '이성래', '사장', 5000000, '1996-01-05', 2);
INSERT INTO employee(empno, empname, title, manager, salary, hiredate, dno)
VALUES (3228, '김주훈', '부장', 4377, 4000000, '1997-03-06', 2);
INSERT INTO employee(empno, empname, title, manager, salary, hiredate, dno)
VALUES (3011, '이수민', '부장', 4377, 4300000, '1996-04-30', 3);
INSERT INTO employee(empno, empname, title, manager, salary, hiredate, dno)
VALUES (1234, '장건호', '부장', 4377, 4200000, '1996-11-23', 1);
INSERT INTO employee(empno, empname, title, manager, salary, hiredate, dno)
VALUES (3426, '박영권', '과장', 1234, 3000000, '1998-07-20', 1);
INSERT INTO employee(empno, empname, title, manager, salary, hiredate, dno)
VALUES (2468, '조범수', '과장', 3011, 3500000, '1998-12-17', 3);
INSERT INTO employee(empno, empname, title, manager, salary, hiredate, dno)
VALUES (2106, '김창섭', '대리', 3228, 2500000, '2000-03-05', 2);
INSERT INTO employee(empno, empname, title, manager, salary, hiredate, dno)
VALUES (1003, '조민희', '대리', 2468, 2600000, '2001-02-19', 2);
INSERT INTO employee(empno, empname, title, manager, salary, hiredate, dno)
VALUES (2544, '오준석', '대리', 2468, 2700000, '2001-08-25', 3);
INSERT INTO employee(empno, empname, title, manager, salary, hiredate, dno)
VALUES (3427, '최종철', '주니어', 1003, 1500000, '2005-10-28', 3);
INSERT INTO employee(empno, empname, title, manager, salary, hiredate, dno)
VALUES (1365, '김상원', '주니어', 3426, 1600000, '2004-02-26', 1);
INSERT INTO employee(empno, empname, title, manager, salary, hiredate, dno)
VALUES (1099, '이재원', '주니어', 3426, 1800000, '2003-12-21', 2);


-- I3. PROJECT 릴레이션을 생성하고 주어진 데이터를 삽입하시오.
-- 회사에서 운영 중인 프로젝트
CREATE TABLE project
(
    projno   INTEGER       NOT NULL,
    projname VARCHAR(30) NOT NULL,
    budget   INTEGER       NOT NULL, -- 예산
    manager  INTEGER       NOT NULL, -- 프로젝트 관리자 아이디
    PRIMARY KEY (projno),
    FOREIGN KEY (manager) REFERENCES employee (empno)
);

INSERT INTO project(projno, projname, budget, manager)
VALUES (1, '새로운 서비스', 150000000, 3228);
INSERT INTO project(projno, projname, budget, manager)
VALUES (2, '차세대 스마트팜', 500000000, 3011);
INSERT INTO project(projno, projname, budget, manager)
VALUES (3, '잘 팔아보세', 200000000, 1234);


-- I4. WORKS_FOR 릴레이션을 생성하고 주어진 데이터를 삽입하시오.

CREATE TABLE works_for
(
    empno     INTEGER NOT NULL, -- 해당 사원이
    projno    INTEGER NOT NULL, -- 해당 프로젝트를
    startdate DATE   NOT NULL, -- 이 시간부터 사용하고 있음
    PRIMARY KEY (empno, projno),
    FOREIGN KEY (empno) REFERENCES employee (empno),
    FOREIGN KEY (projno) REFERENCES project (projno)
);

INSERT INTO works_for(empno, projno, startdate)
VALUES (2106, 1, '2021-01-01');
INSERT INTO works_for(empno, projno, startdate)
VALUES (2468, 2, '2021-03-01');
INSERT INTO works_for(empno, projno, startdate)
VALUES (2544, 2, '2021-03-01');
INSERT INTO works_for(empno, projno, startdate)
VALUES (1003, 2, '2021-03-01');
INSERT INTO works_for(empno, projno, startdate)
VALUES (3427, 2, '2021-03-01');
INSERT INTO works_for(empno, projno, startdate)
VALUES (1003, 3, '2021-03-01');
INSERT INTO works_for(empno, projno, startdate)
VALUES (3426, 3, '2021-01-01');
INSERT INTO works_for(empno, projno, startdate)
VALUES (1365, 3, '2021-01-01');
INSERT INTO works_for(empno, projno, startdate)
VALUES (1099, 3, '2021-01-01');


SELECT *
  FROM employee;
SELECT *
  FROM department;
SELECT *
  FROM works_for;
SELECT *
  FROM project;
  
 
-- Q1. 전체 부서의 모든 애트리뷰트들을 검색하시오.
SELECT *
  FROM employee;

-- Q2. DEPARTMENT 릴레이션에서 부서 이름과 부서 번호를 검색하시오.
SELECT deptno, deptname
   FROM department;
   
-- Q3. EMPLOYEE 릴레이션에서 직급을 검색하시오.
SELECT DISTINCT title
  FROM employee;
 
-- Q4. 3번 부서에서 근무하는 모든 사원들의 이름과 직급을 검색하시오.
SELECT empname, title
  FROM employee
 WHERE dno = 3;

-- Q5. 직급이 과장인 모든 사원들의 이름을 검색하시오.
SELECT empname
  FROM employee
 WHERE title = '과장';

-- Q6. 2000년 2월 1일 이후에 입사한 모든 사원들의 이름과 입사일을 검색하시오.
SELECT empname, hiredate
  FROM employee
 WHERE hiredate > '2000-02-01';

-- Q7. 직급이 과장이 아닌 모든 사원들의 이름과 직급을 검색하시오.
SELECT empname, title
  FROM employee
 WHERE NOT title = '과장';

-- Q8. 부서 2에 근무하면서 매월 250만원보다 많은 급여를 받는 모든 사원들의 이름, 직급, 급여를 검색하시오.
SELECT empname, title, salary 
  FROM employee
 WHERE dno = 2
   AND salary > 2500000;
  
-- Q9. 급여가 200만원 이상, 300만원 이하인 모든 사원들의 이름, 직급, 급여를 검색하시오.
SELECT empname, title, salary 
  FROM employee
 WHERE salary >= 2000000 AND salary <= 3000000;

-- Q10. 직급이 과장이 아니면서 급여가 300만원보다 많은 모든 사원들의 이름, 직급, 급여를 검색하시오.
SELECT empname, title, salary 
  FROM employee
 WHERE NOT title = '과장'
   AND salary > 3000000;
  
-- Q11. 직급이 대리이거나 과장이거나 부장인 모든 사원들의 이름, 직급, 부서 번호를 검색하시오.
SELECT empname, title, dno
  FROM employee
 WHERE title = '대리' OR title = '과장';

-- Q12. 직급이 과장인 사원들에 대하여 이름과, 현재의 급여, 급여가 10% 인상됐을 때의 값을 검색하시오.
SELECT empname, salary AS "현재 급여", salary * 1.1 AS "인상 급여" 
  FROM employee
 WHERE title = '과장';


-- Q13. 김씨 성을 가진 모든 사원들의 이름과 직급을 검색하시오.
SELECT empname, title
  FROM employee
 WHERE empname LIKE '김%';

-- Q14. 직속 상사가 없는, 직급이 가장 높은 사원의 이름과 직급을 검색하시오.
SELECT empname,title
  FROM employee
 WHERE manager IS NULL;

-- Q15. 모든 사원들의 급여와 이름을 검색하여 급여에 따라 내림차순으로 정렬하라.
SELECT salary, empname
  FROM employee
 ORDER BY salary DESC;

-- Q16. 모든 사원들의 부서번호, 급여와 이름을 검색하여 부서번호에 대해서는 오름차순, 급여에 대해서는 내림차순으로 정렬하라.
SELECT dno, salary, empname 
  FROM employee
 ORDER BY dno ASC, salary DESC;

-- Q17. 모든 사원의 평균 급여와 최대 급여를 검색하시오.
SELECT AVG(salary) AS "평균 급여", MAX(salary) AS "최대 급여"
  FROM employee;

-- Q18. 3번 부서에 근무하는 사원들의 수와 평균 급여를 검색하시오.
SELECT COUNT(empname) AS "사원 수", AVG(salary) AS "평균 급여"
  FROM employee
 WHERE dno = 3;

-- Q19. 모든 사원들에 대해서 사원들이 속한 부서번호별로 그룹화하고, 각 부서마다 부서번호, 평균 급여와 최대 급여를 검색하시오.
SELECT dno, AVG(salary) AS "평균 급여", MAX(salary) AS "최대 급여"
  FROM employee
  GROUP BY dno;
 
-- Q20. 모든 사원들에 대해서 사원들이 속한 부서번호별로 그룹화하고,
-- 평균 급여가 2,500,000원 이상인 부서에 대하여 부서번호, 평균 급여와 최대 급여를 검색하시오.
SELECT AVG(salary) AS "평균 급여", MAX(salary) AS "최대 급여"
  FROM employee
 GROUP BY dno
 HAVING AVG(salary) >= 2500000;

-- Q21. 부서에 속한 직원들의 급여의 합계가 1000만원 이상, 1500만원 이하인 부서에 대해서 부서별로 부서번호와 급여의 합계를 검색하시오.
SELECT dno, SUM(salary)
  FROM employee 
 GROUP BY dno
 HAVING SUM(salary) >= 10000000 AND SUM(salary) <= 15000000

-- Q22. 김창섭이 속한 부서이거나 개발 부서의 부서번호를 검색하시오.
SELECT DISTINCT dno
  FROM employee e, department d
 WHERE e.empname = '김창섭' OR d.deptname = '개발';

-- Q22. 모든 사원의 이름과 이 사원이 속한 부서 이름을 검색하시오.
SELECT empname, deptname
  FROM employee e, department d
 WHERE e.dno = d.deptno;

-- Q23. 모든 사원들에 대해서 사원 이름과 근무하는 부서의 층을 검색하시오.
SELECT empname, floor
  FROM employee e , department d 
  WHERE e.dno = d.deptno;


-- Q24. 개발 부서에 근무하는 모든 사원들에 대해서 이름과 직급을 검색하시오.
SELECT empname, title
  FROM employee e, department d 
 WHERE e.dno = d.deptno
   AND deptname = '개발';
  
-- Q25. 모든 사원에 대해서 사원의 이름과 직속 상사의 이름을 검색하시오. (상사가 없는 사원도 포함)
SELECT E.empname AS employee_name, M.empname AS manager_name
FROM employee E
LEFT JOIN employee M 
ON E.manager = M.empno;
 
-- Q26. 모든 사원들에 대해서 소속 부서이름, 사원의 이름, 직급, 급여를 검색하시오.
SELECT deptname, empname, title, salary
  FROM employee e, department d
 WHERE e.dno = d.deptno;

-- Q27. 모든 사원들에 대해서 소속 부서이름, 사원의 이름, 직급, 급여를 검색하시오.
-- 부서 이름에 대해서 오름차순, 부서이름이 같은 경우에는 SALARY에 대해서 내림차순으로 정렬하라.
SELECT deptname, empname, title, salary
  FROM employee e, department d
 WHERE e.dno = d.deptno
 ORDER BY deptname ASC, salary DESC;

-- Q28. 영업부나 개발부에 근무하는 사원들의 이름을 검색하시오.
SELECT empname
  FROM employee e, department d 
 WHERE e.dno = d.deptno
   AND d.deptname = '영업' OR d.deptname = '개발';
  
-- Q29. 김상원과 같은 부서에 근무하는 사원들의 이름과 직급을 검색하시오.
SELECT empname, title
  FROM employee
 WHERE dno = (SELECT dno
   	 			FROM employee
   			WHERE empname = '김상원');
   				
-- Q30. 전체 사원들의 평균 급여보다 많이 받는 사원들의 이름, 급여, 평균급여를 검색하시오.
-- 같이 푸는 문제. 추가 설명 필요함.
SELECT empname, salary, ROUND((SELECT AVG(salary) FROM employee), 2) AS "평균 급여"
  FROM employee
 WHERE salary > (SELECT AVG(salary) FROM employee);

-- Q31. 소속 사원이 한 명도 없는 부서에 대해서 부서 번호, 부서 이름, 층을 검색하시오.
SELECT deptno, deptname, floor
FROM department
WHERE deptno NOT IN (SELECT dno FROM employee);

  
-- Q32. 조민희가 참여하고 있는 프로젝트의 이름과 예산을 검색하시오.
SELECT wf.projno, p.budget 
  FROM works_for wf, employee e , project p 
 WHERE wf.empno = e.empno
   AND wf.projno = p.projno 
   AND e.empname LIKE '조민희';

-- Q33. 모든 사원의 이름과 부서이름, 그리고 직속상사 이름을 출력하시오.
SELECT e.empname , d.deptname, m.empname AS manager_name
FROM employee e
JOIN department d
ON e.dno = d.deptno
LEFT JOIN employee m
ON e.manager = m.empno;

-- Q34. 프로젝트 번호 2와 3에 모두 속한 사원의 이름을 출력하시오.
SELECT e.empname
  FROM employee e
  JOIN works_for w
	ON e.empno = w.empno;
   AND w.projno = 2 AND w.projno = 3;
  
-- U1. EMPLOYEE 릴레이션에서 급여가 3,000,000원 이상인 사원들의 이름, 직급, 급여를 검색하여 HIGH_SALARY라는 릴레이션에 삽입하라.
--     HIGH_SALARY 릴레이션은 이미 생성되어 있다고 가정한다.
  
CREATE TABLE high_salary
(
    empname VARCHAR(10) NOT NULL,
    title   VARCHAR(10) NOT NULL,
    salary  INT         NOT NULL
);

INSERT
  INTO high_salary(empname, title, salary)
 SELECT empname, title, salary
   FROM employee
  WHERE salary > 3000000;


-- U2. 사원번호가 2106인 사원의 소속 부서를 3번 부서로 옮기고, 급여를 5% 올려라.
 UPDATE employee 
    SET dno = 3, salary = salary * 1.05
   WHERE empno = 2106;