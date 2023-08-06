USE ShopHere
GO

--CRUCIAL DATA ENCRYPTION
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Masterkey'
GO
CREATE CERTIFICATE ShopHereCertificate
WITH SUBJECT = 'Protect Crucial Data'
GO
CREATE SYMMETRIC KEY ShopHereSymKey
WITH ALGORITHM = AES_256 ENCRYPTION BY CERTIFICATE ShopHereCertificate
GO
ALTER TABLE HumanResources.Employee
ADD PhoneEncrypted varbinary(MAX)
GO
OPEN SYMMETRIC KEY ShopHereSymKey
	DECRYPTION BY CERTIFICATE ShopHereCertificate
GO
UPDATE HumanResources.Employee
	SET PhoneEncrypted = ENCRYPTBYKEY (KEY_GUID('ShopHereSymKey'), Phone)
	FROM HumanResources.Employee
GO
CLOSE SYMMETRIC KEY ShopHereSymKey
GO