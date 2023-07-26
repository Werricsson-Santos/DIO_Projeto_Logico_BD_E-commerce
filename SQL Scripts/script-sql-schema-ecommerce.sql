-- Criação do banco de dados para o cenário de E-commerce
CREATE DATABASE ecommerce;
USE ecommerce;


-- Criar tabela cliente
CREATE TABLE CUSTOMER(
	IdClient INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(10),
    MiddleInitName CHAR(3),
    LastName VARCHAR(20),
    CPF CHAR(11),
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
    Total FLOAT DEFAULT 0.00,
    Shipping FLOAT DEFAULT 10,
    CONSTRAINT FK_ORDERS_CUSTOMER FOREIGN KEY (IdOrderClient) REFERENCES CUSTOMER(IdClient)
) AUTO_INCREMENT=1;


-- Criar tabela de pagamentos
CREATE TABLE PAYMENT(
	IdPaymentClient INT,
    IdPaymentOrder INT,
	IdPayment INT PRIMARY KEY AUTO_INCREMENT,
	TypePayment ENUM('Boleto', 'Cartão', 'PIX'),
    Value1 INT,
    PaymentAccept BOOL DEFAULT FALSE,
    TwoWays BOOLEAN,
    CONSTRAINT FK_PAYMENT_CUSTOMER FOREIGN KEY (IdPaymentClient) REFERENCES CUSTOMER(IdClient),
    CONSTRAINT FK_PAYMENT_ORDER FOREIGN KEY (IdPaymentOrder) REFERENCES ORDERS(IdOrder)
) AUTO_INCREMENT=1;

    
-- Criar a tabela combo de pagamento, para permitir que o usuário selecione 2 formas de pagamento para o mesmo pedido
CREATE TABLE PAYMENT_COMBO(
	IdCombo INT PRIMARY KEY AUTO_INCREMENT,
    IdPaymentCombo INT,
    TypeCombo ENUM('Boleto', 'Cartão', 'PIX'),
    Value2 INT,
    CONSTRAINT FK_PAYMENT_COMBO FOREIGN KEY (IdPaymentCombo) REFERENCES PAYMENT(IdPayment)
);
    
    
-- Criar função para restringir apenas 2 tipos de pagamento para o mesmo pedido
DELIMITER \\
CREATE TRIGGER TR_CHECK_MAXIMUM_TWO_WAYS
BEFORE  INSERT ON PAYMENT_COMBO
FOR EACH ROW
BEGIN
	DECLARE count_ways INT;
    SET count_ways = ( SELECT COUNT(*) FROM PAYMENT_COMBO
					  WHERE IdPaymentCombo = NEW.IdPaymentCombo);
                      
	IF count_ways >= 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O limite de tipo de pagamentos foi excedido (Máximo - 2 tipos)';
	END IF;
END;
\\
DELIMITER ;
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

-- incluindo relação da tabela cliente e pessoa jurídica.
ALTER TABLE CUSTOMER
	ADD IdLegalClient INT,
    ADD CONSTRAINT FK_LEGAL_CLIENT FOREIGN KEY (IdLegalClient) REFERENCES LEGAL_PERSON(IdLegalPerson),
    ADD CONSTRAINT LEGAL_CLIENT_SHOULDNT_HAVE_CPF CHECK(
													(IdLegalClient IS NOT NULL AND CPF IS NULL) OR
													(IdLegalClient IS NULL AND CPF IS NOT NULL)
												);


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

-- Criar função para somar o valor total do pedido
DELIMITER \\
CREATE TRIGGER SUM_PRODUCTS_ORDER
AFTER INSERT ON PRODUCT_ORDER
FOR EACH ROW
BEGIN
	DECLARE product_value FLOAT;
    DECLARE total_value FLOAT;
    SET product_value = (SELECT Price FROM PRODUCT
						 WHERE IdProduct = NEW.IdPOproduct);
                         
    SET total_value = NEW.POquantity * product_value;
    
	UPDATE ORDERS
	SET Total = Total + total_value
    WHERE IdOrder = NEW.IdPOorder;
END;
\\
DELIMITER ;


-- Criar tabela de entrega
CREATE TABLE DELIVERY(
	IdDelivery INT PRIMARY KEY AUTO_INCREMENT,
    IdDeliveryOrder INT,
    StatusDelivery ENUM('Preparando para envio', 'Saiu para entrega', 'Entregue'),
    TrackCode VARCHAR(25),
    CONSTRAINT FK_DELIVERY_ORDER FOREIGN KEY (IdDeliveryOrder) REFERENCES ORDERS(IdOrder)
);