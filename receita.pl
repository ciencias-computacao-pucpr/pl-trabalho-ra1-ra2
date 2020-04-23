:- dynamic contribuinte/11.
:- dynamic dependente/4.

prog:-
    write('\e[2J'),
    nl,
    write(' MENU '),
    nl,
    writeln('Escolha uma opção: '),
    writeln('1. Incluir Contribuinte'),
    writeln('2. Incluir   Dependente'),
    writeln('3. Localizar Contribuinte pelo CPF'),
    writeln('4. Excluir Contribuinte  e  seus  Dependentes'),
    writeln('5. Relatóriode Contribuintes'),
    writeln('6. Salvar   Dados   em   Arquivo'),
    writeln('7. Carregar  Dados  de  Arquivo'),
    writeln('8. Limpar Dados de Cadastro'),
    writeln('9. Encerrar'),
    read(ENTRADA),
    ENTRADA =\= 9,
    executa( ENTRADA ),
    prog.
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


executa(3) :-
    writeln('Localizar contribuinte pelo CPF'),
    read(CPF),
    contribuinte(CPF, NOME, GENERO,RENDA,LOGR,NUM,COMPL,CIDADE,ESTADO,CEP,CELULAR),
    writeln('CPF: '),
    writeln(CPF),
    writeln('Nome: '),
    writeln(NOME),
    writeln('Genero: '),
    writeln(GENERO),
    writeln('Renda: '),
    writeln(RENDA),
    writeln('Logradouro: '),
    writeln(LOGR),
    writeln('Número: '),
    writeln(NUM),
    writeln('Complemento: '),
    writeln(COMPL),
    writeln('Cidade: '),
    writeln(CIDADE),
    writeln('Estado: '),
    writeln(ESTADO),
    writeln('Cep: '),
    writeln(CEP),
    writeln('Celular: '),
    writeln(CELULAR),
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

executa(_):-
    writeln('default - nao vai mostrar isto depois'),
    read(_),
    prog.

