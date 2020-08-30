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