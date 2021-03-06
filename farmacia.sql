use farmacia;

CREATE TABLE Categoria(
codcategoria INT PRIMARY KEY,
categoria VARCHAR(70));

CREATE TABLE Cidade(
codcidade INT PRIMARY KEY,
cidade VARCHAR(45),
uf VARCHAR(45));

Create TABLE Entrada(
codentrada INT PRIMARY KEY,
dataped DATE,
dataentr DATE,
total VARCHAR(45),
frete Double,
numnf INT,
imposto VARCHAR(45),
Transportadora_codtransportadora INT,
FOREIGN KEY fk_etct(Transportadora_codtransportadora) REFERENCES Transportadora(codtransportadora));

Create Table Transportadora(
codtransportadora INT PRIMARY KEY,
transportadora VARCHAR(45),
endereco VARCHAR(45),
num INT,
bairo VARCHAR(45),
cep INT,
cnpj INT,
insc INT,
contato BIGINT(10),
tel BIGINT(10),
Cidade_codCidade INT,
FOREIGN KEY fk_tccc(Cidade_codCidade) REFERENCES Cidade(codcidade));

CREATE TABLE Loja(
codloja INT PRIMARY KEY,
nome VARCHAR(45),
endereco VARCHAR(45),
num INT,
bairro VARCHAR(45),
tel BIGINT(10),
insc VARCHAR(45),
cnpj VARCHAR(45),
Cidade_codcidade INT,
FOREIGN KEY fk_lccc(Cidade_codcidade) REFERENCES Cidade(codcidade));

CREATE TABLE Saida(
codsaida INT PRIMARY KEY,
total VARCHAR(45),
frete DOUBLE,
imposto VARCHAR(45),
Loja_codloja INT,
Transportadora_codtransportadora INT,
FOREIGN KEY fk_slcl(Loja_codLoja) REFERENCES Loja(codloja),
FOREIGN KEY fk_stct(Transportadora_codtransportadora) REFERENCES Transportadora(codtransportadora));

CREATE TABLE Fornecedor(
codfornecedor INT PRIMARY KEY,
fornecedor VARCHAR(45),
endereco VARCHAR(45),
num INT,
bairo VARCHAR(45),
cep VARCHAR(45),
contato VARCHAR(45),
cnpj INT,
insc VARCHAR(45),
tel DATE,
Cidade_codcidade INT,
FOREIGN KEY fk_fccc(Cidade_codcidade) REFERENCES Cidade(codcidade));

CREATE TABLE Produto(
codproduto INT PRIMARY KEY,
descricao VARCHAR(45),
peso DOUBLE,
controlado VARCHAR(45),
qtdemin DOUBLE,
Fornecedor_codfornecedor INT,
Categoria_codcategoria INT,
FOREIGN KEY fk_pfcf(Fornecedor_codfornecedor) REFERENCES Fornecedor(codfornecedor),
FOREIGN KEY fk_pccc(Categoria_codcategoria) REFERENCES Categoria(codcategoria));

CREATE TABLE ItemEntrada(
coditementrada INT PRIMARY KEY,
lote VARCHAR(45),
qtde INT,
valor FLOAT,
Produto_codproduto INT,
Entrada_codentrada INT,
FOREIGN KEY fk_ipcp(Produto_codproduto) REFERENCES Produto(codproduto),
FOREIGN KEY fk_iece(Entrada_codentrada) REFERENCES Entrada(codentrada));

CREATE TABLE ItemSaida(
coditemsaida INT PRIMARY KEY,
lote VARCHAR(45),
qtde INT,
valor DOUBLE,
Produto_codproduto INT,
Saida_codsaida INT,
FOREIGN KEY fk_ipcp(Produto_codproduto) REFERENCES Produto(codproduto),
FOREIGN KEY fk_iscs(Saida_codsaida) REFERENCES Saida(codsaida));


INSERT INTO ItemSaida(coditemsaida, lote, qtde, valor, Produto_codproduto, Saida_codsaida) VALUES ('3', 'mar??o', '300', '10.50', '3', '3');
INSERT INTO Entrada(codentrada, dataped, dataentr, total, frete, numnf, imposto, Transportadora_codtransportadora) VALUES ('3', '2012-04-12', '2012-04-02', '62.50', '10.50', '3', '10.50', '1');

SELECT * FROM Produto WHERE Categoria_codcategoria = 1;
SELECT * FROM ItemEntrada ORDER BY valor DESC LIMIT 3;
SELECT coditementrada, coditemsaida FROM ItemEntrada INNER JOIN ItemSaida ON coditementrada = coditemsaida;

SELECT COUNT(coditementrada), Produto_codproduto FROM ItemEntrada GROUP BY Produto_codproduto;
SELECT coditementrada, valor,
CASE
	WHEN valor > 20 THEN "valor maior que 20 reais"
    WHEN valor = 20 THEN "valor igual a 20 reais"
    ELSE "o valor eh menor que 20 reais"
END
FROM ItemEntrada;
SELECT DISTINCT Produto_codproduto FROM ItemSaida;

SELECT MIN(valor) FROM ItemSaida;
SELECT MAX(valor) FROM ItemSaida;

SELECT * FROM Loja WHERE Cidade_codcidade=1 AND bairro = 'centro';

CREATE TRIGGER CategoriaTrig
BEFORE INSERT ON Categoria FOR EACH ROW
BEGIN
SET @categoria = NEW.categoria;




