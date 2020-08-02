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


