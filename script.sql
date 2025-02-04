USE [master]
GO

CREATE DATABASE [InventoryManagement]
CONTAINMENT = NONE
ON PRIMARY 
( 
    NAME = N'InventoryManagement', 
    FILENAME = N'InventoryManagement.mdf', 
    SIZE = 8192KB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 65536KB 
)
LOG ON 
( 
    NAME = N'InventoryManagement_log', 
    FILENAME = N'InventoryManagement_log.ldf', 
    SIZE = 8192KB, 
    MAXSIZE = 2048GB, 
    FILEGROWTH = 65536KB 
)
GO

ALTER DATABASE [InventoryManagement] SET COMPATIBILITY_LEVEL = 160
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
BEGIN
    EXEC [InventoryManagement].[dbo].[sp_fulltext_database] @action = 'enable'
END
GO

ALTER DATABASE [InventoryManagement] SET READ_WRITE 
GO

USE [InventoryManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
    [CategoryID] INT IDENTITY(1,1) NOT NULL,
    [CategoryName] NVARCHAR(100) NOT NULL,
    PRIMARY KEY CLUSTERED 
    (
        [CategoryID] ASC
    )
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
    [ProductID] INT IDENTITY(1,1) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [CategoryID] INT NULL,
    [StockQuantity] INT DEFAULT (0) NOT NULL,
    [Price] DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY CLUSTERED 
    (
        [ProductID] ASC
    )
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
    [TransactionID] INT IDENTITY(1,1) NOT NULL,
    [ProductID] INT NULL,
    [TransactionType] NVARCHAR(10) NULL,
    [Quantity] INT NOT NULL,
    [TransactionDate] DATETIME DEFAULT (GETDATE()) NULL,
    PRIMARY KEY CLUSTERED 
    (
        [TransactionID] ASC
    )
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Products] 
    ADD CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) 
    REFERENCES [dbo].[Categories] (CategoryID);
GO

ALTER TABLE [dbo].[Transactions] 
    ADD CONSTRAINT FK_Transactions_Products FOREIGN KEY (ProductID) 
    REFERENCES [dbo].[Products] (ProductID);
GO

ALTER TABLE [dbo].[Transactions] 
    ADD CONSTRAINT CHK_TransactionType CHECK (TransactionType IN ('Отгрузка', 'Приход'));
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddProduct]
    @Name NVARCHAR(100),
    @CategoryID INT,
    @Price DECIMAL(10, 2),
    @StockQuantity INT
AS
BEGIN
    INSERT INTO Products (Name, CategoryID, Price, StockQuantity)
    VALUES (@Name, @CategoryID, @Price, @StockQuantity);
END;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCategories]
AS
BEGIN
    SELECT * FROM Categories;
END;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProducts]
AS
BEGIN
    SELECT * FROM Products;
END;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateProduct]
    @ProductID INT,
    @Name NVARCHAR(255),
    @CategoryID INT,
    @Price DECIMAL(18, 2),
    @StockQuantity INT
AS
BEGIN
    UPDATE Products
    SET 
        Name = @Name,
        CategoryID = @CategoryID,
        Price = @Price,
        StockQuantity = @StockQuantity
    WHERE 
        ProductID = @ProductID;
END;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateProductStock]
    @ProductID INT,
    @TransactionType NVARCHAR(10),
    @Quantity INT
AS
BEGIN
    IF @TransactionType = 'Приход'
    BEGIN
        UPDATE Products
        SET StockQuantity = StockQuantity + @Quantity
        WHERE ProductID = @ProductID;
    END
    ELSE IF @TransactionType = 'Отгрузка'
    BEGIN
        UPDATE Products
        SET StockQuantity = StockQuantity - @Quantity
        WHERE ProductID = @ProductID;
    END
    
    INSERT INTO Transactions (ProductID, TransactionType, Quantity)
    VALUES (@ProductID, @TransactionType, @Quantity);
END;
GO

ALTER DATABASE [InventoryManagement] SET READ_WRITE 
GO
