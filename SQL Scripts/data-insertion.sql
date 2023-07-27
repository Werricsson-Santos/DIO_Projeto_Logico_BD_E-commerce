-- Inserção de dados
USE ecommerce;

-- SHOW TABLES;
-- DESC CUSTOMER;
-- FirstName, MiddleInitName, LastName, CPF, CredCard, Street, HouseNumber, Village, City, State
INSERT INTO CUSTOMER(FirstName, MiddleInitName, LastName, CPF, CredCard, Street, HouseNumber, Village, City, State)
	   VALUES('Maria', 'M', 'Silva', '12345678910', '4532156789021234', 'Rua Silva de Prata', '29', 'Carangola', 'Cidade das Flores', 'SP'),
			 ('Matheus', 'O', 'Pimentel', '98765432130', '3782567890123456', 'Rua Alameda', '289', 'Centro', 'Cidade das Flores', 'SP'),
             ('Ricardo', 'F', 'Silva', '4567891340', '5410234567890123', 'Avenida Alameda Vinha', '1009', 'Centro', 'Cidade das Flores', 'SP'),
             ('Julia', 'S', 'França', '78912345650', '3021789012345678', 'Rua Laranjeiras', '861', 'Centro', 'Cidade das Flores', 'SP'),
             ('Roberta', 'G', 'Assis', '9874563180', '6364321098765432', 'Avenida Koller', '19', 'Centro', 'Cidade das Flores', 'SP'),
             ('Isabela', 'M', 'Cruz', '65478912390', '2849876543210987','Rua Alameda das Flores', '28', 'Centro', 'Cidade das Flores', 'SP');            

-- DESC PRODUCT;
-- ProdName, Category('Eletrônico', 'Móveis', 'Brinquedos', 'Outros'), Price, CassificationKids boolean, Rating, Size
INSERT INTO PRODUCT(ProdName, Category, Price, ClassificationKids, Rating, Size)
	   VALUES('Fone de ouvido', 'Eletrônico', 25.50,  false, '4', null),
			 ('Max Steel', 'Brinquedos', 180.94,  true, '4', null),
             ('Playstation 5', 'Eletrônico', 4500.25,  true, '4', null),
             ('Microfone Vedo - Bm800', 'Eletrônico', 225.00, false, '4', null),
             ('Sofá retrátil', 'Móveis', 1319.99, false, '4', null),
             ('Fire Stick Amazon', 'Eletrônico', 312.55, false, '4', null),
             ('Guitarra Gibson Les Paul Standard 50s', 'Outros', 49024.50, false, '4', null);
             
             
-- DESC STORAGES;
-- StorageLocation, Quantity
INSERT INTO Storages (StorageLocation, Quantity)
	   VALUES('Rua das Flores, 123, São Paulo, SP', 100),
		     ('Avenida dos Sabiás, 456, Rio de Janeiro, RJ', 50),
			 ('Travessa das Mangueiras, 789, Belo Horizonte, MG', 80),
			 ('Alameda das Palmeiras, 321, Salvador, BA', 120);
             

-- DESC LEGAL_PERSON;
-- SocialName, TradeName, CNPJ
INSERT INTO LEGAL_PERSON (SocialName, TradeName, CNPJ)
	   VALUES('TechPlay Distribuidora de Games e Tecnologia', 'TechPlay Games & Tech Distribuidora LTDA', '98765432101234'),
			 ('Distribuidora Kids', 'Kids Distribuição de Brinquedos LTDA', '45678912309876'),
			 ('Distribuidora de Móveis Elegância', 'Móveis Elegância Distribuidora LTDA', '98765432106134'),
			 ('Loja de Brinquedos Alegria', 'Alegria Brinquedos LTDA', '12345678901230'),
			 ('Comércio de Móveis e Decorações XYZ', 'Móveis e Decorações XYZ Comércio LTDA', '12345678902534'),
			 ('GamesTech Store', 'GamesTech Store LTDA', '98765432103634');

-- DESC SUPPLIER;
-- SupplierName, LegalPerson, CPF, Contact, Location
INSERT INTO SUPPLIER (SupplierName, IdLegalSupplier, CPF, Contact, Location)
	   VALUES('João da Silva', 1, null, '119999999', 'Rua das Flores, 123'),
			 ('Maria Souza', 2, null, '228888888', 'Avenida dos Sabiás, 456'),
			 ('Pedro Santos', 3, null, '337777777', 'Rua das Palmeiras, 789'),	
			 ('Carlos Oliveira', null, '78945612300', '446666666', 'Avenida das Aves, 567'),
			 ('Ana Lima', null, '45612378900', '555555555', 'Rua dos Pássaros, 678');


-- DESC SELLER;
-- SellerName, LegalPerson, CPF, Contact, Location
INSERT INTO SELLER (SellerName, IdLegalSeller, CPF, Contact, Location)
	   VALUES('Ana Oliveira', 4, '12345678902', '446666666', 'Rua dos Pássaros, 567'),
			 ('Carlos Lima', 5, '98765432103', '555555555', 'Avenida das Flores, 678'),
			 ('Rafael Mendes', 6, '45678912304', '664444444', 'Rua dos Sabiás, 789'),
			 ('João da Silva', 1, '98765432100', '338888888', 'Rua das Flores, 123'),
			 ('Maria Oliveira', null, '65498732100', '227777777', 'Rua das Palmeiras, 456');
             
-- DESC PRODUCT_SELLER;
-- IdPseller, IdPproduct, ProdQuantity
INSERT INTO PRODUCT_SELLER (IdPseller, IdPproduct, ProdQuantity)
	   VALUES(1, 1, 50),
			 (1, 3, 100),
			 (1, 6, 30),
			 (2, 2, 70),
			 (2, 4, 120),
			 (2, 5, 80),
			 (3, 1, 20),
			 (3, 2, 60),
			 (3, 7, 40),
			 (4, 3, 90),
			 (4, 6, 25),
			 (5, 4, 110);


-- DESC PRODUCT_SUPPLIER;
-- IdPSsupplier, IdPSproduct, PsQuantity
INSERT INTO PRODUCT_SUPPLIER (IdPSsupplier, IdPSproduct, PsQuantity)
	   VALUES(1, 1, 200),
			 (1, 2, 150),
			 (1, 4, 100),
			 (2, 3, 180),
			 (2, 5, 120),
			 (3, 1, 80),
			 (3, 6, 90),
			 (4, 2, 70),
			 (4, 3, 50),
			 (5, 5, 60),
			 (5, 7, 40);
             
             
-- DESC PRODUCT_STORAGE;
-- IdPSproduct, IdPSstorage, Region
INSERT INTO PRODUCT_STORAGE (IdLocalProduct, IdLocalStorage, Region)
	   VALUES(1, 1, 'SP'),
			 (2, 2, 'RJ'),
			 (3, 3, 'MG'),
			 (4, 4, 'BA'),
			 (5, 1, 'SP'),
			 (6, 2, 'RJ'),
			 (7, 3, 'MG');
             
             
-- DESC ORDERS;
-- IdOrderClient, OrderStatus('Em processamento', 'Cancelado', 'Confirmado'), OrderDescription, Shipping
INSERT INTO ORDERS (IdOrderClient, OrderStatus, Shipping)
	   VALUES(1, 'Em processamento', 20.00),
			 (2, 'Cancelado', 15.50),
			 (3, 'Confirmado', 25.00),
			 (1, 'Em processamento', 18.00),
			 (4, 'Confirmado', 12.00),
			 (6, 'Em processamento', 30.50),
			 (3, 'Confirmado', 22.00),
			 (2, 'Cancelado', 10.00),
			 (5, 'Em processamento', 24.00);
             

-- DESC PRODUCT_ORDER;
-- IdPOproduct, IdPOorder, POquantity, POstatus
INSERT INTO PRODUCT_ORDER (IdPOproduct, IdPOorder, POquantity, POstatus)
	   VALUES(1, 1, 10, 'Disponível'),
			 (2, 1, 5, 'Disponível'),
			 (3, 1, 8, 'Sem estoque'),
			 (4, 2, 15, 'Disponível'),
			 (5, 2, 3, 'Sem estoque'),
			 (7, 3, 1, 'Disponível'),
             (2, 4, 1, 'Disponível'),
             (3, 5, 1, 'Disponível'),
             (4, 6, 2, 'Disponível'),
             (5, 7, 1, 'Disponível'),
             (1, 8, 3, 'Disponível'),
             (6, 9, 20, 'Sem estoque');
             
-- DESC PAYMENT;
-- IdPaymentClient, IdPaymentOrder, TypePayment('Boleto', 'Cartão', 'PIX'), PaymentAccept
INSERT INTO PAYMENT (IdPaymentClient, IdPaymentOrder, TypePayment, TwoWays, Value1, PaymentAccept)
	   VALUES(2, 2, 'Cartão', true, 3375.00, true),
			 (3, 3, 'Cartão', true, 29024.50, true),
			 (1, 4, 'Boleto', true, 50.00, true),
			 (4, 5, 'PIX', true, 2250.25, true),
			 (6, 6, 'Cartão', false, 312.55, false),
			 (3, 7, 'Boleto', true, 319.99, true),
			 (2, 8, 'PIX', false, 225.00, true),
			 (5, 9, 'Cartão', false, 0.00, false);
          
-- DESC PAYMENT_COMBO 
-- IdPaymentCombo, TypeCombo, Value2
INSERT INTO PAYMENT_COMBO (IdPaymentCombo, TypeCombo, Value2)
	   VALUES(1, 'Cartão', 3959.97),
			 (2, 'PIX', 20000.00),
			 (3, 'Cartão', 130.94),
             (4, 'Cartão', 2250.00),
             (6, 'Cartão', 1000.00);
             
             
