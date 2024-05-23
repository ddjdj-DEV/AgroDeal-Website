-- Criação da base de dados
CREATE DATABASE IF NOT EXISTS agrodeal;

-- Utilização da base de dados
USE agrodeal;

-- Tabela de Produtos
CREATE TABLE IF NOT EXISTS Produtos (
    ID_Produto INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Produto VARCHAR(255),
    Descricao TEXT,
    Preco DECIMAL(10, 2),
    Categoria VARCHAR(100),
    Quantidade_Estoque INT,
    Imagem_Produto VARCHAR(255),
    Data_Criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela de Categorias
CREATE TABLE IF NOT EXISTS Categorias (
    ID_Categoria INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Categoria VARCHAR(100),
    Descricao_Categoria TEXT,
    Data_Criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela de Relacionamento entre Categorias e Produtos
CREATE TABLE IF NOT EXISTS categoria_produto (
    ID_Categoria INT,
    ID_Produto INT,
    PRIMARY KEY (ID_Categoria, ID_Produto),
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID_Categoria),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID_Produto)
);

-- Tabela de Parcerias
CREATE TABLE IF NOT EXISTS Parcerias (
    ID_Parceria INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Empresa VARCHAR(255),
    Contato_Empresa VARCHAR(255),
    Email_Empresa VARCHAR(255),
    Telefone_Empresa VARCHAR(20),
    Endereco_Empresa VARCHAR(255),
    Data_Criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela de Dados Bancários
CREATE TABLE IF NOT EXISTS Dados_Bancarios (
    ID_Dado_Bancario INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Banco VARCHAR(255),
    Numero_Conta VARCHAR(50),
    Agencia VARCHAR(50),
    Tipo_Conta VARCHAR(50),
    Titular VARCHAR(255),
    CPF_CNPJ VARCHAR(20),
    Data_Criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela de Tipos de Usuário
CREATE TABLE IF NOT EXISTS Tipo_Usuario (
    ID_Tipo_Usuario INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Tipo VARCHAR(50),
    Data_Criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela de Usuários
CREATE TABLE IF NOT EXISTS Usuarios (
    ID_Usuario INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Usuario VARCHAR(100),
    Email_Usuario VARCHAR(255),
    Senha_Usuario VARCHAR(255),
    ID_Tipo_Usuario INT,
    Data_Criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Tipo_Usuario) REFERENCES Tipo_Usuario(ID_Tipo_Usuario)
);

-- Tabela de Log de Atividades de Usuários
CREATE TABLE IF NOT EXISTS Log_Atividades_Usuario (
    ID_Atividade INT AUTO_INCREMENT PRIMARY KEY,
    Tipo_Atividade VARCHAR(100),
    Descricao TEXT,
    Data_Hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    COD_Usuario INT,
    FOREIGN KEY (COD_Usuario) REFERENCES Usuarios(ID_Usuario)
);

-- Tabela de Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100),
    Sobrenome VARCHAR(100),
    Email VARCHAR(255),
    Telefone VARCHAR(20),
    Data_Criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela de Endereços
CREATE TABLE IF NOT EXISTS Enderecos (
    ID_Endereco INT AUTO_INCREMENT PRIMARY KEY,
    COD_Cliente INT,
    Endereco VARCHAR(255),
    Cidade VARCHAR(100),
    Estado VARCHAR(100),
    CEP VARCHAR(20),
    Pais VARCHAR(100),
    Data_Criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (COD_Cliente) REFERENCES Clientes(ID_Cliente)
);

-- Tabela de Pedidos
CREATE TABLE IF NOT EXISTS Pedidos (
    ID_Pedido INT AUTO_INCREMENT PRIMARY KEY,
    COD_Cliente INT,
    Data_Pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status_Pedido ENUM('Pendente', 'Em Processamento', 'Enviado', 'Entregue', 'Cancelado') DEFAULT 'Pendente',
    Data_Criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (COD_Cliente) REFERENCES Clientes(ID_Cliente)
);

-- Tabela de Itens do Pedido
CREATE TABLE IF NOT EXISTS Itens_Pedido (
    ID_Item INT AUTO_INCREMENT PRIMARY KEY,
    COD_Pedido INT,
    COD_Produto INT,
    Quantidade INT,
    Preco_Unitario DECIMAL(10, 2),
    Data_Criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (COD_Pedido) REFERENCES Pedidos(ID_Pedido),
    FOREIGN KEY (COD_Produto) REFERENCES Produtos(ID_Produto)
);

-- Tabela de Favoritos
CREATE TABLE IF NOT EXISTS Favoritos (
    ID_Favorito INT AUTO_INCREMENT PRIMARY KEY,
    COD_Cliente INT,
    COD_Produto INT,
    Data_Adicao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data_Criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (COD_Cliente) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (COD_Produto) REFERENCES Produtos(ID_Produto)
);

-- Tabela de Avaliações
CREATE TABLE IF NOT EXISTS Avaliacoes (
    ID_Avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    COD_Produto INT,
    COD_Cliente INT,
    Avaliacao INT,
    Comentario TEXT,
    Data_Avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data_Criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (COD_Produto) REFERENCES Produtos(ID_Produto),
    FOREIGN KEY (COD_Cliente) REFERENCES Clientes(ID_Cliente)
);

-- Tabela de Cupons de Desconto
CREATE TABLE IF NOT EXISTS Cupons_Desconto (
    ID_Cupom INT AUTO_INCREMENT PRIMARY KEY,
    Codigo_Cupom VARCHAR(20),
    Valor_Desconto DECIMAL(10, 2),
    Data_Validade DATE,
    Restricoes TEXT,
    Data_Criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela de Pagamento de Pedidos
CREATE TABLE IF NOT EXISTS Pgto_Pedido (
    ID_Pgto INT AUTO_INCREMENT PRIMARY KEY,
    COD_Pedido INT,
    Metodo_Pagamento VARCHAR(100),
    Status_Pagamento ENUM('Pendente', 'Pago', 'Cancelado') DEFAULT 'Pendente',
    Data_Pagamento TIMESTAMP,
    Valor_Pago DECIMAL(10, 2),
    Data_Criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (COD_Pedido) REFERENCES Pedidos(ID_Pedido)
);

-- Tabela de Log de Atividades de Clientes
CREATE TABLE IF NOT EXISTS Log_Atividades (
    ID_Atividade INT AUTO_INCREMENT PRIMARY KEY,
    Tipo_Atividade VARCHAR(100),
    Descricao TEXT,
    Data_Hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    COD_Cliente INT,
    FOREIGN KEY (COD_Cliente) REFERENCES Clientes(ID_Cliente)
);



-- Inserções fictícias
INSERT INTO Categorias (Nome_Categoria, Descricao_Categoria) VALUES 
('Fertilizantes', 'Produtos para fertilização do solo'),
('Pesticidas', 'Produtos para controle de pragas'),
('Ferramentas', 'Ferramentas agrícolas variadas');

INSERT INTO Produtos (Nome_Produto, Descricao, Preco, Categoria, Quantidade_Estoque, Imagem_Produto) VALUES 
('Adubo Orgânico', 'Adubo orgânico de alta qualidade', 50.00, 'Fertilizantes', 100, 'adubo_organico.jpg'),
('Pesticida Natural', 'Pesticida natural e seguro', 30.00, 'Pesticidas', 200, 'pesticida_natural.jpg'),
('Enxada', 'Enxada de aço resistente', 25.00, 'Ferramentas', 150, 'enxada.jpg');

INSERT INTO categoria_produto (ID_Categoria, ID_Produto) VALUES 
(1, 1),
(2, 2),
(3, 3);

INSERT INTO Parcerias (Nome_Empresa, Contato_Empresa, Email_Empresa, Telefone_Empresa, Endereco_Empresa) VALUES 
('AgroCorp', 'John Doe', 'contact@agrocorp.com', '123456789', 'Rua das Flores, 123'),
('FarmTech', 'Jane Smith', 'info@farmtech.com', '987654321', 'Avenida das Palmeiras, 456');

INSERT INTO Dados_Bancarios (Nome_Banco, Numero_Conta, Agencia, Tipo_Conta, Titular, CPF_CNPJ) VALUES 
('Banco do Brasil', '123456-7', '0001', 'Corrente', 'AgroDeal Ltda', '12345678000199'),
('Caixa Econômica', '234567-8', '0002', 'Poupança', 'AgroDeal Ltda', '12345678000199');

INSERT INTO Tipo_Usuario (Nome_Tipo) VALUES 
('Administrador'),
('Cliente');

INSERT INTO Usuarios (Nome_Usuario, Email_Usuario, Senha_Usuario, ID_Tipo_Usuario) VALUES 
('admin', 'admin@agrodeal.com', 'senha_admin', 1),
('cliente1', 'cliente1@agrodeal.com', 'senha_cliente1', 2);

INSERT INTO Log_Atividades_Usuario (Tipo_Atividade, Descricao, COD_Usuario) VALUES 
('Login', 'Usuário logado com sucesso', 1),
('Compra', 'Usuário realizou uma compra', 2);

INSERT INTO Clientes (Nome, Sobrenome, Email, Telefone) VALUES 
('Carlos', 'Silva', 'carlos.silva@gmail.com', '999999999'),
('Maria', 'Oliveira', 'maria.oliveira@gmail.com', '888888888');

INSERT INTO Enderecos (COD_Cliente, Endereco, Cidade, Estado, CEP, Pais) VALUES 
(1, 'Rua A, 123', 'São Paulo', 'SP', '01001-000', 'Brasil'),
(2, 'Avenida B, 456', 'Rio de Janeiro', 'RJ', '20001-000', 'Brasil');

INSERT INTO Pedidos (COD_Cliente, Status_Pedido) VALUES 
(1, 'Pendente'),
(2, 'Em Processamento');

INSERT INTO Itens_Pedido (COD_Pedido, COD_Produto, Quantidade, Preco_Unitario) VALUES 
(1, 1, 2, 50.00),
(2, 2, 3, 30.00);

INSERT INTO Favoritos (COD_Cliente, COD_Produto) VALUES 
(1, 1),
(2, 3);

INSERT INTO Avaliacoes (COD_Produto, COD_Cliente, Avaliacao, Comentario) VALUES 
(1, 1, 5, 'Ótimo produto!'),
(2, 2, 4, 'Muito bom, mas poderia ser mais barato.');

INSERT INTO Cupons_Desconto (Codigo_Cupom, Valor_Desconto, Data_Validade, Restricoes) VALUES 
('DESCONTO10', 10.00, '2024-12-31', 'Válido para compras acima de R$ 100,00'),
('FRETEGRATIS', 0.00, '2024-12-31', 'Frete grátis para compras acima de R$ 200,00');

INSERT INTO Pgto_Pedido (COD_Pedido, Metodo_Pagamento, Status_Pagamento, Data_Pagamento, Valor_Pago) VALUES 
(1, 'Cartão de Crédito', 'Pago', CURRENT_TIMESTAMP, 100.00),
(2, 'Boleto Bancário', 'Pendente', NULL, 90.00);

INSERT INTO Log_Atividades (Tipo_Atividade, Descricao, COD_Cliente) VALUES 
('Login', 'Cliente logado com sucesso', 1),
('Compra', 'Cliente realizou uma compra', 2);