Use HMS_Alamgir
Insert into Department Values('ICU'),('CCU'),('Operation Theater'),('Emergency & Casuality'),('Nephrology'),('Physiotherapy'),('Labour'),
('Cardiology'),('Pathology'),('Radiology & Imaging'),('Urology'),('Medicine'),('Surgery'),('Gynae'),('Orthopaedics'),('Paediatrics'),('ENT'),('Dental'),
('Gastroliver'),('Oncology'),('Skin'),('Eye')
Go

Use HMS_Alamgir
Insert into Doctor Values(1,'Alamgir','Medicine','Rajshahi','01745 425 498','alamgirkabir45789@gmail.com'),
							(2,'Apple','Surgery','Dhaka','01745 425 499','alamgirkabir45789@gmail.com'),
							(3,'Moin','Gynae','Feni','01745 455 498','moin@gmail.com'),
							(4,'Iqbal','Cumilla','Rajshahi','01445 425 498','iqbal@gmail.com'),
							(5,'Hagan','Eye','Bogura','01745 725 498','hasan@gmail.com'),
							(6,'Arif','Dental','Banderban','01545 425 498','arif@gmail.com'),
							(7,'Tarek','Onchology','Rangamati','01745 425 418','tarek@gmail.com'),
							(8,'Arefin','Urology','Khulna','01745 425 398','arefin45789@gmail.com'),
							(9,'Asraful','Nephrology','Kushtia','01745 485 498','asraful@gmail.com'),
							(10,'Rayhan','Pathology','Chittagong','01725 425 498','rayhan45789@gmail.com')
Go

Use HMS_Alamgir
Insert into Patient Values(2,'Apple','Fifteen','Male','Dhaka','01785 425 499','apple45789@gmail.com',3),
							(3,'Moimuna','Fifty','Female','Feni','01745 455 498','moin@gmail.com',5),
							(4,'Iqbal','Six','Male','Rajshahi','01445 425 498','iqbal@gmail.com',4),
							(5,'Hasan','Five','Male','Bogura','01745 725 498','hasan@gmail.com',1),
							(6,'Arifa','Seventeen','Female','Banderban','01545 425 498','arif@gmail.com',6),
							(7,'Tarek','Eighty','Male','Rangamati','01745 425 418','tarek@gmail.com',4),
							(8,'Arefina','Thirty','Female','Khulna','01745 425 398','arefin45789@gmail.com',4),
							(9,'Asraful','Twenty','Male','Kushtia','01745 485 498','asraful@gmail.com',3),
							(10,'Rayhana','Ten','Female','Chittagong','01725 425 498','rayhana45789@gmail.com',2)
Go

Use HMS_Alamgir
Insert into Prescription Values(5,3,3),
								(6,5,4),
								(8,4,5),
								(12,6,4),
								(6,1,5),
								(7,3,1),
								(9,5,6)
Go

Use HMS_Alamgir
Insert into Room Values(105,1),(108,5),(405,4),(505,3),(201,2),(306,6)
Go

Use HMS_Alamgir
Insert into RoomCatagory Values('Word',30,'01918-521506',200),
								('Cabin',5,'01918-521506',400),
								('Word_AC',10,'01918-521506',500),
								('Cabin_AC',2,'01918-521506',800),
								('ICU',5,'01918-521506',1000),
								('CCU',10,'01918-521506',1500)
Go

Use HMS_Alamgir
Insert into Medicine Values('Tab.Napa',13,20,5,0.001),
								('Tab.Ace-500mg',5,20,5,0.001),
								('Tab.Ace-250mg',11,20,2,0.001),
								('Cap.Seclo-20mg',12,50,5,0.001),
								('Tab.Zimax-500mg',9,180,2,0.001),
								('Syp.Gepin',8,20,1,0.001)
Go

Use HMS_Alamgir
Insert into Lab Values('X-Ray',13,200,1,0.05),
						('Ultrasound',9,400,1,0.01),
						('Urine R/E',8,200,1,0.01),
						('MRI',12,2000,1,0.05),
						('CBC',5,100,1,0.01),
						('HBSAg',8,200,1,0.01)
								
Go

Use HMS_Alamgir
Insert into #Record Values(3,1,'01-02-2019','21-02-2019','Br.Asthma'),
						(3,1,'01-05-2019','21-05-2019','CVD'),
						(3,1,'01-03-2019','21-04-2019','Fever'),
						(3,1,'11-02-2019','21-02-2019','COPD'),
						(3,1,'01-07-2019','2-08-2019','Pleural effusion'),
						(3,1,'01-02-2019','21-09-2019','Miocardial Infraction')
						
Go

Use HMS_Alamgir
Insert into ##Bill Values(5,500,5,50),
					(11,500,5,100),
					(5,200,3,200),
					(9,100,3,100),
					(12,2000,5,60),
					(7,400,5,40)
Go
--Select Quary
Use HMS_Alamgir
Select * From Patient
Select * From Room
Select * From Doctor
Select * From Department
Select * From Medicine
Select * From Lab
Select * From prescription
Select * From RoomCatagory
Select * From ##Bill


--Inner Join
Select *
  From Patient p
  Join Doctor d
  On p.DoctorID=d.DoctorID
  Join Prescription t
  On t.PatientID=p.PatientID
  Where(p.Gender='Male')
Go
----Update Value
Update Doctor
Set DoctorName='Asraf'
Where DoctorID=9
Go
----Delete Value
Delete From Doctor Where DoctorID=1
Go
--Left Outer Join
Select Lab.TestID,TestName,UnitPrice,TotalLabbill
From Lab
Left join Patient
On Lab.PatientID=Patient.PatientID
Go
----Right Outer Join
Select Medicine.MedicineID,MedicineName,UnitPrice,TotalbillMedicine
From Medicine
Right join Patient
On Medicine.PatientID=Patient.PatientID
Go
----Full Outer Join
Select Patient.PatientID,PatientName,Age
From Patient
Full join Doctor
On Patient.DoctorID=Doctor.DoctorID
Go
----Cross Join
Select Patient.PatientID,PatientName,Gender
From Patient
Cross join Doctor
Go
----Self Join
Select MedicineID,MedicineName
From Medicine as m,Patient as p
Where m.MedicineID<>p.PatientID
Go
----Union
Select PatientID as ptid
From Patient
Union 
Select DoctorID as did
From Doctor
Go 
----Union All
Select DoctorID From Doctor
Union All
Select DepartmentID
From Department
Go

--Cast, Convert, Concatenation

Select ' Today : '+ Cast(Getdate() as varchar)
Go
Select 'Today : ' + Convert( varchar,GETDATE(),3) 
Go

--6 Basic Clause (Select,From, Where, Having, Group By, Order By
Select  MedicineName ,count(MedicineID) 
From  Medicine   
Where MedicineName='Ace'
Group By MedicineName
Having Count(MedicineID)>=1
Order BY MedicineName DESC
GO

----Distinct
Select Distinct PatientName,Age,Gender,Address
From Patient
Go
----Sub Query
Select *
From Patient
Where PatientID=8
Go
----WildCard
Select *
From Doctor
Where DoctorName Like 'a_e_in%';
Go

--Cube, Rollup, Grouping Set

Select Medicine.MedicineID,MedicineName,PatientID,TotalbillMedicine
From  Medicine
Group by MedicineID,MedicineName,PatientID ,TotalbillMedicine With Cube
Go
--Rollup
Select Medicine.MedicineID,MedicineName,PatientID,TotalbillMedicine
From  Medicine
Group by MedicineID,MedicineName,PatientID ,TotalbillMedicine With Rollup
Go
--Grouping Set
Select Medicine.MedicineID,MedicineName,PatientID,TotalbillMedicine
From  Medicine
Group by GROUPING sets( MedicineID,MedicineName,PatientID,TotalbillMedicine)
Go

--Select Into.Copy Data From Another Table
Select *
Into #Record
From Patient
Go

Select * From #Record
Go

--Drop Table
Drop Table #Record
Go

---Truncate Table
Truncate Table ##Bill
Go
--While,If,Else Loop
Declare @a int
Set @a=6
While @a<=8
Begin
	If(@a%3=0)
		Begin
			Print (@a)
			
		End


	Else
		Begin
			Print cast(@a as varchar ) + 'Skip'
		End
		Set @a=@a+3
End
Go

--CTE for counting How Many Doctor are in all Specialization 
Use HMS_Alamgir
Go
with Medicine_CTE(MedicineID,MedicineName,PatientID,TotalbillMedicine)
As
(
Select MedicineID,MedicineName,PatientID,TotalbillMedicine
From Medicine
Where MedicineID Is Not Null
)
Select * From Medicine_CTE
Go

--Create Sequence
Use HMS_Alamgir
Create Sequence sq_Contacts
	As Bigint
	Start With 1
	Increment By 1
	Minvalue 1
	Maxvalue 99999
	No Cycle
	Cache 10;
	GO

Select Next value for sq_Contacts;
GO

--Operator
Select 10+5 as [Sum]
Go
Select 50-20 as [Subtraction]
Go
Select 15*5 as [Multiplication]
Go
Select 60/20 as [Divide]
Go
Select 15%5 as [Remainder]
Go

-- Floor, Round , Celling
Declare @Value decimal (10,2)
Set @Value =11.05
Select Round(@value,0)
Select Ceiling (@value)
Select Floor (@value)

-- Date Format
Select Getdate()
Select DATEDIFF ( YY,cast('06/06/1993' as datetime),GETDATE()) as Years,
       DATEDIFF ( MM,cast('06/06/1993' as datetime),GETDATE()) %12 As Months,
	   DATEDIFF ( DD,cast('06/06/1993' as datetime),GETDATE()) %30 as Days

Go


--Create Trigger for InsertUpdate
Create Trigger tr_insteadoftrigger_insert_update on Medicine
For Insert ,Update
As
if Exists
(
Select 'True'
From inserted i
Join Medicine as m
On i.MedicineID=m.MedicineID
Where m.UnitPrice>20
)
Begin
	Raiserror('Data inserted is not Allowed',15,3)
	Print'Pnsertion Error'
	Rollback Tran
End
Go


Insert into Medicine Values('Tab.Naprox',13,20,5,0.001)
Go

Update Medicine
Set UnitPrice=30
Where MedicineID=6
Go
Select * From Medicine
Go

--Create Trigger for Delete
Create Trigger tr_insteadoftrigger_delete on Medicine
For Delete
As
Begin
	If Exists (Select * From deleted d)
		Begin
			Raiserror('Data deleted is not Allowed',15,3)
			Print'Delete Error'
			Rollback Tran
		End
End
Go


Delete Medicine 
Where MedicineID=6
GO

---Create Procedure and Transaction(Commit,Rollbac)
Create Proc sp_Lab
@testid int,
@testname varchar(20),
@patientid int,
@unitprice money,
@quantity int,
@discount decimal,
@message varchar(30) output
As
Begin
	
	Begin Try
		Begin Transaction
				Insert into Lab(TestID,TestName,PatientID,UnitPrice,Quantity,Discount)
				Values(@testid,@testname,@patientid,@unitprice,@quantity,@discount)
				set @message='Data inserted successfully'
				Print @message
		Commit Transaction
	End Try

	Begin catch
				Rollback Transaction
				Print ('Something goes wrong!!!')

	End catch


End
Go


--Case
SELECT MedicineID,Unitprice,
	CASE
	WHEN Unitprice>20 THEN 'The Unitprice in Greater then 20000'
	WHEN Unitprice=20 THEN 'The Unitprice is 20000'
	ELSE 'The Unitprice in Under then 20000'
END	AS Ace 
FROM Medicine
GO



--Aggregate function
SELECT COUNT (*) FROM Medicine
SELECT AVG (Unitprice) FROM Medicine
SELECT MIN (Unitprice) FROM Medicine
SELECT MAX (Unitprice) FROM Medicine

Begin Tran
Delete From Patient
Where PatientID=8

Go

Commit Tran

Go

RollBack Tran ;
Go

Begin tran 
Save Tran SP10
Insert into Patient Values(2,'Anwar','Fifteen','Male','Dhaka','01785 425 499','apple45789@gmail.com',3)


Go 
Select * From Patient
Begin Tran
Save Tran SP11
Update Patient 
set PatientName = 'Iqbal' Where PatientID =6

Go

Begin Tran
Save Tran SP12
Delete From Patient
Where PatientID=9



Rollback Tran SP10

Go

--Average , Distinct, AND, OR,,NOT,BETWEEN,ALL,Any
--*************************************************

SELECT *   
FROM Medicine  
WHERE MedicineID=1
OR MedicineID=2   
AND UnitPrice > 100
ORDER BY MedicineID DESC 

Go

SELECT MedicineID  
FROM Medicine  
WHERE MedicineID= Any (Select MedicineID From Medicine Where UnitPrice> 100)
ORDER BY  MedicineID DESC; 
Go

SELECT MedicineID  
FROM Medicine  
WHERE MedicineID= All (Select MedicineID From Medicine Where UnitPrice> 100)
ORDER BY  MedicineID DESC; 
Go

SELECT *   
FROM Medicine  
WHERE UnitPrice Between 50 And 200
ORDER BY UnitPrice DESC 
Go

SELECT *   
FROM Medicine  
WHERE UnitPrice Not Between 50 And 200
ORDER BY UnitPrice DESC 
Go

