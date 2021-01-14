--Database Create With Properties
Use Master
--Drop Database IF EXISTS HMS_Alamgir
Drop Database IF EXISTS HMS_Alamgir
Go

Create Database HMS_Alamgir
ON Primary
(
Name='HMS_Alamgir_Data',FileName='C:\Users\idb_c#\HMS_Alamgir.mdf',Size=25MB,Maxsize=100MB,Filegrowth=5%
)
Log ON
(
Name='HMS_Alamgir_Log',FileName='C:\Users\idb_c#\HMS_Alamgir.ldf',Size=2MB,Maxsize=25MB,Filegrowth=1%
)
Go

--Table Create
Use HMS_Alamgir
Create Table Department
(
DepartmentID int primary key identity Not Null,
DepartmentName Varchar(50) Not Null
);
Go

--Table Create
Use HMS_Alamgir
Create Table Doctor
(
DoctorID int primary key identity ,
DepartmentID int Foreign key References Department(DepartmentID)On Update cascade,
DoctorName Varchar(50) Not Null,
Specialization Varchar(50) Not Null,
Address Varchar(50) Not Null,
ContactNo char(30) not null CHECK ((ContactNo Like '[0][1][1-9][1-9][1-9] [0-9][0-9][0-9] [0-9][0-9][0-9]')),
Email Varchar(50) Not Null
);
Go

--Table Create
Use HMS_Alamgir
Create Table Patient
(
PatientID int primary key identity Not Null,
DoctorID int Foreign key References Doctor(DoctorID)On Delete cascade,
PatientName Varchar(50) Not Null,
Age Varchar(10) Not Null,
Gender Varchar(15) Not Null,
Address Varchar(50) Not Null,
ContactNo Varchar(50),
Email Varchar(50) Not Null,
RoomID int Foreign key References Room(RoomID)
);
Go

--Table Create
Use HMS_Alamgir
Create Table Room
(
RoomID int primary key identity,
RoomNo int,
CatagoryID int Foreign key References RoomCatagory(CatagoryID)
);
Go

--Create Schema
Use HMS_Alamgir
GO
CREATE SCHEMA Room
GO

--Table Create
Use HMS_Alamgir
Create Table RoomCatagory
(
CatagoryID int primary  key identity ,
CatagoryName Varchar(30) Not Null,
SetCapacity int,
ContactNo Varchar(50) Not Null,
UnitPrice Money
);
Go

--Table Create
Use HMS_Alamgir
Create Table Medicine
(
MedicineID int primary key identity Not Null,
MedicineName Varchar(50) Not Null,
PatientID int Foreign key References Patient(PatientID),
UnitPrice Money,
Quantity Money,
Discount decimal,
TotalbillMedicine as (( UnitPrice * Quantity) -Discount)
);
Go

--Create Schema
Use HMS_Alamgir
GO
CREATE SCHEMA Medicine
GO

--Table Create
Use HMS_Alamgir
Create Table Lab
(
TestID int primary key identity Not Null,
TestName Varchar(50) Not Null,
PatientID int Foreign key References Patient(PatientID),
UnitPrice Money,
Quantity Money,
Discount decimal,
TotalLabbill as (( UnitPrice * Quantity)-Discount)
);
Go

--Table Create
Use HMS_Alamgir
Create Table Prescription
(
PrescriptionID int primary key identity,
PatientID int Foreign key References Patient(PatientID),
TestID int Foreign key References Lab(TestID),
MedicineID int Foreign key References Medicine(MedicineID) 
);
Go


--Table Create
Use HMS_Alamgir
Create Table #Record
(
RecoreNo int primary key identity Not Null,
PatientID int Foreign key References Patient(PatientID),
AdmissionDate Date not null default (getdate()),
DischargeDate Date not null default (getdate()),
TotalAdmissionDay Datetime,
Disease Varchar(50) Not Null
);
Go

Drop Table #Record

Select * From #Record
Select * From ##Bill

--Table Create
Use HMS_Alamgir
Create Table ##Bill
(
BillID int identity Not Null,
PatientID int Foreign key References Patient(PatientID),
BillPerDay Money,
AdmittedDay int,
TotalBill as (AdmittedDay*BillPerDay),
PaymentAmount Money,
DueAmount as ((AdmittedDay*BillPerDay)-PaymentAmount)
);
Go

--Create Clustered index

Create Nonclustered Index Nci_DoctorName on Doctor(DoctorName)
Go
--Create Nonclustered index
Create clustered Index ci_Totalbill on ##Bill(Totalbill )
Go
--Create View and Encryption
Create view vw_Doctor
with encryption
As
select DoctorID,DoctorName
From Doctor
Go

--Create View with Schemabinding
Create View vw_Schemabinding
with schemabinding
As
select l.TestID,l.PatientID,l.TestName,l.UnitPrice,p.PatientName
From dbo.Lab as l
Join dbo.Patient as p
On p.patientID=l.PatientID
Go
 
Select * from vw_Schemabinding


--Create Table Patient Information
Create Table Patient_Information
(
Patientid int,
Patientname varchar(50),
Age Varchar(10) ,
Gender Varchar(15) ,
Address Varchar(50) ,
ContactNo Varchar(50) ,
Email Varchar(50),
AuditAction varchar(300),
AuditTimeStamp datetime 
)
Go

--Create Tabular function
Create function fn_tabular_PatientSummary()
Returns Table
As
Return
(
select Doctor.DoctorID,DoctorName,Specialization
From Doctor
join Patient
on Doctor.DoctorID=Patient.DoctorID
Where PatientID=5
)
Go
Select * From fn_tabular_PatientSummary()
Go

--Create Sclar function
Create Function fn_Medicinebill_Summary()
Returns int
As
Begin
	Return
	(
	Select Sum(TotalbillMedicine) as [Total Amount]
	From Medicine
	)
End
Go

Print dbo.fn_Medicinebill_Summary()
Go


--Create After Trigger
Create Trigger tr_After_Insert_Patient_Information on dbo.Patient_Information
For Insert
As
Declare
@patientid int,
@patientname varchar(50),
@age Varchar(10) ,
@gender Varchar(15) ,
@address Varchar(50) ,
@contactNo Varchar(50) ,
@email Varchar(50) ,
@auditAction varchar(300),
@auditTimeStamp datetime 
Select @patientid =p.PatientID from inserted as p;
Select @patientname=p.PatientName from inserted as p;
Select @age=p.Age from inserted as p;
Select @gender=p.Gender from inserted as p;
Select @address=p.Address from inserted as p;
Select @contactNo=p.ContactNo from inserted as p;
Select @email=p.Email from inserted as p;
Set @auditAction='Row has been inserted in Patient Record Table';
Insert Into Patient_Information
( 
Patientid,Patientname,Age,Gender,Address,ContactNo,Email,AuditAction ,AuditTimeStamp 
)
Values ( 
@patientid,@patientname,@age,@gender,@address,@contactNo,@email,@auditAction,@auditTimeStamp 
)
Print 'After Trigger fired for insert'
Go

--Create Function get age
Create function dbo.fn_DateDiffInDayMonthYear
(
@datefrom datetime,
@dateto datetime
)
Returns varchar(Max)
As
Begin
    Declare @years int, @months int, @days int
    set @years = DATEDIFF(Year, @datefrom, @dateto)
    If Dateadd(YY, @years, @datefrom) > @dateto
    Begin
        set @years = @years - 1
    End
    set @datefrom = Dateadd(YY, @years, @datefrom)
    set @months = DATEDIFF(MM, @datefrom, @dateto)
    IF Dateadd(MM, @Months, @datefrom) > @dateto
    Begin
        set @months = @months - 1
    End
    set @datefrom = Dateadd(MM, @months, @datefrom)
    set @days = DATEDIFF(DD, @datefrom, @dateto)+1
    Return cast(@years As varchar) + ' Years '
            + cast(@months As varchar) + ' Months '
            + cast(@days As varchar) + ' Days'
End


Select dbo.fn_DateDiffInDayMonthYear('01/01/1992','02/09/2020')

