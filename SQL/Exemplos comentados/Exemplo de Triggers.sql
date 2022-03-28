-- Se existir a tabela cobaia1, DROP antes de criar
If exists (Select 1 from sysobjects where name = 'cobaia1')
	Drop Table dbo.cobaia1

go	-- Aguarda finalizar o comando anterior
Create Table dbo.Cobaia1 (
	ID int identity, 
	Codigo int, 
	Descricao Varchar(100)
	)
go

If exists (Select 1 from sysobjects where name = 'cobaia2')
	Drop Table dbo.cobaia2

go
Create Table dbo.Cobaia2 (
	Codigo int, 
	Descricao Varchar(100),
	Criacao SmallDateTime,
	Ult_Atualizacao DateTime
	)
go

-- Trigger de Insert
If exists (Select 1 from sysobjects where name = 'tr_Insert_Cobaia1_2')
	Drop Trigger tr_Insert_Cobaia1_2
go
Create Trigger tr_Insert_Cobaia1_2 on dbo.cobaia1	-- Declaração da Trigger e qual a tabela associada
For Insert AS	-- Tipo de Trigger a ser disparada (Insert/Updete/Delete...) e tipo For/After (simultanea ou após)
Begin
	Insert Into dbo.cobaia2 (Codigo, Descricao, Criacao, Ult_Atualizacao) 
	Select c1.Codigo, c1.Descricao, getdate(), getdate() 
	From Inserted c1 -- Deleted : Tabela em memória do(s) iten(s) deletados 
End
go
-- Trigger de Delete
If exists (Select 1 from sysobjects where name = 'tr_Delete_Cobaia1_2')
	Drop Trigger tr_Delete_Cobaia1_2
go
Create Trigger tr_Delete_Cobaia1_2 on dbo.cobaia1	-- Declaração da Trigger e qual a tabela associada
After Delete AS	-- Tipo de Trigger a ser disparada (Insert/Updete/Delete...) e tipo For/After (simultanea ou após)
Begin
	Update dbo.cobaia2 
	Set Ult_Atualizacao = getdate() 
	Where Codigo = (Select Codigo From DELETED) -- Deleted : Tabela em memória do(s) iten(s) deletados 
End


go

-- Para validação/testes
Insert Into dbo.Cobaia1 Values (11, 'Teste A')
Insert Into dbo.Cobaia1 Values (21, 'Teste B')
Insert Into dbo.Cobaia1 Values (31, 'Teste C')
Insert Into dbo.Cobaia1 Values (41, 'Teste D')
go
select * from dbo.Cobaia1 
select * from dbo.Cobaia2 
go

Delete dbo.Cobaia1 Where Codigo = 21




