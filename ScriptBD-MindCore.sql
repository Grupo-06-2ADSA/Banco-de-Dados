create database MindCore;
use MindCore;

create table Empresa (
cnpj char(14) primary key unique,
nome varchar(45),
telefone char(11));

create table Componentes (
idComponente int primary key auto_increment,
nomeComponente varchar(45),
quantidade int,
preco decimal(5,2),
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
check (tipo in('Empresa','Gestor','Técnico')),	
turno varchar(20),
check (turno in('manhã', 'tarde', 'noite')),
estado varchar(20),
check (estado in('ativo', 'inativo')),
fkEmpresa char(14),
foreign key (fkEmpresa) references Empresa(cnpj)
);
create table Maquina(
idMaquina int primary key auto_increment,
hostname varchar(45),
ip varchar(45),
imagem date,
fkSala int,
fkEmpresa char(14),
foreign key (fkSala) references Sala(idSala),
foreign key (fkEmpresa) references Empresa(cnpj));

create table Metricas(
idMetrica int primary key auto_increment,
CompCpu int,
CompDisco double,
CompRam double,
fkEmpresa char(14),
foreign key (fkEmpresa) references Empresa(cnpj));


-- CRIAR TABELAS PARA CADA HARDWARE, COM SUAS RESPECTIVAS INFORMAÇÕES!!!

create table HistoricoManutencao(
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

create table LeituraSO(
idSO int primary key auto_increment,
nome varchar(45),
tempoAtividade long,
dataLeitura datetime default current_timestamp,
fkMaquina int,
foreign key (fkMaquina) references Maquina(idMaquina)
);

create table LeituraDisco(
idDisco int primary key auto_increment,
tamanho double,
leituras double,
bytesLeitura double,
escritas double,
bytesEscrita double,
tempoTransferencia long,
dataLeitura datetime default current_timestamp,
fkMaquina int,
foreign key (fkMaquina) references Maquina(idMaquina)
);

create table LeituraJanelas(
idJanela int primary key,
pid int,
titulo varchar(45),
totalJanelas int,
dataLeitura datetime default current_timestamp,
fkMaquina int,
foreign key (fkMaquina) references Maquina(idMaquina)
);

create table LeituraCPU(
idCPU int primary key auto_increment,
nome varchar(100),
emUso double,
dataLeitura datetime default current_timestamp,
fkMaquina int,
foreign key (fkMaquina) references Maquina(idMaquina)
);

create table LeituraMemoriaRam(
idRam int primary key auto_increment,
emUso double,
disponivel double,
total double,
dataLeitura datetime default current_timestamp,
fkMaquina int,
foreign key (fkMaquina) references Maquina(idMaquina)
);

select * from Maquina;
select * from leituraSO;
select * from leituraDisco;
select * from leituraMemoriaRam;
select * from leituraJanelas;
select * from leituraCPU;
select * from Funcionario;






