

-- Exibe a lista de tabelas onde alguma coluna possui nome campo possui ABCDEFGHIJKLMN
Select Distinct o.name 
From sysobjects o join syscolumns c on o.id = c.id
Where c.name like '%ABCDEFGHIJKLMN%' --Substituir pelo termo a ser localizado
Order by o.name


-- Exibe a lista de tabelas onde alguma procedure ou function possui ABCDEFGHIJKLMN em seu código
Select Distinct o.name 
From sysobjects o join syscomments c on o.id = c.id
Where c.text like '%ABCDEFGHIJKLMN%' --Substituir pelo termo a ser localizado
Order by o.name

