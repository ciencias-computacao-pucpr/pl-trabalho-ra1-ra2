:- dynamic contribuinte/11.
:- dynamic dependente/4.
:- dynamic a_dependente/4.
:- dynamic desconto/1.

multifile(contribuinte).
multifile(dependente).

prog:-
    write('\e[2J'),
    nl,
    write(' MENU '),
    nl,
    writeln('Escolha uma opção: '),
    writeln('1. Incluir Contribuinte'),
    writeln('2. Incluir Dependente'),
    writeln('3. Localizar Contribuinte pelo CPF'),
    writeln('4. Excluir Contribuinte  e  seus  Dependentes'),
    writeln('5. Relatóriode Contribuintes'),
    writeln('6. Salvar   Dados   em   Arquivo'),
    writeln('7. Carregar  Dados  de  Arquivo'),
    writeln('8. Limpar Dados de Cadastro'),
    writeln('9. Encerrar'),
    read(ENTRADA),
    ENTRADA =\= 9,
    executa( ENTRADA ).

prog:-    
    write('\e[2J'),
    nl,
    write('Saindo!').

executa(1):-
    write('\e[2J'),
    writeln('CADASTRO DE CONTRIBUINTE'),
    nl,
    writeln('CPF: '), read(CPF),
    writeln('NOME: '), read(NOME),
    writeln('Gênero (fem. ou masc.): '), read(GENERO),
    writeln('Renda anual: '), read(RENDA),
    writeln('Logradouro: '), read(LOGR),
    writeln('Número: '), read(NUM),
    writeln('Completo: '), read(COMPL),
    writeln('Cidade: '), read(CIDADE),
    writeln('Estado: '), read(ESTADO),
    writeln('CEP: '), read(CEP),
    writeln('Celular: '), read(CELULAR),
    assert(contribuinte(CPF,NOME, GENERO,RENDA,LOGR,NUM,COMPL,CIDADE,ESTADO,CEP,CELULAR)),    
    writeln('Cadastrado com sucesso. Digite qualquer coisa para continuar.'),
    read(_),
    prog.

executa(2):-
    write('\e[2J'),
    writeln('CADASTRO DE DEPENDENTE'),
    nl,
    writeln('CPF DO RESPONSAVEL: '),read(CPF),
    contribuinte(CPF,_,_,_,_,_,_,_,_,_,_),
    writeln('Nome: '), read(NOME),
    writeln('Idade: '), read(IDADE),
    writeln('Gênero (fem. ou masc.): '), read(GENERO),
    assert(dependente(CPF,NOME, IDADE, GENERO)),
    writeln('Cadastrado com sucesso. Digite qualquer coisa para continuar.'),
    read(_),
    prog.

executa(2):-
    writeln('cpf não existe, digite algo para voltar ao menu'),
    read(_),
    prog.

executa(3) :-
    write('\e[2J'),
    writeln('Localizar contribuinte pelo CPF'),
    read(CPF),
    contribuinte(CPF, NOME, GENERO,RENDA,LOGR,NUM,COMPL,CIDADE,ESTADO,CEP,CELULAR),
    writeln('CPF: '), writeln(CPF),
    writeln('Nome: '), writeln(NOME),
    writeln('Genero: '), writeln(GENERO),
    writeln('Renda: '), writeln(RENDA),
    writeln('Logradouro: '), writeln(LOGR),
    writeln('Número: '), writeln(NUM),
    writeln('Complemento: '), writeln(COMPL),
    writeln('Cidade: '), writeln(CIDADE),
    writeln('Estado: '), writeln(ESTADO),
    writeln('Cep: '), writeln(CEP),
    writeln('Celular: '), writeln(CELULAR),
    writeln('-------- DEPENTES ----------'),
    listar_dependentes(CPF),
    writeln('Digite qualquer coisa para continuar.'),
    read(_),
    prog.

executa(5):-
    contribuinte(CPF, NOME, GENERO,RENDA,LOGR,NUM,COMPL,CIDADE,ESTADO,CEP,CELULAR),
    retractall(desconto(_)),
    assert(desconto(0)),
    procura_dependentes(CPF),
    desconto(VALOR),
    writeln('CPF: '), writeln(CPF),
    writeln('Nome: '), writeln(NOME),
    writeln('Genero: '), writeln(GENERO),
    writeln('Renda: '), writeln(RENDA),
    writeln('Logradouro: '), writeln(LOGR),
    writeln('Número: '), writeln(NUM),
    writeln('Complemento: '), writeln(COMPL),
    writeln('Cidade: '), writeln(CIDADE),
    writeln('Estado: '), writeln(ESTADO),
    writeln('Cep: '), writeln(CEP),
    writeln('Celular: '), writeln(CELULAR),
    nl,
    writeln('Desconto IPRF: '),
    writeln(VALOR),
    writeln('-------- DEPENTES ----------'),
    listar_dependentes(CPF),
   fail.

executa(5):- true.

executa(3):-
    write('\e[2J'),
    writeln('CPF não existe. Digite qualquer coisa para continuar.'),
    read(_),
    prog.

executa(4):-
    write('\e[2J'),
    writeln('CPF: '),read(CPF),
    retractall(contribuinte(CPF,_,_,_,_,_,_,_,_,_,_)),
    retractall(dependente(CPF,_,_,_)),
    writeln('Dados limpos. Digite qualquer coisa para continuar.'),
    read(_),
    prog.

executa(6):-
    write('\e[2J'),
    tell('banco.pl'),
    listing(contribuinte/11),
    listing(dependente/4),
    told,
    writeln('Salvo com sucesso. Digite qualquer coisa para continuar.'),
    read(_),
    prog.

executa(7):-
    write('\e[2J'),
    consult('banco.pl'),
    writeln('Dados carregados. Digite qualquer coisa para continuar.'),
    read(_),
    prog.

executa(8):-
    write('\e[2J'),
    retractall(contribuinte(_,_,_,_,_,_,_,_,_,_,_)),
    retractall(dependente(_,_,_,_)),
    writeln('Dados limpos. Digite qualquer coisa para continuar.'),
    read(_),
    prog.

listar_dependentes(CPF):-
    dependente(CPF, NOME, GENERO, IDADE),
    write('Nome: '), writeln(NOME),
    write('Genero: '), writeln(GENERO),
    write('Idade: '), writeln(IDADE),
    writeln('--------------------------'),
    fail.

listar_dependentes(_):-true.

procura_dependentes(CPF) :-
    dependente(CPF, _, _, _),
    retract(desconto(TOTAL)),
    RESULTADO is TOTAL + 1200,
    assert(desconto(RESULTADO)),
    % writeln(TOTAL),
    fail.

procura_dependentes(_) :- true.
    

