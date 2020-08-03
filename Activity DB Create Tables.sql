 -- section 1
CREATE TABLE tblCHARACTERISTIC (
	CharID INT primary key identity(1,1),
	CharName varchar(500) NULL,
	CharDescr varchar(500) NULL
)

CREATE TABLE tblPROFILE (
	ProfileID INT primary key identity(1,1),
	ProfName varchar(500) NULL,
	ProfDescr varchar(500) NULL
)

CREATE TABLE tblPROFILE_CHARACTERISTIC (
	ProfCharID INT primary key identity(1,1),
	CharID INT foreign key references tblCHARACTERISTIC(CharID) NOT NULL,
	ProfID INT foreign key references tblPROFILE(ProfileID) NOT NULL
)

 -- section 2
Create Table tblBUILDING(
	BuildingID int Primary Key Identity Not Null,
	BuildingeName varchar(100) Not Null,
);

Go
 Create Table tblLOCATION(
	LocationID int Primary Key Identity Not Null,
	LocationName varchar(100) Not Null,
	BuildingID int Not Null,
	Constraint fktblBuilding Foreign Key (BuildingID) References tblBUILDING(BuildingID)
);
Go


