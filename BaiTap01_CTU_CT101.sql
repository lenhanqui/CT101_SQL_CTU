-- Bảng PHICONG
CREATE TABLE PHICONG(
    MPC smallint PRIMARY KEY,
    hoten varchar2(50) NOT NULL,
    dchi varchar2(30)
);

-- Bảng CONGTY
CREATE TABLE CONGTY(
    MCT smallint NOT NULL,
    tencty varchar(30) UNIQUE,
    nuoc varchar(20),
    PRIMARY KEY (MCT) 
);

-- Bảng CHUYENBAY 
CREATE TABLE CHUYENBAY(
    SOCB varchar(10) NOT NULL,
    MPC smallint NOT NULL,
    MMB smallint NOT NULL,
    noidi varchar(20) DEFAULT 'Paris',
    noiden varchar(20),
    khoangcach int CHECK(khoangcach>0),
    giodi char(5),
    gioden char(5),
    ngaybay date,
    CONSTRAINT fk_MPC 
    FOREIGN KEY(MPC) 
	REFERENCES PHICONG(MPC),
    FOREIGN KEY(MMB) 
	REFERENCES MAYBAY(MMB) 
);

ALTER TABLE LAMVIEC ADD songay int;
ALTER TABLE LAMVIEC ADD nuoc varchar(20) UNIQUE;
ALTER TABLE PHICONG ADD CONSTRAINT pk_MPC PRIMARY KEY (MPC);
ALTER TABLE LAMVIEC DROP COLUMN nuoc ;
ALTER TABLE PHICONG DROP CONSTRAINT pk_MPC;
ALTER TABLE LAMVIEC MODIFY songay smallint ;
UPDATE CONGTY SET tencty= 'RYANAIR'
WHERE tencty='Easy Jet';
DELETE FROM CONGTY ;
DELETE FROM CONGTY WHERE tencty='Easy Jet';

SELECT hoten, dchi
FROM PHICONG;

INSERT INTO CONGTY(MCT, tencty, nuoc) VALUES (1, 'Air France', 'Phap');
INSERT INTO CONGTY VALUES (3, 'Qantas', 'Uc');
INSERT INTO CONGTY VALUES (2, 'British Airways', 'Anh');
INSERT INTO CONGTY VALUES (4, 'Easy Jet', 'EU');

UPDATE CONGTY SET tencty= 'RYANAIR'
WHERE tencty='Easy Jet';

DELETE FROM CONGTY ;
− DELETE FROM CONGTY WHERE tencty='Easy Jet';

SELECT hoten AS hoten_phicong, dchi AS diachi
FROM PHICONG ;

SELECT p.hoten, p.dchi AS diachi
FROM PHICONG AS p;
- PHICONG AS p = PHICONG p
- p.dchi AS diachi = p.dchi diachi

SELECT *
FROM PHICONG ;

SELECT hoten
FROM PHICONG
WHERE dchi='Paris';

SET DATEFORMAT dmy;
ORACLE: alter session set nls_date_format = 'mm/dd/yyyy';

SELECT hoten
FROM PHICONG
WHERE nuoc IN ('Phap','Anh','Uc');

SELECT *
FROM CHUYENBAY
WHERE khoangcach BETWEEN 10000 AND 15000;

SELECT hoten
FROM PHICONG
WHERE hoten LIKE 'D%';

SELECT hoten
FROM PHICONG
WHERE dchi IS NULL;

SELECT hoten, COUNT(*) FROM PHICONG
WHERE nuoc='Phap';

SELECT hoten, nuoc
FROM PHICONG
ORDER BY hoten, nuoc DESC;

SELECT MPC FROM LAMVIEC WHERE MCT=1 
INTERSECT
SELECT MPC FROM LAMVIEC WHERE MCT=2
SELECT MPC FROM LAMVIEC WHERE MCT=2
MINUS
SELECT MPC FROM LAMVIEC WHERE MCT=3
SELECT MPC FROM LAMVIEC WHERE MCT=2 and MPC NOT IN
(SELECT MPC FROM LAMVIEC WHERE MCT=3)
	
SELECT DISTINCT p.MPC, hoten
FROM LAMVIEC l, PHICONG p
WHERE l.MPC = p.MPC
AND songay > 20
	
SELECT DISTINCT tencty
FROM LAMVIEC l, PHICONG p, CONGTY c
WHERE l.MPC = p.MPC AND l.MCT = c.MCT
AND hoten = 'Patrick Cortier'
	
SELECT *
FROM PHICONG p CROSS JOIN LAMVIEC l
	
SELECT *
FROM PHICONG p, LAMVIEC l
SELECT DISTINCT p.MPC, hoten
FROM LAMVIEC l NATURAL JOIN PHICONG p
WHERE songay > 20

SELECT hoten
FROM PHICONG p JOIN LAMVIEC l
ON p.MPC=l.MPC
WHERE songay=20;

SELECT hoten, MCT, songay
FROM PHICONG p
LEFT JOIN LAMVIEC l
ON p.MPC=l.MPC

SELECT l.MPC, hoten,dchi, songay
FROM (SELECT * FROM PHICONG WHERE nuoc LIKE 'anh') p
RIGHT JOIN (SELECT * FROM LAMVIEC where MCT=1) l
ON p.MPC=l.MPC

SELECT l.MPC, hoten,dchi, songay
FROM (SELECT * FROM PHICONG WHERE nuoc LIKE 'anh') p
FULL JOIN (SELECT * FROM LAMVIEC where MCT=1) l
ON p.MPC=l.MPC

SELECT hoten
FROM PHICONG
WHERE MPC IN
(SELECT MPC FROM LAMVIEC WHERE songay>20)

SELECT hoten FROM PHICONG a, LAMVIEC b
WHERE a.MPC = b.MPC and
songay =
(SELECT MAX(songay) FROM LAMVIEC)

SELECT loai FROM LOAIMAYBAY
WHERE NSX='Boeing'
AND socho > ANY
(SELECT socho FROM LOAIMAYBAY WHERE NSX='Airbus')

SELECT loai FROM LOAIMAYBAY

WHERE NSX= 'Airbus'
AND socho > ALL
(SELECT socho FROM LOAIMAYBAY WHERE NSX='Boeing')

SELECT * FROM MAYBAY
WHERE EXISTS (SELECT MMB FROM CHUYENBAY
WHERE MAYBAY.MMB=CHUYENBAY.MMB
AND noiden='paris')

SELECT t1.* FROM Table1 t1
WHERE t1.ID NOT IN (SELECT t2.ID FROM Table2 t2)
Được thay bằng
SELECT t1.*
FROM Table1 t1 LEFT JOIN Table2 t2
ON t1.ID = t2.ID
WHERE t2.ID IS NULL
	
SELECT t1.*
FROM Table1 t1 RIGHT JOIN Table2 t2
ON t1.ID = t2.ID
WHERE t1.ID IS NULL

SELECT COUNT(*) FROM PHICONG WHERE nuoc='Phap';

SELECT SUM(khoangcach) as Tong,
MIN(khoangcach) Nho_nhat,
MAX(khoangcach) Lon_nhat,
AVG(khoangcach) as Trung_binh
FROM CHUYENBAY
WHERE MPC=20;

SELECT nuoc, count(*) so_phi_cong
FROM PHICONG
GROUP BY nuoc ;

SELECT nuoc, count(*) so_phi_cong
FROM PHICONG
GROUP BY nuoc HAVING count(*) >=3 ;

SELECT INTO temp
FROM CONGTY

CREATE TABLE PHICONG_PHAP(
MPC smallint PRIMARY KEY,
hoten varchar(30),
dchi varchar(30));

INSERT INTO PHICONG_PHAP
SELECT MPC, hoten, dchi
FROM PHICONG
WHERE nuoc='Phap'

SELECT TOP(2) * FROM PHICONG
ORDER BY hoten

GRANT SELECT, INSERT ON PHICONG TO user1 WITH
GRANT OPTION
REVOKE SELECT, INSERT ON PHICONG FROM user1
CASCADE
