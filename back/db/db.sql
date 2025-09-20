CREATE DATABASE APEX_I;

USE APEX_I;

CREATE USER 'apex_user'@'%' IDENTIFIED BY 'senha123';

GRANT ALL PRIVILEGES ON APEX_I.* TO 'apex_user'@'%';
ALTER USER 'apex_user'@'%' IDENTIFIED WITH mysql_native_password BY 'senha123';
FLUSH PRIVILEGES;


CREATE TABLE ong (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE voluntario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    idong INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    depto VARCHAR(100),
    FOREIGN KEY (idong) REFERENCES ong(id)
);

CREATE TABLE aluno (
    id INT AUTO_INCREMENT PRIMARY KEY,
    idong INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    area_interesse VARCHAR(100),
    FOREIGN KEY (idong) REFERENCES ong(id)
);

CREATE TABLE professor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    idong INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    materia VARCHAR(100) NOT NULL,
    FOREIGN KEY (idong) REFERENCES ong(id)
);

-- ONGs
INSERT INTO ong (nome) VALUES ('ONG Esperança');
INSERT INTO ong (nome) VALUES ('ONG Futuro Melhor');

-- Professores (2 por ONG)
INSERT INTO professor (idong, nome, materia) VALUES (1, 'Ana Souza', 'Matemática');
INSERT INTO professor (idong, nome, materia) VALUES (1, 'Carlos Lima', 'Português');
INSERT INTO professor (idong, nome, materia) VALUES (2, 'Fernanda Alves', 'Inglês');
INSERT INTO professor (idong, nome, materia) VALUES (2, 'João Pereira', 'Informática');

-- Voluntários (2 por ONG)
INSERT INTO voluntario (idong, nome, depto) VALUES (1, 'Mariana Costa', 'Administração');
INSERT INTO voluntario (idong, nome, depto) VALUES (1, 'Rafael Silva', 'Logística');
INSERT INTO voluntario (idong, nome, depto) VALUES (2, 'Beatriz Santos', 'RH');
INSERT INTO voluntario (idong, nome, depto) VALUES (2, 'Lucas Martins', 'Financeiro');

-- Alunos (3 por ONG, área de interesse ligada à matéria dos professores da mesma ONG)

-- ONG 1 (Matemática / Português)
INSERT INTO aluno (idong, nome, area_interesse) VALUES (1, 'Paulo Henrique', 'Matemática');
INSERT INTO aluno (idong, nome, area_interesse) VALUES (1, 'Juliana Rocha', 'Português');
INSERT INTO aluno (idong, nome, area_interesse) VALUES (1, 'Gabriel Oliveira', 'Matemática');

-- ONG 2 (Inglês / Informática)
INSERT INTO aluno (idong, nome, area_interesse) VALUES (2, 'Camila Ferreira', 'Inglês');
INSERT INTO aluno (idong, nome, area_interesse) VALUES (2, 'Felipe Andrade', 'Informática');
INSERT INTO aluno (idong, nome, area_interesse) VALUES (2, 'Aline Souza', 'Inglês');