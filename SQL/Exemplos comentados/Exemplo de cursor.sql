
SET nocount on

--Declaração de Variáveis
DECLARE @Entidade INT,
		@Razao varchar(100)

-- Declaração de cursor
DECLARE MeuCursor CURSOR LOCAL FOR

--Select utilizado para alimentar o cursor
SELECT T01002_I_CDENT, T01002_S_RAZAOSOC FROM [RH].[T01002_ENTIDADE]

--Inicializa
OPEN MeuCursor
  
--Alimenta as variáveis que serão utilizadas para uso 
FETCH NEXT 
FROM MeuCursor 
INTO @Entidade, @Razao

--Enquanto o cursor estiver aberto
WHILE @@FETCH_STATUS = 0
  BEGIN	--Inicio do loop

	--Qualquer código que precise do cursor, sem limite de linhas    	
    IF @@FETCH_STATUS = 0
      SELECT 'Cursor Aberto'
	ELSE
	  SELECT 'Cursor Fechado'

	  
	Print 'Entidade: ' + cast(@Entidade as varchar) + ' - ' + @Razao
	
	SELECT * FROM [RH].[T01002_ENTIDADE] where T01002_I_CDENT = @Entidade

	--Move o cursor para o próximo registro    
    FETCH NEXT FROM MeuCursor 
     INTO @Entidade, @Razao
        
  END --Fim do loop
  
--Fecha cursor aberto 
CLOSE MeuCursor

--Libera a memória consumida pelo cursor
DEALLOCATE MeuCursor






