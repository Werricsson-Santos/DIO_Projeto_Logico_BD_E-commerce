-- Queries:
USE ecommerce;

-- Quantos pedidos foram feitos por cada cliente e quando a loja faturou com cada cliente?
SELECT IdClient, CONCAT(FirstName, ' ', MiddleInitName, ' ', LastName) AS Cliente,
	COUNT(*) AS  Total_De_Pedidos, FORMAT(SUM(Total), 2) AS Faturamento_Por_Cliente
	FROM CUSTOMER
		INNER JOIN ORDERS o ON IdClient = IdOrderClient
		INNER JOIN PRODUCT_ORDER ON IdPOorder = IdOrder
    GROUP BY IdClient;

-- Algum vendedor também é fornecedor?
SELECT * FROM SELLER INNER JOIN SUPPLIER ON IdLegalSeller = IdLegalSupplier;


-- Relação de produtos fornecedores e estoques;
SELECT ProdName, Category, Price, ClassificationKids,
	   StorageLocation, Quantity,
	   SupplierName, CPF, IdLegalSupplier, CNPJ, SocialName, TradeName FROM PRODUCT 
	INNER JOIN PRODUCT_SUPPLIER ON IdProduct = IdPSproduct
    INNER JOIN SUPPLIER ON IdPSsupplier = IdSupplier
    LEFT JOIN LEGAL_PERSON ON IdLegalSupplier = IdLegalPerson
    INNER JOIN PRODUCT_STORAGE ON IdLocalProduct - IdProduct
    INNER JOIN STORAGES ON IdLocalStorage = IdStorage
    ORDER BY Quantity DESC;
    
-- Relação de nome dos fornecedores e nome dos produtos
SELECT ProdName, SupplierName FROM PRODUCT 
INNER JOIN PRODUCT_SUPPLIER ON IdProduct = IdPSproduct
INNER JOIN SUPPLIER ON IdPSsupplier = IdSupplier;


-- Qual são os produtos mais caros?
SELECT * FROM PRODUCT ORDER BY Price DESC;

-- Qual é o mais barato?
SELECT * FROM PRODUCT WHERE Price HAVING MIN(Price);


-- Quantos produtos temos em cada categoria?
SELECT Category, COUNT(*) AS Quantity FROM PRODUCT GROUP BY Category ORDER BY Quantity DESC;