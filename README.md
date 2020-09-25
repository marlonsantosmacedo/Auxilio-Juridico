# Auxílio Jurídico
Trabalho desenvolvido durante a disciplina de BD1

# Sumário

### 1. COMPONENTES<br>
Integrantes do grupo<br>
Lucas Neves de Oliveira: lucas.7.snow@gmail.com<br>
Marlon Santos Macedo: wazymazy@gmail.com<br>

### 2. INTRODUÇÃO E MOTIVAÇÃO<br>
O Sistema “Auxílio Jurídico” tem como objetivo auxiliar juridicamente as pessoas de baixa renda na pandemia. Muitos cidadãos tiveram problemas em receber seus benefícios, como: seguro-desemprego, auxílio emergencial etc. Os cidadãos não podem sair de casa para poder resolver esses problemas, e muitos não podem pagar advogados ou nem sabem como recorrer, e é nessa hora que entra o “Auxílio Jurídico”.

### 3. MINI-MUNDO<br>

Para utilizar esse auxílio o auxiliado precisa acessar o sistema e informar seu nome, CPF, senha, CTPS (se possuir), RG, número de telefone e data de nascimento. Após isso, o auxiliado pode abrir uma ou mais solicitações. Cada solicitação possui um código único, o registro de seu estado atual, do auxiliado que a abriu, e da data em que foi aberta. Uma solicitação só pode estar vinculada a apenas um auxiliado, o que a abriu. As solicitações podem ser atendidas por advogados, que devem se cadastrar no sistema informando seu nome, CPF, senha e número do registro na OAB. Um advogado pode atender a várias solicitações, mas uma solicitação só pode ser atendida por um advogado. Após a solicitação ser atendida, o auxiliado e o advogado podem trocar mensagens, que possuem um código único, o texto enviado, a data de envio e o remetente, que pode ser tanto um auxiliado, quanto um advogado. Toda mensagem deve estar vinculada a apenas uma solicitação, já as solicitações podem possuir várias mensagens. Durante o processo, o estado da solicitação pode ser alterada pelo advogado para indicar se está em aguardando atendimento, em andamento, aguardando informações ou finalizada.

### 4. PROTOTIPAÇÃO, PERGUNTAS A SEREM RESPONDIDAS E TABELA DE DADOS<br>
#### 4.1. RASCUNHOS BÁSICOS DA INTERFACE (MOCKUPS)<br>
![Imagem de mockup do sistema Auxílio Jurídico](https://github.com/marlonsantosmacedo/Auxilio-Juridico/blob/master/imagens/mockup.jpeg?raw=true)
[Arquivo PDF do Protótipo Balsamiq feito para Auxílio Jurídico](https://github.com/marlonsantosmacedo/Auxilio-Juridico/blob/master/arquivos/Auxílio%20Jurídico.pdf?raw=true)

#### 4.2 QUAIS PERGUNTAS PODEM SER RESPONDIDAS COM O SISTEMA PROPOSTO? 
> O sistema Auxílio Jurídico utiliza principalmente as seguintes consultas:
* Buscar um auxiliado por nome de usuário.
* Listar solicitações abertas por um auxiliado.
* Listar solicitações não atendidas por nenhum profissional.
* Listar solicitações em aberto atendidas por um profissional jurídico.
* Listar mensagens de ligadas a uma solicitação.
 
#### 4.3 TABELA DE DADOS DO SISTEMA:
[Tabela de dados do Auxílio Jurídico](https://github.com/marlonsantosmacedo/Auxilio-Juridico/blob/master/arquivos/tabela-completa.xlsx?raw=true)
    
### 5.MODELO CONCEITUAL<br>
![Modelo conceitual do Auxílio Jurídico](https://github.com/marlonsantosmacedo/Auxilio-Juridico/blob/master/imagens/modeloconceitual.png?raw=true)
    
#### 5.1 Validação do Modelo Conceitual
    ATVGen: Matheus Costa Evangelista, Natan Paschoal Cypriano, Rafael de Almeida Viana Gusmão.
    Não tiveram observação.

#### 5.2 Descrição dos dados 
    USUARIO: É a tabela responsável por armazenar os dados cruciais usuário (nome, cpf e senha).
    AUXILIADO: Tabela responsável por armazenar os dados de quem é auxiliado (CTPS, RG, telefone e data de nascimento) e o usuário ao qual está atrelado.
    PROFISSIONAL_JURIDICO: Responsável por armazenar o nº OAB do profissional e o usuário ao qual está atrelado.
    SOLICITACAO: Contém os dados da solicitação (código, estado atual e data de abertura).
    MENSAGEM: Armazena os dados das mensagens (código, texto e data de envio) e quem são os remetentes.

### 6	MODELO LÓGICO<br>
![Modelo lógico do Auxílio Jurídico](https://github.com/marlonsantosmacedo/Auxilio-Juridico/blob/master/imagens/modelologico.png?raw=true)

### 7	MODELO FÍSICO<br>
```sql
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
```
        
       
### 8	INSERT APLICADO NAS TABELAS DO BANCO DE DADOS<br>
[Arquivo com drops, creates e inserts.](https://github.com/marlonsantosmacedo/Auxilio-Juridico/blob/master/arquivos/drops_creates_e_inserts.sql?raw=true)

### 9	TABELAS E PRINCIPAIS CONSULTAS<br>
#### 9.1	CONSULTAS DAS TABELAS COM TODOS OS DADOS INSERIDOS (Todas) <br>
[Visualizar em tempo real no Colab](https://colab.research.google.com/drive/1j0ICDi_BpbP6BwfdsQ4bEc74kuqLuRNM?usp=sharing) <br>
[Visualizar em tempo real no GitHub](https://github.com/marlonsantosmacedo/Auxilio-Juridico/blob/master/arquivos/AuxilioJuridico_tabelas.ipynb)

># Marco de Entrega 01: Do item 1 até o item 9.1<br>

#### 9.2	CONSULTAS DAS TABELAS COM FILTROS WHERE (Mínimo 4)<br>
```sql
SELECT * FROM usuario WHERE nome = 'Emanuel';
SELECT * FROM profissional_juridico WHERE numero_oab = 5667;
SELECT * FROM mensagem WHERE codigo < 9;
SELECT * FROM solicitacao WHERE estado_atual = 'FECHADO';
```

#### 9.3	CONSULTAS QUE USAM OPERADORES LÓGICOS, ARITMÉTICOS E TABELAS OU CAMPOS RENOMEADOS (Mínimo 11)
```
a) Criar 5 consultas que envolvam os operadores lógicos AND, OR e Not
```

```sql
SELECT * FROM solicitacao WHERE estado_atual = 'ABERTO' AND data_abertura > '2020-03-02';
SELECT * FROM solicitacao WHERE estado_atual = 'ABERTO' OR data_abertura > '2020-06-01';
SELECT * FROM mensagem WHERE NOT codigo_solicitacao = 1;
SELECT * FROM mensagem WHERE codigo != 5 AND codigo_solicitacao != 2;
SELECT * FROM usuario WHERE NOT nome = 'Lucas' AND cpf > 20000;
```

```
b) Criar no mínimo 3 consultas com operadores aritméticos 
```

```sql
SELECT codigo, (cpf_auxiliado - cpf_profissional) AS cpf_subtraido FROM solicitacao;
SELECT data_envio, (cpf_remetente / codigo_solicitacao) AS cpf_div_cod_pr FROM mensagem;
SELECT data_envio, (cpf_remetente * codigo) AS cpf_mult_cod FROM mensagem;
```

```
c) Criar no mínimo 3 consultas com operação de renomear nomes de campos ou tabelas
```

```sql
SELECT cpf_usuario AS cpf, numero_oab AS oab FROM profissional_juridico;
SELECT cpf_usuario AS cpf, ctps AS carteira_de_trabalho FROM auxiliado;
SELECT codigo_solicitacao AS cod_solicitacao, data_envio FROM mensagem;
```

#### 9.4	CONSULTAS QUE USAM OPERADORES LIKE E DATAS (Mínimo 12) <br>
```
a) Criar outras 5 consultas que envolvam like ou ilike
```

```sql 	
SELECT * FROM usuario WHERE nome ILIKE 'e%';
SELECT * FROM usuario WHERE nome ILIKE '%a';
SELECT * FROM solicitacao WHERE estado_atual ILIKE 'a%';
SELECT * FROM mensagem WHERE texto ILIKE '%a_';
SELECT * FROM usuario WHERE senha LIKE '%7';
```

```
b) Criar uma consulta para cada tipo de função data apresentada.
```
    
```sql
SELECT codigo, current_date - (data_envio) AS tempo_envio FROM mensagem;

SELECT codigo, current_date - (data_abertura) AS tempo_abertura FROM solicitacao;

/* Não temos colunas do tipo "time" nas tabelas */

SELECT NOW(), current_date - (data_abertura) AS tempo_abertura FROM solicitacao;

SELECT cpf_usuario, DATE_PART('year', (AGE(current_date, data_nascimento))) AS idade FROM auxiliado;

SELECT NOW(), data_envio FROM mensagem;

SELECT cpf_usuario, EXTRACT('month' FROM data_nascimento) AS mes_aniversario FROM auxiliado;

SELECT cpf_usuario, EXTRACT('year' FROM data_nascimento) AS ano_nascimento FROM auxiliado;
```


#### 9.5	INSTRUÇÕES APLICANDO ATUALIZAÇÃO E EXCLUSÃO DE DADOS (Mínimo 6)<br>
```
a) Criar minimo 3 de exclusão
```

```sql
DELETE FROM mensagem WHERE codigo = 12;
DELETE FROM mensagem WHERE codigo = 1 AND cpf_remetente = 342353;
DELETE FROM mensagem WHERE data_envio = '2020-04-12 16:00:02';
```

```
b) Criar minimo 3 de atualização
```

```sql
UPDATE usuario SET nome = 'Lucas Neves' WHERE nome = 'Lucas';
UPDATE solicitacao SET estado_atual = 'FECHADO' WHERE codigo = 1;
UPDATE usuario SET senha = '765' WHERE nome = 'Cleiton Rasta';
```

#### 9.6	CONSULTAS COM INNER JOIN E ORDER BY (Mínimo 6)<br>
```
a) Uma junção que envolva todas as tabelas possuindo no mínimo 2 registros no resultado
```

```sql
/* Todas as mensagens enviadas por auxiliados e o nome do remetente e do destinatário, ordenadas por data de envio (crescente): */
SELECT mensagem.texto, usuario_auxiliado.nome AS remetente, usuario_profissional.nome AS destinatario
	FROM usuario AS usuario_auxiliado
	INNER JOIN auxiliado ON auxiliado.cpf_usuario = usuario_auxiliado.cpf
	INNER JOIN mensagem ON mensagem.cpf_remetente = auxiliado.cpf_usuario
	INNER JOIN solicitacao ON solicitacao.codigo = mensagem.codigo_solicitacao
	LEFT JOIN profissional_juridico ON profissional_juridico.cpf_usuario = solicitacao.cpf_profissional
	INNER JOIN usuario AS usuario_profissional ON usuario_profissional.cpf = profissional_juridico.cpf_usuario
	ORDER BY mensagem.data_envio ASC;
```

```
b) Outras junções que o grupo considere como sendo as de principal importância para o trabalho
```

```sql
/* Todas as mensagens em uma solicitação, ordenadas por data de envio (decrescente): */
SELECT mensagem.*
	FROM mensagem
	INNER JOIN solicitacao ON solicitacao.codigo = mensagem.codigo_solicitacao
	WHERE solicitacao.codigo = 1
	ORDER BY mensagem.data_envio DESC;

/* Solicitações em aberto e o nome do auxiliado, ordenadas por data de abertura (decrescente): */
SELECT usuario.nome AS auxiliado, solicitacao.*
	FROM usuario
	INNER JOIN solicitacao ON solicitacao.cpf_auxiliado = usuario.cpf
	WHERE solicitacao.estado_atual = 'ABERTO'
	ORDER BY solicitacao.data_abertura DESC;

/* Todas as mensagens enviadas por um usuário específico, ordenadas por data de envio (crescente): */
SELECT mensagem.*
	FROM mensagem
	INNER JOIN usuario ON usuario.cpf = mensagem.cpf_remetente
	WHERE usuario.cpf = 11557
	ORDER BY mensagem.data_envio ASC;

/* Todas as solicitações atendidas por um profissional específico junto de seu registro na OAB, ordenadas por data de abertura (decrescente): */
SELECT profissional_juridico.numero_oab, solicitacao.*
	FROM solicitacao
	INNER JOIN profissional_juridico ON profissional_juridico.cpf_usuario = solicitacao.cpf_profissional
	WHERE profissional_juridico.cpf_usuario = 1556785
	ORDER BY solicitacao.data_abertura DESC;

/* Todas as solicitações criadas por um usuário específico e a quantidade de mensagens nelas, por data de abertura (crescente): */
SELECT solicitacao.*, COUNT(mensagem.*) AS mensagens
	FROM solicitacao
	INNER JOIN mensagem ON mensagem.codigo_solicitacao = solicitacao.codigo
	WHERE solicitacao.cpf_auxiliado = 342353
	GROUP BY solicitacao.codigo
	ORDER BY solicitacao.data_abertura ASC;
```

#### 9.7	CONSULTAS COM GROUP BY E FUNÇÕES DE AGRUPAMENTO (Mínimo 6)<br>
```
a) Criar minimo 2 envolvendo algum tipo de junção
```

```sql
/* Todas as solicitações e a quantidade de mensagens nelas: */
SELECT solicitacao.*, COUNT(mensagem.*) AS mensagens
	FROM solicitacao
	INNER JOIN mensagem ON mensagem.codigo_solicitacao = solicitacao.codigo
	GROUP BY solicitacao.codigo;
	
/* Nome e número da OAB de todos os profissionais e o número de solicitações atendidas por eles: */
SELECT usuario.nome, profissional_juridico.numero_oab, COUNT(solicitacao.*) AS solicitacoes
	FROM profissional_juridico
	INNER JOIN usuario ON usuario.cpf = profissional_juridico.cpf_usuario
	INNER JOIN solicitacao ON solicitacao.cpf_profissional = usuario.cpf
	GROUP BY usuario.cpf, profissional_juridico.numero_oab;
	
/* A quantidade de mensagens que cada usuário enviou: */
SELECT usuario.nome, COUNT(mensagem.*)
	FROM usuario
	INNER JOIN mensagem ON mensagem.cpf_remetente = usuario.cpf
	GROUP BY usuario.cpf;
	
/* Quantidade de auxiliados por década de nascimento: */
SELECT EXTRACT(DECADE FROM auxiliado.data_nascimento) AS decada, COUNT(auxiliado.*) AS auxiliados
	FROM auxiliado
	GROUP BY EXTRACT(DECADE FROM auxiliado.data_nascimento);
	
/* Quantidade de mensagens enviadas por data: */
SELECT mensagem.data_envio::date, COUNT(mensagem.*)
	FROM mensagem
	GROUP BY mensagem.data_envio::date;
	
/* Quantidade de solicitações abertas por mês e ano: */
SELECT EXTRACT(YEAR FROM solicitacao.data_abertura) AS ano, EXTRACT(MONTH FROM solicitacao.data_abertura) AS mes, COUNT(solicitacao.*)
	FROM solicitacao
	GROUP BY EXTRACT(YEAR FROM solicitacao.data_abertura), EXTRACT(MONTH FROM solicitacao.data_abertura);
```

#### 9.8	CONSULTAS COM LEFT, RIGHT E FULL JOIN (Mínimo 4)<br>
```
a) Criar minimo 1 de cada tipo
```

```sql
SELECT codigo_solicitacao, data_envio, solicitacao.estado_atual, solicitacao.data_abertura
	FROM mensagem
	RIGHT OUTER JOIN solicitacao ON (mensagem.codigo_solicitacao = solicitacao.codigo);

SELECT usuario.nome, usuario.cpf, numero_oab
	FROM usuario
	LEFT OUTER JOIN profissional_juridico ON (profissional_juridico.cpf_usuario = usuario.cpf)
	WHERE profissional_juridico.numero_oab IS NOT NULL;

SELECT usuario.nome,usuario.cpf, auxiliado.ctps, auxiliado.rg, auxiliado.numero_telefone
	FROM usuario
	FULL OUTER JOIN auxiliado ON (usuario.cpf = auxiliado.cpf_usuario)
	WHERE auxiliado.ctps IS NOT NULL;

SELECT usuario.nome AS profissional, solicitacao.codigo, solicitacao.estado_atual AS caso, solicitacao.data_abertura
	FROM usuario
	FULL OUTER JOIN solicitacao ON (usuario.cpf = solicitacao.cpf_profissional)
	WHERE solicitacao.codigo IS NOT NULL;
```

#### 9.9	CONSULTAS COM SELF JOIN E VIEW (Mínimo 6)<br>
```
a) Uma junção que envolva Self Join (caso não ocorra na base justificar e substituir por uma view)
```

```
Não é possível fazer self-join na base de dados do Auxílio Jurídico pois não há nenhum auto-relacionamento.
```

```
b) Outras junções com views que o grupo considere como sendo de relevante importância para o trabalho
```

```sql
/* Solicitações disponíveis para serem atendidas e nome do auxiliado, ordenadas por data de abertura (decrescente): */
CREATE VIEW solicitacoes_disponiveis AS
	SELECT usuario.nome AS auxiliado, solicitacao.*
	FROM usuario
	INNER JOIN solicitacao ON solicitacao.cpf_auxiliado = usuario.cpf
	WHERE solicitacao.cpf_profissional IS NULL AND solicitacao.estado_atual = 'ABERTO'
	ORDER BY solicitacao.data_abertura DESC;
	
/* Solicitações e dados da última mensagem enviada em cada uma delas: */
CREATE VIEW conversas AS
	SELECT solicitacao.*, mensagem.texto AS texto_mensagem, mensagem.data_envio AS data_envio_mensagem, mensagem.cpf_remetente AS remetente_mensagem
	FROM solicitacao
	INNER JOIN mensagem ON mensagem.codigo_solicitacao = solicitacao.codigo
	WHERE mensagem.codigo IN (
		SELECT MAX(codigo)
			FROM mensagem
			GROUP BY codigo_solicitacao
	);
	
/* Auxiliados e seus dados de usuário (para login etc.): */
CREATE VIEW usuario_auxiliado AS
	SELECT *
	FROM auxiliado
	LEFT JOIN usuario ON usuario.cpf = auxiliado.cpf_usuario;
	
	
/* Profissionais jurídicos e seus dados de usuário (para login etc.): */
CREATE VIEW usuario_profissional AS
	SELECT *
	FROM profissional_juridico
	LEFT JOIN usuario ON usuario.cpf = profissional_juridico.cpf_usuario;
	
/* Solicitações e dados dos profissionais que as atenderam: */
CREATE VIEW solicitacao_profissional AS
	SELECT solicitacao.*, profissional_juridico.numero_oab, usuario.nome AS nome_profissional
	FROM solicitacao
	LEFT JOIN profissional_juridico ON profissional_juridico.cpf_usuario = solicitacao.cpf_profissional
	LEFT JOIN usuario ON usuario.cpf = profissional_juridico.cpf_usuario;
	
/* Solicitações e nome e CPF dos auxiliados que as criaram: */
CREATE VIEW solicitacao_auxiliado AS
	SELECT solicitacao.*, usuario.nome AS nome_auxiliado
	FROM solicitacao
	LEFT JOIN usuario ON usuario.cpf = solicitacao.cpf_auxiliado;
```


#### 9.10	SUBCONSULTAS (Mínimo 4)<br>
```
a) Criar minimo 1 envolvendo GROUP BY
b) Criar minimo 1 envolvendo algum tipo de junção
```

```sql
/* Solicitações e dados da última mensagem enviada em cada uma delas: */
SELECT *
	FROM solicitacao
	INNER JOIN mensagem ON mensagem.codigo_solicitacao = solicitacao.codigo
	WHERE mensagem.codigo IN (
		SELECT MAX(codigo)
			FROM mensagem
			GROUP BY codigo_solicitacao
	);

/* Nome e idade dos auxiliados que estão acima da média de idade entre os auxiliados: */
SELECT usuario.nome, DATE_PART('year', AGE(NOW(), auxiliado.data_nascimento)) as idade
	FROM usuario
	INNER JOIN auxiliado ON auxiliado.cpf_usuario = usuario.cpf
	WHERE AGE(NOW(), auxiliado.data_nascimento) > (
		SELECT AVG(AGE(NOW(), data_nascimento))
			FROM auxiliado
	);
	
/* Nome e quantidade de mensagens dos usuários que mais enviaram mensagens: */
SELECT usuario.nome, COUNT(mensagem.*)
	FROM usuario
	LEFT JOIN mensagem ON mensagem.cpf_remetente = usuario.cpf
	GROUP BY usuario.cpf
	HAVING COUNT(mensagem.*) = (
		SELECT COUNT(*)
			FROM mensagem
			GROUP BY cpf_remetente
			ORDER BY COUNT(*) DESC
			LIMIT 1
	);

/* Nome e quantidade de solicitações atendidas dos profissionais que mais atenderam solicitações: */
SELECT usuario.nome, COUNT(solicitacao.*) AS solicitacoes_atendidas
	FROM profissional_juridico
	LEFT JOIN usuario ON usuario.cpf = profissional_juridico.cpf_usuario
	INNER JOIN solicitacao ON solicitacao.cpf_profissional = usuario.cpf
	GROUP BY usuario.cpf
	HAVING COUNT(solicitacao.*) = (
		SELECT COUNT(*)
			FROM solicitacao
			GROUP BY cpf_profissional
			ORDER BY COUNT(*) DESC
			LIMIT 1
	);
```

># Marco de Entrega 02: Do item 9.2 até o ítem 9.10<br>

### 10 RELATÓRIOS E GRÁFICOS

#### a) análises e resultados provenientes do banco de dados desenvolvido (usar modelo disponível)
#### b) link com exemplo de relatórios será disponiblizado pelo professor no AVA
#### OBS: Esta é uma atividade de grande relevância no contexto do trabalho. Mantenha o foco nos 5 principais relatórios/resultados visando obter o melhor resultado possível.

    

### 11	AJUSTES DA DOCUMENTAÇÃO, CRIAÇÃO DOS SLIDES E VÍDEO PARA APRESENTAÇAO FINAL <br>

#### a) Modelo (pecha kucha)<br>
#### b) Tempo de apresentação 6:40 

># Marco de Entrega 03: Itens 10 e 11<br>
<br>
<br>
<br> 



### 12 FORMATACAO NO GIT:<br> 
https://help.github.com/articles/basic-writing-and-formatting-syntax/
<comentario no git>
    
##### About Formatting
    https://help.github.com/articles/about-writing-and-formatting-on-github/
    
##### Basic Formatting in Git
    
    https://help.github.com/articles/basic-writing-and-formatting-syntax/#referencing-issues-and-pull-requests
    
    
##### Working with advanced formatting
    https://help.github.com/articles/working-with-advanced-formatting/
#### Mastering Markdown
    https://guides.github.com/features/mastering-markdown/

    
### OBSERVAÇÕES IMPORTANTES

#### Todos os arquivos que fazem parte do projeto (Imagens, pdfs, arquivos fonte, etc..), devem estar presentes no GIT. Os arquivos do projeto vigente não devem ser armazenados em quaisquer outras plataformas.
1. <strong>Caso existam arquivos com conteúdos sigilosos<strong>, comunicar o professor que definirá em conjunto com o grupo a melhor forma de armazenamento do arquivo.

#### Todos os grupos deverão fazer Fork deste repositório e dar permissões administrativas ao usuário do git "profmoisesomena", para acompanhamento do trabalho.

#### Os usuários criados no GIT devem possuir o nome de identificação do aluno (não serão aceitos nomes como Eu123, meuprojeto, pro456, etc). Em caso de dúvida comunicar o professor.


Link para BrModelo:<br>
http://www.sis4.com/brModelo/download.html
<br>


Link para curso de GIT<br>
![https://www.youtube.com/curso_git](https://www.youtube.com/playlist?list=PLo7sFyCeiGUdIyEmHdfbuD2eR4XPDqnN2?raw=true "Title")

