CREATE DATABASE LOJA_ANDREW_TTSP;

USE LOJA_ANDREW_TTSP;

CREATE TABLE cadfun(
	codfun INTEGER NOT NULL,
    nome VARCHAR(40) NOT NULL,
    depto CHAR(2),
    funcao CHAR(20),
    salario DECIMAL(10,2)
);

INSERT INTO cadfun (codfun, nome, depto, funcao, salario) VALUES(
	07, 'APARECIDA SILVA', '3', 'SECRETARIA', 1200.50),
    (08, 'MARCELE FERREIRA SILVA', '2', 'SUB-GERENTE', 1500.00),
    (36, 'FERNANDA SILVA ALMEIDA', '4', 'VENDEDOR', 1010.15),
    (37, 'GABRIELA FERNANDES', '4', 'VENDEDOR', 1010.15),
    (38, 'RAFAEL OLIVEIRA CRUZ', '4', 'VENDEDOR', 1010.15),
    (44, 'JACIBA DA SILVA', '3', NULL, 1500.00),
    (02, 'WILSON DE MACEDO', '3', 'PROGRAMADOR', 1050.00),
    (05, 'AUGUSTO SOUZA', '3', 'PROGRAMADOR', 1050.00);
    
SELECT * FROM cadfun;
SELECT *, max(salario) FROM cadfun;
SELECT * FROM cadfun WHERE depto LIKE '3';
SELECT * FROM cadfun WHERE funcao LIKE 'PROGRAMADOR';
SELECT * FROM cadfun WHERE salario LIKE '11%';
SELECT * FROM cadfun WHERE salario LIKE '10%';
SELECT * FROM cadfun WHERE salario > 1069.00;

UPDATE cadfun SET salario = salario + 100;

