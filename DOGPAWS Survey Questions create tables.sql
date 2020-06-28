-- detail type, detail, person detail, person
USE DOGPAWS_Surveys_Temp
GO

Create Table tblSURVEY_TYPE(
	SurveyTypeID int Identity Not Null,
	SurveyTypeName varchar(100) Not Null,
	SurveyTypeDescr varchar(500) Not Null,
	Constraint pktblSURVEY_TYPE Primary Key (SurveyTypeID)
);
Go

Create Table tblOBJECTIVE(
	ObjectiveID int Identity Not Null,
	ObjectiveName varchar(100) Not Null,
	ObjectiveDescr varchar(500) Not Null,
	Constraint pktblOBJECTIVE Primary Key (ObjectiveID)
);
Go

Create Table tbLDISTRIBUTION(
	DistributionID int Identity Not Null,
	DistributionName varchar(100) Not Null,
	DistributionDescr varchar(500) Not Null,
	Constraint pktblDistribution Primary Key (DistributionID)
);
Go

Create Table tblSURVEY(
	SurveyID int Identity Not Null,
	SurveyTypeID int Not Null,
	SurveyName varchar(100) Not Null,
	SurveyBeginDate date Not Null,
	SurveyEndDate date Not Null,
	Constraint pktblSURVEY Primary Key (SurveyID),
	Constraint fkSurveyTypeID Foreign Key (SurveyTypeID) References tblSURVEY_TYPE(SurveyTypeID)
);
Go

Create Table tblSURVEY_DISTRIBUTION(
	SurveyDistID int Identity Not Null,
	SurveyID int Not Null,
	DistributionID int Not Null,
	SurveyDisDate date Not Null,
	Constraint pktblSURVEY_DISTRIBUTION Primary Key (SurveyDistID),
	Constraint fkSurveyID Foreign Key (SurveyID) References tblSURVEY(SurveyID),
	Constraint fkDistributionID Foreign Key (DistributionID) References tblDISTRIBUTION(DistributionID)
);
Go

CREATE TABLE tblDETAIL_TYPE(
	DetailTypeID INT PRIMARY KEY IDENTITY(1,1),
	DetailTypeName varchar(50) NOT NULL,
	DetailTypeDescr varchar(500)
)

CREATE TABLE tblDETAIL(
	DetailID INT PRIMARY KEY IDENTITY(1,1),
	DetailName varchar(50) NOT NULL,
	DetailTypeID INT FOREIGN KEY REFERENCES tblDETAIL_TYPE(DetailTypeID),
	DetailDesc varchar(500)
)

CREATE TABLE tblPERSON(
	PersonID INT PRIMARY KEY IDENTITY(1,1),
	Fname varchar(20) NOT NULL,
	Lname varchar(20) NOT NULL,
	BirthDate DATE NOT NULL,
	NetID INT NOT NULL,
	Email varchar(50)
)

CREATE TABLE tblPERSON_DETAIL(
	PersonDetailID INT PRIMARY KEY IDENTITY(1,1),
	PersonID INT FOREIGN KEY REFERENCES tblPERSON(PersonID),
	DetailID INT FOREIGN KEY REFERENCES tblDETAIL(DetailID),
	DateValue DATE,
	CharValue CHAR,
	NumericValue NUMERIC
)

-- create Table tblSURVEY_OBJECTIVE
Create Table tblSURVEY_OBJECTIVE(
    SurveyObjectiveID int Constraint pkSurveyObjectiveID Primary Key Identity,
    SurveyID int,
    ObjectiveID int
)
go

-- create Table tblSURVEY_STATUS
Create Table tblSURVEY_STATUS(
    SurveyStatusID int Constraint pkSurveyStatusID Primary Key Identity,
    SurveyID int,
    StatusID int,
    BeginDate date
)
go

-- create Table tblSTATUS
Create Table tblSTATUS(
    StatusID int Constraint pkStatusID Primary Key Identity,
    StatusName nvarchar(100),
    StatusDescr nvarchar(100)
)
go



-- alter the table to add with constraints (foreign keys)
Alter Table tblSURVEY_OBJECTIVE
Add Constraint fkSurveyIDSO Foreign Key(SurveyID) References tblSURVEY(SurveyID),
    Constraint fkObjectiveID Foreign Key(ObjectiveID) References tblOBJECTIVE(ObjectiveID)
Alter Table tblSURVEY_STATUS
Add Constraint fkSurveyIDSS Foreign Key(SurveyID) References tblSURVEY(SurveyID),