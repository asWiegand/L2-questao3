create database cadastro
default character set utf8
default collate utf8_general_ci;

use cadastro;
create table contratos(
id int not null auto_increment,
valor_parcela int,
parcelas int,
primary key(id)
) default charset = utf8;

create table pessoas(
id int not null auto_increment,
nome varchar(30),
contrato_id int,
inadimplente char(1),
dt_completo date,
primary key (id),
foreign key (contrato_id) references contratos(id)
) default charset = utf8;

create table pagamentos(
id int not null auto_increment,
pessoa_id int,
dt_pagamento date,
primary key (id),
foreign key(pessoa_id) references pessoas(id)
)default charset = utf8;

use cadastro;
insert into contratos(valor_parcela, parcelas) values
('150', '100'),
('300', '48'),
('550', '24'),
('1000', '12');

insert into pessoas(nome, contrato_id, inadimplente, dt_completo) values
('Cristian Ghyprievy', '2', 'S', NULL),
('Joana Cabel', '1', 'S', NULL),
('John Serial', '3', 'S', NULL),
('Michael Seven', '2', 'N', '2021-09-25');

insert into pagamentos (pessoa_id, dt_pagamento) values
('4', '2021-09-01'),
('3', '2021-09-05'),
('1', '2021-09-19'),
('2', '2021-09-25');

use cadastro;
select pessoas.nome as nome, date_format(pagamentos.dt_pagamento, '%d') as dia_mes, contratos.valor_parcela as valor_parcela
from pessoas
join contratos, pagamentos
where pessoas.contrato_id = contratos.id
and pessoas.id = pagamentos.pessoa_id
and pessoas.inadimplente like 'S';

use cadastro;
select pessoas.nome as nome, contratos.valor_parcela * contratos.parcelas as valor_total
from pessoas
join contratos
where pessoas.inadimplente like 'N'
and pessoas.contrato_id = contratos.id;