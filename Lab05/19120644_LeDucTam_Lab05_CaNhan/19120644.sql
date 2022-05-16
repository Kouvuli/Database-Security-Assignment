/*----------------------------------------------------------
MASV:19120644	
HO TEN:LE DUC TAM
LAB: 05
NGAY:15/05/2022
----------------------------------------------------------*/
--Server A
-- Tao master key Server A
USE master
Go
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '19120644'
GO
-- Mo master key vua tao de su dung
OPEN MASTER KEY DECRYPTION BY PASSWORD='19120644' 
GO
--Tao certificate QLBongDaCert
Create CERTIFICATE QLBongDaCert
With Subject = 'QLBongDaCert'

--Tao key aa hoa DB QLBongDa bang certificate vua tao bang thuat toan AES_128
USE QLBongDa
GO
CREATE DATABASE ENCRYPTION KEY
	WITH ALGORITHM = AES_128
	ENCRYPTION BY SERVER CERTIFICATE QLBongDaCert


ALTER DATABASE QLBongDa SET ENCRYPTION ON


--Luu certificate va khoa da duoc giai ma vao trong D:\BK
USE master
GO 
BACKUP CERTIFICATE QLBongDaCert  to file = 'D:\BK\QLBongDaCert.cert'
WITH PRIVATE KEY(
FILE = 'D:\BK\QLBongDaCert.pvk',
ENCRYPTION BY PASSWORD = '19120644'
)
GO

-------------------------------------------------------------------------------------------------------
--Server B 
-- Tao master key o server B
USE master
Go
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '123456'
GO
OPEN MASTER KEY DECRYPTION BY PASSWORD ='123456'
GO
-- Tao certificate voi key tu cert voi key da co trong thu muc BK1 và password 19120644 
USE master
GO
CREATE CERTIFICATE QLBongDaCert FROM file = 'D:\BK1\QLBongDaCert.cert'
WITH PRIVATE KEY(
FILE = 'D:\BK1\QLBongDaCert.pvk',
DECRYPTION BY PASSWORD = '19120644'
)
GO