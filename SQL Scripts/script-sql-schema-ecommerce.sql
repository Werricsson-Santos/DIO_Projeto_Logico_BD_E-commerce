-- Criação do banco de dados para o cenário de E-commerce
CREATE DATABASE ecommerce;
USE ecommerce;


-- Criar tabela cliente

CREATE TABLE CUSTOMER(
	IdClient INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(10),
    MiddleInitName CHAR(3),
    LastName VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    CredCard CHAR(16),
	Street VARCHAR(60),
    HouseNumber VARCHAR(5) NOT NULL,
    Village VARCHAR(20),
    City VARCHAR(20),
    State CHAR(2),
    PostCode VARCHAR(11),
	CONSTRAINT UNIQUE_CPF_CUSTOMER UNIQUE (CPF),
    CONSTRAINT UNIQUE_CREDCARD_CUSTOMER UNIQUE (CredCard)
) AUTO_INCREMENT=1;


-- Criar tabela produto
CREATE TABLE PRODUCT(
	IdProduct INT AUTO_INCREMENT PRIMARY KEY,
    ProdName VARCHAR(65),
    Category ENUM('Eletrônico', 'Móveis', 'Brinquedos', 'Outros') NOT NULL,
    Price FLOAT NOT NULL,
    ClassificationKids BOOL,
    ProdDescription VARCHAR(45),
    Reviews VARCHAR(30),
    Rating FLOAT DEFAULT 0,
    Size VARCHAR(10)
) AUTO_INCREMENT=1;


-- Criar tabela pedido
CREATE TABLE ORDERS(
	IdOrder INT AUTO_INCREMENT PRIMARY KEY,
    IdOrderClient INT,
    OrderStatus ENUM('Em processamento', 'Cancelado', 'Confirmado') DEFAULT 'Em processamento',
    OrderDescription VARCHAR(45),
    Shipping FLOAT DEFAULT 10,
    CONSTRAINT FK_ORDERS_CUSTOMER FOREIGN KEY (IdOrderClient) REFERENCES CUSTOMER(IdClient)
) AUTO_INCREMENT=1;


-- Criar tabela de pagamentos
CREATE TABLE PAYMENT(
	IdPaymentClient INT,
    IdPaymentOrder INT,
	IdPayment INT PRIMARY KEY AUTO_INCREMENT,
	TypePayment ENUM('Boleto', 'Cartão', 'PIX'),
    PaymentAccept BOOL DEFAULT FALSE,
    CONSTRAINT FK_PAYMENT_CUSTOMER FOREIGN KEY (IdPaymentClient) REFERENCES CUSTOMER(IdClient),
    CONSTRAINT FK_PAYMENT_ORDER FOREIGN KEY (IdPaymentOrder) REFERENCES ORDERS(IdOrder)
) AUTO_INCREMENT=1;

ALTER TABLE PAYMENT 
	ADD IdOrderPayment INT,
	ADD CONSTRAINT FK_ORDERS_PAYMENT FOREIGN KEY (IdOrderPayment) REFERENCES PAYMENT(IdPayment);


-- Criar tabela estoque
CREATE TABLE STORAGES(
	IdStorage INT AUTO_INCREMENT PRIMARY KEY,
    StorageLocation VARCHAR(255),
	Quantity INT DEFAULT 0
) AUTO_INCREMENT=1;


-- criar tabela pessoa jurídica
	CREATE TABLE LEGAL_PERSON(
	IdLegalPerson INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    TradeName VARCHAR(255),
	CNPJ CHAR(15) NOT NULL,
    CONSTRAINT UNIQUE_LEGAL_PERSON UNIQUE (CNPJ)
) AUTO_INCREMENT=1;


-- Criar tabela fornecedor
CREATE TABLE SUPPLIER(
	IdSupplier INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(45) NOT NULL,
-- Caso o fornecedor não seja pessoa jurídica o IdLegalPerson será 0
    IdLegalSupplier INT DEFAULT 0,
	CPF CHAR(11),
    Contact char(9) NOT NULL,
    Location VARCHAR(255),
	CONSTRAINT FK_LEGAL_SUPPLIER FOREIGN KEY (IdLegalSupplier) REFERENCES LEGAL_PERSON(IdLegalPerson),
    CONSTRAINT UNIQUE_SUPPLIER UNIQUE (CPF)
) AUTO_INCREMENT=1;


-- Criar tabela vendedor
CREATE TABLE SELLER(
	IdSeller INT AUTO_INCREMENT PRIMARY KEY,
	SellerName VARCHAR(45) NOT NULL,
-- Caso o vendedor não seja pessoa jurídica o IdLegalPerson será 0
    IdLegalSeller INT DEFAULT 0,
	CPF CHAR(11),
    Contact char(9) NOT NULL,
    Location VARCHAR(255),
	CONSTRAINT FK_LEGAL_SELLER FOREIGN KEY (IdLegalSeller) REFERENCES LEGAL_PERSON(IdLegalPerson),
    CONSTRAINT UNIQUE_SUPPLIER UNIQUE (CPF)
) AUTO_INCREMENT=1;


-- Criar tabela de relação entre produto e vendedor
CREATE TABLE PRODUCT_SELLER(
	IdPseller INT,
    IdPproduct INT,
    ProdQuantity INT DEFAULT 1,
    PRIMARY KEY (IdPseller, IdPproduct),
    CONSTRAINT FK_PRODUCT_SELLER_SELLER FOREIGN KEY (IdPseller) REFERENCES SELLER(IdSeller),
    CONSTRAINT FK_PRODUCT_SELLER_PRODUCT FOREIGN KEY (IdPproduct) REFERENCES PRODUCT(IdProduct)
);


-- Criar tabela de relação entre produto e fornecedor
CREATE TABLE PRODUCT_SUPPLIER(
	IdPSsupplier INT,
    IdPSproduct INT,
    PsQuantity INT NOT NULL,
    PRIMARY KEY (IdPSsupplier, IdPSproduct),
    CONSTRAINT FK_PS_SUPPLIER FOREIGN KEY (IdPSsupplier) REFERENCES SUPPLIER(IdSupplier),
    CONSTRAINT FK_PS_PRODUCT FOREIGN KEY (IdPSproduct) REFERENCES PRODUCT(IdProduct)
);


-- Criar tabela de relação entre produto e estoque
CREATE TABLE PRODUCT_STORAGE(
	IdPSproduct INT,
    IdPSstorage INT,
    Region CHAR(2) NOT NULL,
    PRIMARY KEY (IdPSproduct, IdPSstorage),
    CONSTRAINT FK_LOCATION_PRODUCT FOREIGN KEY (IdPSproduct) REFERENCES PRODUCT(IdProduct),
    CONSTRAINT FK_LOCATION_STORAGE FOREIGN KEY (IdPSstorage) REFERENCES STORAGES(IdStorage)
);


-- Criar tabela de relação entre produto e pedido
CREATE TABLE PRODUCT_ORDER(
	IdPOproduct INT,
    IdPOorder INT,
    POquantity INT DEFAULT 1,
    POstatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (IdPOproduct, IdPOorder),
    CONSTRAINT FK_PO_PRODUCT FOREIGN KEY (IdPOproduct) REFERENCES PRODUCT(IdProduct),
    CONSTRAINT FK_PO_ORDER FOREIGN KEY (IdPOorder) REFERENCES ORDERS(IdOrder)
);