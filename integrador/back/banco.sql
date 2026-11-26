
CREATE DATABASE IF NOT EXISTS controle_acesso;
USE controle_acesso;

-- TABELA DE PESSOAS
CREATE TABLE pessoas (
    idPessoa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    cpf CHAR(11) NOT NULL UNIQUE,
    dataNascimento DATE NOT NULL
);

-- TABELA DE CURSOS
CREATE TABLE cursos (
    idCurso INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255)
);

-- TABELA DE TURMAS
CREATE TABLE turmas (
    idTurma INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    horarioInicio TIME NOT NULL,
    horarioFim TIME NOT NULL,
    dataInicio DATE NOT NULL,
    dataFim DATE NOT NULL,
    idCurso INT NOT NULL,
    FOREIGN KEY (idCurso) REFERENCES cursos(idCurso),
    CHECK (horarioFim > horarioInicio),
    CHECK (dataFim >= dataInicio)
);

-- TABELA DE ALUNOS
CREATE TABLE alunos (
    idPessoa INT PRIMARY KEY,
    matricula VARCHAR(20) NOT NULL UNIQUE,
    idTurma INT NOT NULL,
    FOREIGN KEY (idPessoa) REFERENCES pessoas(idPessoa),
    FOREIGN KEY (idTurma) REFERENCES turmas(idTurma)
);

-- TABELA DE FUNCIONÁRIOS
CREATE TABLE funcionarios (
    idPessoa INT PRIMARY KEY,
    nif VARCHAR(20) NOT NULL UNIQUE,
    cargo VARCHAR(80) NOT NULL,
    FOREIGN KEY (idPessoa) REFERENCES pessoas(idPessoa)
);

-- TABELA DE VISITANTES
CREATE TABLE visitantes (
    idPessoa INT PRIMARY KEY,
    empresa VARCHAR(100),
    motivoVisita VARCHAR(255) NOT NULL,
    FOREIGN KEY (idPessoa) REFERENCES pessoas(idPessoa)
);

-- TABELA DE ACESSOS
CREATE TABLE acessos (
    idAcesso INT AUTO_INCREMENT PRIMARY KEY,
    dataHora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipoAcesso VARCHAR(10) NOT NULL,
    idPessoa INT NOT NULL,
    FOREIGN KEY (idPessoa) REFERENCES pessoas(idPessoa),
    CHECK (tipoAcesso IN ('ENTRADA', 'SAIDA'))
);

-- ÍNDICES
CREATE INDEX idx_matricula ON alunos(matricula);
CREATE INDEX idx_nif ON funcionarios(nif);

-- CURSOS
INSERT INTO cursos (nome, descricao) VALUES
('Desenvolvimento de Sistemas', 'Curso técnico de programação'),
('Automação Industrial', 'Curso técnico de automação');

-- TURMAS
INSERT INTO turmas
(nome, horarioInicio, horarioFim, dataInicio, dataFim, idCurso)
VALUES
('DS - 3A', '07:30:00', '12:00:00', '2026-02-01', '2026-06-30', 1),
('AI - 3A', '13:00:00', '17:30:00', '2026-02-01', '2026-06-30', 2);

-- PESSOAS
INSERT INTO pessoas
(nome, email, telefone, cpf, dataNascimento)
VALUES
('João Silva', 'joao@email.com', '11999990001', '12345678901', '2007-05-10'),
('Maria Souza', 'maria@email.com', '11999990002', '12345678902', '2007-08-15'),
('Carlos Oliveira', 'carlos@email.com', '11999990003', '12345678903', '1985-03-20'),
('Ana Santos', 'ana@email.com', '11999990004', '12345678904', '1990-11-12'),
('Pedro Costa', 'pedro@email.com', '11999990005', '12345678905', '1995-06-25');

-- ALUNOS
INSERT INTO alunos (idPessoa, matricula, idTurma) VALUES
(1, '2026001', 1),
(2, '2026002', 2);

-- FUNCIONÁRIOS
INSERT INTO funcionarios (idPessoa, nif, cargo) VALUES
(3, 'FUNC001', 'Professor'),
(4, 'FUNC002', 'Coordenadora');

-- VISITANTES
INSERT INTO visitantes (idPessoa, empresa, motivoVisita) VALUES
(5, 'Tech Solutions', 'Reunião com a coordenação');

-- REGISTROS DE ACESSO
INSERT INTO acessos (dataHora, tipoAcesso, idPessoa) VALUES
('2026-11-26 07:30:00', 'ENTRADA', 1),
('2026-11-26 07:35:00', 'ENTRADA', 2),
('2026-11-26 07:40:00', 'ENTRADA', 3),
('2026-11-26 08:00:00', 'SAIDA', 2),
('2026-11-26 08:15:00', 'ENTRADA', 5);

-- CONSULTA DE ACESSOS
SELECT
    pessoas.nome,
    pessoas.cpf,
    acessos.dataHora,
    acessos.tipoAcesso
FROM acessos
INNER JOIN pessoas
ON acessos.idPessoa = pessoas.idPessoa
ORDER BY acessos.dataHora DESC;

-- ESTRUTURA DAS TABELAS
SHOW CREATE TABLE pessoas;
SHOW CREATE TABLE cursos;
SHOW CREATE TABLE turmas;
SHOW CREATE TABLE alunos;
SHOW CREATE TABLE funcionarios;
SHOW CREATE TABLE visitantes;
SHOW CREATE TABLE acessos;
