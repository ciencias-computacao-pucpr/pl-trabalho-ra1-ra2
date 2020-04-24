:- dynamic contribuinte/11.
:- dynamic dependente/4.
:- dynamic a_dependente/4.
:- dynamic desconto/1.
:- dynamic renda_total/1.

multifile(contribuinte).
multifile(dependente).

prog:-
    retractall(renda_total(_)),
    assert(renda_total(0)),
    write('\e[2J'),
    nl,
    write(' MENU '),
    nl,
    writeln('Escolha uma opção: '),
    writeln('1. Incluir Contribuinte'),
    writeln('2. Incluir Dependente'),
    writeln('3. Localizar Contribuinte pelo CPF'),
    writeln('4. Excluir Contribuinte  e  seus  Dependentes'),
    writeln('5. Relatório de Contribuintes'),
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
    retract(renda_total(RENDA_ACUMULADA)),
    RENDA_TOTAL is RENDA_ACUMULADA + RENDA,
    assert(renda_total(RENDA_TOTAL)),
    retractall(desconto(_)),
    assert(desconto(0)),
    procura_dependentes(CPF),
    desconto(VALOR),
    write('CPF: '), write(CPF),tab(4),   write('| Nome: '), writeln(NOME),
    write('Genero: '), write(GENERO), tab(4),  write('| Renda: '), writeln(RENDA),
    write('Logradouro: '), write(LOGR),tab(4), write('| Número: '), writeln(NUM),
    write('Complemento: '), write(COMPL),tab(4), write('| Cidade: '), writeln(CIDADE),
    write('Estado: '), write(ESTADO),tab(4), write('| Cep: '), writeln(CEP),
    write('Celular: '), writeln(CELULAR),
    nl,
    write('Desconto IPRF: '),
    writeln(VALOR),
    writeln('-------- DEPENTES ----------'),
    listar_dependentes(CPF),
    fail.

executa(5):-
    renda_total(RENDA_TOTAL),
    write('Renda total: '),writeln(RENDA_TOTAL),
    writeln('Digite qualquer coisa para continuar.'),
    read(_),
    prog.

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
    

