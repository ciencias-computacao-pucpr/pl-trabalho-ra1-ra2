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
    writeln('9. Encerrar    '),
    read(ENTRADA),
    ENTRADA =\= 9,
    executa( ENTRADA ),
    prog.
prog:-    
    write('\e[2J'),
    nl,
    write('Saindo!').

executa:-
    writeln('default - nao vai mostrar isto depois')
