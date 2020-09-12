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
```
        
       
### 8	INSERT APLICADO NAS TABELAS DO BANCO DE DADOS<br>
[Arquivo com drops, creates e inserts.](https://github.com/marlonsantosmacedo/Auxilio-Juridico/blob/master/arquivos/drops_creates_e_inserts.sql?raw=true)

### 9	TABELAS E PRINCIPAIS CONSULTAS<br>
#### 9.1	CONSULTAS DAS TABELAS COM TODOS OS DADOS INSERIDOS (Todas) <br>
[Visualizar em tempo real no Colab](https://colab.research.google.com/drive/1j0ICDi_BpbP6BwfdsQ4bEc74kuqLuRNM?usp=sharing) <br>
[Visualizar em tempo real no GitHub](https://github.com/marlonsantosmacedo/Auxilio-Juridico/blob/master/arquivos/AuxilioJuridico_tabelas.ipynb)

># Marco de Entrega 01: Do item 1 até o item 9.1<br>

#### 9.2	CONSULTAS DAS TABELAS COM FILTROS WHERE (Mínimo 4)<br>
	SELECT * FROM usuario where nome = 'Emanuel';
	SELECT * FROM profissional_juridico where numero_oab = 5667;
	SELECT * FROM mensagem where codigo < 9;
	SELECT * FROM solicitacao where estado_atual = 'FECHADO';
#### 9.3	CONSULTAS QUE USAM OPERADORES LÓGICOS, ARITMÉTICOS E TABELAS OU CAMPOS RENOMEADOS (Mínimo 11)
    a) Criar 5 consultas que envolvam os operadores lógicos AND, OR e Not
    	SELECT * FROM solicitacao where estado_atual = 'ABERTO' and data_abertura > '2021-02-21';
	SELECT * FROM solicitacao where estado_atual = 'ABERTO' or data_abertura > '2021-01-12';
	SELECT * FROM mensagem where not codigo_solicitacao = 1 ;
	SELECT * FROM mensagem where codigo != 5 and codigo_solicitacao !=2;
	SELECT * FROM usuario where not nome = 'Lucas' and cpf > 20000;
	
    b) Criar no mínimo 3 consultas com operadores aritméticos 
    	select codigo, (cpf_auxiliado - cpf_profissional) as cpf_subitraido from solicitacao;
	select data_envio, (cpf_remetente/codigo_solicitacao ) as cpf_div_cod_pr from mensagem;
	select data_envio, (cpf_remetente*codigo) as cpf_mult_cod from mensagem;
	
    c) Criar no mínimo 3 consultas com operação de renomear nomes de campos ou tabelas
	select cpf_usuario as "cpf", numero_oab as "oab" from profissional_juridico pj;
	select cpf_usuario as "cpf", ctps as "carteira_de_trabalho" from auxiliado;
	select codigo_solicitacao as "cod_solicitacao", data_envio from mensagem;
#### 9.4	CONSULTAS QUE USAM OPERADORES LIKE E DATAS (Mínimo 12) <br>
    a) Criar outras 5 consultas que envolvam like ou ilike
    	
	select * from usuario where nome ilike 'e%';
	select * from usuario where nome ilike '%a';
	select * from solicitacao where estado_atual ilike 'a%';
	select * from mensagem where texto ilike '%a_';
	select * from usuario where senha like '%7';
	
    b) Criar uma consulta para cada tipo de função data apresentada.
	select codigo, current_date - (data_envio) as "tempo_envio" from mensagem;
	select codigo, current_date - (data_abertura) as "tempo_abertura" from solicitacao;
	
	
FALTA FAZER
#### 9.5	INSTRUÇÕES APLICANDO ATUALIZAÇÃO E EXCLUSÃO DE DADOS (Mínimo 6)<br>
    a) Criar minimo 3 de exclusão
    	delete from mensagem where codigo = 12;
	delete from mensagem where codigo = 1 and cpf_remetente = 342353;
	delete from mensagem where data_envio = '2021-02-28';
	
    b) Criar minimo 3 de atualização
    	update usuario set nome = 'LUCAS' where nome = 'Lucas';
	alter table mensagem rename column texto to mensagem;
	update usuario set senha = '765' where nome = 'Cleiton Rasta';

#### 9.6	CONSULTAS COM INNER JOIN E ORDER BY (Mínimo 6)<br>
    a) Uma junção que envolva todas as tabelas possuindo no mínimo 2 registros no resultado
    b) Outras junções que o grupo considere como sendo as de principal importância para o trabalho

#### 9.7	CONSULTAS COM GROUP BY E FUNÇÕES DE AGRUPAMENTO (Mínimo 6)<br>
    a) Criar minimo 2 envolvendo algum tipo de junção

#### 9.8	CONSULTAS COM LEFT, RIGHT E FULL JOIN (Mínimo 4)<br>
    a) Criar minimo 1 de cada tipo

#### 9.9	CONSULTAS COM SELF JOIN E VIEW (Mínimo 6)<br>
        a) Uma junção que envolva Self Join (caso não ocorra na base justificar e substituir por uma view)
        b) Outras junções com views que o grupo considere como sendo de relevante importância para o trabalho

#### 9.10	SUBCONSULTAS (Mínimo 4)<br>
     a) Criar minimo 1 envolvendo GROUP BY
     b) Criar minimo 1 envolvendo algum tipo de junção

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


