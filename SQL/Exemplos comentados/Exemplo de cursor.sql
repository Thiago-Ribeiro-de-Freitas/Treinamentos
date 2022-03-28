
SET nocount on

--Declara��o de Vari�veis
DECLARE @Entidade INT,
		@Razao varchar(100)

-- Declara��o de cursor
DECLARE MeuCursor CURSOR LOCAL FOR

--Select utilizado para alimentar o cursor
SELECT T01002_I_CDENT, T01002_S_RAZAOSOC FROM [RH].[T01002_ENTIDADE]

--Inicializa
OPEN MeuCursor
  
--Alimenta as vari�veis que ser�o utilizadas para uso 
FETCH NEXT 
FROM MeuCursor 
INTO @Entidade, @Razao

--Enquanto o cursor estiver aberto
WHILE @@FETCH_STATUS = 0
  BEGIN	--Inicio do loop

	--Qualquer c�digo que precise do cursor, sem limite de linhas    	
    IF @@FETCH_STATUS = 0
      SELECT 'Cursor Aberto'
	ELSE
	  SELECT 'Cursor Fechado'

	  
	Print 'Entidade: ' + cast(@Entidade as varchar) + ' - ' + @Razao
	
	SELECT * FROM [RH].[T01002_ENTIDADE] where T01002_I_CDENT = @Entidade

	--Move o cursor para o pr�ximo registro    
    FETCH NEXT FROM MeuCursor 
     INTO @Entidade, @Razao
        
  END --Fim do loop
  
--Fecha cursor aberto 
CLOSE MeuCursor

--Libera a mem�ria consumida pelo cursor
DEALLOCATE MeuCursor






