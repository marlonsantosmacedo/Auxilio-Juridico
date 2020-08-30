/* Drops */

DROP TABLE IF EXISTS USUARIO;
DROP TABLE IF EXISTS PROFISSIONAL_JURIDICO;
DROP TABLE IF EXISTS AUXILIADO;
DROP TABLE IF EXISTS SOLICITACAO;
DROP TABLE IF EXISTS MENSAGEM;

/* Creates */

CREATE TABLE USUARIO (
	nome varchar(60),
	cpf bigint PRIMARY KEY,
	senha varchar(30)
);


CREATE TABLE PROFISSIONAL_JURIDICO (
	cpf_usuario bigint REFERENCES USUARIO(cpf) PRIMARY KEY,
	numero_oab bigint
);

CREATE TABLE AUXILIADO (
	cpf_usuario bigint REFERENCES USUARIO(cpf) PRIMARY KEY,
	ctps bigint,
	rg bigint,
	numero_telefone int,
	data_nascimento date
);

CREATE TABLE SOLICITACAO (
	codigo serial PRIMARY KEY,
	estado_atual varchar(100),
	data_abertura date,
	cpf_auxiliado bigint REFERENCES AUXILIADO(cpf_usuario),
	cpf_profissional bigint REFERENCES PROFISSIONAL_JURIDICO(cpf_usuario)
);

CREATE TABLE MENSAGEM (
	codigo serial PRIMARY KEY,
	codigo_solicitacao serial REFERENCES SOLICITACAO(codigo),
	texto varchar(255),
	data_envio timestamp,
	cpf_remetente bigint REFERENCES USUARIO(cpf)
);

/* Inserts */

INSERT INTO USUARIO (
	nome,
	cpf,
	senha
) VALUES (
	'Cleiton Rasta',
	1556785,
	'rasta'
), (
	'Emanuel',
	342353,
	'1557'
), (
	'Juscileide',
	11557,
	'777'
), (
	'Maria',
	12312,
	'lola'
), (
	'Marlon',
	45324,
	'edge'
), (
	'Lucas',
	11223,
	'tchola'
);

INSERT INTO AUXILIADO (
	cpf_usuario,
	ctps,
	rg,
	numero_telefone,
	data_nascimento
) VALUES (
	342353,
	1328946,
	1245879,
	9997872,
	'1978-09-23'
), (
	11557,
	2454789,
	8530267,
	9959752,
	'1988-11-01'
), (
	45324,
	3578549,
	8752566,
	9752664,
	'1991-08-30'
), (
	11223,
	4587845,
	2458789,
	9365654,
	'1979-02-19'
);

INSERT INTO PROFISSIONAL_JURIDICO (
	cpf_usuario,
	numero_oab
) values (
	1556785,
	5667
), (
	12312,
	6534
);

INSERT INTO SOLICITACAO (
	estado_atual,
	data_abertura,
	cpf_auxiliado,
	cpf_profissional
) VALUES (
	'ABERTO',
	'2021-02-21',
	342353,
	1556785
), (
	'ABERTO',
	'2021-02-28',
	11223,
	12312
), (
	'FECHADO',
	'2021-03-03',
	11557,
	1556785
);

INSERT INTO MENSAGEM (
	codigo_solicitacao,
	texto,
	data_envio,
	cpf_remetente
) VALUES (
	1,
	'Tenho dívidas pendentes como cheque especial e outros débitos.',
	'2021-02-21 09:31:23',
	342353
), (
	1,
	'Esses débitos serão automaticamente cobrados quando o auxílio for depositado?',
	'2021-02-21 09:31:45',
	342353
), (
	1,
	'Não.',
	'2021-02-21 11:49:49',
	1556785
), (
	1,
	'O valor do auxílio não será usado para amortizar débitos anteriores.',
	'2021-02-21 11:50:06',
	1556785
), (
	1,
	'Ele ficará blindado em sua conta.',
	'2021-02-21 11:50:34',
	1556785
), (
	1,
	'Trata-se de um auxílio emergencial para ajudar no sustento das famílias nesse período de excepcionalidade',
	'2021-02-21 11:51:09',
	1556785
), (
	2,
	'Recebo pensão por morte do INSS. Não tenho outra renda, sou diarista e pago aluguel.',
	'2021-02-28 15:27:20',
	11223
), (
	2,
	'Tenho direito ao benefício do auxílio emergencial?',
	'2021-02-28 15:27:36',
	11223
), (
	2,
	'Não.',
	'2021-03-01 10:19:58',
	12312
), (
	2,
	'Os titulares de benefício da Previdência Social não podem receber o auxílio emergencial.',
	'2021-03-01 10:20:18',
	12312
), (
	2,
	'Mesmo que preencham todas as outras condições para isso.',
	'2021-03-01 10:20:32',
	12312
), (
	3,
	'Meu marido é aposentado, mas eu não sou.',
	'2021-03-03 21:18:25',
	11557
), (
	3,
	'Estou desempregada.',
	'2021-03-03 21:18:36',
	11557
), (
	3,
	'Posso pedir o auxílio emergencial?',
	'2021-03-03 21:18:54',
	11557
), (
	3,
	'Sim, se cumprir as condições.',
	'2021-03-04 09:11:02',
	1556785
);