/* Drops */

DROP TABLE IF EXISTS usuario CASCADE;
DROP TABLE IF EXISTS auxiliado CASCADE;
DROP TABLE IF EXISTS profissional_juridico CASCADE;
DROP TABLE IF EXISTS solicitacao CASCADE;
DROP TABLE IF EXISTS mensagem CASCADE;
DROP VIEW IF EXISTS visao_geral CASCADE;

/* Creates */

CREATE TABLE usuario (
	nome varchar(60),
	cpf bigint PRIMARY KEY,
	senha varchar(30)
);

CREATE TABLE auxiliado (
	cpf_usuario bigint REFERENCES usuario(cpf) PRIMARY KEY,
	ctps bigint,
	rg bigint,
	numero_telefone int,
	data_nascimento date
);

CREATE TABLE profissional_juridico (
	cpf_usuario bigint REFERENCES usuario(cpf) PRIMARY KEY,
	numero_oab bigint
);

CREATE TABLE solicitacao (
	codigo serial PRIMARY KEY,
	estado_atual varchar(100),
	data_abertura date,
	cpf_auxiliado bigint REFERENCES auxiliado(cpf_usuario),
	cpf_profissional bigint REFERENCES profissional_juridico(cpf_usuario)
);

CREATE TABLE mensagem (
	codigo serial PRIMARY KEY,
	codigo_solicitacao serial REFERENCES solicitacao(codigo),
	texto varchar(255),
	data_envio timestamp,
	cpf_remetente bigint REFERENCES usuario(cpf)
);

CREATE VIEW visao_geral AS (
	SELECT
		usuario.nome AS usuario_nome,
		usuario.cpf AS usuario_cpf,
		usuario.senha AS usuario_senha,
		auxiliado.cpf_usuario AS auxiliado_cpf_usuario,
		auxiliado.ctps AS auxiliado_ctps,
		auxiliado.rg AS auxiliado_rg,
		auxiliado.numero_telefone AS auxiliado_numero_telefone,
		auxiliado.data_nascimento AS auxiliado_data_nascimento,
		profissional_juridico.cpf_usuario AS profissional_cpf_usuario,
		profissional_juridico.numero_oab AS profissional_numero_oab,
		solicitacao.codigo AS solicitacao_codigo,
		solicitacao.estado_atual AS solicitacao_estado_atual,
		solicitacao.data_abertura AS solicitacao_data_abertura,
		solicitacao.cpf_auxiliado AS solicitacao_cpf_auxiliado,
		solicitacao.cpf_profissional AS solicitacao_cpf_profissional,
		mensagem.codigo AS mensagem_codigo,
		mensagem.codigo_solicitacao AS mensagem_codigo_solicitacao,
		mensagem.texto AS mensagem_texto,
		mensagem.data_envio AS mensagem_data_envio,
		mensagem.cpf_remetente AS mensagem_cpf_remetente
		FROM usuario
		RIGHT JOIN auxiliado ON auxiliado.cpf_usuario = usuario.cpf
		LEFT JOIN profissional_juridico ON profissional_juridico.cpf_usuario = auxiliado.cpf_usuario
		LEFT JOIN solicitacao ON solicitacao.cpf_auxiliado = auxiliado.cpf_usuario
		LEFT JOIN mensagem ON mensagem.codigo_solicitacao = solicitacao.codigo
		WHERE mensagem.cpf_remetente = solicitacao.cpf_auxiliado
) UNION ALL (
	SELECT
		usuario.nome AS usuario_nome,
		usuario.cpf AS usuario_cpf,
		usuario.senha AS usuario_senha,
		auxiliado.cpf_usuario AS auxiliado_cpf_usuario,
		auxiliado.ctps AS auxiliado_ctps,
		auxiliado.rg AS auxiliado_rg,
		auxiliado.numero_telefone AS auxiliado_numero_telefone,
		auxiliado.data_nascimento AS auxiliado_data_nascimento,
		profissional_juridico.cpf_usuario AS profissional_cpf_usuario,
		profissional_juridico.numero_oab AS profissional_numero_oab,
		solicitacao.codigo AS solicitacao_codigo,
		solicitacao.estado_atual AS solicitacao_estado_atual,
		solicitacao.data_abertura AS solicitacao_data_abertura,
		solicitacao.cpf_auxiliado AS solicitacao_cpf_auxiliado,
		solicitacao.cpf_profissional AS solicitacao_cpf_profissional,
		mensagem.codigo AS mensagem_codigo,
		mensagem.codigo_solicitacao AS mensagem_codigo_solicitacao,
		mensagem.texto AS mensagem_texto,
		mensagem.data_envio AS mensagem_data_envio,
		mensagem.cpf_remetente AS mensagem_cpf_remetente
		FROM usuario
		LEFT JOIN auxiliado ON auxiliado.cpf_usuario = usuario.cpf
		RIGHT JOIN profissional_juridico ON profissional_juridico.cpf_usuario = usuario.cpf
		LEFT JOIN solicitacao ON solicitacao.cpf_profissional = profissional_juridico.cpf_usuario
		LEFT JOIN mensagem ON mensagem.codigo_solicitacao = solicitacao.codigo
		WHERE mensagem.cpf_remetente != solicitacao.cpf_auxiliado
);

/* Inserts */

INSERT INTO usuario (
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
), (
	'Ruth',
	28347,
	'dri'
), (
	'Bruno',
	48903,
	'ninn'
), (
	'Leonardo',
	78923,
	'jack'
), (
	'Paloma',
	93483,
	'99037'
), (
	'Daniela',
	93846,
	'hbby'
), (
	'May',
	94582,
	'889236'
), (
	'George',
	67384,
	'hhype'
), (
	'Larissa',
	78374,
	'uleka'
);

INSERT INTO auxiliado (
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
	'1999-08-30'
), (
	11223,
	4587845,
	2458789,
	9365654,
	'1998-02-19'
), (
	48903,
	1231445,
	4535636,
	97522342,
	'1990-05-30'
), (
	78923,
	3578549,
	8752566,
	9752664,
	'1991-08-30'
), (
	93483,
	3578549,
	8752566,
	9752664,
	'1991-08-30'
), (
	94582,
	3578549,
	8752566,
	9752664,
	'1991-08-30'
), (
	78374,
	3578549,
	8752566,
	9752664,
	'1991-08-30'
);

INSERT INTO profissional_juridico (
	cpf_usuario,
	numero_oab
) values (
	1556785,
	5667
), (
	12312,
	6534
), (
	28347,
	3456
), (
	93846,
	9874
), (
	67384,
	4859
);

INSERT INTO solicitacao (
	estado_atual,
	data_abertura,
	cpf_auxiliado,
	cpf_profissional
) VALUES (
	'ABERTO',
	'2020-03-01',
	342353,
	1556785
), (
	'ABERTO',
	'2020-03-02',
	11223,
	12312
), (
	'FECHADO',
	'2020-03-03',
	11557,
	1556785
), (
	'FECHADO',
	'2020-04-12',
	93483,
	67384
), (
	'FECHADO',
	'2020-04-15',
	94582,
	28347
), (
	'ABERTO',
	'2020-05-04',
	48903,
	28347
), (
	'FECHADO',
	'2020-06-15',
	78923,
	67384
), (
	'FECHADO',
	'2020-06-17',
	78374,
	93846
), (
	'ABERTO',
	'2020-07-11',
	78374,
	NULL
);

INSERT INTO mensagem (
	codigo_solicitacao,
	texto,
	data_envio,
	cpf_remetente
) VALUES (
	1,
	'Tenho dívidas pendentes como cheque especial e outros débitos.',
	'2020-03-01 09:31:23',
	342353
), (
	1,
	'Esses débitos serão automaticamente cobrados quando o auxílio for depositado?',
	'2020-03-01 09:31:45',
	342353
), (
	1,
	'Não.',
	'2020-03-01 11:49:49',
	1556785
), (
	1,
	'O valor do auxílio não será usado para amortizar débitos anteriores.',
	'2020-03-01 11:50:06',
	1556785
), (
	1,
	'Ele ficará blindado em sua conta.',
	'2020-03-01 11:50:34',
	1556785
), (
	1,
	'Trata-se de um auxílio emergencial para ajudar no sustento das famílias nesse período de excepcionalidade',
	'2020-03-01 11:51:09',
	1556785
), (
	2,
	'Recebo pensão por morte do INSS. Não tenho outra renda, sou diarista e pago aluguel.',
	'2020-03-02 15:27:20',
	11223
), (
	2,
	'Tenho direito ao benefício do auxílio emergencial?',
	'2020-03-02 15:27:36',
	11223
), (
	2,
	'Não.',
	'2020-03-02 10:19:58',
	12312
), (
	2,
	'Os titulares de benefício da Previdência Social não podem receber o auxílio emergencial.',
	'2020-03-02 10:20:18',
	12312
), (
	2,
	'Mesmo que preencham todas as outras condições para isso.',
	'2020-03-02 10:20:32',
	12312
), (
	3,
	'Meu marido é aposentado, mas eu não sou.',
	'2020-03-03 21:18:25',
	11557
), (
	3,
	'Estou desempregada.',
	'2020-03-03 21:18:36',
	11557
), (
	3,
	'Posso pedir o auxílio emergencial?',
	'2020-03-03 21:18:54',
	11557
), (
	3,
	'Sim, se cumprir as condições.',
	'2020-03-04 09:11:02',
	1556785
), (
	4,
	'Fui tentar o auxílio e sigo todos os pré requisitos, mas da erro na RAIS.',
	'2020-04-12 09:11:02',
	93483
), (
	4,
	'Faz quanto tempo desde o último contrato?',
	'2020-04-12 10:12:00',
	67384	
), (
	4,
	'Dois meses antes do auxílio, era servidor público.',
	'2020-04-12 10:15:02',
	93483
), (
	4,
	'Pela lei a RAIS deve ser atualizada anualmente. Tente entrar em contato com a empresa ou órgão que foi contratado.',
	'2020-04-12 10:22:00',
	67384	
), (
	4,
	'Liguei para o setor de rh e não consegui resolver.',
	'2020-04-12 15:11:02',
	93483
), (
	4,
	'Nesse caso um processo será necessário.',
	'2020-04-12 15:22:00',
	67384	
), (
	4,
	'Como devo proceder nesse período de pandemia?',
	'2020-04-12 15:31:02',
	93483
), (
	4,
	'Entre em contato com a defensoria pública, através do email def@estado.com. E mande as cópias de seus documentos.',
	'2020-04-12 15:42:00',
	67384	
), (
	4,
	'Entrarei em contato.',
	'2020-04-12 16:00:02',
	93483
), (
	5,
	'Não entendo, me encaixo em todos os requisitos para o auxílio e o mesmo foi negado.',
	'2020-04-15 11:11:02',
	94582
), (
	5,
	'Qual a renda familiar bruta?',
	'2020-04-15 11:21:04',
	28347
), (
	5,
	'Como assim?',
	'2020-04-15 11:25:11',
	94582
), (
	5,
	'Somando a renda de todos que trabalham de carteira assinada ou recebe algum auxílio.',
	'2020-04-15 11:29:04',
	28347
), (
	5,
	'Só minha esposa trabalha, a renda é de R$3,500.',
	'2020-04-15 11:33:14',
	94582
), (
	5,
	'No seu caso a renda mensal é maior que a necessária para o auxílio.',
	'2020-04-15 11:35:04',
	28347
), (
	5,
	'Ok, obrigado.',
	'2020-04-15 11:41:02',
	94582
), (
	6,
	'Sofri um acidente mas a carteira não era assinada.',
	'2020-05-04 08:15:02',
	48903
), (
	6,
	'E qual foi a posição da empresa?',
	'2020-05-04 11:00:33',
	28347
), (
	6,
	'Não estão me dando uma resposta direta e estou sem receber.',
	'2020-05-04 11:15:02',
	48903
), (
	6,
	'Tem como comprovar que estava trabalhando nesse período?',
	'2020-05-04 11:20:33',
	28347
), (
	6,
	'Tenho alguns contracheques assinados, e algumas conversas com o chefe salvas.',
	'2020-05-04 11:35:02',
	48903
), (
	6,
	'A senhora pode entrar com um processo contra e empresa, guarde essas provas pois serão necessárias e entre em contato com a defensoria pública.',
	'2020-05-04 12:00:33',
	28347
), (
	6,
	'Ok, Obrigada.',
	'2020-05-04 12:15:02',
	48903
), (
	7,
	'Meu contrato acabou e percebi que não recebi meu fgts, é normal?',
	'2020-06-15 11:41:02',
	78923
), (
	7,
	'Não, entre em contato com a empresa. Se não chegar a um acordo denuncie.',
	'2020-06-15 11:51:02',
	67384
), (
	7,
	'Tem mais de 5 meses que sai, ainda consigo?',
	'2020-06-15 11:55:02',
	78923
), (
	7,
	'Pode ser solicitado mesmo até um ano depois do desligamento.',
	'2020-06-15 11:57:02',
	67384
), (
	7,
	'Obrigado',
	'2020-06-15 11:59:15',
	78923
), (
	8,
	'Fui aprovado mais não recebi o auxilio. Como proceder?',
	'2020-06-17 15:06:01',
	78374
), (
	8,
	'A caixa está liberando em lotes, se foi por agora é só aguardar que já deve cair no aplicativo da Caixa.',
	'2020-06-17 15:41:02',
	93846
), (
	8,
	'Ok',
	'2020-06-17 16:02:11',
	78374
), (
	9,
	'Saiu outro lote e ainda não recebi, o que faço?',
	'2020-07-11 15:16:01',
	78374
);
