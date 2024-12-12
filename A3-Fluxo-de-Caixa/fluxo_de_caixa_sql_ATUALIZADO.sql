

CREATE DATABASE fluxo_de_caixa_2;


------------Implementação_das_Tabelas:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



-- Table: tb_contas

CREATE TABLE tb_contas (
    id_conta INT IDENTITY(1,1) PRIMARY KEY, 
    nome_conta VARCHAR(100) NOT NULL,        
    tipo_conta VARCHAR(50) NOT NULL,         
    saldo_inicial DECIMAL(10, 2) NOT NULL,  
    data_criacao DATETIME DEFAULT GETDATE()  
);




----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Table: tb_categorias

CREATE TABLE tb_categorias (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,   
    nome_categoria VARCHAR(100) NOT NULL,          
    tipo VARCHAR(10) CHECK(tipo IN ('receita', 'despesa')) NOT NULL  
);


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--Table: tb_centros_custo

CREATE TABLE tb_centros_custo(
    id_centro_custo INT IDENTITY(1,1) PRIMARY KEY,  
    nome_centro_custo VARCHAR(100) NOT NULL,         
    departamento VARCHAR(100) 
);



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Table: tb_formas_pagamento

CREATE TABLE tb_formas_pagamento (
    id_forma_pagamento INT IDENTITY(1,1) PRIMARY KEY, 
    tipo_pagamento VARCHAR(50) CHECK(tipo_pagamento IN ('dinheiro', 'cartão', 'transferência', 'outros')) NOT NULL,  
    detalhes VARCHAR(255) 
);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--Table: tb_detalhes_transferencia


CREATE TABLE tb_detalhes_transferencia (
    id_detalhe INT PRIMARY KEY,
    id_forma_pagamento INT,
    banco VARCHAR(100),
    agencia VARCHAR(50),
    conta VARCHAR(50),
    FOREIGN KEY (id_forma_pagamento) REFERENCES tb_formas_pagamento(id_forma_pagamento)
);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Table: tb_movimentacoes

CREATE TABLE tb_movimentacoes (
    id_movimentacao INT IDENTITY(1,1) PRIMARY KEY, 
    valor DECIMAL(10, 2) NOT NULL,                  
    data_movimentacao DATETIME NOT NULL,            
    tipo VARCHAR(10) CHECK(tipo IN ('entrada', 'saída')) NOT NULL, 
    descricao TEXT,                                 
    id_conta INT NOT NULL,                          
    id_categoria INT NOT NULL,                      
    id_centro_custo INT NOT NULL,                   
    id_forma_pagamento INT NOT NULL,                 
    FOREIGN KEY (id_conta) REFERENCES tb_contas(id_conta),                
    FOREIGN KEY (id_categoria) REFERENCES tb_categorias(id_categoria),    
    FOREIGN KEY (id_centro_custo) REFERENCES tb_centros_custo(id_centro_custo), 
    FOREIGN KEY (id_forma_pagamento) REFERENCES tb_formas_pagamento(id_forma_pagamento) 
);



------------Criação_de_Index---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Index: idx_id_forma_pagamento_tb_detalhes_transferencia

CREATE INDEX idx_id_forma_pagamento 
ON tb_detalhes_transferencia(id_forma_pagamento);


-- Index: idx_id_conta_tb_movimentacoes

CREATE INDEX idx_id_conta 
ON tb_movimentacoes(id_conta);

-- Index: idx_id_categoria

CREATE INDEX idx_id_categoria_tb_movimentacoes
ON tb_movimentacoes(id_categoria);

-- Index:  idx_id_centro_custo_tb_movimentacoes

CREATE INDEX idx_id_centro_custo 
ON tb_movimentacoes(id_centro_custo);

-- Index: idx_id_forma_pagamento_tb_movimentacoes

CREATE INDEX idx_id_forma_pagamento
ON tb_movimentacoes(id_forma_pagamento);
-------------------------------------------------------------------------------



------------Inserção_de_Dados_de_Teste---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--Inserção de Dados na tb_contas:

INSERT INTO tb_contas (nome_conta, tipo_conta, saldo_inicial)
VALUES 
('Caixa Econômica Federal', 'banco', 5000.00),
('Banco do Brasil', 'banco', 15000.00),
('Itaú Unibanco', 'banco', 20000.00),
('Bradesco', 'banco', 10000.00),
('Santander', 'banco', 8000.00),
('Banco Original', 'banco', 12000.00);

	   
	   
	   
--Inserção de Dados na tb_categorias:

INSERT INTO tb_categorias (nome_categoria, tipo)
VALUES ('Receita de Vendas', 'receita'),
       ('Despesa com Fornecedores', 'despesa'),
       ('Despesa de Funcionários', 'despesa');
	   
	   
--Inserção de Dados na tb_centros_custo:

INSERT INTO tb_centros_custo (nome_centro_custo, departamento)
VALUES ('Vendas', 'Comercial'),
       ('Marketing', 'Comercial'),
       ('TI', 'Tecnologia');
	   
	   
--Inserção de Dados na tb_formas_pagamento:

INSERT INTO tb_formas_pagamento (tipo_pagamento, detalhes)
VALUES 
('dinheiro', NULL),                         
('cartão', 'Visa'),                          
('transferência', 'Caixa Econômica Federal - Conta 1234'),   
('transferência', 'Banco do Brasil - Conta 5678'),           
('transferência', 'Itaú Unibanco - Conta 9876'),             
('transferência', 'Bradesco - Conta 2345');  
	   
	   
--Inserção de Dados na tb_detalhes_transferencia:

INSERT INTO tb_detalhes_transferencia (id_detalhe, id_forma_pagamento, banco, agencia, conta)
VALUES (1, 3, 'Itaú Unibanco', 'Agência 123', 'Conta 9876'),
       (2, 3, 'Bradesco', 'Agência 456', 'Conta 2345');
	   
	   

--Inserção de Dados na tb_movimentacoes:

INSERT INTO tb_movimentacoes (valor, data_movimentacao, tipo, descricao, id_conta, id_categoria, id_centro_custo, id_forma_pagamento)
VALUES (1000.00, '2024-12-01', 'entrada', 'Recebimento de vendas', 1, 1, 1, 1),
       (-500.00, '2024-12-02', 'saída', 'Pagamento a fornecedor', 2, 2, 2, 3),
       (-300.00, '2024-12-02', 'saída', 'Salário de funcionários', 3, 3, 3, 2);



---Consultas:

SELECT * FROM tb_contas;
SELECT * FROM tb_categorias;
SELECT * FROM tb_centros_custo;
SELECT * FROM tb_formas_pagamento;
SELECT * FROM tb_detalhes_transferencia;
SELECT * FROM tb_movimentacoes;



-- Consultar todas as movimentações de um determinado período
SELECT * FROM tb_movimentacoes WHERE data_movimentacao BETWEEN '2024-12-01' AND '2024-12-02';

-- Consultar movimentações por conta e categoria
SELECT * FROM tb_movimentacoes
WHERE id_conta = 1 AND id_categoria = 1;



------------Implementação_de_Objetos_de_Banco_de_Dados:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--Stored Procedures:

--Cálculo do saldo do fluxo de caixa.

CREATE PROCEDURE CalcularSaldoFluxoCaixa
AS
BEGIN
    DECLARE @saldo DECIMAL(18, 2);
    
    SELECT @saldo = SUM(CASE WHEN tipo = 'entrada' THEN valor 
                             WHEN tipo = 'saída' THEN -valor 
                             ELSE 0 END)
    FROM tb_movimentacoes;

    PRINT 'Saldo Atual do Fluxo de Caixa: ' + CAST(@saldo AS VARCHAR);
END;

--Geração de relatórios de receitas e despesas.

CREATE PROCEDURE GerarRelatorioReceitasDespesas
AS
BEGIN
    SELECT 
        c.nome_categoria AS Categoria,
        SUM(CASE WHEN m.tipo = 'entrada' THEN m.valor ELSE 0 END) AS Total_Receitas,
        SUM(CASE WHEN m.tipo = 'saída' THEN m.valor ELSE 0 END) AS Total_Despesas
    FROM Movimentacoes m
    INNER JOIN Categorias c ON m.id_categoria = c.id_categoria
    GROUP BY c.nome_categoria
    ORDER BY c.nome_categoria;
END;

--Projeção do fluxo de caixa futuro.

CREATE PROCEDURE ProjetarFluxoCaixaFuturo (@meses INT = 12)
AS
BEGIN
    DECLARE @media_receitas DECIMAL(18, 2);
    DECLARE @media_despesas DECIMAL(18, 2);

    SELECT 
        @media_receitas = AVG(CASE WHEN tipo = 'entrada' THEN valor ELSE NULL END),
        @media_despesas = AVG(CASE WHEN tipo = 'saída' THEN valor ELSE NULL END)
    FROM tb_movimentacoes
    WHERE data_movimentacao >= DATEADD(MONTH, -@meses, GETDATE());

    PRINT 'Projeção Média Mensal de Receitas: ' + CAST(@media_receitas AS VARCHAR);
    PRINT 'Projeção Média Mensal de Despesas: ' + CAST(@media_despesas AS VARCHAR);
END;

--Validação de dados de entrada


CREATE PROCEDURE ValidarInsercaoMovimentacao
    @tipo VARCHAR(10),
    @valor DECIMAL(18, 2),
    @data_movimentacao DATETIME
AS
BEGIN
    IF @tipo NOT IN ('entrada', 'saída')
    BEGIN
        PRINT 'Erro: Tipo de movimentação inválido.';
        RETURN;
    END

    IF @valor <= 0
    BEGIN
        PRINT 'Erro: O valor deve ser maior que zero.';
        RETURN;
    END

    IF @data_movimentacao > GETDATE()
    BEGIN
        PRINT 'Erro: A data da movimentação não pode ser no futuro.';
        RETURN;
    END

    PRINT 'Dados validados com sucesso.';
END;




------------------------Funções:------------------------------------------------------------------------------------------------



--Cálculo de juros compostos.

CREATE FUNCTION CalcularJurosCompostos
    (@principal DECIMAL(18, 2), @taxa DECIMAL(10, 4), @periodos INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    RETURN @principal * POWER(1 + @taxa, @periodos);
END;

-----------------------------------------------------------------------------------------------------------------------


--Cálculo do valor presente líquido (VPL).

-- Passo 1: Criar a tabela de fluxos de caixa e inserir dados
CREATE TABLE FluxosCaixa
(
    periodo INT,
    valor DECIMAL(18, 2)
);

INSERT INTO FluxosCaixa (periodo, valor)
VALUES 
    (1, 1000),
    (2, 2000),
    (3, 3000);

-- Passo 2: Criar a função CalcularVPL
CREATE FUNCTION CalcularVPL
(
    @taxa DECIMAL(10, 4)
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @vpl DECIMAL(18, 2) = 0;
    DECLARE @periodo INT;
    DECLARE @valor DECIMAL(18, 2);

    -- Cursor para iterar pelos fluxos de caixa
    DECLARE fluxo_cursor CURSOR FOR
    SELECT periodo, valor
    FROM FluxosCaixa;

    OPEN fluxo_cursor;

    FETCH NEXT FROM fluxo_cursor INTO @periodo, @valor;


    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @vpl = @vpl + @valor / POWER(1 + @taxa, @periodo);
        FETCH NEXT FROM fluxo_cursor INTO @periodo, @valor;
    END;

    
    CLOSE fluxo_cursor;
    DEALLOCATE fluxo_cursor;

    RETURN @vpl;
END;

-- Passo 3: Executar a função para verificar o resultado
SELECT dbo.CalcularVPL(0.05) AS VPL;



-----------------------------------------------------------------------------------------------------------------------

CREATE FUNCTION CalcularTIR
(
    @iteracoes INT,
    @precisao DECIMAL(10, 6)
)
RETURNS DECIMAL(10, 6)
AS
BEGIN
    DECLARE @tir DECIMAL(10, 6) = 0.1; -- Valor inicial da TIR
    DECLARE @vpl DECIMAL(18, 2);
    DECLARE @ajuste DECIMAL(10, 6);
    DECLARE @periodo INT;
    DECLARE @valor DECIMAL(18, 2);
    
    -- Cursor para iterar pelos fluxos de caixa
    DECLARE fluxo_cursor CURSOR FOR
    SELECT periodo, valor
    FROM FluxosCaixa;

    -- Loop para encontrar a TIR
    WHILE @iteracoes > 0
    BEGIN
        SET @vpl = 0;

        -- Abrir o cursor
        OPEN fluxo_cursor;

        -- Obter a primeira linha
        FETCH NEXT FROM fluxo_cursor INTO @periodo, @valor;

        -- Iterar pelas linhas do cursor
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @vpl = @vpl + @valor / POWER(1 + @tir, @periodo);
            FETCH NEXT FROM fluxo_cursor INTO @periodo, @valor;
        END;

        -- Fechar o cursor
        CLOSE fluxo_cursor;

        -- Se o VPL for suficientemente próximo de 0, retorne a TIR
        IF ABS(@vpl) <= @precisao
            RETURN @tir;

        -- Calcular o ajuste para a TIR
        SET @ajuste = -(@vpl / (
            SELECT SUM(-periodo * valor / POWER(1 + @tir, periodo + 1))
            FROM FluxosCaixa
        ));

        -- Atualizar a TIR
        SET @tir = @tir + @ajuste;
        SET @iteracoes = @iteracoes - 1;
    END;

    -- Desalocar o cursor
    DEALLOCATE fluxo_cursor;

    RETURN NULL; 
END;


-- Chamar a função CalcularTIR 
SELECT dbo.CalcularTIR(100, 500.2) AS TIR;



--------------triggres------------------------------------------------------------------------------------------


CREATE TRIGGER trg_validar_insercao
ON tb_movimentacoes
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM INSERTED
        WHERE tipo NOT IN ('entrada', 'saída') 
           OR valor <= 0
    )
    BEGIN
        RAISERROR ('Erro: Dados inválidos para inserção.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO tb_movimentacoes (tipo, valor, data_movimentacao, id_categoria)
        SELECT tipo, valor, data_movimentacao, id_categoria
        FROM INSERTED;
    END
END;

CREATE TRIGGER trg_atualizar_saldo
ON tb_movimentacoes
AFTER INSERT, DELETE
AS
BEGIN
    DECLARE @saldo_total DECIMAL(18, 2);

    SELECT @saldo_total = SUM(CASE WHEN tipo = 'entrada' THEN valor 
                                   WHEN tipo = 'saída' THEN -valor 
                                   ELSE 0 END)
    FROM tb_movimentacoes;

    UPDATE ResumoFluxoCaixa
    SET saldo_atual = @saldo_total;
END;



