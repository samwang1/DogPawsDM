GO
CREATE PROC uspGetPerson
@fname varchar(20),
@lname varchar(20),
@dob DATE,
@ProfileID INT OUTPUT
AS
SET @ProfileID = (SELECT ProfileID FROM tblPROFILE WHERE Fname = @fname AND Lname = @lname AND BirthDate = @dob)
