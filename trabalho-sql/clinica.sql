CREATE DATABASE Clinica;
USE Clinica;

CREATE TABLE Ambulatorios (
    nroa INT PRIMARY KEY,
    andar NUMERIC(3) NOT NULL,
    capacidade SMALLINT
);

CREATE TABLE Medicos (
    codm INT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT NOT NULL,
    especialidade CHAR(20),
    CPF NUMERIC(11) UNIQUE,
    cidade VARCHAR(30),
    nroa INT,
    FOREIGN KEY (nroa) REFERENCES Ambulatorios(nroa) -- chave estrangeira ai, references indica qual tabel e coluna a FK referee
);

CREATE TABLE Pacientes (
    codp INT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT NOT NULL,
    cidade CHAR(30),
    CPF NUMERIC(11) UNIQUE,
    doenca VARCHAR(40) NOT NULL
);

CREATE TABLE Funcionarios (
    codf INT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT,
    CPF NUMERIC(11) UNIQUE,
    cidade VARCHAR(30),
    salario NUMERIC(10),
    cargo VARCHAR(20)
);

CREATE TABLE Consultas (
    codm INT,
    codp INT,
    data DATE,
    hora TIME,
    FOREIGN KEY (codm) REFERENCES Medicos(codm),
    FOREIGN KEY (codp) REFERENCES Pacientes(codp)
);

ALTER TABLE Funcionarios ADD COLUMN nroa INT;

CREATE UNIQUE INDEX idx_medicos_cpf ON Medicos(CPF);
CREATE INDEX idx_medicos_nroa ON Medicos(nroa);
CREATE INDEX idx_pacientes_doenca ON Pacientes(doenca);

DROP INDEX idx_pacientes_doenca ON Pacientes;

ALTER TABLE Funcionarios DROP COLUMN cargo, DROP COLUMN nroa;