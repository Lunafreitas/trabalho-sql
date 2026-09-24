CREATE DATABASE clinica;
USE clinica;

-- Cria a tabela de ambulatorios
CREATE TABLE Ambulatorios (
    nroa INT PRIMARY KEY,
    andar NUMERIC(3) NOT NULL,
    capacidade SMALLINT
);

-- Cria a tabela de medicos
CREATE TABLE Medicos (
    codm INT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT NOT NULL,
    especialidade CHAR(20),
    CPF NUMERIC(11) UNIQUE,
    cidade VARCHAR(30),
    nroa INT,
    FOREIGN KEY (nroa) REFERENCES Ambulatorios(nroa)
);

-- Cria a tabela de pacientes
CREATE TABLE Pacientes (
    codp INT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT NOT NULL,
    cidade CHAR(30),
    CPF NUMERIC(11) UNIQUE,
    doenca VARCHAR(40) NOT NULL
);

-- Cria a tabela de funcionarios
CREATE TABLE Funcionarios (
    codf INT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT,
    CPF NUMERIC(11) UNIQUE,
    cidade VARCHAR(30),
    salario NUMERIC(10),
    cargo VARCHAR(20)
);

-- Cria a tabela de consultas
CREATE TABLE Consultas (
    codm INT,
    codp INT,
    data DATE,
    hora TIME,
    FOREIGN KEY (codm) REFERENCES Medicos(codm),
    FOREIGN KEY (codp) REFERENCES Pacientes(codp)
);

-- Adiciona nroa em Funcionarios
ALTER TABLE Funcionarios ADD COLUMN nroa INT;

-- Cria os indices
CREATE UNIQUE INDEX idx_medicos_cpf ON Medicos(CPF);
CREATE INDEX idx_medicos_nroa ON Medicos(nroa);
CREATE INDEX idx_pacientes_doenca ON Pacientes(doenca);

-- Remove o indice doenca
DROP INDEX idx_pacientes_doenca ON Pacientes;

-- Remove cargo e nroa
ALTER TABLE Funcionarios DROP COLUMN cargo, DROP COLUMN nroa;


-- Insere os ambulatorios
INSERT INTO Ambulatorios VALUES
(1,1,30),
(2,1,50),
(3,2,40),
(4,2,25),
(5,2,55);

-- Insere os medicos
INSERT INTO Medicos VALUES
(1,'João',40,'ortopedia',10000100000,'Florianopolis',1),
(2,'Maria',42,'traumatologia',10000110000,'Blumenau',2),
(3,'Pedro',51,'pediatria',11000100000,'São José',2),
(4,'Carlos',28,'ortopedia',11000110000,'Joinville',4),
(5,'Marcia',33,'neurologia',11000111000,'Biguacu',3);

-- Insere os pacientes
INSERT INTO Pacientes VALUES
(1,'Ana',20,'Florianopolis',20000200000,'gripe'),
(2,'Paulo',24,'Palhoca',20000222000,'fratura'),
(3,'Lucia',30,'Biguacu',22000200000,'tendinite'),
(4,'Carlos',28,'Joinville',11000110000,'sarampo');

-- Insere os funcionarios
INSERT INTO Funcionarios
(codf,nome,idade,cidade,salario,CPF) VALUES
(1,'Rita',32,'Sao Jose',1200,20000100000),
(2,'Maria',55,'Palhoca',1220,30000110000),
(3,'Caio',45,'Florianopolis',1100,41000100000),
(4,'Carlos',44,'Florianopolis',1200,51000110000),
(5,'Paula',33,'Florianopolis',2500,61000110000);

-- Insere as consultas
INSERT INTO Consultas VALUES
(1,1,'2006-06-12','14:00:00'),
(1,4,'2006-06-13','10:00:00'),
(2,1,'2006-06-13','09:00:00'),
(2,2,'2006-06-13','11:00:00'),
(2,3,'2006-06-14','14:00:00'),
(2,4,'2006-06-14','17:00:00'),
(3,1,'2006-06-19','18:00:00'),
(3,3,'2006-06-12','10:00:00'),
(3,4,'2006-06-19','13:00:00'),
(4,4,'2006-06-20','13:00:00'),
(4,4,'2006-06-22','19:30:00');


-- ATUALIZAÇÕES

-- 1. Paulo mudou para Ilhota
UPDATE Pacientes
SET cidade = 'Ilhota'
WHERE nome = 'Paulo';


-- 2. Consulta do medico 1 com paciente 4
UPDATE Consultas
SET data = '2006-07-04', hora = '12:00:00'
WHERE codm = 1 AND codp = 4;


-- 3. Ana fez aniversario e sua doenca mudou
UPDATE Pacientes
SET doenca = 'câncer', idade = idade + 1
WHERE nome = 'Ana';


-- 4. Consulta de Pedro com Carlos passou para 1 hora e meia depois
UPDATE Consultas
SET hora = ADDTIME(hora, '01:30:00')
WHERE codm = 3 AND codp = 4;


-- 5. Carlos saiu da clinica
DELETE FROM Funcionarios
WHERE nome = 'Carlos';


-- 6. Cancela consultas depois das 19 horas
DELETE FROM Consultas
WHERE hora > '19:00:00';


-- 7. Remove pacientes com cancer ou menores de 10 anos
-- Primeiro remove suas consultas
DELETE FROM Consultas
WHERE codp IN (
    SELECT codp
    FROM Pacientes
    WHERE doenca = 'câncer' OR idade < 10
);

DELETE FROM Pacientes
WHERE doenca = 'câncer' OR idade < 10;


-- 8. Remove medicos de Biguacu ou Palhoca
DELETE FROM Medicos
WHERE cidade = 'Biguacu' OR cidade = 'Palhoca';