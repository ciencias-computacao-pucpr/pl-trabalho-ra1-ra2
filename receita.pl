:- dynamic contribuinte/11.

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
    write('CPF '), read(CPF),
    write('NOME: '), read(NOME),
    write('Gênero (fem. ou masc.): '), read(GENERO),
    write('Renda anual: '), read(RENDA),
    write('Logradouro: '), read(LOGR),
    write('Número: '), read(NUM),
    write('Completo: '), read(COMPL),
    write('Cidade: '), read(CIDADE),
    write('Estado: '), read(ESTADO),
    write('CEP: '), read(CEP),
    write('Celular: '), read(CELULAR),
    assert(contribuinte(CPF,NOME, GENERO,RENDA,LOGR,NUM,COMPL,CIDADE,ESTADO,CEP,CELULAR)),
    writeln('Cadastrado com sucesso. Digite qualquer coisa para continuar.'),
    read(_),
    prog.



executa(_):-
    writeln('default - nao vai mostrar isto depois'),
    read(_),
    prog.

