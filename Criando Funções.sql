select ucase('meu banco'); -- ele retorna MEU BANCO upperCase

select lcase('MEU BANCO'); -- ele retorna meu banco, lowcaser

select concat('meu nome é: ','Andrew'); -- ele concatena

select concat(contactname, '', address) 'Nome e Endereço' from customers; 

select orderDate from orders;

select orderID, orderDate, adddate(orderDate, 30) as 'Data adicionada' from orders;
-- ele adiciona uma data(a data que você mexe, os dias que você vai acrescentar)

select datediff('2010-05-03', '2010-05-04');
-- ele calcula a data e retorna a diferença em dias (a data maior vêm primeiro)

select orderID, orderDate, datediff(curDate(), orderDate) from orders;

select curdate();

select date_format('2010-05-03', '%d/%m/%Y');
-- Formatador de datas

select orderID, orderDate, date_format(orderDate, '%d/%m/%Y') as 'Data formatada' from orders;
/* 
%d: dias
%m: meses
%y: retorna os dois ultímos digitos do ano
%Y: retorna os quatros digitos do ano
%w: retorna o número do dia correspondente ex: (Segunda: 1, Terça: 2)
%W: retorna o nome do dia correspondente

*/

select date_format('2010-05-03', '%W, %M of %Y');

select md5('bruno');

select * from employees;

DELIMITER $$
-- delimiter ele diz onde inicia e onde termina por função
create function obterTitulo(idEmployee int) 
		returns char(4) -- o retorno da função
			deterministic -- deterministic tem relação com o retorno, quando a aplicação é estática e só vai retornar um tipo de dado
        begin -- começo do comportamento
			declare strTitulo char(4); -- iniciando a variável
            select employees.TitleOfCourtesy into strTitulo 
				from employees 
					where employees.EmployeeID = idEmployee;
		return strTitulo;
        END; 
        $$
        
-- toda função precisa de um select, diferente de procedure que usamos call


DELIMITER $$
CREATE FUNCTION obterTituloPort(idEmployee int)
		RETURNS VARCHAR(10)
			DETERMINISTIC
		BEGIN
			DECLARE strTitulo VARCHAR(10);
            SELECT ucase(employees.TitleOfCourtesy) into strTitulo
				from employees
					WHERE employees.EmployeeID = idEmployee;
                    
			IF strTitulo = 'MRS.'
					THEN SET strTitulo = 'SENHORA';
				ELSEIF strTitulo = 'MR.'
					THEN SET strTitulo = 'SENHOR';
				ELSEIF strTitulo = 'MS.'
					THEN SET strTitulo = 'SENHORITA';
				ELSE
					SET strTitulo = 'Doutor';
            END IF;
                        
			RETURN strTitulo;
			END;
            $$
        
SELECT obterTituloPort(2);

SELECT obterTitulo(2);