SET SERVEROUTPUT ON
--Bloco tipo PROCEDURE
CREATE OR REPLACE PROCEDURE PR_CALCULA_MEDIA
    AS --Sessão de variáveis locais da procedure
    
    v_media INTEGER := 0;
    
    v_criterio_aprovacao INTEGER := 0;
    
    v_ano_letivo VARCHAR2(4) := TO_CHAR(SYSDATE, 'RRRR');
    
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
    
    DBMS_OUTPUT.PUT_LINE('Obtendo criterio de aprovacao para o ano letivo: '|| v_ano_letivo);
    
    v_criterio_aprovacao := fnc_obtem_criterio_aprovacao(v_ano_letivo);
    
    DBMS_OUTPUT.PUT_LINE('Criterio de aprovacao para o ano letivo: '||v_ano_letivo||' eh: '|| v_criterio_aprovacao);
    
    FOR i IN alunos
      
      LOOP
                
        v_media := fnc_obtem_media(i.nota_primeiro_bim,   --obtendo média direto de uma function 
                                 i.nota_segundo_bim,
                                 i.nota_terceiro_bim,
                                 i.nota_quarto_bim);
    
        DBMS_OUTPUT.PUT_LINE('====================================================================================');
        DBMS_OUTPUT.PUT_LINE('Aluno: '||i.nome);
        DBMS_OUTPUT.PUT_LINE('Nota primeiro bimestre: '|| i.nota_primeiro_bim);
        DBMS_OUTPUT.PUT_LINE('Nota segundo bimestre: '|| i.nota_segundo_bim);
        DBMS_OUTPUT.PUT_LINE('Nota terceiro bimestre: '|| i.nota_terceiro_bim);
        DBMS_OUTPUT.PUT_LINE('Nota quarto bimestre: '|| i.nota_quarto_bim);
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('Media total: '|| v_media);
        DBMS_OUTPUT.PUT_LINE('Criterio de Aprovacao: '|| v_criterio_aprovacao);
    
    
        DBMS_OUTPUT.PUT_LINE('Resultado final: '|| fnc_is_aprovado(v_criterio_aprovacao, v_media) );    --obtendo resultado de uma function
        DBMS_OUTPUT.PUT_LINE('====================================================================================');
     
     END LOOP;
     
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE ('ERRO [PR_CALCULA_MEDIA] => '||SQLERRM(SQLCODE));
END PR_CALCULA_MEDIA;