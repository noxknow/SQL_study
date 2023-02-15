# 칼럼 출력 SQL 작성하기

> ||는 mysql이 아니라 oracle에서 사용하는 문자 합성 연산자.
> 

## FORMAT

```sql
create database ncs;
show databases;
use ncs;

create table emp_test (
	empNo decimal(4) primary key,
    eName varchar(10) not null,
    hireDate date,
    sal decimal(7,2),
    comm decimal(7,2),
    deptNo decimal(2)
);
show tables;
desc emp_test;

create table dept_test (
	deptNo decimal(2) primary key,
    dName varchar(20) Not Null,
    loc varchar(13)
);
show tables;
desc dept_test;

INSERT INTO EMP_TEST VALUES (1001,'이승기', '2020-01-01', 800, NULL, 20);
INSERT INTO EMP_TEST VALUES (1002,'최경주', '2021-03-01',1600, NULL, 30);
INSERT INTO EMP_TEST VALUES (1003,'김광현', '2001-04-01', 1200, NULL,30);
INSERT INTO EMP_TEST VALUES (1004,'양의지', '2000-08-01', 2900, NULL,20);
INSERT INTO EMP_TEST VALUES (1005,'이경규', '2010-09-01', 1200, NULL,30);
INSERT INTO EMP_TEST VALUES (1006,'이승엽', '2011-01-01', 2800, NULL,30);
INSERT INTO EMP_TEST VALUES (1007,'나대표', '2010-10-01', 2400, NULL,10);
INSERT INTO EMP_TEST VALUES (1008,'유현주', '2019-09-01', 3000, NULL,20);
INSERT INTO EMP_TEST VALUES (1009,'김미현', '1997-01-01', 5000, NULL, 10);
INSERT INTO EMP_TEST VALUES (1010,'원태인' ,'2000-11-01', 1500, NULL, 30);
select * from emp_test;

INSERT INTO DEPT_TEST VALUES (10, '회계팀', '서울') ;
INSERT INTO DEPT_TEST VALUES (20, '마케팅팀', '인천');
INSERT INTO DEPT_TEST VALUES (30, '영업팀', '부산');
INSERT INTO DEPT_TEST VALUES (40, '상품정보팀', '대구');
INSERT INTO DEPT_TEST VALUES (50, '총무팀', '서울');
select * from dept_test;

select empno, eName, deptno from emp_test;
select empno 사원번호, ename 이름, sal 급여, deptno 부서번호 from emp_test;
select concat(ename, '의 30% 인상된 급여는', sal * 1.3, '달러 입니다.') from emp_test;
# select ename + '의 30% 인상된 급여는' + (sal * 1.3) + '달러 입니다.' from emp_test;
# select ename || '의 30% 인상된 급여는' || (sal * 1.3) || '달러 입니다.' from emp_test;

select ename 이름, concat('$', format(sal, 2)) 급여, 
	datediff('2021-08-01', hiredate) 근무일수 from emp_test;

급여    --> 이런식으로 format 된다.
$800.00
$1,600.00
```

---

## ROUND

```sql
집계 합수와 그룹 함수를 통해 부서별 인원수와 급여의 최소, 최대, 평균값을 칼럼으
로 추출하는 SQL을 실행한다

select deptno 부서번호, count(*) 인원수, min(sal) 최소급여, max(sal) 최대급여, round(avg(sal)) 평균급여
	from emp_test group by deptno order by deptno desc;

부서번호, 인원수, 최소급여, 최대급여, 평균급여
	30	     5	    1200.00	  2800.00 	1660
	20	     3	    800.00	  3000.00 	2233
	10	     2	    2400.00  	5000.00 	3700
```

---

## IFNULL, NULLIF

```sql
칼럼값이 NULL인 경우, NULL 관련 함수를 통해 다른 값으로 대체하여 출력하는 SQL을 
실행한다. 다음은 NVL 함수를 이용하여 COMM(보너스) 칼럼이 NULL인 경우 0으로 
대체하였고, NULLIF 함수를 이용하여 DEPTNO(부서코드)가 20인 경우 NULL로 그 
외는 부서코드를 그대로 출력하는 SQL을 실행한다

select ename 사원이름, sal 급여, comm 보너스1, ifnull(comm, 0) 보너스2, 
	deptno 부서1, nullif(deptno, 20) 부서2 from emp_test;
```

---

## JOIN

```sql
select e.empno, e.ename, e.sal, e.deptno, d.dname
	from emp_test e inner join dept_test d on e.deptno = d.deptno;

empno, ename, sal, deptno, dname
1001	이승기	800.00	20	마케팅팀
1002	최경주	1600.00	30	영업팀
1003	김광현	1200.00	30	영업팀
1004	양의지	2900.00	20	마케팅팀
1005	이경규	1200.00	30	영업팀
1006	이승엽	2800.00	30	영업팀
1007	나대표	2400.00	10	회계팀
1008	유현주	3000.00	20	마케팅팀
1009	김미현	5000.00	10	회계팀
1010	원태인	1500.00	30	영업팀

select e.empno, e.ename, e.sal, e.deptno, d.dname
	from emp_test e right outer join dept_test d on e.deptno = d.deptno;

empno, ename, sal, deptno, dname
1009	김미현	5000.00	10	회계팀
1007	나대표	2400.00	10	회계팀
1008	유현주	3000.00	20	마케팅팀
1004	양의지	2900.00	20	마케팅팀
1001	이승기	800.00	20	마케팅팀
1010	원태인	1500.00	30	영업팀
1006	이승엽	2800.00	30	영업팀
1005	이경규	1200.00	30	영업팀
1003	김광현	1200.00	30	영업팀
1002	최경주	1600.00	30	영업팀
				                  상품정보팀
	                  	 		총무팀

inner join 일 때는 emp_test에 40과 50이 없어서 상품정보팀과 총무팀이 나오지 않지만, 
right outer join을 이용하면 dept_test에 있는 상품정보팀과 총무팀도 나오게 된다.

emp_test에 한명을 더 추가하고 left outer join한다면

insert into emp_test(empno, ename, sal) 
	values (2001, "나신입", 10);
select * from emp_test;

select e.empno, e.ename, e.sal, d.deptno, d.dname, d.loc
	from emp_test as e left outer join dept_test d 
		on e.deptno = d.deptno;

empno, ename, sal, deptno, dname, loc
1001	이승기	800.00	20	마케팅팀	인천
1002	최경주	1600.00	30	영업팀	부산
1003	김광현	1200.00	30	영업팀	부산
1004	양의지	2900.00	20	마케팅팀	인천
1005	이경규	1200.00	30	영업팀	부산
1006	이승엽	2800.00	30	영업팀	부산
1007	나대표	2400.00	10	회계팀	서울
1008	유현주	3000.00	20	마케팅팀	인천
1009	김미현	5000.00	10	회계팀	서울
1010	원태인	1500.00	30	영업팀	부산
2001	나신입	10.00   --> left outer 하면 나신입이 나온다.

mysql에서는 full outer join을 지원해주지 않아서 union을 이용한다.

select e.empno, e.ename, e.sal, d.deptno, d.dname, d.loc
	from emp_test as e left outer join dept_test d 
		on e.deptno = d.deptno
UNION
select e.empno, e.ename, e.sal, d.deptno, d.dname, d.loc
	from emp_test as e right outer join dept_test d 
		on e.deptno = d.deptno;
```

---

## WHERE 절 (BETWEEN, IN, LIKE)

```sql
급여가 2,000 이상인 사원 레코드 추출

select ename, deptno, sal
	from emp_test where sal >= 2000;
    
급여가 1500보다 크거나 같고, 3000보다 작거나 같은 사원 레코드 추출

select ename, deptno, sal
	from emp_test where sal between 1500 and 3000;

부서번호가 10 또는 20인 사원 레코드 추출

select ename, deptno, sal
	from emp_test where deptno in(10, 20);

이름이 ‘이’로 시작하는 사원 레코드 추출

select ename, deptno, sal
	from emp_test where ename like '이%';

이름의 두 번째 문자가 ‘현’인 사원 레코드 추출

select ename, deptno, sal
	from emp_test where ename like '_현%';
```
