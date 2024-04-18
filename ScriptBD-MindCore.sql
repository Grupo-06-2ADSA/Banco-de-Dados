create database MindCore;
use MindCore;

create table Empresa (
cnpj char(14) primary key unique,
nome varchar(45),
telefone char(11));

create table Estoque (
idEstoque int primary key auto_increment,
componente varchar(45),
quantidade int,
preco decimal,
fkEmpresa char(14),
foreign key (fkEmpresa) references Empresa(cnpj)
);
create table Sala (
idSala int primary key auto_increment,
nome varchar(45),
andar int,
fkEmpresa char(14),
foreign key (fkEmpresa) references Empresa(cnpj)
);
create table Funcionario (
idFunc int primary key auto_increment,
nome varchar(45),
email varchar(45),
senha varchar(45),
telefone char(11),
tipo varchar(45),
check (tipo in('empresa','admin','comum')),	
fkEmpresa char(14),
foreign key (fkEmpresa) references Empresa(cnpj)
);
create table Maquina(
idMaquina int primary key auto_increment,
ip varchar(45),
fkSala int,
fkEmpresa char(14),
foreign key (fkSala) references Sala(idSala),
foreign key (fkEmpresa) references Empresa(cnpj));

-- CRIAR TABELAS PARA CADA HARDWARE, COM SUAS RESPECTIVAS INFORMAÇÕES!!!

create table Historico(
idHistorico int primary key auto_increment,
Dia date,
descricao varchar(45),
tipo varchar(45),
fkMaquina int,
fkSala int,
responsavel int,
foreign key (fkMaquina) references Maquina(idMaquina),
foreign key (fkSala) references Sala(idSala),
foreign key (responsavel) references Funcionario(idFunc));

create table infoPc(
idPc int primary key auto_increment,
sistemaOperacional varchar(100),
memoriaUso Long,
discoUso Long,
fkMaquina int);
select * from empresa;
select * from funcionario;



        















