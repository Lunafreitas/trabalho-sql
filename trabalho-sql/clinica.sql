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





INSERT INTO Ambulatorios (nroa, andar, capacidade) VALUES (1, 1, 30);
INSERT INTO Ambulatorios (nroa, andar, capacidade) VALUES (2, 1, 50);
INSERT INTO Ambulatorios (nroa, andar, capacidade) VALUES (3, 2, 40);
INSERT INTO Ambulatorios (nroa, andar, capacidade) VALUES (4, 2, 25);
INSERT INTO Ambulatorios (nroa, andar, capacidade) VALUES (5, 2, 55);

INSERT INTO Medicos (codm, nome, idade, especialidade, CPF, cidade, nroa) VALUES (1, 'João', 40, 'ortopedia', 10000100000, 'Florianopolis', 1);
INSERT INTO Medicos (codm, nome, idade, especialidade, CPF, cidade, nroa) VALUES (2, 'Maria', 42, 'traumatologia', 10000110000, 'Blumenau', 2);
INSERT INTO Medicos (codm, nome, idade, especialidade, CPF, cidade, nroa) VALUES (3, 'Pedro', 51, 'pediatria', 11000100000, 'São José', 2);
INSERT INTO Medicos (codm, nome, idade, especialidade, CPF, cidade, nroa) VALUES (4, 'Carlos', 28, 'ortopedia', 11000110000, 'Joinville', 4);
INSERT INTO Medicos (codm, nome, idade, especialidade, CPF, cidade, nroa) VALUES (5, 'Marcia', 33, 'neurologia', 11000111000, 'Biguacu', 3);

INSERT INTO Pacientes (codp, nome, idade, cidade, CPF, doenca) VALUES (1, 'Ana', 20, 'Florianopolis', 20000200000, 'gripe');
INSERT INTO Pacientes (codp, nome, idade, cidade, CPF, doenca) VALUES (2, 'Paulo', 24, 'Palhoca', 20000222000, 'fratura');
INSERT INTO Pacientes (codp, nome, idade, cidade, CPF, doenca) VALUES (3, 'Lucia', 30, 'Biguacu', 22000200000, 'tendinite');
INSERT INTO Pacientes (codp, nome, idade, cidade, CPF, doenca) VALUES (4, 'Carlos', 28, 'Joinville', 11000110000, 'sarampo');

INSERT INTO Funcionarios (codf, nome, idade, cidade, salario, CPF) VALUES (1, 'Rita', 32, 'Sao Jose', 1200, 20000100000);
INSERT INTO Funcionarios (codf, nome, idade, cidade, salario, CPF) VALUES (2, 'Maria', 55, 'Palhoca', 1220, 30000110000);
INSERT INTO Funcionarios (codf, nome, idade, cidade, salario, CPF) VALUES (3, 'Caio', 45, 'Florianopolis', 11000100000);
INSERT INTO Funcionarios (codf, nome, idade, cidade, salario, CPF) VALUES (4, 'Carlos', 44, 'Florianopolis', 1200, 51000110000);
INSERT INTO Funcionarios (codf, nome, idade, cidade, salario, CPF) VALUES (5, 'Paula', 33, 'Florianopolis', 2500, 61000110000);

INSERT INTO Consultas (codm, codp, data, hora) VALUES (1, 1, '2006-06-12', '14:00:00'),
INSERT INTO Consultas (codm, codp, data, hora) VALUES (1, 4, '2006-06-13', '10:00:00'),
INSERT INTO Consultas (codm, codp, data, hora) VALUES (2, 1, '2006-06-13', '09:00:00'),
INSERT INTO Consultas (codm, codp, data, hora) VALUES (2, 2, '2006-06-13', '11:00:00'),
INSERT INTO Consultas (codm, codp, data, hora) VALUES (2, 3, '2006-06-14', '14:00:00'),
INSERT INTO Consultas (codm, codp, data, hora) VALUES (2, 4, '2006-06-14', '17:00:00'),
INSERT INTO Consultas (codm, codp, data, hora) VALUES (3, 1, '2006-06-19', '18:00:00'),
INSERT INTO Consultas (codm, codp, data, hora) VALUES (3, 3, '2006-06-12', '10:00:00'),
INSERT INTO Consultas (codm, codp, data, hora) VALUES (3, 4, '2006-06-19', '13:00:00'),
INSERT INTO Consultas (codm, codp, data, hora) VALUES (4, 4, '2006-06-20', '13:00:00'),
INSERT INTO Consultas (codm, codp, data, hora) VALUES (4, 4, '2006-06-22', '19:30:00');