USE [eyechic]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 3/25/2024 5:56:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[AccountId] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](max) NULL,
	[fullname] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[Role] [int] NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/25/2024 5:56:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](max) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 3/25/2024 5:56:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [date] NULL,
	[TotalPrice] [int] NULL,
	[AccountId] [int] NULL,
	[ShipDate] [date] NULL,
	[Status] [nvarchar](50) NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 3/25/2024 5:56:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[ProductId] [int] NULL,
	[Quantity] [int] NULL,
	[UnitPrice] [int] NULL,
	[Discount] [int] NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 3/25/2024 5:56:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Price] [int] NULL,
	[Color] [nvarchar](50) NULL,
	[Origin] [nvarchar](max) NULL,
	[Material] [nvarchar](max) NULL,
	[CategoryId] [int] NULL,
	[Img] [nvarchar](max) NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([AccountId], [email], [fullname], [password], [Role]) VALUES (1, N'anhbm1311hung@gmail.com', N'Bùi Mạnh Hùng', N'13112002', 1)
INSERT [dbo].[Account] ([AccountId], [email], [fullname], [password], [Role]) VALUES (2, N'hungbmhe161538@fpt.edu.vn', N'Bui Manh Hung', N'131102', 2)
INSERT [dbo].[Account] ([AccountId], [email], [fullname], [password], [Role]) VALUES (4, N'hung@fpt', N'Bui Manh Hung', N'123', 2)
INSERT [dbo].[Account] ([AccountId], [email], [fullname], [password], [Role]) VALUES (6, N'hung1234@gmail.com', N'Bui Manh Hung', N'123', 1)
INSERT [dbo].[Account] ([AccountId], [email], [fullname], [password], [Role]) VALUES (7, N'hung1111@gmail.com', N'Bui Manh Hung', N'123', 1)
INSERT [dbo].[Account] ([AccountId], [email], [fullname], [password], [Role]) VALUES (1005, N'admin', N'admin', N'admin', 1)
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (1, N'Gọng kim loại')
INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (2, N'Gọng nhựa')
INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (3, N'Gọng nhựa dẻo')
INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (4, N'Gọng mắt mèo')
INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (5, N'Phụ kiện kính mắt ')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (2, CAST(N'2024-03-23' AS Date), 139000, 4, CAST(N'2024-03-26' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (3, CAST(N'2024-03-22' AS Date), 139000, 1, CAST(N'2024-03-26' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (4, CAST(N'2024-03-20' AS Date), 289000, 1, CAST(N'2024-03-24' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (5, CAST(N'2024-03-15' AS Date), 578000, 1, CAST(N'2024-03-18' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1002, CAST(N'2024-03-15' AS Date), 139000, 1, CAST(N'2024-03-18' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1003, CAST(N'2024-03-23' AS Date), 289000, 1, CAST(N'2024-03-25' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1004, CAST(N'2024-03-20' AS Date), 139000, 1, CAST(N'2024-03-26' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1005, CAST(N'2024-03-23' AS Date), 139000, 6, CAST(N'2024-03-26' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1006, CAST(N'2024-03-22' AS Date), 139000, 1, CAST(N'2024-03-26' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1007, CAST(N'2024-03-20' AS Date), 289000, 2, CAST(N'2024-03-24' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1008, CAST(N'2024-03-15' AS Date), 578000, 4, CAST(N'2024-03-18' AS Date), N'Done')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1009, CAST(N'2024-03-15' AS Date), 139000, 1005, CAST(N'2024-03-18' AS Date), N'Done')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1010, CAST(N'2024-03-23' AS Date), 289000, 7, CAST(N'2024-03-25' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1011, CAST(N'2024-03-17' AS Date), 289000, 4, CAST(N'2024-03-19' AS Date), N'Done')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1012, CAST(N'2024-03-18' AS Date), 139000, 6, CAST(N'2024-03-21' AS Date), N'Done')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1013, CAST(N'2024-03-16' AS Date), 578000, 2, CAST(N'2024-03-19' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1014, CAST(N'2024-03-19' AS Date), 139000, 7, CAST(N'2024-03-22' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1015, CAST(N'2024-03-21' AS Date), 289000, 1005, CAST(N'2024-03-24' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1016, CAST(N'2024-03-24' AS Date), 578000, 1, CAST(N'2024-03-27' AS Date), N'Done')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1017, CAST(N'2024-03-25' AS Date), 139000, 6, CAST(N'2024-03-28' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1018, CAST(N'2024-03-26' AS Date), 139000, 4, CAST(N'2024-03-29' AS Date), N'Done')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1019, CAST(N'2024-03-27' AS Date), 289000, 2, CAST(N'2024-03-30' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1020, CAST(N'2024-03-28' AS Date), 578000, 1, CAST(N'2024-03-31' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1021, CAST(N'2024-03-29' AS Date), 139000, 7, CAST(N'2024-04-01' AS Date), N'Done')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1022, CAST(N'2024-03-30' AS Date), 289000, 4, CAST(N'2024-04-02' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1023, CAST(N'2024-04-02' AS Date), 139000, 2, CAST(N'2024-04-05' AS Date), N'Done')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1024, CAST(N'2024-04-03' AS Date), 578000, 6, CAST(N'2024-04-06' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1025, CAST(N'2024-04-04' AS Date), 139000, 1, CAST(N'2024-04-07' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1026, CAST(N'2024-04-05' AS Date), 289000, 1005, CAST(N'2024-04-08' AS Date), N'Done')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1027, CAST(N'2024-04-06' AS Date), 578000, 6, CAST(N'2024-04-09' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1028, CAST(N'2024-04-07' AS Date), 139000, 2, CAST(N'2024-04-10' AS Date), N'Done')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1029, CAST(N'2024-04-08' AS Date), 139000, 7, CAST(N'2024-04-11' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1030, CAST(N'2024-04-09' AS Date), 289000, 4, CAST(N'2024-04-12' AS Date), N'Done')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1031, CAST(N'2024-04-10' AS Date), 139000, 1, CAST(N'2024-04-13' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1032, CAST(N'2024-04-11' AS Date), 289000, 6, CAST(N'2024-04-14' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1033, CAST(N'2024-04-12' AS Date), 578000, 2, CAST(N'2024-04-15' AS Date), N'Done')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1034, CAST(N'2024-04-13' AS Date), 139000, 7, CAST(N'2024-04-16' AS Date), N'Done')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1035, CAST(N'2024-04-14' AS Date), 289000, 4, CAST(N'2024-04-17' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1036, CAST(N'2024-04-15' AS Date), 578000, 1005, CAST(N'2024-04-18' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1037, CAST(N'2024-04-16' AS Date), 139000, 1, CAST(N'2024-04-19' AS Date), N'Done')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1038, CAST(N'2024-04-17' AS Date), 289000, 6, CAST(N'2024-04-20' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1039, CAST(N'2024-04-18' AS Date), 578000, 4, CAST(N'2024-04-21' AS Date), N'Done')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1040, CAST(N'2024-04-19' AS Date), 139000, 2, CAST(N'2024-04-22' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1041, CAST(N'2024-04-20' AS Date), 289000, 1, CAST(N'2024-04-23' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1042, CAST(N'2024-04-21' AS Date), 578000, 6, CAST(N'2024-04-24' AS Date), N'Done')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1043, CAST(N'2024-04-22' AS Date), 139000, 7, CAST(N'2024-04-25' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1044, CAST(N'2024-04-23' AS Date), 289000, 1005, CAST(N'2024-04-26' AS Date), N'Done')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1045, CAST(N'2024-04-24' AS Date), 578000, 4, CAST(N'2024-04-27' AS Date), N'Processing')
INSERT [dbo].[Order] ([OrderId], [OrderDate], [TotalPrice], [AccountId], [ShipDate], [Status]) VALUES (1046, CAST(N'2024-04-25' AS Date), 139000, 2, CAST(N'2024-04-28' AS Date), N'Done')
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (1, 1002, 1, 1, 139000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (2, 1003, 2, 1, 289000, 3)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (3, 1004, 1, 1, 139000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (462, 2, 2, 4, 150000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (463, 2, 4, 2, 130000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (464, 3, 1004, 2, 180000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (465, 3, 1005, 3, 160000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (466, 3, 1006, 1, 170000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (467, 4, 1007, 4, 140000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (468, 4, 1008, 3, 190000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (470, 5, 1010, 1, 210000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (471, 5, 1011, 2, 220000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (472, 5, 1012, 3, 230000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (473, 1002, 1013, 4, 240000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (474, 1002, 1014, 3, 180000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (476, 1003, 1016, 1, 160000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (477, 1003, 1017, 2, 170000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (478, 1003, 1018, 3, 150000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (479, 1004, 1019, 4, 130000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (480, 1004, 1020, 3, 120000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (481, 1004, 1, 2, 140000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (482, 1005, 2, 1, 200000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (483, 1005, 4, 2, 220000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (485, 1006, 1005, 4, 190000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (486, 1006, 1006, 3, 210000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (487, 1006, 1007, 2, 230000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (488, 1007, 1008, 1, 160000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (489, 1007, 1009, 2, 170000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (490, 1007, 1010, 3, 150000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (491, 1008, 1011, 4, 130000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (492, 1008, 1012, 3, 120000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (493, 1008, 1013, 2, 140000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (494, 1009, 1014, 1, 200000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (495, 1009, 1015, 2, 220000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (496, 1009, 1016, 3, 180000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (497, 1010, 1017, 4, 190000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (498, 1010, 1018, 3, 210000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (499, 1010, 1019, 2, 230000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (500, 1011, 1020, 1, 160000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (501, 1011, 1, 2, 170000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (502, 1011, 2, 3, 150000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (503, 1012, 4, 4, 130000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (504, 1012, 1004, 3, 120000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (505, 1012, 1005, 2, 140000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (506, 1013, 1006, 1, 200000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (507, 1013, 1007, 2, 220000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (508, 1013, 1008, 3, 180000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (509, 1014, 1009, 4, 190000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (510, 1014, 1010, 3, 210000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (511, 1014, 1011, 2, 230000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (512, 1015, 1012, 1, 160000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (513, 1015, 1013, 2, 170000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (514, 1015, 1014, 3, 150000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (515, 1016, 1015, 4, 130000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (516, 1016, 1016, 3, 120000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (517, 1016, 1017, 2, 140000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (518, 1017, 1018, 1, 200000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (519, 1017, 1019, 2, 220000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (520, 1017, 1020, 3, 180000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (521, 1018, 1, 4, 190000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (522, 1018, 2, 3, 210000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (523, 1018, 4, 2, 230000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (524, 1019, 1004, 1, 160000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (525, 1019, 1005, 2, 170000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (526, 1019, 1006, 3, 150000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (527, 1020, 1007, 4, 130000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (528, 1020, 1008, 3, 120000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (529, 1020, 1009, 2, 140000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (530, 1021, 1010, 1, 210000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (531, 1021, 1011, 2, 220000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (532, 1021, 1012, 3, 230000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (533, 1022, 1013, 4, 240000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (534, 1022, 1014, 3, 180000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (535, 1022, 1015, 2, 190000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (536, 1023, 1016, 1, 160000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (537, 1023, 1017, 2, 170000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (538, 1024, 1019, 4, 130000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (539, 1024, 1020, 3, 120000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (540, 1024, 1, 2, 140000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (541, 1025, 2, 1, 200000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (542, 1025, 4, 2, 220000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (543, 1025, 1004, 3, 180000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (544, 1026, 1005, 4, 190000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (545, 1026, 1006, 3, 210000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (546, 1026, 1007, 2, 230000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (547, 1027, 1008, 1, 160000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (548, 1027, 1009, 2, 170000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (549, 1027, 1010, 3, 150000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (550, 1028, 1011, 4, 130000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (551, 1028, 1012, 3, 120000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (552, 1028, 1013, 2, 140000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (553, 1029, 1014, 1, 200000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (554, 1029, 1015, 2, 220000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (555, 1029, 1016, 3, 180000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (556, 1030, 1017, 4, 190000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (557, 1030, 1018, 3, 210000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (558, 1030, 1019, 2, 230000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (559, 1031, 1020, 1, 160000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (560, 1031, 1, 2, 170000, 0)
GO
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (561, 1031, 2, 3, 150000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (562, 1032, 4, 4, 130000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (563, 1032, 1004, 3, 120000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (564, 1032, 1005, 2, 140000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (565, 1033, 1006, 1, 200000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (566, 1033, 1007, 2, 220000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (567, 1033, 1008, 3, 180000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (568, 1034, 1009, 4, 190000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (569, 1034, 1010, 3, 210000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (570, 1034, 1011, 2, 230000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (571, 1035, 1012, 1, 160000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (572, 1035, 1013, 2, 170000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (573, 1035, 1014, 3, 150000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (574, 1036, 1015, 4, 130000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (575, 1036, 1016, 3, 120000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (576, 1036, 1017, 2, 140000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (577, 1037, 1018, 1, 200000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (578, 1037, 1019, 2, 220000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (579, 1037, 1020, 3, 180000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (580, 1038, 1, 4, 190000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (581, 1038, 2, 3, 210000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (582, 1038, 4, 2, 230000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (583, 1039, 1004, 1, 160000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (584, 1039, 1005, 2, 170000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (585, 1039, 1006, 3, 150000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (586, 1040, 1007, 4, 130000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (587, 1040, 1008, 3, 120000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (588, 1040, 1009, 2, 140000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (589, 1041, 1010, 1, 210000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (590, 1041, 1011, 2, 220000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (591, 1041, 1012, 3, 230000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (592, 1042, 1013, 4, 240000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (593, 1042, 1014, 3, 180000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (594, 1042, 1015, 2, 190000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (595, 1043, 1016, 1, 160000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (596, 1043, 1017, 2, 170000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (597, 1043, 1018, 3, 150000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (599, 1044, 1020, 3, 120000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (600, 1044, 1, 2, 140000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (601, 1045, 2, 1, 200000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (602, 1045, 4, 2, 220000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (603, 1045, 1004, 3, 180000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (604, 1046, 1005, 4, 190000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (605, 1046, 1006, 3, 210000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice], [Discount]) VALUES (606, 1046, 1007, 2, 230000, 0)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1, N'Kính cận nam mắt vuông giả cận', N'cam kết 100% sản phẩm là ảnh thật shop tự chụp, quý khách hoàn toàn yên tâm khi mua và sử dụng sản phẩm.

', 139000, N'Black', N'EyeChic', N'Nhựa cứng', 2, N'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-liy44sxzcssya1', 39)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (2, N'Kính gọng vuông nam nữ', N'- Chân gọng kính làm từ nhựa dẻo, giúp mang gọng kính trong thời gian dài cũng không gây khó chịu hay đau ở vành tai.  - Mắt kính theo gọng là mắt kính 0 độ các bạn có thể mang giả cận, chống bụi và lắp mắt kính cận.  - Giá sản phẩm chưa bao gồm dịch vụ cắt mắt kính cận.  - Chốt gọng chắc chắn giúp giữ form kính mắt tốt.  - Gọng kính được thiết kế thời trang phù hợp cho cả nam và nữ.  - Các gọng KÍNH MÁT được phủ lớp chống UV400.', 289000, N'Black / Đen bóng ', N'EyeChic', N'Nhựa cứng ', 2, N'https://down-vn.img.susercontent.com/file/873133224f39ea8d4b93b0d346383f94', 30)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (4, N'Gọng kính cận vuông nam nữ', N'Chân kính làm từ nhựa dẻo, giúp mang kính trong thời gian dài cũng không gây khó chịu hay đau ở vành tai.  - Mắt kính theo gọng là mắt kính nhựa 0 độ các bạn có thể mang giả cận, chống bụi và lắp mắt kính cận.  - Giá sản phẩm chưa bao gồm dịch vụ cắt mắt kính.  - Chốt kính chắc chắn giúp giữ form kính tốt.  - Kính được thiết kế thời trang phù hợp cho cả nam và nữ.  - Kính râm sẽ được phủ lớp chống UV400.', 270000, N'Black / Đen bóng ', N'EyeChic', N'Nhựa dẻo', 3, N'https://down-vn.img.susercontent.com/file/05df168381bf723c02d7961eccacb198', 40)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1004, N'Gọng kính cận vuông nam nữ', N'- Chân kính làm từ nhựa dẻo, giúp mang kính trong thời gian dài cũng không gây khó chịu hay đau ở vành tai.- Mắt kính theo gọng là mắt kính nhựa 0 độ các bạn có thể mang giả cận, chống bụi và lắp mắt kính cận.- Giá sản phẩm chưa bao gồm dịch vụ cắt mắt kính.- Chốt kính chắc chắn giúp giữ form kính tốt.- Kính được thiết kế thời trang phù hợp cho cả nam và nữ.- Kính râm sẽ được phủ lớp chống UV400.', 150000, N'Ðen', N'EyeChic', N'Nhựa dẻo', 1, N'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lmc92qsxlcdb3e', 29)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1005, N'Kính cận nam nữ mắt kính vuông to chắn bụi đi đường chống ánh sáng xanh 616', N'- Chân gọng kính làm từ nhựa dẻo, giúp mang gọng kính trong thời gian dài cũng không gây khó chịu hay đau ở vành tai.

- Mắt kính theo gọng là mắt kính 0 độ các bạn có thể mang giả cận, chống bụi và lắp mắt kính cận.

- Giá sản phẩm chưa bao gồm dịch vụ cắt mắt kính cận.

- Chốt gọng chắc chắn giúp giữ form kính mắt tốt.

- Gọng kính được thiết kế thời trang phù hợp cho cả nam và nữ.

- Các gọng KÍNH MÁT được phủ lớp chống UV400.', 99000, N'Đen', N'EyeChic', N'Nhựa', 2, N'https://down-vn.img.susercontent.com/file/1aecab7518bb3c5bec58cb99a2d95f8a', 30)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1006, N'Gọng kính cận nam nữ mắt kính tròn gọng kính kim loại màu sắc thời trang ', N'- Chân gọng kính làm từ nhựa dẻo, giúp mang gọng kính trong thời gian dài cũng không gây khó chịu hay đau ở vành tai.

- Mắt kính theo gọng là mắt kính 0 độ các bạn có thể mang giả cận, chống bụi và lắp mắt kính cận.

- Giá sản phẩm chưa bao gồm dịch vụ cắt mắt kính cận.

- Chốt gọng chắc chắn giúp giữ form kính mắt tốt.

- Gọng kính được thiết kế thời trang phù hợp cho cả nam và nữ.', 119000, N'Đen vàng', N'EyeChic', N'Nhựa dẻo', 3, N'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lmns4908emlb55', 20)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1007, N'Gọng kính kim loại tròn nam nữ phù hợp mặt nhỏ càng kính nhẹ nhàng màu sắc thời trang ', N'- Chân gọng kính làm từ nhựa dẻo, giúp mang gọng kính trong thời gian dài cũng không gây khó chịu hay đau ở vành tai.

- Mắt kính theo gọng là mắt kính 0 độ các bạn có thể mang giả cận, chống bụi và lắp mắt kính cận.

- Giá sản phẩm chưa bao gồm dịch vụ cắt mắt kính cận.

- Chốt gọng chắc chắn giúp giữ form kính mắt tốt.

- Gọng kính được thiết kế thời trang phù hợp cho cả nam và nữ.

- Các gọng KÍNH MÁT được phủ lớp chống UV400.', 199000, N'Trắng', N'EyeChic', N'Nhựa', 2, N'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lmmcaq79avhb9b', 33)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1008, N'Gọng kính mắt mèo kim loại nữ thiết kế phong cách phụ kiện thời trang ', N'- Chân gọng kính làm từ nhựa dẻo, giúp mang gọng kính trong thời gian dài cũng không gây khó chịu hay đau ở vành tai.

- Mắt kính theo gọng là mắt kính 0 độ các bạn có thể mang giả cận, chống bụi và lắp mắt kính cận.

- Giá sản phẩm chưa bao gồm dịch vụ cắt mắt kính cận.

- Chốt gọng chắc chắn giúp giữ form kính mắt tốt.

- Gọng kính được thiết kế thời trang phù hợp cho cả nam và nữ.

- Các gọng KÍNH MÁT được phủ lớp chống UV400.', 179000, N'Đen', N'EyeChic', N'Kim loại', 1, N'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lmmcaq7jvjdr13', 25)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1009, N'Gọng kính cận nam nữ mắt vuông chữ V phụ kiện thời trang', N'- Chân gọng kính làm từ nhựa dẻo, giúp mang gọng kính trong thời gian dài cũng không gây khó chịu hay đau ở vành tai.

- Mắt kính theo gọng là mắt kính 0 độ các bạn có thể mang giả cận, chống bụi và lắp mắt kính cận.

- Giá sản phẩm chưa bao gồm dịch vụ cắt mắt kính cận.

- Chốt gọng chắc chắn giúp giữ form kính mắt tốt.

- Gọng kính được thiết kế thời trang phù hợp cho cả nam và nữ.

- Các gọng KÍNH MÁT được phủ lớp chống UV400.', 115000, N'Đen', N'EyeChic', N'Nhựa dẻo', 3, N'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lp52yp43u79q28', 40)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1010, N'Gọng kính cận vuông nam nữ chất liệu nhựa dẻo phụ kiện thời trang', N'- Chân gọng kính làm từ nhựa dẻo, giúp mang gọng kính trong thời gian dài cũng không gây khó chịu hay đau ở vành tai.

- Mắt kính theo gọng là mắt kính 0 độ các bạn có thể mang giả cận, chống bụi và lắp mắt kính cận.

- Giá sản phẩm chưa bao gồm dịch vụ cắt mắt kính cận.

- Chốt gọng chắc chắn giúp giữ form kính mắt tốt.

- Gọng kính được thiết kế thời trang phù hợp cho cả nam và nữ.

- Các gọng KÍNH MÁT được phủ lớp chống UV400.', 99000, N'Xám', N'EyeChic', N'Nhựa dẻo', 3, N'https://down-vn.img.susercontent.com/file/2376d9372e6b7da53c3d327f70e69cd9', 35)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1011, N'Kính cận nam chất liệu nhựa cứng cáp mắt vuông giả cận thời trang', N'- Chân gọng kính làm từ nhựa dẻo, giúp mang gọng kính trong thời gian dài cũng không gây khó chịu hay đau ở vành tai.

- Mắt kính theo gọng là mắt kính 0 độ các bạn có thể mang giả cận, chống bụi và lắp mắt kính cận.

- Giá sản phẩm chưa bao gồm dịch vụ cắt mắt kính cận.

- Chốt gọng chắc chắn giúp giữ form kính mắt tốt.

- Gọng kính được thiết kế thời trang phù hợp cho cả nam và nữ.

- Các gọng KÍNH MÁT được phủ lớp chống UV400.', 139000, N'Đen bóng', N'EyeChic', N'Nhựa dẻo', 3, N'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lmmcaq7j7nq716', 33)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1012, N'Gọng kính nhựa Acetate cao cấp đa giác nam nữ', N'- Chân gọng kính làm từ nhựa dẻo, giúp mang gọng kính trong thời gian dài cũng không gây khó chịu hay đau ở vành tai.

- Mắt kính theo gọng là mắt kính 0 độ các bạn có thể mang giả cận, chống bụi và lắp mắt kính cận.

- Giá sản phẩm chưa bao gồm dịch vụ cắt mắt kính cận.

- Chốt gọng chắc chắn giúp giữ form kính mắt tốt.

- Gọng kính được thiết kế thời trang phù hợp cho cả nam và nữ.

- Các gọng KÍNH MÁT được phủ lớp chống UV400.', 804000, N'Xanh đen', N'EyeChic', N'Acetate', 1, N'https://down-vn.img.susercontent.com/file/sg-11134201-7rbmj-lqabbwojxmbpe4', 20)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1013, N'Gọng kính titanium T1181 nửa khung thời trang nam cao cấp siêu nhẹ siêu bền OURESS', N'- Chân gọng kính làm từ nhựa dẻo, giúp mang gọng kính trong thời gian dài cũng không gây khó chịu hay đau ở vành tai.

- Mắt kính theo gọng là mắt kính 0 độ các bạn có thể mang giả cận, chống bụi và lắp mắt kính cận.

- Giá sản phẩm chưa bao gồm dịch vụ cắt mắt kính cận.

- Chốt gọng chắc chắn giúp giữ form kính mắt tốt.

- Gọng kính được thiết kế thời trang phù hợp cho cả nam và nữ.

- Các gọng KÍNH MÁT được phủ lớp chống UV400.', 730000, N'Xám', N'EyeChic', N'Titanium', 1, N'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lisjcabdwjiqd0', 15)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1014, N'Gọng kính bầu tròn nữ kim loại EYESSTORE phụ kiện thời trang PRD02', N'- Chân gọng kính làm từ nhựa dẻo, giúp mang gọng kính trong thời gian dài cũng không gây khó chịu hay đau ở vành tai.

- Mắt kính theo gọng là mắt kính 0 độ các bạn có thể mang giả cận, chống bụi và lắp mắt kính cận.

- Giá sản phẩm chưa bao gồm dịch vụ cắt mắt kính cận.

- Chốt gọng chắc chắn giúp giữ form kính mắt tốt.

- Gọng kính được thiết kế thời trang phù hợp cho cả nam và nữ.

- Các gọng KÍNH MÁT được phủ lớp chống UV400.', 219000, N'Vàng', N'EyeChic', N'Kim Loại', 1, N'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-ls98isk22d212f', 10)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1015, N'Gọng kính mắt thời trang nam nữ dáng tròn chất liệu kim loại cao cấp', N'- Chân gọng kính làm từ nhựa dẻo, giúp mang gọng kính trong thời gian dài cũng không gây khó chịu hay đau ở vành tai.

- Mắt kính theo gọng là mắt kính 0 độ các bạn có thể mang giả cận, chống bụi và lắp mắt kính cận.

- Giá sản phẩm chưa bao gồm dịch vụ cắt mắt kính cận.

- Chốt gọng chắc chắn giúp giữ form kính mắt tốt.

- Gọng kính được thiết kế thời trang phù hợp cho cả nam và nữ.

- Các gọng KÍNH MÁT được phủ lớp chống UV400.', 930000, N'Đen', N'EyeChic', N'Kim Loại', 1, N'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lt3j9e3q7vdlcd', 10)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1016, N'Gọng kính thời trang nam nữ chất liệu nhựa nhẹ nhàng bền vững thiết kế thời trang nhiều màu sắc', N'- Chân gọng kính làm từ nhựa dẻo, giúp mang gọng kính trong thời gian dài cũng không gây khó chịu hay đau ở vành tai.

- Mắt kính theo gọng là mắt kính 0 độ các bạn có thể mang giả cận, chống bụi và lắp mắt kính cận.

- Giá sản phẩm chưa bao gồm dịch vụ cắt mắt kính cận.

- Chốt gọng chắc chắn giúp giữ form kính mắt tốt.

- Gọng kính được thiết kế thời trang phù hợp cho cả nam và nữ.

- Các gọng KÍNH MÁT được phủ lớp chống UV400.', 159000, N'Đen trắng', N'EyeChic', N'Nhựa', 2, N'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lhsz5s9w1ked33', 22)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1017, N'Tròng kính cận loạn có độ mắt kính chống ánh sáng xanh, đổi màu đi nắng chống tia', N'Chống ánh sáng xanh', 559000, N'Không', N'EyeChic', N'Thủy Tinh, Plastic, Polycarbonate và Chất liệu Chiết suất cao High Index.', 5, N'https://down-vn.img.susercontent.com/file/5845ceecd32f67cb36e769251358313d', 15)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1018, N'Móc vít chìa khóa sửa gọng kính', N'Móc Vít Gọng Kính có 2 đầu 1 đầu 4 cạnh và 1 đầu 2 cạnh. Với kích thước mini, chiếc móc vít này phù hợp để tháo mở gọng kính, đồng hồ hay cả  những ốc vít nhỏ trên điện thoại của bạn.

- Chất liệu : thép không gỉ.

- Móc khóa trang trí kiêm tua vít ( màu trắng ).

- Tiện lợi, thời trang, nhỏ gọn.

- Sửa điện thoại, đồng hồ, gọng kính hiệu quả.

- Chiều dài: 5.5 cm

- Loại: Tua vít 2 đầu', 9900, N'Đen', N'EyeChic ', N'Thép không gỉ', 5, N'https://salt.tikicdn.com/cache/w300/ts/product/39/3f/06/7af4d5cd8e73977c3aa7adaa5bea6c99.jpg', 40)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1019, N'Khăn Lau Kính Đa Năng Chuyên Dụng - Lau Mắt Kính Cận Mặt Kính Điện Thoại ', N'- Giúp mắt kính sáng bóng , nhìn rõ , sáng 

- Giúp nhìn rõ hơn

- Chất liệu mềm mại không xù lông

- Lau sạch nhanh các vét bụi bẩn , vân tay', 1900, N'Nhiều màu', N'EyeChic', N'Vải', 5, N'https://down-vn.img.susercontent.com/file/61cb1f45618d56485d108e5753ec88a5', 100)
INSERT [dbo].[Product] ([ProductId], [ProductName], [Description], [Price], [Color], [Origin], [Material], [CategoryId], [Img], [Quantity]) VALUES (1020, N'Nước xịt rửa mắt kính ', N'Nước Xịt Rửa Kính Mắt Chuyên Dụng :



- Giúp mắt kính sáng bóng , nhìn rõ , sáng 

- Tạo lớp màng bảo vệ mắt kính

- Giúp nhìn rõ hơn

- Có thể sử dụng cho cả màn hình laptop , điện thoại 

-Làm giảm mỏi mắt do vết xước 

- Chiết xuất hương liệu tự nhiên

- Dạng xịt hơi sương , thể tích 60ml', 12000, N'Trắng', N'EyeChic', N'Nhựa', 5, N'https://down-vn.img.susercontent.com/file/72817c1fe619f3dbc721d097323bc3cd', 100)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Account] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Account] ([AccountId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Account]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderId])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
