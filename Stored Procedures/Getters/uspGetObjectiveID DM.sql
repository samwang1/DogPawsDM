USE DOGPAWS_TEST
GO

CREATE PROCEDURE uspGetObjectiveID
@ObjName varchar(100),
@ObjID INT OUTPUT
AS
SET @ObjID = (SELECT ObjectiveID 
			FROM tblOBJECTIVE
			WHERE ObjectiveName = @ObjName)
GO
