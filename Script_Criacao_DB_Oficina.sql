-- CRIAÇÃO BD OFICINA E SUAS ENTIDADES DE RELACIONAMENTO

CREATE DATABASE if not exists oficina;
USE oficina;

-- tabela cliente
CREATE TABLE clients (
	idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(15),
    Minit CHAR(3), 
    Lname VARCHAR(20),
    CNH CHAR(45) NOT NULL,
    Address VARCHAR(100),
    contact VARCHAR(11), 
    CONSTRAINT unique_cpf_client UNIQUE (CNH)   
);

CREATE TABLE PF (
	IdPF INT AUTO_INCREMENT PRIMARY KEY,
    idPFClient INT,
    CPF VARCHAR(45) NOT NULL,
    RG VARCHAR(45),
    CONSTRAINT fk_PF_Clients FOREIGN KEY (idpfClient) REFERENCES clients (idClient)
);

CREATE TABLE PJ (
	IdPJ INT AUTO_INCREMENT PRIMARY KEY,
    idPJClient INT,
    socialName VARCHAR(255) NOT NULL,
    CNPJ VARCHAR(45) NOT NULL,
    stateRegistration VARCHAR(45),
    CONSTRAINT fk_PJ_Clients FOREIGN KEY (idPJClient) REFERENCES clients (idClient)
);

CREATE TABLE mechanicalTeam (
	IdMechanicalTeam INT AUTO_INCREMENT PRIMARY KEY,
    mechanics VARCHAR(255)
);

CREATE TABLE mechanical (
	IdMechanical INT AUTO_INCREMENT PRIMARY KEY,
    idMTmechanical INT,
    socialName VARCHAR(255) NOT NULL,
    CNPJ VARCHAR(45) NOT NULL,
    stateRegistration VARCHAR(45),
    CONSTRAINT fk_mechanical_mechanicalTeam FOREIGN KEY (idMTmechanical) REFERENCES mechanicalTeam (IdMechanicalTeam)
);

CREATE TABLE vehicle (
	IdVehicle INT AUTO_INCREMENT PRIMARY KEY,
    idVehicleClient INT,
    vehicleModel VARCHAR(255),
    vehicleYear VARCHAR(45),
    licensePlate VARCHAR(45),
    CONSTRAINT fk_vehicle_clients FOREIGN KEY (idVehicleClient) REFERENCES clients (idClient)
);

CREATE TABLE carPart (
	IdcarPart INT AUTO_INCREMENT PRIMARY KEY,
    carPartType VARCHAR(255),
    quantity INT NOT NULL
);

CREATE TABLE type_payment(
	idtypepayment INT AUTO_INCREMENT PRIMARY KEY,
    typePaymentDescription VARCHAR(45) NOT NULL
);

CREATE TABLE carReview (
	idCarReview INT AUTO_INCREMENT PRIMARY KEY,
    idCarReviewClient INT,
    idCarReviewVehicle INT,
	CONSTRAINT fk_carReview_clients FOREIGN KEY (idCarReviewClient) REFERENCES clients (idClient),
    CONSTRAINT fk_carReview_vehicle FOREIGN KEY (idCarReviewVehicle) REFERENCES vehicle (IdVehicle)
);

CREATE TABLE carRepair (
	idCarRepair INT AUTO_INCREMENT PRIMARY KEY,
    idCarRepairClient INT,
    idCarRepairVehicle INT,
	CONSTRAINT fk_carRepair_clients FOREIGN KEY (idCarRepairClient) REFERENCES clients (idClient),
    CONSTRAINT fk_carRepair_vehicle FOREIGN KEY (idCarRepairVehicle) REFERENCES vehicle (IdVehicle)
);

CREATE TABLE delivery (
	idDelivery INT AUTO_INCREMENT PRIMARY KEY,
    deliveryStatus VARCHAR(45)
);

CREATE TABLE payment (
	idPayment INT AUTO_INCREMENT PRIMARY KEY,
    idPayType_payment INT,
    idPayDelivery INT,
    Pvalue FLOAT(9,2),
    paid TINYINT,
    paymentStatus VARCHAR(45),
	CONSTRAINT fk_payment_type_payment FOREIGN KEY (idPayType_payment) REFERENCES type_payment (idtypepayment),
    CONSTRAINT fk_payment_delivery FOREIGN KEY (idPayDelivery) REFERENCES delivery (idDelivery)
);

CREATE TABLE partStorage (
	idpartStorage INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT,
    location VARCHAR(255)
);

-- drop table storageHasPart;
CREATE TABLE storageHasPart (
    idStorageHasPartPartStorage INT,
    idStorageHasPartCarPart INT,
    PRIMARY KEY (idStorageHasPartPartStorage, idStorageHasPartCarPart),
	CONSTRAINT fk_storageHasPart_partStorage FOREIGN KEY (idStorageHasPartPartStorage) REFERENCES partStorage (idpartStorage),
    CONSTRAINT fk_storageHasPart_carPart FOREIGN KEY (idStorageHasPartCarPart) REFERENCES carPart (IdcarPart)
);

CREATE TABLE budget (
	idBudget INT AUTO_INCREMENT PRIMARY KEY,
    idBudgetMechanical INT,
    idBudgetCarReview INT,
    idBudgetCarRepair INT,
    service VARCHAR(255),
    carpart VARCHAR(45),
    quantity INT,
    bugetValue FLOAT(9,2),
    Bstatus VARCHAR(45),
	CONSTRAINT fk_budget_mechanical FOREIGN KEY (idBudgetMechanical) REFERENCES mechanical (IdMechanical),
    CONSTRAINT fk_budget_carReview FOREIGN KEY (idBudgetCarReview) REFERENCES carReview (idCarReview),
    CONSTRAINT fk_budget_carRepair FOREIGN KEY (idBudgetCarRepair) REFERENCES carRepair (idCarRepair)
);

CREATE TABLE orders (
	idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT,
    idOrderMechanicalTeam INT,
    idOrderBudget INT,
    OrderDescription VARCHAR(255),
    requestDate DATE,
    Bstatus VARCHAR(45),
	CONSTRAINT fk_orders_clients FOREIGN KEY (idOrderClient) REFERENCES clients (idClient),
    CONSTRAINT fk_orders_mechanicalTeam FOREIGN KEY (idOrderMechanicalTeam) REFERENCES mechanicalTeam (IdMechanicalTeam),
    CONSTRAINT fk_orders_Budget FOREIGN KEY (idOrderBudget) REFERENCES Budget (idBudget)
);

CREATE TABLE carpartHasBudget (
	idCarpartHasBudgetClient INT,
    idCarpartHasBudgetCarPart INT,
    idCarpartHasBudgetBudget INT,
    idCarpartHasBudgetVehicle INT,
    idCarpartHasBudgetReview INT,
    idCarpartHasBudgetRepair INT,
    PRIMARY KEY (idCarpartHasBudgetClient, idCarpartHasBudgetCarPart, idCarpartHasBudgetBudget, idCarpartHasBudgetVehicle, idCarpartHasBudgetReview, idCarpartHasBudgetRepair ),
	CONSTRAINT fk_carpartHasBudget_client FOREIGN KEY (idCarpartHasBudgetClient) REFERENCES clients (idClient),
	CONSTRAINT fk_carpartHasBudget_carPart FOREIGN KEY (idCarpartHasBudgetCarPart) REFERENCES carPart (IdcarPart),
    CONSTRAINT fk_carpartHasBudget_budget FOREIGN KEY (idCarpartHasBudgetBudget) REFERENCES Budget (idBudget),
    CONSTRAINT fk_carpartHasBudget_Vehicle FOREIGN KEY (idCarpartHasBudgetVehicle) REFERENCES vehicle (IdVehicle),
    CONSTRAINT fk_carpartHasBudget_Review FOREIGN KEY (idCarpartHasBudgetReview) REFERENCES carReview (idCarReview),
    CONSTRAINT fk_carpartHasBudget_Repair FOREIGN KEY (idCarpartHasBudgetRepair) REFERENCES carRepair (idCarRepair)
);

CREATE TABLE workOrder (
	idWorkOrder INT AUTO_INCREMENT PRIMARY KEY,
	idWorkOrderOrders INT,
    idWorkOrderMechanical INT,
    idWorkOrderReview INT,
    idWorkOrderRepair INT,
    idWorkOrderPayment INT,
    workOrderNumber VARCHAR(45),
    WOStatus VARCHAR(45),
    deiveryDate DATE,
    dateIssuence DATE,
	CONSTRAINT fk_workOrder_orders FOREIGN KEY (idWorkOrderOrders) REFERENCES orders (idOrder),
	CONSTRAINT fk_workOrder_mechanical FOREIGN KEY (idWorkOrderMechanical) REFERENCES mechanical (IdMechanical),
    CONSTRAINT fk_workOrder_Review FOREIGN KEY (idWorkOrderReview) REFERENCES carReview (idCarReview),
    CONSTRAINT fk_workOrder_Repair FOREIGN KEY (idWorkOrderRepair) REFERENCES carRepair (idCarRepair),
	CONSTRAINT fk_workOrder_payment FOREIGN KEY (idWorkOrderPayment) REFERENCES payment (idPayment)    
);


desc clients;
desc pf;
desc pj;
show tables;
select * from clients