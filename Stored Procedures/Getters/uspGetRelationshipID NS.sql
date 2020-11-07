USE DOGPAWS_TEST
GO

CREATE PROC uspGetRelationshipID
@RN varchar(30),
@R_ID INT OUTPUT
AS
SET @R_ID = (SELECT RelationshipID FROM tblRELATIONSHIP WHERE RelationshipName = @RN)