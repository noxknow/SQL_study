# 계정 및 권한

```sql
show databases;
use mysql;
show tables;
desc user;
select * from user;

select host, user from user;

create user hiru@localhost identified by '1234';
select host, user from user;
drop user hiru@'%';
drop user hiru@localhost;

show grants for hiru@localhost;
grant select, insert, update, delete on ncs.* to hiru@localhost;
show grants for hiru@localhost;

revoke delete on ncs.* from hiru@localhost;
show grants for hiru@localhost;
grant delete on ncs.* to hiru@localhost;
show grants for hiru@localhost;

revoke all, grant option from hiru@localhost;
show grants for hiru@localhost;

drop user hiru@localhost;
use mysql;
select user, host from user;

create user hiru@localhost identified by '1234';
show grants for hiru@localhost;
grant all privileges on ncs.* to hiru@localhost;
show grants for hiru@localhost;

revoke all, grant option from hiru@localhost;
drop user hiru@localhost;
```

## Drop

```sql
drop user hiru@localhost;
```

## Grant

> grant를 이용하여 hiru@localhost에게 crud의 권한을 넘겨준다면 cmd에서 hiru로 접속 했을 때 권한을 사용할 수가 있다.
> 

```sql
create user hiru@localhost identified by '1234';
select host, user from user;

show grants for hiru@localhost;
grant select, insert, update, delete on ncs.* to hiru@localhost;
show grants for hiru@localhost;
> 부여되는 내용 GRANT SELECT, INSERT, UPDATE, DELETE ON `ncs`.* TO `hiru`@`localhost`

모든 권한 부여
>
grant all privileges on ncs.* to hiru@localhost;
```

## Revoke

> grant로 받은 권한 삭제
> 

```sql
revoke delete on ncs.* from hiru@localhost;
show grants for hiru@localhost;

완전 삭제
>
revoke all, grant option from hiru@localhost;
show grants for hiru@localhost;
```

## 예시

```sql
create user deliver@localhost identified by '1234';
select user, host from mysql.user;

grant execute on procedure sqldb.delivProc to deliver@localhost;
show grants for deliver@localhost;
revoke execute on procedure sqldb.delivProc from deliver@localhost;

drop user deliver@localhost;
select user, host from mysql.user;
```
