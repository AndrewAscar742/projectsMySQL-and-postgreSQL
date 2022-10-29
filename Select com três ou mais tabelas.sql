CREATE DATABASE simulado;

USE simulado;

DROP TABLE IF EXISTS atores;

CREATE TABLE atores (

cod int(11) NOT NULL,

nome varchar(45) DEFAULT NULL,

nacionalidade varchar(30) DEFAULT NULL,

idade int(11) DEFAULT NULL,

sexo char(1) DEFAULT NULL,

PRIMARY KEY (cod)

);

INSERT INTO atores VALUES (1,'will smith','americana',35,'m'),(2,'Angelina jolie','americana',34,'f'),(3,'Fernanda Montenegro','brasileira',70,'f'),(4,'Wagner Moura','brasileira',36,'m'),(5,'Roberto Downey Jr','americana',42,'m');

DROP TABLE IF EXISTS atuam;

CREATE TABLE atuam (

cod int(11) NOT NULL,

codatores int(11) DEFAULT NULL,

codfilme int(11) DEFAULT NULL,

cache decimal(10,2) DEFAULT NULL,

personagem varchar(45) DEFAULT NULL,

PRIMARY KEY (cod),

KEY codfilme (codfilme),

KEY atuam_ibfk_1 (codatores),

CONSTRAINT atuam_ibfk_1 FOREIGN KEY (codatores) REFERENCES atores (cod),

CONSTRAINT atuam_ibfk_2 FOREIGN KEY (codfilme) REFERENCES filmes (cod)

);

INSERT INTO atuam VALUES (1,4,1,100000.00,'Capitão Nascimento'),(2,4,2,18000.00,'John'),(3,1,3,200000.00,'Will'),(4,1,4,250000.00,'Stanley'),(5,2,5,350000.00,'Malévola'),(6,2,6,333000.00,'Mary'),(7,3,7,50000.00,'Fernanda'),(8,3,8,55000.00,'Maria'),(9,5,9,700000.00,'Tony Starks'),(10,5,10,660000.00,'Sherlock Holmes');

DROP TABLE IF EXISTS estudio;

CREATE TABLE estudio (

cod int(11) NOT NULL,

nome varchar(45) DEFAULT NULL,

proprietario varchar(45) DEFAULT NULL,

faturamentoanoanterior decimal(10,2) DEFAULT NULL,

datafundacao date DEFAULT NULL,

PRIMARY KEY (cod)

);

INSERT INTO estudio VALUES (1,'Center Filmes','João',200000.00,'1980-01-29'),(2,'MGM','Michael',178000.00,'1990-01-23'),(3,'Universal','Douglas',12000.00,'2000-01-21'),(4,'Disney','Lucas',500000.00,'1980-12-31'),(5,'Argentina Filmes','Maradona',38700.43,'2005-10-10');

DROP TABLE IF EXISTS filmes;

CREATE TABLE filmes (

cod int(11) NOT NULL,

meses int(11) DEFAULT NULL,

nome varchar(45) DEFAULT NULL,

anolancamento year(4) DEFAULT NULL,

custototal decimal(10,2) DEFAULT NULL,

codestudio int(11) DEFAULT NULL,

PRIMARY KEY (cod),

KEY codestudio (codestudio),

CONSTRAINT filmes_ibfk_1 FOREIGN KEY (codestudio) REFERENCES estudio (cod)

);

INSERT INTO filmes VALUES (1,20,'Tropa de elite',2010,200000.00,1),(2,12,'Elysium',2014,650000.00,4),(3,15,'MIB',2007,500000.00,2),(4,9,'A procura da felicidade',2009,300000.00,2),(5,4,'Malévola',2014,178000.00,4),(6,7,'O Procurado',2008,243000.00,1),(7,12,'Central do Brasil',1998,80000.00,3),(8,3,'O auto da compadecida',2000,112777.00,5),(9,21,'Homem de Ferro',2008,1000000.00,5),(10,36,'Sherlock Holmes',2009,999999.00,3);

-- Exercícios

desc estudio;
desc filmes;
desc atores;
desc atuam;

-- Ex1
select nome as 'Estudio', datafundacao, faturamentoanoanterior from estudio;

-- Ex2
select estudio.nome ,filmes.nome, anolancamento as "Data de lançamento"
	from filmes 
		inner join estudio
			on filmes.codestudio = estudio.cod
order by estudio.nome, filmes.nome;

-- Ex 3
select nome as "Ator", sexo as "Sexo", atuam.personagem as 'Personagem', atuam.cache as "Valor ganhado por ator"
	from atores 
		inner join atuam
			on atores.cod = atuam.codatores;

-- Ex 4
select nome, min(anolancamento) from filmes group by (anolancamento) limit 1;

-- Ex 5
select atores.nome, atuam.personagem, atuam.cache, estudio.proprietario
	from atores 
		inner join estudio
			on atores.cod = estudio.cod
		inner join atuam
			on atores.cod = atuam.codatores
	where atores.nome = 'Wagner Moura';

-- Ex 6
select nome, count(anolancamento) from filmes 
where anolancamento >= 1998 and anolancamento <= 2008 
group by (anolancamento);

select count(anolancamento) from filmes 
where anolancamento between 1998 and  2008;


-- Ex 7 -- refazer
select atores.nome, sexo, count(sexo), estudio.nome
from atores inner join estudio
on atores.cod = estudio.cod
where estudio.nome = 'Universal';

-- Ex 8
select atuam.cod, atuam.codfilme, atores.cod, atores.nome
from atuam inner join atores
on atuam.codatores = atores.cod
where atores.nacionalidade = 'Americana';

-- Ex 9
select filmes.nome, atores.nome, atuam.cache 
from atores inner join atuam
on atores.cod = atuam.codatores
inner join filmes
on filmes.cod = atuam.codfilme
where atuam.cache > 190000.00;

-- Ex 10
select estudio.nome, filmes.nome, atores.nome, atuam.personagem
from atuam inner join atores
on atuam.codatores = atores.cod
inner join filmes
on atuam.codfilme = filmes.cod
inner join estudio
on atores.cod = estudio.cod
where filmes.nome = 'Homem de Ferro';


-- Ex 11
select atores.nome, max(atuam.cache)
from atores inner join atuam 
on atores.cod = atuam.codatores
group by (atuam.cache) order by atuam.cache desc limit 1;

-- Ex 12
select estudio.nome, estudio.proprietario, filmes.nome, filmes.meses, filmes.custototal, atores.nome, atores.nacionalidade, atores.idade, atores.sexo
from atores inner join atuam
on atores.cod = atuam.codatores
inner join filmes
on atuam.codfilme = filmes.cod
inner join estudio
on estudio.cod = atores.cod
where estudio.datafundacao > "01-02-1980.";

/*
Obs: Quando há três ou mais tabelas, você deve selecionar (from) da tabela mais "fraca", aquela que estiver maior ligações
Na Clásula ON, é comum mudar as chaves estrangeiras e primárias para comparação
*/

select * from atuam;
select * from estudio;
select * from atores;
select * from filmes;