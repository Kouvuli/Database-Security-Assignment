CREATE DATABASE QLBongDa

USE QLBongDa
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE CAUTHU
(
	MACT numeric identity(1,1) NOT NULL,
	HOTEN nvarchar(100) NOT NULL,
	VITRI nvarchar(20) NOT NULL,
	NGAYSINH datetime,
	DIACHI nvarchar(200),
	MACLB varchar(5) NOT NULL,
	MAQG varchar(5) NOT NULL,
	SO int NOT NULL,
	CONSTRAINT PK_CAUTHU PRIMARY KEY (MACT) 
)

--DROP TABLE TRANDAU
--DROP TABLE BANGXH
--DROP TABLE HLV_CLB
--DROP TABLE HUANLUYENVIEN
--DROP TABLE CAUTHU
--DROP TABLE CAULACBO 
--DROP TABLE TINH
--DROP TABLE QUOCGIA
--DROP TABLE SANVD
CREATE TABLE QUOCGIA
(
	MAQG varchar(5) NOT NULL,
	TENQG nvarchar(60) NOT NULL,
	CONSTRAINT PK_QUOCGIA PRIMARY KEY (MAQG)
)

CREATE TABLE CAULACBO(
	MACLB varchar(5) NOT NULL,
	TENCLB nvarchar(100) NOT NULL,
	MASAN varchar(5) NOT NULL,
	MATINH varchar(5) NOT NULL,
	CONSTRAINT PK_CAULACBO PRIMARY KEY (MACLB)
)
CREATE TABLE TINH(
	MATINH varchar(5) NOT NULL,
	TENTINH nvarchar(100) NOT NULL,
	CONSTRAINT PK_TINH PRIMARY KEY(MATINH)
)
CREATE TABLE SANVD(
	MASAN varchar(5) NOT NULL,
	TENSAN nvarchar(100) NOT NULL,
	DIACHI nvarchar(200),
	CONSTRAINT PK_SANVD PRIMARY KEY(MASAN)
)

CREATE TABLE HUANLUYENVIEN(
	MAHLV varchar(5) NOT NULL,
	TENHLV nvarchar(100) NOT NULL,
	NGAYSINH datetime,
	DIACHI nvarchar(200),
	DIENTHOAI nvarchar(20),
	MAQG varchar(5) NOT NULL,
	CONSTRAINT PK_HUANLUYENVIEN PRIMARY KEY(MAHLV)
)

CREATE TABLE HLV_CLB(
	MAHLV varchar(5) NOT NULL,
	MACLB varchar(5) NOT NULL,
	VAITRO nvarchar(100) NOT NULL,
	CONSTRAINT PK_HLV_CLB PRIMARY KEY(MAHLV,MACLB)
)

CREATE TABLE TRANDAU(
	MATRAN numeric identity(1,1) NOT NULL,
	NAM int NOT NULL,
	VONG int NOT NULL,
	NGAYTD datetime NOT NULL,
	MACLB1 varchar(5) NOT NULL,
	MACLB2 varchar(5) NOT NULL,
	MASAN varchar(5) NOT NULL,
	KETQUA varchar(5) NOT NULL,
	CONSTRAINT PK_TRANDAU PRIMARY KEY (MATRAN)
)

CREATE TABLE BANGXH (
	MACLB varchar(5) NOT NULL,
	NAM int NOT NULL,
	VONG int NOT NULL,
	SOTRAN int NOT NULL,
	THANG int NOT NULL,
	HOA int NOT NULL,
	THUA int NOT NULL,
	HIEUSO varchar(5) NOT NULL,
	DIEM int NOT NULL,
	HANG int NOT NULL,
	CONSTRAINT PK_BANGXH PRIMARY KEY(MACLB,NAM,VONG)
)


ALTER TABLE TRANDAU ADD CONSTRAINT FK_TRANDAU_SANVD FOREIGN KEY(MASAN)
REFERENCES SANVD (MASAN)

ALTER TABLE TRANDAU ADD CONSTRAINT FK_TRANDAU_CLB1 FOREIGN KEY(MACLB1)
REFERENCES CAULACBO (MACLB)

ALTER TABLE TRANDAU ADD CONSTRAINT FK_TRANDAU_CLB2 FOREIGN KEY(MACLB2)
REFERENCES CAULACBO (MACLB)

ALTER TABLE BANGXH ADD CONSTRAINT FK_BANGXH_CLB FOREIGN KEY(MACLB)
REFERENCES CAULACBO (MACLB)

ALTER TABLE CAULACBO ADD CONSTRAINT FK_CLB_SANVD FOREIGN KEY(MASAN)
REFERENCES SANVD (MASAN)

ALTER TABLE CAULACBO ADD CONSTRAINT FK_CLB_TINH FOREIGN KEY(MATINH)
REFERENCES TINH (MATINH)

ALTER TABLE CAUTHU ADD CONSTRAINT FK_CAUTHU_CLB FOREIGN KEY(MACLB)
REFERENCES CAULACBO (MACLB)

ALTER TABLE CAUTHU ADD CONSTRAINT FK_CAUTHU_QUOCQIA FOREIGN KEY(MAQG)
REFERENCES QUOCGIA (MAQG)

ALTER TABLE HUANLUYENVIEN ADD CONSTRAINT FK_HLV_QUOCQIA FOREIGN KEY(MAQG)
REFERENCES QUOCGIA (MAQG)

ALTER TABLE HLV_CLB ADD CONSTRAINT FK_HLV_CLB_HUANLUYENVIEN FOREIGN KEY(MAHLV)
REFERENCES HUANLUYENVIEN (MAHLV)

ALTER TABLE HLV_CLB ADD CONSTRAINT FK_HLV_CLB_CAULACBO FOREIGN KEY(MACLB)
REFERENCES CAULACBO (MACLB)




INSERT INTO QUOCGIA (MAQG,TENQG) VALUES('VN',N'Việt Nam')
INSERT INTO QUOCGIA (MAQG,TENQG) VALUES('ANH',N'Anh Quốc')
INSERT INTO QUOCGIA (MAQG,TENQG) VALUES('TBN',N'Tây Ban Nha')
INSERT INTO QUOCGIA (MAQG,TENQG) VALUES('BDN',N'Bồ Đào Nha')
INSERT INTO QUOCGIA (MAQG,TENQG) VALUES('BRA',N'Brazil')
INSERT INTO QUOCGIA (MAQG,TENQG) VALUES('ITA',N'Ý')
INSERT INTO QUOCGIA (MAQG,TENQG) VALUES('THA',N'Thái Lan')

INSERT INTO HUANLUYENVIEN (MAHLV,TENHLV,NGAYSINH,DIACHI,DIENTHOAI,MAQG) VALUES ('HLV01',N'Vital',convert(date, '15/10/1955', 103),NULL,0918011075,'BDN')
INSERT INTO HUANLUYENVIEN (MAHLV,TENHLV,NGAYSINH,DIACHI,DIENTHOAI,MAQG) VALUES ('HLV02',N'Lê Huỳnh Đức',convert(date, '20/05/1972', 103),NULL,01223456789,'VN')
INSERT INTO HUANLUYENVIEN (MAHLV,TENHLV,NGAYSINH,DIACHI,DIENTHOAI,MAQG) VALUES ('HLV03',N'Kiatisuk',convert(date, '11/12/1970', 103),NULL,01990123456,'THA')
INSERT INTO HUANLUYENVIEN (MAHLV,TENHLV,NGAYSINH,DIACHI,DIENTHOAI,MAQG) VALUES ('HLV04',N'Hoàng Anh Tuấn',convert(date, '10/06/1970', 103),NULL,0989112233,'VN')
INSERT INTO HUANLUYENVIEN (MAHLV,TENHLV,NGAYSINH,DIACHI,DIENTHOAI,MAQG) VALUES ('HLV05',N'Trần Công Minh',convert(date, '07/07/1973', 103),NULL,0909099990,'VN')
INSERT INTO HUANLUYENVIEN (MAHLV,TENHLV,NGAYSINH,DIACHI,DIENTHOAI,MAQG) VALUES ('HLV06',N'Trần Văn Phúc',convert(date, '02/03/1973', 103),NULL,01650101234,'VN')

INSERT INTO TINH(MATINH,TENTINH) VALUES ('BD',N'Bình Dương')
INSERT INTO TINH(MATINH,TENTINH) VALUES ('GL',N'Gia Lai')
INSERT INTO TINH(MATINH,TENTINH) VALUES ('DN',N'Đà Nẵng')
INSERT INTO TINH(MATINH,TENTINH) VALUES ('KH',N'Khánh Hòa')
INSERT INTO TINH(MATINH,TENTINH) VALUES ('PY',N'Phú Yên')
INSERT INTO TINH(MATINH,TENTINH) VALUES ('LA',N'Long An')

INSERT INTO SANVD(MASAN,TENSAN,DIACHI) VALUES ('GD',N'Gò Đậu',N'123 QL1, TX Thủ Dầu Một, Bình Dương')
INSERT INTO SANVD(MASAN,TENSAN,DIACHI) VALUES ('PL',N'Pleiku',N'22 Hồ Tùng Mậu, Thống Nhất, Thị xã Pleiku, Gia Lai')
INSERT INTO SANVD(MASAN,TENSAN,DIACHI) VALUES ('CL',N'Chi Lăng',N'127 Võ Văn Tần, Đà Nẵng')
INSERT INTO SANVD(MASAN,TENSAN,DIACHI) VALUES ('NT',N'Nha Trang',N'128 Phan Chu Trinh, Nha Trang, Khánh Hòa')
INSERT INTO SANVD(MASAN,TENSAN,DIACHI) VALUES ('TH',N'Tuy Hòa',N'57 Trường Chinh, Tuy Hòa, Phú Yên')
INSERT INTO SANVD(MASAN,TENSAN,DIACHI) VALUES ('LA',N'Long An',N'102 Hùng Vương, Tp Tân An, Long An')

INSERT INTO CAULACBO (MACLB,TENCLB,MASAN,MATINH) VALUES ('BBD',N'BECAMEX BÌNH DƯƠNG','GD','BD')
INSERT INTO CAULACBO (MACLB,TENCLB,MASAN,MATINH) VALUES ('HAGL',N'HOÀNG ANH GIA LAI','PL','GL')
INSERT INTO CAULACBO (MACLB,TENCLB,MASAN,MATINH) VALUES ('SDN',N'SHB ĐÀ NẴNG','CL','DN')
INSERT INTO CAULACBO (MACLB,TENCLB,MASAN,MATINH) VALUES ('KKH',N'KHATOCO KHÁNH HÒA','NT','KH')
INSERT INTO CAULACBO (MACLB,TENCLB,MASAN,MATINH) VALUES ('TPY',N'THÉP PHÚ YÊN','TH','PY')
INSERT INTO CAULACBO (MACLB,TENCLB,MASAN,MATINH) VALUES ('GDT',N'GẠCH ĐỒNG TÂM LONG AN','LA','LA')

INSERT INTO CAUTHU(HOTEN,VITRI,NGAYSINH,DIACHI,MACLB,MAQG,SO) VALUES(N'Nguyễn Vũ Phong',N'Tiền vệ',convert(date, '01/20/1990', 101),NULL,'BBD','VN',17)
INSERT INTO CAUTHU(HOTEN,VITRI,NGAYSINH,DIACHI,MACLB,MAQG,SO) VALUES(N'Nguyễn Công Vinh',N'Tiền đạo',convert(date, '03/10/1992', 101),NULL,'HAGL','VN',9)
INSERT INTO CAUTHU(HOTEN,VITRI,NGAYSINH,DIACHI,MACLB,MAQG,SO) VALUES(N'Trần Tấn Tài',N'Tiền vệ',convert(date, '11/12/1989', 101),NULL,'BBD','VN',8)
INSERT INTO CAUTHU(HOTEN,VITRI,NGAYSINH,DIACHI,MACLB,MAQG,SO) VALUES(N'Phan Hồng Sơn',N'Thủ môn',convert(date, '06/10/1991', 101),NULL,'HAGL','VN',1)
INSERT INTO CAUTHU(HOTEN,VITRI,NGAYSINH,DIACHI,MACLB,MAQG,SO) VALUES(N'Ronaldo',N'Tiền vệ',convert(date, '12/12/1989', 101),NULL,'SDN','BRA',7)
INSERT INTO CAUTHU(HOTEN,VITRI,NGAYSINH,DIACHI,MACLB,MAQG,SO) VALUES(N'Robinho',N'Tiền vệ',convert(date, '10/12/1989', 101),NULL,'SDN','BRA',8)
INSERT INTO CAUTHU(HOTEN,VITRI,NGAYSINH,DIACHI,MACLB,MAQG,SO) VALUES(N'Vidic',N'Hậu vệ',convert(date, '10/15/1987', 101),NULL,'HAGL','ANH',3)
INSERT INTO CAUTHU(HOTEN,VITRI,NGAYSINH,DIACHI,MACLB,MAQG,SO) VALUES(N'Trần Văn Santos',N'Thủ môn',convert(date, '10/21/1990', 101),NULL,'BBD','BRA',1)
INSERT INTO CAUTHU(HOTEN,VITRI,NGAYSINH,DIACHI,MACLB,MAQG,SO) VALUES(N'Nguyễn Trường Sơn',N'Hậu vệ',convert(date, '08/26/1993', 101),NULL,'BBD','VN',4)

INSERT INTO TRANDAU(NAM,VONG,NGAYTD,MACLB1,MACLB2,MASAN,KETQUA) VALUES (2009,1,convert(date, '07/02/2009', 103),'BBD','SDN','GD','3-0')
INSERT INTO TRANDAU(NAM,VONG,NGAYTD,MACLB1,MACLB2,MASAN,KETQUA) VALUES (2009,1,convert(date, '07/02/2009', 103),'KKH','GDT','NT','1-1')
INSERT INTO TRANDAU(NAM,VONG,NGAYTD,MACLB1,MACLB2,MASAN,KETQUA) VALUES (2009,2,convert(date, '16/02/2009', 103),'SDN','KKH','CL','2-2')
INSERT INTO TRANDAU(NAM,VONG,NGAYTD,MACLB1,MACLB2,MASAN,KETQUA) VALUES (2009,2,convert(date, '16/02/2009', 103),'TPY','BBD','TH','5-0')
INSERT INTO TRANDAU(NAM,VONG,NGAYTD,MACLB1,MACLB2,MASAN,KETQUA) VALUES (2009,3,convert(date, '01/03/2009', 103),'TPY','GDT','TH','0-2')
INSERT INTO TRANDAU(NAM,VONG,NGAYTD,MACLB1,MACLB2,MASAN,KETQUA) VALUES (2009,3,convert(date, '01/03/2009', 103),'KKH','BBD','NT','0-1')
INSERT INTO TRANDAU(NAM,VONG,NGAYTD,MACLB1,MACLB2,MASAN,KETQUA) VALUES (2009,4,convert(date, '07/03/2009', 103),'KKH','TPY','NT','1-0')
INSERT INTO TRANDAU(NAM,VONG,NGAYTD,MACLB1,MACLB2,MASAN,KETQUA) VALUES (2009,4,convert(date, '07/03/2009', 103),'BBD','GDT','GD','2-2')

INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('BBD',2009,1,1,1,0,0,'3-0',3,1)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('KKH',2009,1,1,0,1,0,'1-1',1,2)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('GDT',2009,1,1,0,1,0,'1-1',1,3)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('TPY',2009,1,0,0,0,0,'0-0',0,4)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('SDN',2009,1,1,0,0,1,'0-3',0,5)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('TPY',2009,2,1,1,0,0,'5-0',3,1)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('BBD',2009,2,2,1,0,1,'3-5',3,2)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('KKH',2009,2,2,0,2,0,'3-3',2,3)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('GDT',2009,2,1,0,1,0,'1-1',1,4)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('SDN',2009,2,2,1,1,0,'2-5',1,5)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('BBD',2009,3,3,2,0,1,'4-5',6,1)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('GDT',2009,3,2,1,1,0,'3-1',4,2)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('TPY',2009,3,2,1,0,1,'5-2',3,3)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('KKH',2009,3,3,0,2,1,'3-4',2,4)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('SDN',2009,3,2,1,1,0,'2-5',1,5)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('BBD',2009,4,4,2,1,1,'6-7',7,1)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('GDT',2009,4,3,1,2,0,'5-1',5,2)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('KKH',2009,4,4,1,2,1,'4-4',5,3)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('TPY',2009,4,3,1,0,2,'5-3',3,4)
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG) VALUES('SDN',2009,4,2,1,1,0,'2-5',1,5)

INSERT INTO HLV_CLB(MAHLV,MACLB,VAITRO) VALUES ('HLV01','BBD',N'HLV Chính')
INSERT INTO HLV_CLB(MAHLV,MACLB,VAITRO) VALUES ('HLV02','SDN',N'HLV Chính')
INSERT INTO HLV_CLB(MAHLV,MACLB,VAITRO) VALUES ('HLV03','HAGL',N'HLV Chính')
INSERT INTO HLV_CLB(MAHLV,MACLB,VAITRO) VALUES ('HLV04','KKH',N'HLV Chính')
INSERT INTO HLV_CLB(MAHLV,MACLB,VAITRO) VALUES ('HLV05','GDT',N'HLV Chính')
INSERT INTO HLV_CLB(MAHLV,MACLB,VAITRO) VALUES ('HLV06','BBD',N'HLV thủ môn')