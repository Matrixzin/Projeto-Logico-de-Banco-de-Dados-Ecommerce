CREATE DATABASE Ecommerce;
USE Ecommerce;

-- CLIENTE
CREATE TABLE Cliente(
		idCliente INT auto_increment PRIMARY KEY,
        Nome VARCHAR(45),
        Endereço VARCHAR(45),
		CPF CHAR(11) NOT NULL,
        CNPJ VARCHAR(18),
        constraint unique_cpf_cliente unique (CPF),
        constraint unique_cnpj_cliente unique (cnpj)
        );
        
desc Cliente;

-- PRODUTO
CREATE TABLE Produto(
		idProduto INT auto_increment PRIMARY KEY,
        Categoria varchar(45),
        Descrição VARCHAR(45),
        Valor float
        );

desc Produto;

-- PAGAMENTO
CREATE TABLE Pagamento(
		idPagamento INT auto_increment PRIMARY KEY,
        PagamentoCliente INT,
        Cartão varchar(45),
        Bandeira varchar(45),
        Número varchar(45),
        constraint fk_pagamento_cliente foreign key (PagamentoCliente) references Cliente(idCliente)
        );
        
desc Pagamento;

-- ENTREGA
CREATE TABLE Entrega(
		idEntrega INT auto_increment PRIMARY KEY,
        StatusEntrega bool,
        CodigoRastreio VARCHAR(45),
        DataEntrega date
        );
        
desc Entrega;

-- PEDIDO
CREATE TABLE Pedido(
		idPedido INT auto_increment PRIMARY KEY,
        StatusPedido bool DEFAULT FALSE,
        Frete FLOAT,
        Descrição VARCHAR (45),
        constraint fk_entrega foreign key (idPedido) references Entrega(idEntrega)
        );
        
desc Pedido;

-- ESTOQUE
CREATE TABLE Estoque(
		idEstoque INT auto_increment PRIMARY KEY,
        Local varchar (45)
        );
        
DESC Estoque;

-- PRODUTOS EM ESTOQUE
CREATE TABLE EstoqueProduto(
		idProduto INT PRIMARY KEY,
        idEstoqueProduto int,
        Quantidade FLOAT,
        constraint fk_estoque foreign key (idProduto) references Produto(idProduto),
        constraint fk_produto_estoque foreign key (idEstoqueProduto) references Estoque(idEstoque)
        );
        
desc EstoqueProduto;

-- FORNECEDOR PRINCIPAL
CREATE TABLE Fornecedor(
		idFornecedor INT auto_increment PRIMARY KEY,
        RazãoSocial VARCHAR(45),
        CPF CHAR (11) NOT NULL,
        CNPJ VARCHAR (18),
        constraint unique_cpf_cliente unique (CPF),
        constraint unique_cnpj_cliente unique (CNPJ)
        );
        
desc Fornecedor;

-- FORNECEDOR TERCEIRO
CREATE TABLE Terceiro(
		idTerceiro INT auto_increment PRIMARY KEY,
        RazãoSocial varchar(45),
        Localização VARCHAR(45),
        CPF CHAR(11) NOT NULL,
        CNPJ VARCHAR(18),
        constraint unique_cpf_cliente UNIQUE (CPF),
        constraint unique_cnpj_cliente UNIQUE (CNPJ)
        );
        
desc Terceiro;

-- PEDIDO DE PRODUTO
CREATE TABLE PedidoProduto(
		idPedido INT,
        idProduto INT,
        Quantidade FLOAT DEFAULT 1,
        constraint fk_pedido foreign key (idPedido) references Terceiro(idTerceiro),
        constraint fk_produto foreign key (idProduto) references Produto(idProduto)
        );
        
desc PedidoProduto;

-- PEDIDO DE PRODUTO PARA FORNECEDOR PRINCIPAL
CREATE TABLE PedidoFornecedor(
		idCompraFornecedor INT,
        idFornecedorPedido INT,
        Quantidade FLOAT DEFAULT 1,
        constraint fk_pedido_fornecedor foreign key (idCompraFornecedor) references Fornecedor(idFornecedor),
        constraint fk_fornecedor_pedido foreign key (idFornecedorPedido) references Pedido(idPedido)
        );
        
desc PedidoFornecedor;

-- PRODUTOS EM ESTOQUE FORNECEDOR PRINCIPAL (VERIFICA SE O FORNECEDOR TEM O PRODUTO QUE O CLIENTE DESEJA)
CREATE TABLE EstoqueFornecedor(
		idEstoqueFornecedor INT,
        idProdutoFornecedor INT,
        constraint fk_estoque_fornecedor foreign key (idEstoqueFornecedor) references Fornecedor(idFornecedor),
        constraint fk_produtos_fornecedor foreign key (idProdutoFornecedor) references Produto(idProduto)
        );
        
desc EstoqueFornecedor;

-- PRODUTOS EM ESTOQUE FORNECEDOR TERCEIRO (VERIFICA SE O FORNECEDOR TEM O PRODUTO QUE O CLIENTE DESEJA)
CREATE TABLE EstoqueTerceiro(
		idProdutosEstoque INT,
        idProFornecedor INT,
        constraint fk_produtos_estoque foreign key (idProdutosEstoque) references Produto(idProduto),
        constraint fk_pro_fornecedor foreign key (idProFornecedor) references Terceiro(idTerceiro)
        );
        
desc EstoqueTerceiro;