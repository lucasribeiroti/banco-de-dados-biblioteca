-- CRIANDO O BANCO BIBLIOTECADB
CREATE DATABASE BibliotecaDB;
GO

USE BibliotecaDB;
GO

-- CRIANDO AS TABELAS AUTORES, LIVROS, USUARIOS E EMPRESTIMOS
CREATE TABLE Autores (
    AutorID INT IDENTITY(1,1) PRIMARY KEY,
    Nome NVARCHAR(100) NOT NULL,
    Nacionalidade NVARCHAR(50)
);

CREATE TABLE Livros (
    LivroID INT IDENTITY(1,1) PRIMARY KEY,
    Titulo NVARCHAR(150) NOT NULL,
    AnoPublicacao INT NOT NULL,
    ISBN NVARCHAR(20) UNIQUE,
    AutorID INT NOT NULL,
    CONSTRAINT CHK_AnoPublicacao CHECK (AnoPublicacao >= 1500),
    CONSTRAINT FK_Livros_Autores
        FOREIGN KEY (AutorID) REFERENCES Autores(AutorID)
);

CREATE TABLE Usuarios (
    UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
    Nome NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Telefone NVARCHAR(20),
    DataCadastro DATE DEFAULT GETDATE()
);

CREATE TABLE Emprestimos (
    EmprestimoID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT NOT NULL,
    LivroID INT NOT NULL,
    DataEmprestimo DATE NOT NULL DEFAULT GETDATE(),
    DataPrevistaDevolucao DATE NOT NULL,
    DataDevolucao DATE NULL,
    CONSTRAINT FK_Emprestimos_Usuarios
        FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    CONSTRAINT FK_Emprestimos_Livros
        FOREIGN KEY (LivroID) REFERENCES Livros(LivroID),
    CONSTRAINT CHK_DataDevolucao
        CHECK (DataDevolucao IS NULL OR DataDevolucao >= DataEmprestimo)
);


--INSERINDO DADOS EM AUTORES, LIVROS E USUARIOS
-- Autores
INSERT INTO Autores (Nome, Nacionalidade)
VALUES 
('Machado de Assis', 'Brasileira'),
('Pillpum', 'Brasileira'),
('Jamantha', 'Brasileira');

-- Livros
INSERT INTO Livros (Titulo, AnoPublicacao, ISBN, AutorID)
VALUES
('Zé pinga', 1899, '9788535910663', 1),
('1984', 1949, '9780451524935', 2),
('Zé cachaça', 1997, '9788532530783', 3);

-- Usuários
INSERT INTO Usuarios (Nome, Email, Telefone)
VALUES
('Lucas Ribeiro', 'lucas@email.com', '32999999999'),
('Pedro Atalaiza', 'pedro@email.com', '32988888888');

INSERT INTO Livros (Titulo, AnoPublicacao, AutorID)
VALUES ('Livro Inválido', 2020, 999);

-- CRIANDO A TRIGGER
CREATE TRIGGER TR_VerificarDisponibilidade
ON Emprestimos
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Emprestimos E
        JOIN inserted I ON E.LivroID = I.LivroID
        WHERE E.DataDevolucao IS NULL
    )
    BEGIN
        RAISERROR ('Livro já está emprestado.', 16, 1);
        RETURN;
    END

    INSERT INTO Emprestimos
    SELECT * FROM inserted;
END;

-- CRIANDO O ROLLBACK
BEGIN TRANSACTION;
INSERT INTO Usuarios (Nome, Email)
VALUES ('Teste', 'teste@email.com');
ROLLBACK;

-- CRIANDO O COMMIT
BEGIN TRANSACTION;
INSERT INTO Usuarios (Nome, Email)
VALUES ('Teste', 'teste@email.com');
COMMIT;


-- DEFININDO A DATA DE DEVOLUÇÃO DOS EMPRÉSTIMOS
UPDATE Emprestimos
SET DataDevolucao = '2025-04-10'
WHERE EmprestimoID = 1;

UPDATE Emprestimos
SET DataDevolucao = '2025-04-11'
WHERE EmprestimoID = 2;

UPDATE Emprestimos
SET DataDevolucao = '2026-04-19'
WHERE EmprestimoID = 3;

-- CONSULTA PARA VERIFICAR EMPRÉSTIMOS EM ABERTO
SELECT *
FROM Emprestimos
WHERE DataDevolucao IS NULL;

-- CONSULTANDO AS CHAVES ESTRANGEIRAS
SELECT 
    fk.name AS NomeConstraint,
    tp.name AS TabelaOrigem,
    cp.name AS ColunaOrigem,
    tr.name AS TabelaReferenciada,
    cr.name AS ColunaReferenciada
FROM sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc 
    ON fk.object_id = fkc.constraint_object_id
INNER JOIN sys.tables tp 
    ON fkc.parent_object_id = tp.object_id
INNER JOIN sys.columns cp 
    ON fkc.parent_object_id = cp.object_id 
    AND fkc.parent_column_id = cp.column_id
INNER JOIN sys.tables tr 
    ON fkc.referenced_object_id = tr.object_id
INNER JOIN sys.columns cr 
    ON fkc.referenced_object_id = cr.object_id 
    AND fkc.referenced_column_id = cr.column_id;