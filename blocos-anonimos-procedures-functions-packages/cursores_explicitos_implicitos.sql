SET SERVEROUTPUT ON
--Bloco anônimo (DECLARE, BEGIN, END) ou (BEGIN, END)
DECLARE --Opcional (se for declarar variáveis, precisa do DECLARE)
    --Sessão de variáveis
    
    media INTEGER := 0;
    
    criterio_aprovacao INTEGER := 6;
    
    --Cursor Explícito
    CURSOR alunos IS
     SELECT alu.matricula,
       alu.nome,
       nota.nota_primeiro_bim,
       nota.nota_segundo_bim,
       nota.nota_terceiro_bim,
       nota.nota_quarto_bim
    FROM TB_ALUNOS alu,
     TB_NOTAS nota
    WHERE alu.matricula = nota.matricula_aluno;
    
    /*
      Um cursor implícito, é aquele que é declarado dentro do BEGIN, como um SELECT INTO comum.
      Há formas de percorrer um cursor implícito, como utilizar um for com o select, ex:
       FOR i IN (SELECT * FROM TB_ALUNOS)
         LOOP
            processamento linha por linha
    */
    
BEGIN  
        
    FOR alu IN alunos
      
      LOOP
        
        DBMS_OUTPUT.PUT_LINE('Percorrendo cursor, aluno: '||alu.nome);
        
        media := (alu.nota_primeiro_bim + alu.nota_segundo_bim + alu.nota_terceiro_bim + alu.nota_quarto_bim / 4 );
    
        DBMS_OUTPUT.PUT_LINE('====================================================================================');
        DBMS_OUTPUT.PUT_LINE('Aluno: '||alu.nome);
        DBMS_OUTPUT.PUT_LINE('Nota primeiro bimestre: '|| alu.nota_primeiro_bim);
        DBMS_OUTPUT.PUT_LINE('Nota segundo bimestre: '|| alu.nota_segundo_bim);
        DBMS_OUTPUT.PUT_LINE('Nota terceiro bimestre: '|| alu.nota_terceiro_bim);
        DBMS_OUTPUT.PUT_LINE('Nota quarto bimestre: '|| alu.nota_quarto_bim);
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('Media total: '|| media);
        DBMS_OUTPUT.PUT_LINE('Criterio de Aprovacao: '|| criterio_aprovacao);
    
    
        DBMS_OUTPUT.PUT_LINE('Resultado final: '|| CASE WHEN media >= criterio_aprovacao THEN 'Aprovado' ELSE 'Reprovado' END);
        DBMS_OUTPUT.PUT_LINE('====================================================================================');
     
     END LOOP;
     
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE ('ERRO => '||SQLERRM(SQLCODE));
END;