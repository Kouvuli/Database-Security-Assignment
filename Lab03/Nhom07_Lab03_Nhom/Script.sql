/*----------------------------------------------------------
MASV:19120644-19120622-19120617
HO TEN CAC THANH VIEN NHOM:LÊ ĐỨC TÂM-NGUYỄN MINH PHỤNG-MẠCH VI PHONG
LAB: 03 - NHOM 7
NGAY:28/04/2022
----------------------------------------------------------*/
--a)CAU LENH TAO DB
create database QLSVNhom
go
--drop table BANGDIEM
--drop table HOCPHAN
--drop table SINHVIEN
--drop table LOP
--drop table NHANVIEN

use QLSVNhom
--drop database QLSVNhom

go
/*----------------------------------------------------------
MASV:19120644-19120622-19120617
HO TEN CAC THANH VIEN NHOM:LÊ ĐỨC TÂM-NGUYỄN MINH PHỤNG-MẠCH VI PHONG
LAB: 03 - NHOM 7
NGAY:28/04/2022
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
LAB: 03 - NHOM 7
NGAY:28/04/2022
----------------------------------------------------------*/
--c)CAU LENH TAO STORED PROCEDURE
--i)
go
create or alter proc SP_INS_PUBLIC_NHANVIEN
@MANV varchar(20),
@HOTEN nvarchar(100),
@EMAIL varchar(20),
@LUONGCB int,
@TENDN nvarchar(100),
@MK varchar(100)
as
begin
	declare @asymID int
	declare @proc varchar(MAX) = 
		'create asymmetric key '+@MANV+'
			with algorithm = RSA_512
			encryption by password = '''+@MK+''''
	if (select count(*) from sys.asymmetric_keys where name = @MANV) = 0
	begin
		exec(@proc)
	end
	
	set @asymID = asymkey_id(@MANV)
	insert into NHANVIEN values 
	(@MANV,@HOTEN,@EMAIL,
	ENCRYPTBYASYMKEY(@asymID, convert(varchar(MAX),@LUONGCB))
	,@TENDN,HASHBYTES('SHA1',@MK),@MANV)
end;

	
--ii)
go
create or alter proc SP_SEL_PUBLIC_NHANVIEN
@TENDN nvarchar(100),
@MK varchar(100)
as
begin
	select MANV, HOTEN, EMAIL, convert(varchar(MAX),decryptbyasymkey(asymkey_id(MANV),LUONG,convert(nvarchar(MAX),@MK))) as LUONG
	from NHANVIEN
	where TENDN = @TENDN
end;

/*----------------------------------------------------------
MASV:19120644-19120622-19120617
HO TEN CAC THANH VIEN NHOM:LÊ ĐỨC TÂM-NGUYỄN MINH PHỤNG-MẠCH VI PHONG
LAB: 03 - NHOM 7
NGAY:28/04/2022
----------------------------------------------------------*/
--d)
go
create or alter proc SP_INS_PUBLIC_SINHVIEN
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
	(@MASV,@HOTEN,@NGAYSINH,@DIACHI,@MALOP,@TENDN,hashbytes('MD5',@MATKHAU))
end;
go

create or alter proc SP_AUTHEN_NHANVIEN
@TENDN nvarchar(100),
@MATKHAU varchar(100)
as
begin
	select *
	from NHANVIEN
	where TENDN = @TENDN
		and MATKHAU = hashbytes('SHA1', @MATKHAU)
end;
exec SP_AUTHEN_NHANVIEN 'NVA','123456'
go
create or alter proc SP_INS_BANGDIEM
@MASV varchar(20),
@MAHP varchar(20),
@DIEMTHI varchar(10)
as
begin
	if (select count(*) from sys.symmetric_keys where name = 'DIEMTHI') = 0
		exec('create symmetric key DIEMTHI
			with algorithm = AES_256
			encryption by password = '''+'diemthi'+'''')

	exec('open symmetric key DIEMTHI decryption by password = '''+'diemthi'+'''')
	insert into BANGDIEM values(@MASV,@MAHP,encryptbykey(KEY_GUID('DIEMTHI'),@DIEMTHI))

	exec('close symmetric key DIEMTHI')
end;
go
create or alter proc SP_SELECT_BANGDIEM_HOCPHAN_SINHVIEN
@MASV varchar(20),
@MAHP varchar(20)
as
begin
	exec('open symmetric key DIEMTHI decryption by password = '''+'diemthi'+'''')

	select MASV, MAHP, convert(varchar(MAX),decryptbykey(DIEMTHI)) as DIEMTHI
	from BANGDIEM
	where MASV = @MASV AND MAHP=@MAHP

	exec('close symmetric key DIEMTHI')
end;
go
create or alter proc SP_UPDATE_BANGDIEM_SINHVIEN
@MASV varchar(20),
@MAHP varchar(20),
@DIEMTHI varchar(10)
as
begin
	if (select count(*) from sys.symmetric_keys where name = 'DIEMTHI') = 0
		create symmetric key DIEMTHI
			with algorithm = AES_256
			encryption by password = 'diemthi'

	open symmetric key DIEMTHI decryption by password = 'diemthi'
	update BANGDIEM 
	set DIEMTHI = encryptbykey(KEY_GUID('DIEMTHI'),@DIEMTHI)
	where MASV = @MASV AND MAHP = @MAHP 
	
	close symmetric key DIEMTHI
	EXEC SP_SELECT_BANGDIEM_HOCPHAN_SINHVIEN @MASV,@MAHP;
end;
go
create or alter proc SP_SELECT_BANGDIEM_SINHVIEN
@MASV varchar(20)
as
begin
	exec('open symmetric key DIEMTHI decryption by password = '''+'diemthi'+'''')

	select MASV, MAHP, convert(varchar(MAX),decryptbykey(DIEMTHI)) as DIEMTHI
	from BANGDIEM
	where MASV = @MASV

	exec('close symmetric key DIEMTHI')
end;



-- insert NHANVIEN
go
EXEC SP_INS_PUBLIC_NHANVIEN 'NV01', 'NGUYEN VAN A', 'nva@yahoo.com', 3000000, 'NVA', '123456'
EXEC SP_INS_PUBLIC_NHANVIEN 'NV02', 'NGUYEN VAN B', 'nvb@yahoo.com', 3000000, 'NVB', '123456'
EXEC SP_INS_PUBLIC_NHANVIEN 'NV03', 'NGUYEN VAN C', 'nvc@yahoo.com', 3000000, 'NVC', '123456'
EXEC SP_INS_PUBLIC_NHANVIEN 'NV04', 'NGUYEN VAN D', 'nvd@yahoo.com', 3000000, 'NVD', '123456'
EXEC SP_INS_PUBLIC_NHANVIEN 'NV05', 'NGUYEN VAN E', 'nve@yahoo.com', 3000000, 'NVE', '123456'
EXEC SP_INS_PUBLIC_NHANVIEN 'NV06', 'NGUYEN VAN G', 'nvg@yahoo.com', 3000000, 'NVG', '123456'

-- insert LOP
insert into LOP values
('CNTT-K17','Cong Nghe Thong Tin','NV01'),
('CNTT-K18','Cong Nghe Thong Tin','NV02'),
('CNTT-K19','Cong Nghe Thong Tin','NV03'),
('CNTT-K20','Cong Nghe Thong Tin','NV04'),
('CNTT-K21','Cong Nghe Thong Tin','NV05')

-- insert SINHVIEN

EXEC SP_INS_PUBLIC_SINHVIEN 'SV01', 'TRAN VAN A', '1990-1-1', '001 AN DUONG VUONG', 'CNTT-K17', 'TVA', '001'
EXEC SP_INS_PUBLIC_SINHVIEN 'SV02', 'TRAN VAN B', '1990-1-1', '002 AN DUONG VUONG', 'CNTT-K18', 'TVB', '002'
EXEC SP_INS_PUBLIC_SINHVIEN 'SV03', 'TRAN VAN C', '1990-1-1', '003 AN DUONG VUONG', 'CNTT-K19', 'TVC', '003'
EXEC SP_INS_PUBLIC_SINHVIEN 'SV04', 'TRAN VAN D', '1990-1-1', '004 AN DUONG VUONG', 'CNTT-K20', 'TVD', '004'
EXEC SP_INS_PUBLIC_SINHVIEN 'SV05', 'TRAN VAN E', '1990-1-1', '005 AN DUONG VUONG', 'CNTT-K21', 'TVE', '005'

-- insert HOCPHAN

insert into HOCPHAN values
('CSC001','Co So Nganh 1',4),
('CSC002','Co So Nganh 2',4),
('CSC003','Co So Nganh 3',4),
('CSC004','Co So Nganh 4',4),
('CSC005','Co So Nganh 5',4)


go

-- insert BANGDIEM
exec SP_INS_BANGDIEM 'SV01','CSC001','8'
exec SP_INS_BANGDIEM 'SV02','CSC002','8.5'
exec SP_INS_BANGDIEM 'SV03','CSC003','9'
exec SP_INS_BANGDIEM 'SV04','CSC004','9.5'
exec SP_INS_BANGDIEM 'SV05','CSC005','10'




