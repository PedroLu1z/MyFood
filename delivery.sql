DROP DATABASE IF EXISTS MyFood_Marketplace_DB;
CREATE DATABASE MyFood_Marketplace_DB;
USE MyFood_Marketplace_DB;

CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE Endereco (
    cep VARCHAR(10) PRIMARY KEY,
    rua VARCHAR(120) NOT NULL,
    bairro VARCHAR(80) NOT NULL,
    cidade VARCHAR(80) NOT NULL,
    estado CHAR(2) NOT NULL
);

CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    fk_cep VARCHAR(10) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(100),
    FOREIGN KEY (fk_cep) REFERENCES Endereco(cep)
);

CREATE TABLE Restaurante (
    id_restaurante INT AUTO_INCREMENT PRIMARY KEY,
    nome_restaurante VARCHAR(100) NOT NULL,
    taxa_comissao_percentual DECIMAL(5,2) NOT NULL CHECK (taxa_comissao_percentual >= 0),
    fk_categoria_id INT NOT NULL,
    fk_cep VARCHAR(10) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(100),
    FOREIGN KEY (fk_categoria_id) REFERENCES Categoria(id_categoria),
    FOREIGN KEY (fk_cep) REFERENCES Endereco(cep)
);

-- NOVA TABELA: Centraliza o cardápio de cada restaurante
CREATE TABLE Produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    fk_restaurante_id INT NOT NULL,
    nome_produto VARCHAR(100) NOT NULL,
    preco_atual DECIMAL(10,2) NOT NULL CHECK (preco_atual >= 0),
    FOREIGN KEY (fk_restaurante_id) REFERENCES Restaurante(id_restaurante)
);

CREATE TABLE Pedidos (
    id_pedidos INT AUTO_INCREMENT PRIMARY KEY,
    fk_restaurante_id INT NOT NULL,
    fk_cliente_id INT NOT NULL,
    tempo_entrega INT NOT NULL CHECK (tempo_entrega > 0),
    status_pedido VARCHAR(30) NOT NULL,
    taxa_entrega DECIMAL(10,2) NOT NULL CHECK (taxa_entrega >= 0),
    FOREIGN KEY (fk_restaurante_id) REFERENCES Restaurante(id_restaurante),
    FOREIGN KEY (fk_cliente_id) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Itens_pedido (
    id_itens_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fk_pedidos_id INT NOT NULL,
    fk_produto_id INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    preco_unitario DECIMAL(10,2) NOT NULL CHECK (preco_unitario >= 0),
    FOREIGN KEY (fk_pedidos_id) REFERENCES Pedidos(id_pedidos),
    FOREIGN KEY (fk_produto_id) REFERENCES Produto(id_produto)
);


-- INSERTS: CATEGORIA, ENDERECO, CLIENTE E RESTAURANTE MANTIDOS
INSERT INTO Categoria (nome_categoria) VALUES
('Pizzaria'), ('Japonesa'), ('Hamburgueria'), ('Italiana'), ('Brasileira'), 
('Mexicana'), ('Vegana'), ('Frango'), ('Sobremesas'), ('Padaria');

INSERT INTO Endereco (cep, rua, bairro, cidade, estado) VALUES
('01305-000', 'Rua Augusta', 'Consolação', 'São Paulo', 'SP'),
('01310-200', 'Avenida Paulista', 'Bela Vista', 'São Paulo', 'SP'),
('01426-001', 'Rua Oscar Freire', 'Jardins', 'São Paulo', 'SP'),
('04101-000', 'Rua Vergueiro', 'Vila Mariana', 'São Paulo', 'SP'),
('01451-000', 'Avenida Brigadeiro Faria Lima', 'Itaim Bibi', 'São Paulo', 'SP'),
('01302-001', 'Rua da Consolação', 'Consolação', 'São Paulo', 'SP'),
('01414-000', 'Rua Haddock Lobo', 'Cerqueira César', 'São Paulo', 'SP'),
('05402-000', 'Avenida Rebouças', 'Pinheiros', 'São Paulo', 'SP'),
('05406-000', 'Rua Teodoro Sampaio', 'Pinheiros', 'São Paulo', 'SP'),
('04010-200', 'Rua Domingos de Morais', 'Vila Mariana', 'São Paulo', 'SP'),
('04506-001', 'Avenida Santo Amaro', 'Brooklin', 'São Paulo', 'SP'),
('01405-001', 'Rua Pamplona', 'Jardim Paulista', 'São Paulo', 'SP'),
('05408-000', 'Rua Cardeal Arcoverde', 'Pinheiros', 'São Paulo', 'SP'),
('04028-002', 'Avenida Ibirapuera', 'Moema', 'São Paulo', 'SP'),
('01307-001', 'Rua Frei Caneca', 'Consolação', 'São Paulo', 'SP'),
('05422-002', 'Rua dos Pinheiros', 'Pinheiros', 'São Paulo', 'SP'),
('01228-200', 'Avenida Angélica', 'Higienópolis', 'São Paulo', 'SP'),
('01415-001', 'Rua Bela Cintra', 'Consolação', 'São Paulo', 'SP'),
('04535-000', 'Rua João Cachoeira', 'Itaim Bibi', 'São Paulo', 'SP'),
('04045-003', 'Avenida Jabaquara', 'Saúde', 'São Paulo', 'SP');

INSERT INTO Cliente (nome_cliente, telefone, fk_cep, numero, complemento) VALUES
('Ana Souza', '11988412301', '01305-000', '120', 'Apto 101'),
('Bruno Lima', '11976521402', '01310-200', '1500', 'Conjunto 12'),
('Carla Mendes', '11965833303', '01426-001', '500', 'Casa 2'),
('Diego Alves', '11954744404', '04101-000', '900', 'Apto 22'),
('Eduarda Rocha', '11943655505', '01451-000', '2500', 'Sala 5'),
('Felipe Martins', '11932566606', '01302-001', '1800', 'Loja 1'),
('Gabriela Nunes', '11921477707', '01414-000', '300', 'Apto 14'),
('Henrique Dias', '11910388808', '05402-000', '1200', 'Casa 3'),
('Isabela Costa', '11989299909', '05406-000', '800', 'Fundos'),
('João Pereira', '11978101010', '04010-200', '1500', 'Apto 31');

INSERT INTO Restaurante (nome_restaurante, taxa_comissao_percentual, fk_categoria_id, fk_cep, numero, complemento) VALUES
('Pizza Prime', 12.75, 1, '04506-001', '900', 'Loja 2'),
('Sushi Zen', 15.35, 2, '01405-001', '700', 'Apto 81'),
('Burger House', 10.80, 3, '05408-000', '120', 'Casa 4'),
('Cantina Bella', 13.25, 4, '04028-002', '2200', 'Conjunto 9'),
('Tempero Paulista', 11.45, 5, '01307-001', '650', 'Apto 45'),
('Taco Loco', 14.60, 6, '05422-002', '1000', 'Loja 7'),
('Veggie Life', 9.95, 7, '01228-200', '2100', 'Sala 3'),
('Frango Express', 10.55, 8, '01415-001', '950', 'Apto 56'),
('Doce Mania', 8.35, 9, '04535-000', '350', 'Loja 4'),
('Padaria Central', 7.85, 10, '04045-003', '1700', 'Casa 8');

-- POPULANDO O CARDÁPIO (PRODUTOS)
INSERT INTO Produto (fk_restaurante_id, nome_produto, preco_atual) VALUES
(1, 'Pizza Calabresa Grande', 59.90), (1, 'Refrigerante 2L', 12.50), (1, 'Borda Recheada', 8.75),
(1, 'Pizza Quatro Queijos', 62.40), (1, 'Suco de Uva', 13.55), (1, 'Sobremesa da Casa', 15.45),
(2, 'Combo Sushi 30 Peças', 89.90), (2, 'Temaki Salmão', 24.75), (2, 'Guioza', 19.60),
(2, 'Yakissoba Especial', 52.35), (2, 'Hot Roll', 21.40), (2, 'Chá Gelado', 9.85),
(3, 'Burger Clássico', 34.90), (3, 'Batata Frita Média', 16.80), (3, 'Milkshake Chocolate', 19.20),
(3, 'Burger Bacon', 38.45), (3, 'Onion Rings', 18.75), (3, 'Refrigerante Lata', 6.95),
(4, 'Lasanha Bolonhesa', 44.80), (4, 'Ravioli de Queijo', 39.65), (4, 'Tiramisu', 18.90),
(5, 'Virado à Paulista', 38.70), (5, 'Suco de Laranja', 9.85), (5, 'Pudim', 11.30),
(6, 'Taco de Carne', 16.70), (6, 'Nachos com Queijo', 22.45), (6, 'Churros', 8.70),
(7, 'Salada Vegana Especial', 28.60), (7, 'Suco Verde', 12.75), (7, 'Brownie Vegano', 14.35);

INSERT INTO Pedidos (fk_restaurante_id, fk_cliente_id, tempo_entrega, status_pedido, taxa_entrega) VALUES
(1, 1, 35, 'Entregue', 7.45), (1, 2, 42, 'Entregue', 8.75),
(2, 3, 50, 'Entregue', 9.90), (2, 4, 47, 'Em preparo', 8.55),
(3, 5, 28, 'Entregue', 6.75), (3, 6, 31, 'Saiu para entrega', 7.25),
(4, 7, 40, 'Entregue', 7.85), (5, 8, 45, 'Em preparo', 8.25),
(6, 9, 38, 'Entregue', 8.95), (7, 10, 32, 'Cancelado', 6.55);

-- ITENS PEDIDO REFERENCIANDO O ID DO PRODUTO
INSERT INTO Itens_pedido (fk_pedidos_id, fk_produto_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 59.90), (1, 2, 1, 12.50), (1, 3, 1, 8.75),
(2, 4, 1, 62.40), (2, 5, 1, 13.55), (2, 6, 1, 15.45),
(3, 7, 1, 89.90), (3, 8, 2, 24.75), (3, 9, 1, 19.60),
(4, 10, 1, 52.35), (4, 11, 2, 21.40), (4, 12, 1, 9.85),
(5, 13, 2, 34.90), (5, 14, 1, 16.80), (5, 15, 1, 19.20),
(6, 16, 1, 38.45), (6, 17, 1, 18.75), (6, 18, 2, 6.95),
(7, 19, 1, 44.80), (7, 20, 1, 39.65), (7, 21, 1, 18.90),
(8, 22, 1, 38.70), (8, 23, 2, 9.85), (8, 24, 1, 11.30),
(9, 25, 3, 16.70), (9, 26, 1, 22.45), (9, 27, 2, 8.70),
(10, 28, 2, 28.60), (10, 29, 1, 12.75), (10, 30, 1, 14.35);

-- CONSULTA 1: VALOR TOTAL DE CADA PEDIDO
SELECT 
    p.id_pedidos AS ID_Pedido,
    c.nome_cliente AS Cliente,
    r.nome_restaurante AS Restaurante,
    p.status_pedido AS Status_Pedido,
    p.taxa_entrega AS Taxa_Entrega,
    ROUND(SUM(i.quantidade * i.preco_unitario), 2) AS Total_Itens,
    ROUND(SUM(i.quantidade * i.preco_unitario) + p.taxa_entrega, 2) AS Valor_Total_Pedido
FROM Pedidos p
INNER JOIN Cliente c ON p.fk_cliente_id = c.id_cliente
INNER JOIN Restaurante r ON p.fk_restaurante_id = r.id_restaurante
INNER JOIN Itens_pedido i ON i.fk_pedidos_id = p.id_pedidos
GROUP BY p.id_pedidos, c.nome_cliente, r.nome_restaurante, p.status_pedido, p.taxa_entrega;

-- CONSULTA 2: RESTAURANTES DA CATEGORIA HAMBURGUERIA
SELECT r.nome_restaurante AS Restaurante, cat.nome_categoria AS Categoria
FROM Restaurante r
INNER JOIN Categoria cat ON r.fk_categoria_id = cat.id_categoria
WHERE cat.nome_categoria = 'Hamburgueria';

-- CONSULTA 3: CLIENTES QUE MORAM EM PINHEIROS
SELECT c.nome_cliente AS Cliente, e.rua AS Rua, c.numero AS Numero, c.complemento AS Complemento, 
       e.bairro AS Bairro, e.cidade AS Cidade, e.estado AS Estado
FROM Cliente c
INNER JOIN Endereco e ON c.fk_cep = e.cep
WHERE e.bairro = 'Pinheiros';

-- CONSULTA 4: PEDIDOS ENTREGUES COM TAXA ACIMA DE R$ 5,00
SELECT id_pedidos AS Pedido, status_pedido AS Status_Pedido, taxa_entrega AS Taxa_Entrega
FROM Pedidos
WHERE status_pedido = 'Entregue' AND taxa_entrega > 5.00;

-- CONSULTA 5: RESTAURANTES DAS CATEGORIAS HAMBURGUERIA OU PIZZARIA
SELECT r.nome_restaurante AS Restaurante, cat.nome_categoria AS Categoria
FROM Restaurante r
INNER JOIN Categoria cat ON r.fk_categoria_id = cat.id_categoria
WHERE cat.nome_categoria IN ('Hamburgueria', 'Pizzaria');

-- CONSULTA 6: QUANTIDADE DE PEDIDOS ENTREGUES
SELECT COUNT(*) AS Quantidade_Entregues
FROM Pedidos
WHERE status_pedido = 'Entregue';

-- CONSULTA 7: MÉDIA DA TAXA DE COMISSÃO DOS RESTAURANTES
SELECT ROUND(AVG(taxa_comissao_percentual), 2) AS Media_Comissao_Percentual
FROM Restaurante;

-- CONSULTA 8: FATURAMENTO TOTAL DOS PRODUTOS, DESCONSIDERANDO CANCELADOS
SELECT ROUND(SUM(i.quantidade * i.preco_unitario), 2) AS Faturamento_Total_Produtos
FROM Itens_pedido i
INNER JOIN Pedidos p ON i.fk_pedidos_id = p.id_pedidos
WHERE p.status_pedido <> 'Cancelado';

-- CONSULTA 9: GANHO DO MARKETPLACE COM COMISSÃO POR PEDIDO
SELECT 
    p.id_pedidos AS Pedido,
    r.nome_restaurante AS Restaurante,
    r.taxa_comissao_percentual AS Percentual_Comissao,
    ROUND(SUM(i.quantidade * i.preco_unitario), 2) AS Total_Itens,
    ROUND(SUM(i.quantidade * i.preco_unitario) * (r.taxa_comissao_percentual / 100), 2) AS Ganho_Marketplace_Comissao
FROM Pedidos p
INNER JOIN Restaurante r ON p.fk_restaurante_id = r.id_restaurante
INNER JOIN Itens_pedido i ON i.fk_pedidos_id = p.id_pedidos
WHERE p.status_pedido <> 'Cancelado'
GROUP BY p.id_pedidos, r.nome_restaurante, r.taxa_comissao_percentual;

-- CONSULTA 10: RELATÓRIO COMPLETO DOS PEDIDOS
SELECT 
    p.id_pedidos AS Pedido,
    c.nome_cliente AS Cliente,
    r.nome_restaurante AS Restaurante,
    cat.nome_categoria AS Categoria,
    p.status_pedido AS Status_Pedido,
    p.tempo_entrega AS Tempo_Entrega_Minutos,
    p.taxa_entrega AS Taxa_Entrega,
    ROUND(SUM(i.quantidade * i.preco_unitario), 2) AS Total_Produtos,
    ROUND(SUM(i.quantidade * i.preco_unitario) + p.taxa_entrega, 2) AS Valor_Final
FROM Pedidos p
INNER JOIN Cliente c ON p.fk_cliente_id = c.id_cliente
INNER JOIN Restaurante r ON p.fk_restaurante_id = r.id_restaurante
INNER JOIN Categoria cat ON r.fk_categoria_id = cat.id_categoria
INNER JOIN Itens_pedido i ON i.fk_pedidos_id = p.id_pedidos
GROUP BY p.id_pedidos, c.nome_cliente, r.nome_restaurante, cat.nome_categoria, p.status_pedido, p.tempo_entrega, p.taxa_entrega
ORDER BY p.id_pedidos;
