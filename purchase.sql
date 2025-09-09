USE [Sales]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[purchase](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_product] [int] NULL,
	[id_category] [int] NULL,
	[id_shop] [int] NULL,
	[purchase_date] [date] NULL,
	[amount] [decimal](5, 2) NULL,
	[id_subcategory] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[purchase]  WITH CHECK ADD  CONSTRAINT [FK_category_id_2] FOREIGN KEY([id_category])
REFERENCES [dbo].[dict_category] ([id])
GO

ALTER TABLE [dbo].[purchase] CHECK CONSTRAINT [FK_category_id_2]
GO

ALTER TABLE [dbo].[purchase]  WITH CHECK ADD  CONSTRAINT [FK_products_id] FOREIGN KEY([id_product])
REFERENCES [dbo].[products] ([id])
GO

ALTER TABLE [dbo].[purchase] CHECK CONSTRAINT [FK_products_id]
GO

ALTER TABLE [dbo].[purchase]  WITH CHECK ADD  CONSTRAINT [FK_shop_id] FOREIGN KEY([id_shop])
REFERENCES [dbo].[dict_shop] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[purchase] CHECK CONSTRAINT [FK_shop_id]
GO


