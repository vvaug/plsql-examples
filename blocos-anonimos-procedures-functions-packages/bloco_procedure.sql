CREATE OR REPLACE PROCEDURE PR_CALCULA_MEDIA
    AS --Sessão de variáveis locais da procedure
    
    media INTEGER := 0;
    
    criterio_aprovacao INTEGER := 6;
    
    --cursor explícito
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

BEGIN  
        
    FOR i IN alunos
      
      LOOP
        
        DBMS_OUTPUT.PUT_LINE('Percorrendo cursor, aluno: '||i.nome);
        
        media := (i.nota_primeiro_bim + i.nota_segundo_bim + i.nota_terceiro_bim + i.nota_quarto_bim / 4 );
    
        DBMS_OUTPUT.PUT_LINE('====================================================================================');
        DBMS_OUTPUT.PUT_LINE('Aluno: '||i.nome);
        DBMS_OUTPUT.PUT_LINE('Nota primeiro bimestre: '|| i.nota_primeiro_bim);
        DBMS_OUTPUT.PUT_LINE('Nota segundo bimestre: '|| i.nota_segundo_bim);
        DBMS_OUTPUT.PUT_LINE('Nota terceiro bimestre: '|| i.nota_terceiro_bim);
        DBMS_OUTPUT.PUT_LINE('Nota quarto bimestre: '|| i.nota_quarto_bim);
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('Media total: '|| media);
        DBMS_OUTPUT.PUT_LINE('Criterio de Aprovacao: '|| criterio_aprovacao);
    
    
        DBMS_OUTPUT.PUT_LINE('Resultado final: '|| CASE WHEN media >= criterio_aprovacao THEN 'Aprovado' ELSE 'Reprovado' END);
        DBMS_OUTPUT.PUT_LINE('====================================================================================');
     
     END LOOP;
     
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE ('ERRO => '||SQLERRM(SQLCODE));
END PR_CALCULA_MEDIA;

/

SET SERVEROUTPUT ON
BEGIN
PR_CALCULA_MEDIA; --procedures devem ser chamadas dentro de um bloco
END;