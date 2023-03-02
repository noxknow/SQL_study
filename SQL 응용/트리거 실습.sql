USE sqlDB;
DROP TABLE buyTbl; -- 구매테이블은 실습에 필요없으므로 삭제.
CREATE TABLE backup_userTbl( 
	 userID CHAR(8) NOT NULL PRIMARY KEY, 
	 name VARCHAR(10) NOT NULL, 
	 birthYear INT NOT NULL, 
	 addr CHAR(2) NOT NULL, 
	 mobile1 CHAR(3), 
	 mobile2 CHAR(8), 
	 height SMALLINT, 
	 mDate DATE,
	 modType CHAR(2), -- 변경된 타입. '수정' 또는 '삭제'
	 modDate DATE, -- 변경된 날짜
	 modUser VARCHAR(256) -- 변경한 사용자
);

select * from backup_userTbl;

DROP TRIGGER IF EXISTS backUserTbl_UpdateTrg;
DELIMITER // 
CREATE TRIGGER backUserTbl_UpdateTrg -- 트리거 이름
 AFTER UPDATE -- 변경 후에 작동하도록 지정
 ON userTBL -- 트리거를 부착할 테이블
 FOR EACH ROW 
BEGIN
 INSERT INTO backup_userTbl VALUES( OLD.userID, OLD.name, OLD.birthYear, 
 OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, 
 '수정', CURDATE(), CURRENT_USER() );
END // 
DELIMITER ;

DROP TRIGGER IF EXISTS backUserTbl_DeleteTrg;
DELIMITER // 
CREATE TRIGGER backUserTbl_DeleteTrg -- 트리거 이름
 AFTER DELETE -- 삭제 후에 작동하도록 지정
 ON userTBL -- 트리거를 부착할 테이블
 FOR EACH ROW 
BEGIN
 INSERT INTO backup_userTbl VALUES( OLD.userID, OLD.name, OLD.birthYear, 
 OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, 
 '삭제', CURDATE(), CURRENT_USER() );
END // 
DELIMITER ;

UPDATE userTbl SET addr = '몽고' WHERE userID = 'JKW';
select * from userTbl;
DELETE FROM userTbl WHERE height >= 177;
select * from userTbl;

select * from backup_userTbl;
