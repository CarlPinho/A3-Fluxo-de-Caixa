# A3-Fluxo-de-Caixa

#### NOME: Carlos Emanuel Da Sulva Pinho
#### RA: 1252228970

## Desenvolvimento de um Banco de Dados Relacional para Gestão do Fluxo de Caixa

# Introdução:

O fluxo de caixa é uma ferramenta essencial para a gestão financeira de empresas, pois oferece uma visão detalhada das entradas e saídas de recursos financeiros ao longo de um período. Ele permite que gestores avaliem a liquidez da organização, tomem decisões estratégicas embasadas e antecipem possíveis dificuldades financeiras. Além disso, um fluxo de caixa bem gerido promove sustentabilidade, auxiliando na alocação de recursos para investimentos, controle de custos e cumprimento de obrigações financeiras.

## Resumo:
O fluxo de caixa é vital para a saúde financeira e a sustentabilidade das empresas.
Ele auxilia na avaliação da liquidez, controle de custos e planejamento estratégico.



## Objetivo:

O principal objetivo deste trabalho é desenvolver um banco de dados relacional utilizando o Sistema de Gerenciamento de Banco de Dados (SGBD) MS SQL Server, com foco na análise e no cálculo do fluxo de caixa de uma empresa. Este banco de dados deve:

Armazenar informações detalhadas sobre receitas, despesas, investimentos e movimentações financeiras.
Facilitar a consulta e a geração de relatórios que apoiem a tomada de decisão.
Suportar análises financeiras, como saldos consolidados, tendências de receitas e despesas e previsões de fluxo de caixa.



### Etapas do Desenvolvimento:

1. Modelagem Conceitual / Entidade-Relacionamento (MER)
Identificação de Entidades Relevantes
As principais entidades do banco de dados são:

Contas: Representam os ativos financeiros, como caixa, contas bancárias e aplicações.
Categorias de Receitas e Despesas: Classificam as movimentações financeiras.
Movimentações Financeiras: Registra entradas e saídas de dinheiro.
Centros de Custo: Identificam setores ou projetos responsáveis pelas movimentações.
Formas de Pagamento: Especificam como as transações foram realizadas (dinheiro, cartão, transferência).
Definição de Relacionamentos
Exemplos de relacionamentos entre as entidades:

Contas e Movimentações Financeiras: Uma conta pode estar associada a várias movimentações.
Movimentações e Categorias: Cada movimentação pertence a uma categoria (receita ou despesa).
Centros de Custo e Movimentações: Um centro de custo pode ter várias movimentações, mas cada movimentação está associada a apenas um centro de custo.
Elaboração do Diagrama MER
Utilize a ferramenta BRModelo para representar graficamente o MER.
Inclua atributos como nome da conta, valor da movimentação, data da transação e descrição da categoria.
Resumo
Identificação de cinco entidades principais: contas, categorias, movimentações, centros de custo e formas de pagamento.
Relacionamentos estruturados para suportar análise detalhada do fluxo de caixa.
Representação gráfica via BRModelo.




## Modelagem Conceitual / Entidade-Relacionamento (MER)

## Imagem 
![](https://github.com/CarlPinho/A3-Fluxo-de-Caixa/blob/main/A3-Fluxo-de-Caixa/MER%20e%20DER/Modelo_Conceitual.png?raw=true)

Relacionamentos no MER
Contas → Movimentações Financeiras

Um para Muitos: Uma conta pode ter várias movimentações financeiras.
Movimentações Financeiras → Categorias

Muitos para Um: Cada movimentação pertence a uma única categoria, mas uma categoria pode estar associada a várias movimentações.
Movimentações Financeiras → Centros de Custo

Muitos para Um: Cada movimentação está associada a um único centro de custo, mas um centro pode estar ligado a várias movimentações.
Movimentações Financeiras → Formas de Pagamento

Muitos para Um: Cada movimentação utiliza uma única forma de pagamento, mas uma forma de pagamento pode estar relacionada a várias movimentações.


2. Modelagem Lógica / Diagrama de Relacionamento (DER)
Representação do DER
Na modelagem lógica, o MER será transformado em um DER, ajustando para compatibilidade com o MS SQL Server:

Normalização: As tabelas serão normalizadas até a 3ª Forma Normal para evitar redundâncias e inconsistências.
Chaves Primárias e Estrangeiras:
Cada tabela terá uma chave primária identificadora.
Relacionamentos serão definidos com chaves estrangeiras (por exemplo, categoria_id em movimentações financeiras para referenciar categorias).
Atributos:
Tabela Contas: ID, nome da conta, saldo inicial.
Tabela Movimentações: ID, valor, data, conta associada, forma de pagamento.
Tabela Categorias: ID, nome, tipo (receita ou despesa).


## Imagem 
![](https://github.com/CarlPinho/A3-Fluxo-de-Caixa/blob/main/A3-Fluxo-de-Caixa/MER%20e%20DER/Modelo_L%C3%B3gico.png?raw=true)


 Modelo Lógico (DER)
No modelo lógico, as entidades são ajustadas para estruturas compatíveis com o SGBD (MS SQL Server), e são definidos relacionamentos por meio de chaves estrangeiras.

Tabelas e Colunas
Contas

id_conta (Primary Key)
nome_conta (VARCHAR)
tipo_conta (ENUM: 'caixa', 'banco', 'aplicação')
saldo_inicial (DECIMAL)
data_criacao (DATE)
Movimentações

id_movimentacao (Primary Key)
valor (DECIMAL)
data_movimentacao (DATE)
tipo (ENUM: 'entrada', 'saída')
descricao (TEXT)
id_conta (Foreign Key → Contas)
id_categoria (Foreign Key → Categorias)
id_centro_custo (Foreign Key → Centros de Custo)
id_forma_pagamento (Foreign Key → Formas de Pagamento)
Categorias

id_categoria (Primary Key)
nome_categoria (VARCHAR)
tipo (ENUM: 'receita', 'despesa')
Centros de Custo

id_centro_custo (Primary Key)
nome_centro_custo (VARCHAR)
departamento (VARCHAR, opcional)
Formas de Pagamento

id_forma_pagamento (Primary Key)
tipo_pagamento (ENUM: 'dinheiro', 'cartão', 'transferência', etc.)
detalhes (VARCHAR, opcional)
Relacionamentos no DER
Tabela Contas ↔ Tabela Movimentações

Relacionamento: Um para Muitos
Chave Estrangeira: id_conta em Movimentações
Tabela Categorias ↔ Tabela Movimentações

Relacionamento: Um para Muitos
Chave Estrangeira: id_categoria em Movimentações
Tabela Centros de Custo ↔ Tabela Movimentações

Relacionamento: Um para Muitos
Chave Estrangeira: id_centro_custo em Movimentações
Tabela Formas de Pagamento ↔ Tabela Movimentações

Relacionamento: Um para Muitos
Chave Estrangeira: id_forma_pagamento em Movimentações


# Dicionário de Dados:

Este dicionário de dados descreve as tabelas e seus respectivos atributos, conforme o modelo conceitual do sistema de controle financeiro. As tabelas são projetadas para garantir integridade referencial e normalização até a terceira forma normal (3FN).

## Estrutura do Banco de Dados:

##  Tabela: Contas


| Atributo            | Tipo de Dados                                        |
| ------------------- |:---------------------------------------------------:|
| id_conta            | INT (Chave Primária)                                 |
| nome_conta          | VARCHAR(100)                                         |
| tipo_conta          | VARCHAR('caixa', 'banco', 'aplicação')               |
| saldo_inicial       | DECIMAL(10, 2)                                       |
| data_criacao        | DATE                                                 |

## 2. Tabela: Movimentações

| Atributo            | Tipo de Dados                                        |
| ------------------- |:---------------------------------------------------:|
| id_movimentacao     | INT (Chave Primária)                                 |
| valor               | DECIMAL(10, 2)                                       |
| data_movimentacao   | DATE                                                 |
| tipo                | VARCHAR('entrada', 'saída')                             |
| descricao           | TEXT                                                 |
| id_conta            | INT (Chave Estrangeira)                              |
| id_categoria        | INT (Chave Estrangeira)                              |
| id_centro_custo     | INT (Chave Estrangeira)                              |
| id_forma_pagamento  | INT (Chave Estrangeira)                              |

## 3. Tabela: Categorias

| Atributo            | Tipo de Dados                                        |
| ------------------- |:---------------------------------------------------:|
| id_categoria        | INT (Chave Primária)                                 |
| nome_categoria      | VARCHAR(100)                                         |
| tipo                | VARCHAR('receita', 'despesa')                        |

## 4. Tabela: Centros de Custo

| Atributo            | Tipo de Dados                                        |
| ------------------- |:---------------------------------------------------:|
| id_centro_custo     | INT (Chave Primária)                                 |
| nome_centro_custo   | VARCHAR(100)                                         |
| departamento        | VARCHAR(100)                                         |

## 5. Tabela: Formas de Pagamento

| Atributo            | Tipo de Dados                                        |
| ------------------- |:---------------------------------------------------:|
| id_forma_pagamento  | INT (Chave Primária)                                 |
| tipo_pagamento      | VARCHAR('dinheiro', 'cartão', 'transferência', 'outro') |
| detalhes            | VARCHAR(255)                                         |


## Stored Procedures
### CalcularSaldoFluxoCaixa:
* Objetivo: Calcula o saldo atual do fluxo de caixa somando as entradas e subtraindo as saídas.
* Lógica: A procedure percorre as movimentações da tabela tb_movimentacoes e calcula o saldo com base no tipo de movimentação (entrada ou saída).
* Resultado: Exibe o saldo total do fluxo de caixa.







```
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

```

### GerarRelatorioReceitasDespesas:
* Objetivo: Gera um relatório de receitas e despesas por categoria.
 *Lógica: A procedure soma os valores de entradas e saídas agrupados por categoria (nome_categoria) da tabela Categorias.
* Resultado: Exibe o total de receitas e despesas por categoria.


```
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
```

### ProjetarFluxoCaixaFuturo:
* Objetivo: Faz uma projeção do fluxo de caixa futuro com base nas médias de receitas e despesas dos últimos meses.
* Lógica: Calcula a média de receitas e despesas nos últimos meses (o número de meses pode ser definido pelo parâmetro @meses).
* Resultado: Exibe as projeções médias de receitas e despesas mensais.


```
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

```

### ValidarInsercaoMovimentacao:
* Objetivo: Valida os dados de entrada para as movimentações financeiras.
* Lógica: Verifica se o tipo de movimentação é válido, se o valor é maior que zero e se a data não é futura.
* Resultado: Exibe mensagens de erro ou sucesso.

# Funções:

### CalcularJurosCompostos:
* Objetivo: Calcula o valor futuro de um investimento usando juros compostos.



```
CREATE FUNCTION CalcularJurosCompostos
    (@principal DECIMAL(18, 2), @taxa DECIMAL(10, 4), @periodos INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    RETURN @principal * POWER(1 + @taxa, @periodos);
END;

```

###  CalcularVPL:
* Objetivo: Calcula o valor presente líquido (VPL) de um conjunto de fluxos de caixa.
* Lógica: Desconta os fluxos de caixa usando uma taxa de desconto e calcula o somatório do VPL.


```
CREATE FUNCTION CalcularVPL
    (@taxa DECIMAL(10, 4), @fluxos TipoFluxos READONLY)  
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @vpl DECIMAL(18, 2) = 0;

    SELECT @vpl = @vpl + valor / POWER(1 + @taxa, periodo)
    FROM @fluxos;
    
    RETURN @vpl;
END;

```

### CalcularTIR:
*  Objetivo: Calcula a taxa interna de retorno (TIR) de um conjunto de fluxos de caixa.
*  Lógica: A função utiliza um método iterativo para encontrar a TIR, ajustando a taxa até que o VPL se aproxime de zero.


```
CREATE FUNCTION CalcularTIR
    (@fluxos TipoFluxos READONLY, @iteracoes INT, @precisao DECIMAL(10, 6))
RETURNS DECIMAL(10, 6)
AS
BEGIN
    DECLARE @tir DECIMAL(10, 6) = 0.1; -- Valor inicial da TIR
    DECLARE @vpl DECIMAL(18, 2);
    DECLARE @ajuste DECIMAL(10, 6);

    WHILE @iteracoes > 0
    BEGIN
        SELECT @vpl = SUM(valor / POWER(1 + @tir, periodo))
        FROM @fluxos;

        IF ABS(@vpl) <= @precisao
            RETURN @tir;

        SELECT @ajuste = -(@vpl / SUM(-periodo * valor / POWER(1 + @tir, periodo + 1)))
        FROM @fluxos;

        SET @tir = @tir + @ajuste;
        SET @iteracoes = @iteracoes - 1;
    END

    RETURN NULL;
END;

```


### Triggers
#### trg_validar_insercao:
* Objetivo: Valida a inserção de dados na tabela tb_movimentacoes antes de serem realmente inseridos.
* Lógica: Verifica se os dados inseridos são válidos (tipo e valor) e, caso contrário, cancela a transação.

```
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

```

#### trg_atualizar_saldo:
* Objetivo: Atualiza o saldo do fluxo de caixa na tabela ResumoFluxoCaixa após a inserção ou exclusão de movimentações.
* Lógica: Calcula o saldo total de todas as movimentações e atualiza o saldo na tabela ResumoFluxoCaixa.


```
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

```

5. Execução de Funções
5.1 Cálculo de Juros Compostos
Para calcular os juros compostos, utilize a função CalcularJurosCompostos:

```

SELECT dbo.CalcularJurosCompostos(1000, 0.05, 12) AS ValorComJuros;
Este comando calculará o valor final após 12 meses com uma taxa de 5% ao mês sobre um principal de 1000.
```
5.2 Cálculo do Valor Presente Líquido (VPL)
Para calcular o VPL com base em um conjunto de fluxos de caixa, use a função CalcularVPL:

```
DECLARE @fluxos TABLE (periodo INT, valor DECIMAL(18,2));
INSERT INTO @fluxos VALUES (1, -1000), (2, 500), (3, 500), (4, 500);


SELECT dbo.CalcularVPL(0.1, @fluxos) AS VPL;
```

Isso calcula o VPL com uma taxa de 10% para os fluxos de caixa inseridos.

5.3 Cálculo da Taxa Interna de Retorno (TIR)
Para calcular a TIR, utilize a função CalcularTIR:

```
DECLARE @fluxos TABLE (periodo INT, valor DECIMAL(18,2));
INSERT INTO @fluxos VALUES (0, -1000), (1, 400), (2, 400), (3, 400);

SELECT dbo.CalcularTIR(@fluxos) AS TIR;
Isso calculará a TIR para os fluxos de caixa inseridos.

```
