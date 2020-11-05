-- stored procedure to add a friend

-- both people already exist in tblPROFILE

-- input parameters: [fname1, lname1, dob1](can be replaced by netid1), [fname2, lname2, dob2](netid2), relationship


CREATE PROC uspAddFriend
@fname1 varchar(20),
@lname1 varchar(20),
@dob1 DATE,
@fname2 varchar(20),
@lname2 varchar(20),
@dob2 DATE,
@relationship varchar(30)

AS
BEGIN
	DECLARE @P1ID INT, @P2ID INT, @RID INT
  
  -- assume relationship is a lookup table with default value "Other"
  SET @RID = (SELECT RelationshipID FROM tblRELATIONSHIP WHERE RelationshipName = @relationship)
  
  EXEC uspGetProfileID
  @fname = @fname1,
  @lname = @lname1,
  @dob = @dob1,
  @P1ID = @ProfileID OUTPUT
  IF @P1ID IS NULL
  BEGIN
  	PRINT 'Error, Profile 1 not found'
    RAISERROR ('@P1ID cannot be NULL', 11, 1)
  END
  
  EXEC uspGetProfileID
  @fname = @fname2,
  @lname = @lname2,
  @dob = @dob2,
  @P2ID = @ProfileID OUTPUT
  IF @P2ID IS NULL
  BEGIN
  	PRINT 'Error, Profile 2 not found'
    RAISERROR ('@P2ID cannot be NULL', 11, 1)
  END

	BEGIN TRAN T1
  	INSERT INTO tblFRIEND(ProfileID1, ProfileID2, RelationshipID, AddDate)
		values(@P1ID, @P2ID, @RID, GETDATE())
    
    INSERT INTO tblFRIEND(ProfileID1, ProfileID2, RelationshipID, AddDate)
		values(@P2ID, @P1ID, @RID, GETDATE())
    
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK TRAN T1
      END
  	ELSE
  		COMMIT TRAN T1
END