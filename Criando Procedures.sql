CREATE DATABASE CINEMA;
DROP TABLE IF EXISTS atores; -- Apague a tabela caso ela já exista

CREATE TABLE atores (
	cod int NOT NULL,
	nome varchar(45) DEFAULT NULL,
	nacionalidade varchar(30) DEFAULT NULL,
	idade int DEFAULT NULL,
	sexo char(1) DEFAULT NULL,
	PRIMARY KEY (cod)
);

INSERT INTO atores VALUES 
(1,'will smith','americana',35,'m'),
(2,'Angelina jolie','americana',34,'f'),
(3,'Fernanda Montenegro','brasileira',70,'f'),
(4,'Wagner Moura','brasileira',36,'m'),
(5,'Roberto Downey Jr','americana',42,'m');

DROP TABLE IF EXISTS atuam;

CREATE TABLE atuam (
	cod int NOT NULL,
	codatores int DEFAULT NULL,
	codfilme int DEFAULT NULL,
	cache decimal(10,2) DEFAULT NULL,
	personagem varchar(45) DEFAULT NULL,
	PRIMARY KEY (cod),

	CONSTRAINT atuam_ibfk_1 
	FOREIGN KEY (codatores) REFERENCES atores (cod),
	CONSTRAINT atuam_ibfk_2 
	FOREIGN KEY (codfilme) REFERENCES Filmes (cod)
);

INSERT INTO atuam VALUES 
(1,4,1,100000.00,'Capitão Nascimento'),
(2,4,2,18000.00,'John'),(3,1,3,200000.00,'Will'),
(4,1,4,250000.00,'Stanley'),(5,2,5,350000.00,'Malévola'),
(6,2,6,333000.00,'Mary'),(7,3,7,50000.00,'Fernanda'),
(8,3,8,55000.00,'Maria'),(9,5,9,700000.00,'Tony Starks'),
(10,5,10,660000.00,'Sherlock Holmes');

DROP TABLE IF EXISTS estudio;

CREATE TABLE estudio (
	cod int NOT NULL,
	nome varchar(45) DEFAULT NULL,
	proprietario varchar(45) DEFAULT NULL,
	faturamentoanoanterior decimal(10,2) DEFAULT NULL,
	datafundacao date DEFAULT NULL,
	PRIMARY KEY (cod)

);

INSERT INTO estudio VALUES (1,'Center Filmes','João',200000.00,'1980-01-29'),(2,'MGM','Michael',178000.00,'1990-01-23'),(3,'Universal','Douglas',12000.00,'2000-01-21'),(4,'Disney','Lucas',500000.00,'1980-12-31'),(5,'Argentina Filmes','Maradona',38700.43,'2005-10-10');

DROP TABLE IF EXISTS filmes;

CREATE TABLE filmes (
	cod int NOT NULL,
	meses int DEFAULT NULL,
	nome varchar(45) DEFAULT NULL,
	anolancamento DATE DEFAULT NULL,
	custototal decimal(10,2) DEFAULT NULL,
	codestudio int DEFAULT NULL,
	PRIMARY KEY (cod),
	
	CONSTRAINT filmes_ibfk_1 
	FOREIGN KEY (codestudio) 
	REFERENCES estudio (cod)

);

INSERT INTO filmes VALUES 
(1,20,'Tropa de elite','2010',200000.00,1),
(2,12,'Elysium','2014',650000.00,4),
(3,15,'MIB','2007',500000.00,2),
(4,9,'A procura da felicidade','2009',300000.00,2),
(5,4,'Malévola','2014',178000.00,4),
(6,7,'O Procurado','2008',243000.00,1),
(7,12,'Central do Brasil','1998',80000.00,3),
(8,3,'O auto da compadecida','2000',112777.00,5),
(9,21,'Homem de Ferro','2008',1000000.00,5),
(10,36,'Sherlock Holmes','2009',999999.00,3);


SELECT * FROM ESTUDIO;
SELECT * FROM ATUAM;
SELECT * FROM ATORES;
SELECT * FROM FILMES;

-- CRIANDO PROCEDURE

CREATE PROCEDURE BUSCA_FILMES
	@NomeAtor varchar(45) -- variável(parâmetro) de entrada, tem que ser igual o da coluna

AS

SET @NomeAtor = '%' + @NomeAtor + '%'

SELECT filmes.nome, filmes.anolancamento, atores.nome, atuam.personagem
	FROM ATUAM
		INNER JOIN FILMES ON ATUAM.codfilme = FILMES.COD
		INNER JOIN ATORES ON ATORES.COD = ATUAM.codatores
		INNER JOIN ESTUDIO ON estudio.cod = filmes.codestudio
	WHERE ATORES.nome LIKE @NomeAtor

	END;


EXEC BUSCA_FILMES @NomeAtor = 'will smith';
EXECUTE BUSCA_FILMES 'Angelina Jolie';

-- PROCEDURE PARA INSERIR NOVO FILME

CREATE PROCEDURE InserirNovoFilme
	@NomeFilme varchar(45),
	@MesesFilme int,
	@AnoFilme date,
	@CustoFilme decimal(10,2),
	@fkEstudio int

AS
BEGIN
	DECLARE @vCod INT;
	SELECT @vCod = max(cod) + 1 from filmes;

	INSERT INTO filmes (cod, meses, nome, anolancamento, custototal, codestudio)
		VALUES (@vCod, @MesesFilme, @NomeFilme, @AnoFilme, @CustoFilme, @fkEstudio)

	SELECT @vCod = cod from filmes where cod = @vCod;
	SELECT @vCod as Retorno;
END;

EXEC InserirNovoFilme 'O Condenado', 12, '2022-08-24', 4500, 2;

SELECT * FROM FILMES;