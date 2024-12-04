-- Criação do banco de dados para cenário do E-comerce

-- create database ecommerce;
use ecommerce;

-- criar tabela cliente
drop table clients;
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Addresss varchar(30),
    constraint unique_cpf_client unique (CPF)
);
desc clients;


-- criar tabela produto
-- size equivale as dimensções do produto
drop table product;
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(10),
    classification_kids bool default false,
    category enum("Eletrônico","Vestimenta","Brinquedos","Alimentos","Móveis") not null,
    avaliação float default 0,
    size varchar(10)
);

-- criar tabela de pagamentos
-- para continuar: temrina de implementar a tabela e criar a conexão com as tabelas necessárias
-- além disso, reflit essa modificação no diagrama de esquema relacional
-- criar constraints relacionadas ao pagamento
-- create table payments(
-- 	idClient int primary key,
--     idPayment int,
--     typePayment enum('Boleto','Cartão','Dois Cartões'),
--     limitAvailable float,
--     primary key(idClient, id_payment)
-- );

-- criar tabela de pedidos
drop table orders;
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento' ,
    orderDescription varchar(255),
    sendValue float default 0,
    paymentCash boolean default false,
    -- idPayment 
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
		on update cascade
        on delete set null
);
desc orders;

-- criar tabela estoque
drop table productStorage;
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

-- criar tabela fornecedor
drop table supplier;
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
desc supplier;

-- criar tabela vendedor
drop table seller;
create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbsName varchar(255),
    CNPJ char(15),
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

-- criar tabela productSeller
drop table productSeller;
create table productSeller(
	idPseller int,
    idProduct int,
    prodQuantity int default 1,
    primary key (idPseller, idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idProduct) references product(idProduct)
);
desc productSeller;

drop table productOrder;
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantify int default 1,
    poStatus enum('Disponível','Sem Estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

drop table storageLocation;
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location foreign key (idLproduct) references product(idProduct),
    constraint fk_product_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

drop table productSupplier;
create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

show tables;

show databases;

use information_schema;
desc referetial_constraints;
show tables;