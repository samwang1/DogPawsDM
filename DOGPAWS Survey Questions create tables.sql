-- detail type, detail, person detail, person
USE DOGPAWS_Surveys_Temp
GO

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