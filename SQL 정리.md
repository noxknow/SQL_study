## 목차

- [1. 데이터베이스](#bookmark_tabs-데이터베이스) <br/>
  - [1.1  데이터베이스 유형의 구분](#데이터베이스-유형의-구분) <br/>
  - [1.2  데이터베이스 관리 시스템 (DBMS)](#데이터베이스-관리-시스템-(DBMS)) <br/>
- [2. SQL 쿼리 실행 순서](#SQL-쿼리-실행-순서) <br/>
- [3. SQL Join](#SQL-Join) <br/>

# :bookmark_tabs: **데이터베이스**

+ 데이터베이스란 데이터의 모음을 말한다.
+ 대량의 데이터를 효율적으로 관리할 수 있다.
+ 이러한 데이터를 조직화하는 방식(데이터베이스를 만드는 방식)에는 여러가지가 있다.
+ 데이터베이스를 만들고 관리하는 방식에 따라 데이터베이스 유형을 구분할 수 있다.

## 👉 데이터베이스 유형의 구분

+ 관계형 데이터베이스 vs 비관계형 데이터베이스
+ SQL vs NoSQL

<p align=center>
  <img alt='RDBMS' width=500 src='https://i0.wp.com/hanamon.kr/wp-content/uploads/2021/07/SQL-%E1%84%80%E1%85%B5%E1%84%87%E1%85%A1%E1%86%AB-%E1%84%80%E1%85%AA%E1%86%AB%E1%84%80%E1%85%A8%E1%84%92%E1%85%A7%E1%86%BC-%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%A5%E1%84%87%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%89%E1%85%B3-%E1%84%83%E1%85%A9%E1%84%89%E1%85%B5%E1%86%A8%E1%84%92%E1%85%AA.png?resize=768%2C864&ssl=1'>
  <img alt='NOSQL' width=500 src='https://i0.wp.com/hanamon.kr/wp-content/uploads/2021/07/%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%A5%E1%84%87%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%89%E1%85%B3-%E1%84%92%E1%85%A7%E1%86%BC%E1%84%89%E1%85%B5%E1%86%A8-%E1%84%83%E1%85%A9%E1%84%89%E1%85%B5%E1%86%A8%E1%84%92%E1%85%AA-3.png?w=1280&ssl=1'>
</p>
cf) https://hanamon.kr/%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4-sql-vs-nosql/

## 👉 데이터베이스 관리 시스템 (DBMS)

+ 이러한 개념적인 데이터베이스를 실질적으로 구현하기 위해서 일반적으로 데이터베이스 관리 시스템 (DBMS) 이라는 것을 사용한다.

## 👉 SQL 도식화

![image](https://github.com/noxknow/SQL_study/assets/122594223/1489c1ef-4502-4f8b-bba4-6704bced6199)
cf) https://artist-developer.tistory.com/39

- `DDL`(Data Define Language, 데이터 정의어) : CREATE, ALTER, DROP, TRUNCATE
- `DML`(Data Manipulation Language, 데이터 조작어) : SELECT, INSERT, UPDATE, DELETE
- `DCL`(Data Control Language, 데이터 제어어) : GRANT, REVOKE

# SQL 쿼리 실행 순서

### 1. FROM 절 (+ Join)

---

가장 먼저 진행되는건 FROM절이다

테이블 전체를 가져오는 역할을 하며

INDEX를 사용하지 않는다는 가정에서 WHERE절이나 SELECT절에서 일부 행이나 열을 제거하여 출력한다고 해도 가장 처음에 테이블의 모든 데이터를 가져온다.

테이블을 합쳐주는 JOIN또한 동순위로 진행된다.

### **2.  WHERE절**

---

FROM에서 가져온 테이블을 WHERE절을 통해 원하는 조건에 맞는 값만 필터링해주는 역할을 한다

### **3. GROUP BY**

---

> 컬럼을 그룹핑해준다
> 

GROUP BY로 묶으면 가장 상단에 있는 데이터들을 임의로 가져온다. 고로 SELECT에 MAX를 해도 최대값을 가져오는것이 아닌 그룹화된 테이블 가장 상단을 가져오게 된다.

### **4. HAVING 절**

---

HAVING 은 GROUP BY를 통해 그룹핑 후에 그 그룹에 사용하는 조건절로서 WHERE 과 HAVING에 둘다 적용할수 있는 조건이라면 WHERE절에 사용하는게 바람직하다  -  (이는 HAVING절은 각 그룹에 조건을 거는 방식이기 떄문에 리소스를 더 먹게 된다.)

하지만 AVG 같이 집계함수를 사용하는 경우에는 각 그룹의 평균을 구하는 것이기 떄문에 HAVING절을 사용해야 한다.

### **5. SELECT절**

---

위에 조건들을 적용하고 난후 어떤 컬럼을 출력할지 선택합니다

### **6. ORDER BY절**

---

출력할 컬럼의 순서를 어떠한 방식으로 정렬할지 정해줍니다

### **7.LIMIT**

---

최종 결과물을 몇개까지 보여줄지 선택합니다

# SQL Join

### **예제 테이블**

![image](https://github.com/noxknow/SQL_study/assets/122594223/f3fc48a7-a444-42fd-8fce-6d1594bfa97a)

### **MySQL INNER JOIN**

- 두 테이블을 조인하여 조인절에 해당하는 결과만 생성 (같은 경우만)

```sql
SELECT t1.id, t2.id
FROM t1
INNER JOIN t2
ON t1.pattern = t2.pattern;
```

*결과*

| id | id |
| --- | --- |
| 2 | A |
| 3 | B |

### **MySQL LEFT OUTER JOIN**

- 왼쪽에 위치한 테이블 전부가 포함 & 오른쪽에 위치한 테이블은 조건이 만족하는 경우만 포함

```sql
SELECT t1.id, t2.id
FROM t1
LEFT JOIN t2
ON t1.pattern = t2.pattern
ORDER BY t1.id;
```

*결과*

| id | id |
| --- | --- |
| 1 | null |
| 2 | A |
| 3 | B |

### **MySQL RIGHT OUTER JOIN**

- 오른쪽에 위치한 테이블 전부가 포함 & 왼쪽에 위치한 테이블은 조건이 만족하는 경우만 포함

```sql
SELECT t1.id, t2.id
FROM t1
RIGHT JOIN t2
ON t1.pattern = t2.pattern
ORDER BY t2.id;
```

*결과*

| id | id |
| --- | --- |
| 2 | A |
| 3 | B |
| null | C |

