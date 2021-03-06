/*----------------------------------------------------------
MASV:19120644-19120622-19120617
HO TEN CAC THANH VIEN NHOM:LÊ ĐỨC TÂM-NGUYỄN MINH PHỤNG-MẠCH VI PHONG
LAB: 04 - NHOM 7
NGAY:01/05/2022
----------------------------------------------------------*/
--a)CAU LENH TAO DB
create database QLSVNhom

go
use QLSVNhom

go
drop table BANGDIEM
drop table HOCPHAN
drop table SINHVIEN
drop table LOP
drop table NHANVIEN


--drop database QLSVNhom

go
/*----------------------------------------------------------
MASV:19120644-19120622-19120617
HO TEN CAC THANH VIEN NHOM:LÊ ĐỨC TÂM-NGUYỄN MINH PHỤNG-MẠCH VI PHONG
LAB: 04 - NHOM 7
NGAY:01/05/2022
----------------------------------------------------------*/
-- b)CAC CAU LENH TAO TABLE
create table SINHVIEN
(
	MASV varchar(20) primary key,
	HOTEN nvarchar(100) not null,
	NGAYSINH datetime,
	DIACHI nvarchar(200),
	MALOP varchar(20),
	TENDN nvarchar(100) not null unique,
	MATKHAU varbinary(MAX) not null
)

create table NHANVIEN
(
	MANV varchar(20) primary key,
	HOTEN nvarchar(100) not null,
	EMAIL varchar(20),
	LUONG varbinary(MAX),
	TENDN nvarchar(100) not null unique,
	MATKHAU varbinary(MAX) not null,
	PUBKEY varchar(20)
)

create table LOP
(
	MALOP varchar(20) primary key,
	TENLOP nvarchar(100) not null,
	MANV varchar(20)
)

create table HOCPHAN
(
	MAHP varchar(20) primary key,
	TENHP nvarchar(100) not null,
	SOTC int
)

create table BANGDIEM
(
	MASV varchar(20),
	MAHP varchar(20),
	DIEMTHI varbinary (MAX),
	primary key (MASV, MAHP)
)


alter table SINHVIEN add constraint FK_SINHVIEN_LOP foreign key(MALOP) references LOP(MALOP)
alter table LOP add constraint FK_LOP_NHANVIEN foreign key(MANV) references NHANVIEN(MANV)


alter table BANGDIEM add constraint FK_BANGDIEM_SINHVIEN foreign key(MASV) references SINHVIEN(MASV)
alter table BANGDIEM add constraint FK_BANGDIEM_HOCPHAN foreign key(MAHP) references HOCPHAN(MAHP)


/*----------------------------------------------------------
MASV:19120644-19120622-19120617
HO TEN CAC THANH VIEN NHOM:LÊ ĐỨC TÂM-NGUYỄN MINH PHỤNG-MẠCH VI PHONG
LAB: 04 - NHOM 7
NGAY:01/05/2022
----------------------------------------------------------*/
--c)CAU LENH TAO STORED PROCEDURE
--i)
go
create or alter proc SP_INS_PUBLIC_ENCRYPT_NHANVIEN
@MANV varchar(20),
@HOTEN nvarchar(100),
@EMAIL varchar(20),
@LUONG varbinary(100),
@TENDN nvarchar(100),
@MATKHAU varbinary(100),
@PUBKEY varchar(20)
as
begin
	ALTER DATABASE QLSVNhom
	SET COMPATIBILITY_LEVEL = 120
	INSERT INTO NHANVIEN (MANV, HOTEN, EMAIL, LUONG, TENDN, MATKHAU,PUBKEY)
    VALUES (@MANV, @HOTEN, @EMAIL, @LUONG
	, @TENDN, @MATKHAU ,@PUBKEY)
end;

--EXEC SP_INS_PUBLIC_ENCRYPT_NHANVIEN 'NV01', 'NGUYEN VAN A', 'NVA@', 'LLLLLL', 'NVA', 'MKMKMKMK', 'PUBPUB'
--select * from nhanvien	
--ii)
go
create or alter proc SP_SEL_PUBLIC_ENCRYPT_NHANVIEN
@TENDN nvarchar(100),
@MATKHAU varchar(100)
as
begin
	select MANV, HOTEN, EMAIL, LUONG
	from NHANVIEN
	where TENDN = @TENDN and MATKHAU=@MATKHAU
end;

--EXEC SP_SEL_PUBLIC_ENCRYPT_NHANVIEN 'NVA', 'MKMKMKMK'

/*----------------------------------------------------------
MASV:19120644-19120622-19120617
HO TEN CAC THANH VIEN NHOM:LÊ ĐỨC TÂM-NGUYỄN MINH PHỤNG-MẠCH VI PHONG
LAB: 04 - NHOM 7
NGAY:01/05/2022
----------------------------------------------------------*/
--d)

GO
create or alter proc SP_INS_PUBLIC_ENCRYPT_SINHVIEN
@MASV varchar(20),
@HOTEN nvarchar(100),
@NGAYSINH datetime,
@DIACHI nvarchar(200),
@MALOP varchar(20),
@TENDN nvarchar(100),
@MATKHAU varchar(100)
as
begin
	insert into SINHVIEN values
	(@MASV,@HOTEN,@NGAYSINH,@DIACHI,@MALOP,@TENDN,CONVERT(VARBINARY(MAX),@MATKHAU))
end;

GO
create or alter proc SP_AUTHEN_NHANVIEN
@TENDN nvarchar(100),
@MATKHAU varchar(100)
as
begin
	select *
	from NHANVIEN
	where TENDN = @TENDN
		and MATKHAU = @MATKHAU
end;

go
create or alter proc SP_INS_BANGDIEM
@MASV varchar(20),
@MAHP varchar(20),
@DIEMTHI varchar(MAX)
as
begin
	insert into BANGDIEM values(@MASV,@MAHP,CONVERT(VARBINARY(MAX),@DIEMTHI))
end;

go
create or alter proc SP_INS_ENCRYPT_BANGDIEM
@MASV varchar(20),
@MAHP varchar(20),
@DIEMTHI varchar(MAX),
@PUBKEY varchar(max)
as
begin
	insert into BANGDIEM values(@MASV,@MAHP,ENCRYPTBYASYMKEY(asymkey_id(@PUBKEY), @DIEMTHI))
end;


go
create or alter proc SP_SEL_BANGDIEM_HOCPHAN_SINHVIEN
@MASV varchar(20),
@MAHP varchar(20)
as
begin

	select MASV, MAHP,DIEMTHI
	from BANGDIEM
	where MASV = @MASV AND MAHP=@MAHP

end;
go
create or alter proc SP_UPDATE_BANGDIEM_SINHVIEN
@MASV varchar(20),
@MAHP varchar(20),
@DIEMTHI varchar(max)
as
begin

	update BANGDIEM 
	set DIEMTHI = CONVERT(VARBINARY(MAX),@DIEMTHI)
	where MASV = @MASV AND MAHP = @MAHP 
	
end;

go
create or alter proc SP_SEL_BANGDIEM_SINHVIEN
@MASV varchar(20)
as
begin

	select MASV, MAHP, DIEMTHI
	from BANGDIEM
	where MASV = @MASV
end;


-- encrypt with RSA
GO
CREATE OR ALTER PROCEDURE ENCRYPT_RSA_512(
	@PUBKEY VARCHAR(20),
	@VALUE varchar(max),
	@MK VARCHAR(100)
)
AS
BEGIN

	SELECT ENCRYPTBYASYMKEY( asymkey_id(@PUBKEY), convert(varchar(MAX),@VALUE)) AS ENCRYPTVALUE
END;


-- decrypt with RSA
GO
CREATE OR ALTER PROCEDURE DECRYPT_RSA_512(
	@PUBKEY VARCHAR(20),
	@VALUE varbinary(MAX),
	@MK VARCHAR(MAX)
)
AS
BEGIN
	SELECT convert(varchar,decryptbyasymkey(asymkey_id(@PUBKEY),convert(varbinary(max),@VALUE),convert(nvarchar(MAX),@MK))) AS DECRYPTVALUE

END;


-- create asymKey
go
CREATE OR ALTER PROC SP_CREATE_ASYM_KEY(
    @PUBKEY VARCHAR(MAX),
    @MATKHAU VARCHAR(MAX)
)
AS
BEGIN
    exec('create asymmetric key '+@PUBKEY+'
            with algorithm = RSA_512
            encryption by password = '''+@MATKHAU+'''')
END;


-- insert asymKey
go
exec SP_CREATE_ASYM_KEY 'NV01','0x7C4A8D09CA3762AF61E59520943DC26494F8941B'
exec SP_CREATE_ASYM_KEY 'NV02','0x7C4A8D09CA3762AF61E59520943DC26494F8941B'
exec SP_CREATE_ASYM_KEY 'NV03','0x7C4A8D09CA3762AF61E59520943DC26494F8941B'
exec SP_CREATE_ASYM_KEY 'NV04','0x7C4A8D09CA3762AF61E59520943DC26494F8941B'
exec SP_CREATE_ASYM_KEY 'NV05','0x7C4A8D09CA3762AF61E59520943DC26494F8941B'
exec SP_CREATE_ASYM_KEY 'NV06','0x7C4A8D09CA3762AF61E59520943DC26494F8941B'
exec SP_CREATE_ASYM_KEY 'NV07','0x7C4A8D09CA3762AF61E59520943DC26494F8941B'
exec SP_CREATE_ASYM_KEY 'NV08','0x7C4A8D09CA3762AF61E59520943DC26494F8941B'
exec SP_CREATE_ASYM_KEY 'NVADMIN','0x7C4A8D09CA3762AF61E59520943DC26494F8941B'


-- insert NHANVIEN
go
EXEC SP_INS_PUBLIC_ENCRYPT_NHANVIEN 'NV01', 'NGUYEN VAN A', 'nva@yahoo.com', 0xE828C147D66801A9BE3A3AC72F7655D15F6AC6486DD1B1C4F09011ACB4D444584486E8D3077C782AE4802F67626551433E3B72FB348F5CA939F91D0C7BAF4D80, 'NVA', 0x7C4A8D09CA3762AF61E59520943DC26494F8941B,'NV01'
EXEC SP_INS_PUBLIC_ENCRYPT_NHANVIEN 'NV02', 'NGUYEN VAN B', 'nvb@yahoo.com', 0x8416999586E90B749282F03E06A58429BFC6EB72D1464632CF37394B96B2BFC4AE001E9E9DE0F91557253CEBB41B942BB1F9331589465803C4D30C270AEC56A3, 'NVB', 0x7C4A8D09CA3762AF61E59520943DC26494F8941B,'NV02'
EXEC SP_INS_PUBLIC_ENCRYPT_NHANVIEN 'NV03', 'NGUYEN VAN C', 'nvc@yahoo.com', 0xDF71A19E194A388DEF324B6E1B677F5F05CC7AD7440254FD1D67AFCFC6D23E6DC44321088276DD02C0C18BAE55580B1B16B0D66A15C166BAC49913997CB11B1A, 'NVC', 0x7C4A8D09CA3762AF61E59520943DC26494F8941B,'NV03'
EXEC SP_INS_PUBLIC_ENCRYPT_NHANVIEN 'NV04', 'NGUYEN VAN D', 'nvd@yahoo.com', 0x891FA70A22269E166CEACA1356264969CEBD3E2EF944BDCD2B8BC7071BBB0980DD8D418326D496E7F257D70C83D9FA0D569D7BF2F066483AB628870287853926, 'NVD', 0x7C4A8D09CA3762AF61E59520943DC26494F8941B,'NV04'
EXEC SP_INS_PUBLIC_ENCRYPT_NHANVIEN 'NV05', 'NGUYEN VAN E', 'nve@yahoo.com', 0xCE9671BD8A184A82A2CEB932E0E4C42F1E1E905629544CC9C5FFCA1BA0EE23CEAB9AB89E2D6A68AF6C48FAE79519287A6533C155DD4279E9A3CC96C295817925, 'NVE', 0x7C4A8D09CA3762AF61E59520943DC26494F8941B,'NV05'
EXEC SP_INS_PUBLIC_ENCRYPT_NHANVIEN 'NV06', 'NGUYEN VAN G', 'nvg@yahoo.com', 0x17946FDDD5EAE5A61D4EF50FC890C6FEB014E9520EB8693B532D5B7F7E27BFCA7E50B15A279DF82FE0A7912FF65DDD673BAE3F479D79E7BB6B9C722EA562A224, 'NVG', 0x7C4A8D09CA3762AF61E59520943DC26494F8941B,'NV06'
SELECT * FROM NHANVIEN

-- insert LOP
insert into LOP values
('CNTT-K17','Cong Nghe Thong Tin','NV01'),
('CNTT-K18','Cong Nghe Thong Tin','NV02'),
('CNTT-K19','Cong Nghe Thong Tin','NV03'),
('CNTT-K20','Cong Nghe Thong Tin','NV04'),
('CNTT-K21','Cong Nghe Thong Tin','NV05')

-- insert SINHVIEN

EXEC SP_INS_PUBLIC_ENCRYPT_SINHVIEN 'SV01', 'TRAN VAN A', '1990-1-1', '001 AN DUONG VUONG', 'CNTT-K17', 'TVA', 0xE10ADC3949BA59ABBE56E057F20F883E
EXEC SP_INS_PUBLIC_ENCRYPT_SINHVIEN 'SV02', 'TRAN VAN B', '1990-1-1', '002 AN DUONG VUONG', 'CNTT-K18', 'TVB', 0xE10ADC3949BA59ABBE56E057F20F883E
EXEC SP_INS_PUBLIC_ENCRYPT_SINHVIEN 'SV03', 'TRAN VAN C', '1990-1-1', '003 AN DUONG VUONG', 'CNTT-K19', 'TVC', 0xE10ADC3949BA59ABBE56E057F20F883E
EXEC SP_INS_PUBLIC_ENCRYPT_SINHVIEN 'SV04', 'TRAN VAN D', '1990-1-1', '004 AN DUONG VUONG', 'CNTT-K20', 'TVD', 0xE10ADC3949BA59ABBE56E057F20F883E
EXEC SP_INS_PUBLIC_ENCRYPT_SINHVIEN 'SV05', 'TRAN VAN E', '1990-1-1', '005 AN DUONG VUONG', 'CNTT-K21', 'TVE', 0xE10ADC3949BA59ABBE56E057F20F883E

-- insert HOCPHAN

insert into HOCPHAN values
('CSC001','Co So Nganh 1',4),
('CSC002','Co So Nganh 2',4),
('CSC003','Co So Nganh 3',4),
('CSC004','Co So Nganh 4',4),
('CSC005','Co So Nganh 5',4)

go

-- insert BANGDIEM

	-- indirectly
exec SP_INS_ENCRYPT_BANGDIEM 'SV01','CSC001','8','NV01'
exec SP_INS_ENCRYPT_BANGDIEM 'SV02','CSC002','8.5','NV02'
exec SP_INS_ENCRYPT_BANGDIEM 'SV03','CSC003','9','NV03'
exec SP_INS_ENCRYPT_BANGDIEM 'SV04','CSC004','9.5','NV04'
exec SP_INS_ENCRYPT_BANGDIEM 'SV05','CSC005','10','NV05'

	-- directly
exec SP_INS_BANGDIEM 'SV01','CSC001',0x7160683F3E29C6E5D6D32679E1ADA38B1875B750148E48D8493C96034A48C102F65686ABBDCD9BAEF268C3B6EF81C9FC6BEC0A37DD15DD865D028DE0EA416A3F
exec SP_INS_BANGDIEM 'SV02','CSC002',0x15B1975E6F9480DDC218DA248087235620E956C2113F99F977BFEDA5A4FC931B36A3CF610A63F5592359509169D366707DC468F9A9584D298B9A07DCCCC4E4A5
exec SP_INS_BANGDIEM 'SV03','CSC003',0xC2AABC76749EA4AAEB9C15B2586777D4A6877FCE52C8A7A7E82BE3F238E32C0A6CABAF4AC075E4556A339682A386141159691298C970758FF63A341661974F0A
exec SP_INS_BANGDIEM 'SV04','CSC004',0xF45BAD1A9CA126BA8562F6209D3316DD63E361FC840D4427E859AED135DAFC4C8B7514414CE33E1C758EC4B582BC8688BF6F1C27058914074E8356C7A986D63E
exec SP_INS_BANGDIEM 'SV05','CSC005',0x17FFFFE913F8EE529B93483C63E68068412AC5015CC0F89747011A67E4E8B85FDBFC7A79E81E93FBCCD33BAC256D4C3817B7BA4D238AD08CD9DC95EB2F00CF0F


--alternative ins_nv
go
create or alter proc SP_INS_PUBLIC_ENCRYPT_NHANVIEN
@MANV varchar(20),
@HOTEN nvarchar(100),
@EMAIL varchar(20),
@LUONG VARCHAR(100),
@TENDN nvarchar(100),
@MATKHAU varchar(100),
@PUBKEY varchar(20)
as
begin
    INSERT INTO NHANVIEN (MANV, HOTEN, EMAIL, LUONG, TENDN, MATKHAU,PUBKEY)
    VALUES (@MANV, @HOTEN, @EMAIL, CAST(@LUONG as varbinary(max)) , @TENDN, CAST(@MATKHAU as varbinary(max)),@PUBKEY)
end;

exec('create asymmetric key NV07
			with algorithm = RSA_512
			encryption by password = '''+'0x7C4A8D09CA3762AF61E59520943DC26494F8941B'+'''')




