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
check (turno in('manha', 'tarde', 'noite')),
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

/*create table infoPc(
idPc int primary key auto_increment,
sistemaOperacional varchar(100),
memoriaUso Long,
discoUso Long,
fkMaquina int);
select * from empresa;
select * from funcionario; */

create table leituraSO(
idSO int primary key auto_increment,
nome varchar(45),
tempoAtividade long,
dataLeitura datetime default current_timestamp,
fkMaquina int,
foreign key (fkMaquina) references Maquina(idMaquina)
);

create table leituraDisco(
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

create table leituraRede(
idRede int primary key auto_increment,
nome varchar(70),
bytesRecebidos long,
bytesEnviados long,
pacotesRecebidos long,
pacotesEnviados long,
dataLeitura datetime default current_timestamp,
fkMaquina int,
foreign key (fkMaquina) references Maquina(idMaquina)
);

create table leituraCPU(
idCPU int primary key auto_increment,
nome varchar(100),
emUso double,
temp double,
dataLeitura datetime default current_timestamp,
fkMaquina int,
foreign key (fkMaquina) references Maquina(idMaquina)
);

create table leituraMemoriaRam(
idRam int primary key auto_increment,
emUso double,
total double,
dataLeitura datetime default current_timestamp,
fkMaquina int,
foreign key (fkMaquina) references Maquina(idMaquina)
);

select * from Maquina;
select * from leituraSO;
select * from leituraDisco;
select * from leituraMemoriaRam;
select * from leituraRede;
select * from leituraCPU;
select * from Funcionario;
select * from sala;
select * from historicomanutencao;

-- Componentes em falta
select nomeComponente, preco from Componentes where quantidade = 0;
--  Manutenções recorrentes
select tipo, count(tipo) from HistoricoManutencao group by tipo;
-- Computadores reservas
select count(hostname) from Maquina where fkSala = null;
-- Computadores inoperantes a mais de 1 dia 
select count(m.hostname) from Maquina m join leituracpu l where l.fkMaquina = m.idMaquina and l.dataLeitura < day(now()); 
-- Computadores sem limpeza a mais de 6 meses
SELECT COUNT(DISTINCT h.fkMaquina) 
FROM historicomanutencao h 
WHERE h.tipo = 'Limpeza' 
  AND h.Dia <= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- Leitura cpu para plotar no gráfico
select s.tempoAtividade, c.emUso, c.temp from leituracpu c join leituraso s where c.fkMaquina = s.fkMaquina order by c.dataLeitura limit 7;

-- Leitura ram para plotar no gráfico
select r.emUso, r.total from leituramemoriaram r join Maquina m where r.fkMaquina = m.idMaquina order by r.dataLeitura limit 7;











