 -- section 1
CREATE TABLE tblCHARACTERISTIC (
	CharID INT primary key identity(1,1),
	CharName varchar(500) NULL,
	CharDescr varchar(500) NULL
)

CREATE TABLE tblPROFILE (
	ProfileID INT primary key identity(1,1),
	Fname varchar(500) NULL,
	Lname varchar(500) NULL,
	Email varchar(500) NULL,
	ProfDescr varchar(500) NULL
)

CREATE TABLE tblPROFILE_CHARACTERISTIC (
	ProfCharID INT primary key identity(1,1),
	CharID INT foreign key references tblCHARACTERISTIC(CharID) NOT NULL,
	ProfID INT foreign key references tblPROFILE(ProfileID) NOT NULL
)


/*

CREATE TABLE tblPROFILE_TYPE (
	ProfTypeID INT PRIMARY KEY IDENTITY(1,1),
	ProfTypeName varchar(30) NOT NULL,
	ProfTypeDesc varchar(500)
)

*/
 -- section 2

Create Table tblLOCATION(
	LocationID int Primary Key Identity(1,1),
	LocationName varchar(100) Not Null,
	LocationDesc varchar(500)
);

Create Table tblBUILDING(
	BuildingID int Primary Key Identity(1,1),
	LocationID INT FOREIGN KEY REFERENCES tblLOCATION(LocationID),
	BuildingName varchar(100) Not Null,
	BuildingDesc varchar(500),
	BuildingShortName varchar(10)
);


-- Section 3

CREATE TABLE tblQUARTER(
    QuarterID int Identity,
    QuarterName varchar(20),
    CONSTRAINT pkQUARTER PRIMARY KEY (QuarterID)
);

CREATE TABLE tblCOURSE(
    CourseID int Identity,
	CourseName varchar(100),
    CoursePrefix varchar(10),
    CourseLevel varchar(10)
);

CREATE TABLE tblCLASS(
    ClassID int Identity,
    CourseID int,
    QuarterID int,
    [Year] varchar(4),
	Section varchar(2),
    CONSTRAINT pkClass PRIMARY KEY (ClassID),
    CONSTRAINT fkCourse FOREIGN KEY (CourseID) REFERENCES tblCOURSE(CourseID),
    CONSTRAINT fkQuarter FOREIGN KEY (QuarterID) REFERENCES tblQUARTER(QuarterID)
);

-- Section 4
CREATE TABLE tblACTIVITY (
	ActivityID INT PRIMARY KEY IDENTITY(1,1),
	ProfileID INT FOREIGN KEY REFERENCES tblPROFILE(ProfileID) NOT NULL,
	ClassID INT FOREIGN KEY REFERENCES tblCLASS(ClassID),
	BuildingID INT FOREIGN KEY REFERENCES tblBUILDING(BuildingID) NOT NULL,
	InterestID INT FOREIGN KEY REFERENCES tblINTEREST(InterestID) NOT NULL
)

CREATE TABLE tblRATING (
	RatingID INT PRIMARY KEY IDENTITY(1,1),
	RatingName varchar(50) NOT NULL,
	RatingAbbrev varchar(50) NOT NULL,
	RatingNumeric varchar(50) NOT NULL,
	RatingDescr varchar(500)
)

CREATE TABLE tblREVIEW (
	ReviewID INT PRIMARY KEY IDENTITY(1,1),
	ActivityID INT FOREIGN KEY REFERENCES tblACTIVITY(ActivityID) NOT NULL,
	RatingID INT FOREIGN KEY REFERENCES tblRATING(RatingID) NOT NULL,
	ReviewContent varchar(2000) NOT NULL,
	ReviewDate datetime NOT NULL
)


-- Section 5

CREATE TABLE tblINTEREST_TYPE(
	InterestTypeID INT PRIMARY KEY IDENTITY(1,1),
	InterestTypeName VARCHAR(100) NOT NULL,
	InterestTypeDescr VARCHAR(500) NULL
);
GO

CREATE TABLE tblACTIVITY_TYPE(
	ActivityTypeID INT PRIMARY KEY IDENTITY(1,1),
	ActivityTypeName VARCHAR(100) NOT NULL,
	ActivityTypeDescr VARCHAR(500) NULL
);
GO

CREATE TABLE tblINTEREST(
	InterestID INT PRIMARY KEY IDENTITY(1,1),
	InterestTypeID INT FOREIGN KEY REFERENCES tblINTEREST_TYPE(InterestTypeID) NOT NULL,
	InterestName VARCHAR(100) NOT NULL,
	InterestDescr VARCHAR(500) NULL
);
GO