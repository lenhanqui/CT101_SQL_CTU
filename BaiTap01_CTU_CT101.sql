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
