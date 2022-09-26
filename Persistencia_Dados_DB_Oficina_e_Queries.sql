-- PERSISTINDO DADOS EM OFICINA
use oficina;

INSERT INTO clients (Fname, Minit, Lname, CNH, Address, contact)
	VALUES('Maria', 'M', 'Silva', '123456789', 'Rua Silva de Prata 29, Carangola - Cidade das Flores', '999999999'),
		  ('Matheus', 'O', 'Pimentel', '987654321', 'Rua Alemeda 289, Centro - Cidade das Flores', '888888888'),
          ('Ricardo', 'F', 'Silva', '45678913', 'Avenida Alemeda Vinha 1009, Centro - Cidade das Flores', '777777777'),
          ('Julia', 'S', 'França', '789123456', 'Rua Laranjeiras 861, Centro - Cidade das Flores', '666666666'),
          ('Roberta', 'G', 'Assis', '98745631', 'Avenida Loller 19, Centro - Cidade das Flores', '555555555'),
          ('Isabela', 'M', 'Cruz', '654789123', 'Rua Alemeda das Flores 28, Centro - Cidade das Flores', '444444444');
          
INSERT INTO pf (idPF, idPFClient, CPF, RG)
	VALUES (1, 3, 46215487954, 6358205412),
		   (2, 5, 66354221524, 2012305410),
		   (3, 4, 51624457733, 9875412210);
           
INSERT INTO pj (idPJ, idPJClient, socialName, CNPJ, stateRegistration)
	VALUES (1, 1, 'Elétrocar', 000196354421150, 121111111),
		   (2, 2, 'Marivonts', 000196354666663, 123333333),
		   (3, 6, 'Vortex', 000122223554121, 115555555);
           

          
SELECT * FROM pf;
desc pf;
desc pj;

show tables;

-- QUERIES
-- recuperando número de clientes
SELECT count(*) from clients;

-- selecionar clientes pessoa física
select concat(Fname, ' ', Lname) Nome, CPF, RG CNH from pf, clients where idPFClient=idClient;

-- selecionar clientes pessoa jurídica
select socialName Razão_Social, CNPJ, CNH, stateRegistration as Inscrição_Estadual from pJ, clients where idPJClient=idClient;
