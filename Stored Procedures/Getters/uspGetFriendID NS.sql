USE DOGPAWS_TEST
GO

CREATE PROC uspGetFriendID
@email1 varchar(50),
@email2 varchar(50),
@F_ID INT OUTPUT
AS
DECLARE @P_ID1 INT, @P_ID2 INT
EXEC uspGetProfileID @email = @email1, @ProfileID = @P_ID1 OUTPUT
EXEC uspGetProfileID @email = @email2, @ProfileID = @P_ID2 OUTPUT

Set @F_ID = (SELECT FriendID FROM tblFRIEND WHERE ProfileID1 = @P_ID1 AND ProfileID2 = @P_ID2)

DECLARE @OUT INT
EXEC uspGetFriendID @email1 = 'suyashdps@gmail.com', @email2 = 'anjali23@uw.edu', @F_ID = @OUT OUTPUT
PRINT(@OUT)

SELECT * FROM tblPROFILE

SELECT * FROM tblFRIEND
INSERT INTO tblFRIEND(ProfileID1, ProfileID2, RelationshipID, AddDate)
VALUES(1, 2, 1,  GETDATE())


SELECT * FROM tblRELATIONSHIP
INSERT INTO tblRELATIONSHIP(RelationshipName)
VALUES('test')