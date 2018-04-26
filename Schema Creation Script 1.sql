-- ist-cs-dw1.ad.syr.edu

Use ist722_fudge_c6_dw
Go

-----DROP TABLES-----

/* Drop table dbo.FactOrders */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge.FactOrders') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge.FactOrders 
;
/* Drop table dbo.FactOrdersFraud */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge.FactOrdersFraud') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge.FactOrdersFraud 
;

/* Drop table fudge.DimDate */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge.DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge.DimDate 
;
/* Drop table fudge.DimClient */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge.DimClient') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge.DimClient 
;
/* Drop table fudge.DimProduct */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge.DimProduct') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge.DimProduct 
;
/* Drop table fudge.DimTitles */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge.DimTitles') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge.DimTitles 
;

-----CREATE TABLES-----

/* Create table fudge.DimClient */
CREATE TABLE fudge.DimClient (
   [ClientKey]  int IDENTITY  NOT NULL
,  [ClientEmail]  varchar(200)   NOT NULL
,  [ClientSource]  varchar(10)   NULL
,  [ClientFirstName]  varchar(50)   NOT NULL
,  [ClientLastName]  varchar(50)   NOT NULL
,  [ClientName]  varchar(102)   NOT NULL
,  [ClientNameReverse]  varchar(102)   NOT NULL
,  [ClientCity]  varchar(50)   NOT NULL
,  [ClientState]  varchar(20)   NOT NULL
,  [ClientZip]  varchar(20)   NOT NULL
,  [ClientCityState]  varchar(1000)   NOT NULL
,  [ClientStreetAddress]  varchar(1000)   NULL
,  [ClientAddressCityState]  varchar(1074)   NOT NULL
,  [RowIsCurrent]  bit DEFAULT  1 NOT NULL
,  [RowStartDate]  datetime DEFAULT '1/1/1900'  NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_fudge.DimClient] PRIMARY KEY CLUSTERED 
( [ClientKey] )
) ON [PRIMARY]
;


/* Create table fudge.DimProduct */
CREATE TABLE fudge.DimProduct (
   [ProductKey]  int IDENTITY  NOT NULL
,  [ProductID]  int   NOT NULL
,  [ProductDepartment]  varchar(50)   NOT NULL
,  [ProductName]  varchar(50)   NOT NULL
,  [ProductActive]  bit  DEFAULT 1 NOT NULL
,  [VendorName]  varchar(50)   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_fudge.DimProduct] PRIMARY KEY CLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;
--Unknown Product Member
SET IDENTITY_INSERT fudge.DimProduct ON
;
INSERT INTO fudge.DimProduct (ProductKey, ProductID, ProductDepartment, ProductName, ProductActive, VendorName, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'None', 'None', 0, 'None', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT fudge.DimProduct OFF
;



/* Create table fudge.DimTitles */
CREATE TABLE fudge.DimTitles (
   [TitleKey]  int IDENTITY  NOT NULL
,  [TitleID]  varchar(50)   NOT NULL
,  [TitleName]  varchar(200)   NOT NULL
,  [TitleType]  varchar(50)   NOT NULL
,  [TitleTopGenre]  varchar(200)   NOT NULL
,  [TitleRating]  varchar(50)   NOT NULL
,  [TitleBlurayAvailable]  bit  DEFAULT 0 NOT NULL
,  [TitleDvdAvailable]  bit  DEFAULT 0 NOT NULL
,  [TitleInstantAvailable]  bit  DEFAULT 0 NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_fudge.DimTitles] PRIMARY KEY CLUSTERED 
( [TitleKey] )
) ON [PRIMARY]
;
-- Title Unknown Member
SET IDENTITY_INSERT fudge.DimTitles ON
;
INSERT INTO fudge.DimTitles (TitleKey, TitleID, TitleName, TitleType, TitleTopGenre, TitleRating, TitleBlurayAvailable, TitleDvdAvailable, TitleInstantAvailable, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, '-1', 'None', 'None', 'None', 'None', 0, 0, 0, 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT fudge.DimTitles OFF
;


/* Create table fudge.DimDate */
CREATE TABLE fudge.DimDate (
   [DateKey]  int   NOT NULL
,  [Date]  datetime   NULL
,  [FullDateUSA]  nchar(11)   NULL
,  [DayOfWeek]  tinyint   NULL
,  [DayName]  nchar(10)   NULL
,  [DayOfMonth]  tinyint   NULL
,  [DayOfYear]  smallint   NULL
,  [WeekOfYear]  tinyint   NULL
,  [MonthName]  nchar(10)   NULL
,  [MonthOfYear]  tinyint   NULL
,  [Quarter]  tinyint   NULL
,  [QuarterName]  nchar(10)   NULL
,  [Year]  smallint   NULL
,  [IsWeekday]  bit  DEFAULT 0 NULL
, CONSTRAINT [PK_fudge.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;
INSERT INTO fudge.DimDate (DateKey, Date, FullDateUSA, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, QuarterName, Year, IsWeekday)
VALUES (-1, null, 'Unk date', 0, 'Unk date', 0, 0, 0, 'Unk month', 0, 0, 'Unk qtr', 0, 0)
;





/* Create table fudge.FactOrdersFraud */
CREATE TABLE fudge.FactOrdersFraud (
   [OrderID]  int   NOT NULL
,  [ClientKey]  int  DEFAULT -1 NOT NULL
,  [OrderDateKey]  int  DEFAULT -1 NOT NULL
,  [ShippedDateKey]  int  DEFAULT -1 NOT NULL
,  [ExpiryDateKey]  int  DEFAULT -1 NOT NULL
,  [CreditCard]  varchar(50) DEFAULT 'Unknown'  NOT NULL
,  [ShipVia]  varchar(20)   NOT NULL
,  [OrderCount]  int   NULL
,  [ShipCount]  int   NULL
,  [CreditCardBelongsToCustomer]  char(3)   NULL
,  [QuantityOfItems]  int   NULL
, CONSTRAINT [PK_fudge.FactOrdersFraud] PRIMARY KEY NONCLUSTERED 
( [OrderID], [ClientKey] )
) ON [PRIMARY]
;






/* Create table dbo.FactOrders */
CREATE TABLE fudge.FactOrders (
   [OrderID]  int DEFAULT -1  NOT NULL
,  [OrderSubID] int DEFAULT -1 NOT NULL
,  [AccountTitleID]  int  DEFAULT -1 NOT NULL
,  [ClientKey]  int  DEFAULT -1 NOT NULL
,  [SourceSystem]  varchar(9)  NOT NULL
,  [TitleKey]  int  DEFAULT -1 NOT NULL
,  [ProductKey]  int  DEFAULT -1 NOT NULL
,  [OrderDateKey]  int  DEFAULT -1 NOT NULL
,  [ShippedDateKey]  int  DEFAULT -1 NOT NULL
,  [SalesPrice]  money   NULL
,  [Quantity]  int   NULL
,  [ExtendedPriceAmount]  money   NULL
,  [View_Count]  int   NULL
,  [EstimatedCostOfMovie]  money   NULL
,  [Order_Count]  int   NULL
,  [Ship_Count]  int   NULL
,  [DaysToShip]  int   NULL
, CONSTRAINT [PK_fudge.FactOrders] PRIMARY KEY NONCLUSTERED 
( [OrderID], [TitleID], [ClientKey] ,[OrderSubID])
) ON [PRIMARY]
;


----- FactOrders Constraints -----
ALTER TABLE fudge.FactOrders ADD CONSTRAINT
   FK_dbo_FactOrders_ClientKey FOREIGN KEY
   (
   ClientKey
   ) REFERENCES fudge.DimClient
   ( ClientKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge.FactOrders ADD CONSTRAINT
   FK_dbo_FactOrders_TitleKey FOREIGN KEY
   (
   TitleKey
   ) REFERENCES fudge.DimTitles
   ( TitleKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge.FactOrders ADD CONSTRAINT
   FK_dbo_FactOrders_ProductKey FOREIGN KEY
   (
   ProductKey
   ) REFERENCES fudge.DimProduct
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge.FactOrders ADD CONSTRAINT
   FK_dbo_FactOrders_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES fudge.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge.FactOrders ADD CONSTRAINT
   FK_dbo_FactOrders_ShippingDateKey FOREIGN KEY
   (
   ShippedDateKey
   ) REFERENCES fudge.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

----- FactOrderFrauds Constraints -----
ALTER TABLE fudge.FactOrdersFraud ADD CONSTRAINT
   FK_fudge_FactOrdersFraud_ClientKey FOREIGN KEY
   (
   ClientKey
   ) REFERENCES fudge.DimClient
   ( ClientKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge.FactOrdersFraud ADD CONSTRAINT
   FK_fudge_FactOrdersFraud_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES fudge.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge.FactOrdersFraud ADD CONSTRAINT
   FK_fudge_FactOrdersFraud_ShippedDateKey FOREIGN KEY
   (
   ShippedDateKey
   ) REFERENCES fudge.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge.FactOrdersFraud ADD CONSTRAINT
   FK_fudge_FactOrdersFraud_ExpryDateKey FOREIGN KEY
   (
   ExpiryDateKey
   ) REFERENCES fudge.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

