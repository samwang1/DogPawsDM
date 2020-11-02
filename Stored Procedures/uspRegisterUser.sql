
-- stored procedure to register dogpaws user
-- parameters: first name, last name, email, username, password, DOB, netid, opt in

/* 

** Prevent SQL injection by cleaning up parameters in JS before sending to SQL **
** Password should not be a plain text, probably just save a hash value from Cryptographic Hash Algorithm like SHA-3 **

// 1. check if f/lname (email) already exist in tblPROFILE
// 		a. if exists, update row with additional info
// 		b. else, add new row with new info
// 2. 

*/
CREATE PROC uspRegisterUser
@fname varchar(50),
@lname varchar(50),
@email varchar(100),
@username varchar(50),
@password varchar(50),
@DOB date,
@netid varchar(30),
@optin bit,
@return_code int OUTPUT -- 1 = success, -1 = fail, 0 = user/database/server error
AS
BEGIN
	SET @return_code = -1
	IF NOT EXISTS (SELECT NetID FROM tblPROFILE WHERE NetID = @netid)
  	-- go ahead with insert
    BEGIN
      BEGIN TRAN T1
        INSERT INTO tblPROFILE(Fname, Lname, BirthDate, NetID, OptIn, Email, [Password])
        VALUES(@fname, @lname, @DOB, @netid, @optin, @email, @password)
      IF @@ERROR = 0
      	BEGIN
      		COMMIT TRAN T1
        	SET @return_code = 1
        END
      ELSE
      	BEGIN
          SET @return_code = 0
          ROLLBACK TRAN T1
        END
	END
END
GO