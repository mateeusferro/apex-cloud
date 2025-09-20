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
INSERT INTO ong (nome) VALUES ('ONG Esperanca');
INSERT INTO ong (nome) VALUES ('ONG Futuro Melhor');

-- Professores (2 por ONG)
INSERT INTO professor (idong, nome, materia) VALUES (1, 'Ana Souza', 'Matematica');
INSERT INTO professor (idong, nome, materia) VALUES (1, 'Carlos Lima', 'Portugues');
INSERT INTO professor (idong, nome, materia) VALUES (2, 'Fernanda Alves', 'Ingles');
INSERT INTO professor (idong, nome, materia) VALUES (2, 'Joao Pereira', 'Informatica');

-- Voluntarios (2 por ONG)
INSERT INTO voluntario (idong, nome, depto) VALUES (1, 'Mariana Costa', 'Administracao');
INSERT INTO voluntario (idong, nome, depto) VALUES (1, 'Rafael Silva', 'Logistica');
INSERT INTO voluntario (idong, nome, depto) VALUES (2, 'Beatriz Santos', 'RH');
INSERT INTO voluntario (idong, nome, depto) VALUES (2, 'Lucas Martins', 'Financeiro');

-- Alunos (3 por ONG, area de interesse ligada a materia dos professores da mesma ONG)

-- ONG 1 (Matematica / Portugues)
INSERT INTO aluno (idong, nome, area_interesse) VALUES (1, 'Paulo Henrique', 'Matematica');
INSERT INTO aluno (idong, nome, area_interesse) VALUES (1, 'Juliana Rocha', 'Portugues');
INSERT INTO aluno (idong, nome, area_interesse) VALUES (1, 'Gabriel Oliveira', 'Matematica');

-- ONG 2 (Ingles / Informatica)
INSERT INTO aluno (idong, nome, area_interesse) VALUES (2, 'Camila Ferreira', 'Ingles');
INSERT INTO aluno (idong, nome, area_interesse) VALUES (2, 'Felipe Andrade', 'Informatica');
INSERT INTO aluno (idong, nome, area_interesse) VALUES (2, 'Aline Souza', 'Ingles');
