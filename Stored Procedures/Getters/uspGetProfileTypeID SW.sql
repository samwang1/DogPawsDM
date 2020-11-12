USE DOGPAWS_TEST
GO

CREATE PROC uspGetProfileTypeID
@PT_Name varchar(50),
@PT_ID INT OUTPUT
AS
SET @PT_ID = (SELECT ProfileTypeID FROM tblPROFILE_TYPE WHERE ProfileTypeName = @PT_Name)

SELECT * FROM tblPROFILE_TYPE
INSERT INTO tblPROFILE_TYPE(ProfileTypeName)
VALUES('Student'), ('Faculty'), ('RSO')

DECLARE @out INT
EXEC uspGetProfileTypeID @PT_Name = 'Student' /* 'Faculty' / 'RSO' */, @PT_ID = @out OUTPUT
PRINT @out