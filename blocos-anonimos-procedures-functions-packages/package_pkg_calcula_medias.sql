/*
  Transformando o processo em uma package
  Uma package se faz necessário quando temos diversos objetos
  (Procedures, Functions, etc) relacionadas ao mesmo processo.
*/
CREATE OR REPLACE PACKAGE pkg_calcula_medias
AS
    
    PROCEDURE pr_calcula_media;
    
    FUNCTION fnc_obtem_media (p_primeiro_bimestre IN INTEGER,
                              p_segundo_bimestre IN INTEGER,
                              p_terceiro_bimestre IN INTEGER,
                              p_quarto_bimestre IN INTEGER ) RETURN INTEGER;
                              
    FUNCTION fnc_is_aprovado (p_criterio_aprovacao IN INTEGER,
                              p_media IN INTEGER) RETURN VARCHAR2;
                              
    FUNCTION fnc_obtem_criterio_aprovacao (p_ano_letivo IN VARCHAR2) RETURN INTEGER;
    
END pkg_calcula_medias;

--Package Body
/
CREATE OR REPLACE PACKAGE BODY pkg_calcula_medias
AS
    FUNCTION fnc_obtem_criterio_aprovacao (p_ano_letivo IN VARCHAR2) RETURN INTEGER
    AS
        v_criterio_aprovacao INTEGER := 0;

    BEGIN

        SELECT param.MEDIA INTO v_criterio_aprovacao
        FROM TB_PARAMETRIZACAO_MEDIA_APROVACAO param  --tabela de configuração / parametrização, faz o processo ser dinâmico de acordo com o valor.
        WHERE TO_CHAR(param.ano_letivo) = p_ano_letivo;

        RETURN v_criterio_aprovacao;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERRO [fnc_obtem_criterio_aprovacao] => '||SQLERRM(SQLCODE));

    END fnc_obtem_criterio_aprovacao;
    
    FUNCTION fnc_is_aprovado (p_criterio_aprovacao IN INTEGER, p_media IN INTEGER) RETURN VARCHAR2
    AS
        resultado VARCHAR2(100) := NULL;

    BEGIN

        IF ( p_media >= p_criterio_aprovacao ) THEN
            RETURN 'Aprovado';
        ELSE
            RETURN 'Reprovado';
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERRO [fnc_is_aprovado] => '||SQLERRM(SQLCODE));

    END fnc_is_aprovado;
    
    FUNCTION fnc_obtem_media (p_primeiro_bimestre IN INTEGER,
                                            p_segundo_bimestre IN INTEGER,
                                            p_terceiro_bimestre IN INTEGER,
                                            p_quarto_bimestre IN INTEGER ) RETURN INTEGER
    AS
        media INTEGER := 0;

    BEGIN

        media := ( p_primeiro_bimestre + p_segundo_bimestre + p_terceiro_bimestre + p_quarto_bimestre / 4 );

        RETURN media;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERRO [fnc_obtem_media] => '||SQLERRM(SQLCODE));

    END fnc_obtem_media;
    
    PROCEDURE pr_calcula_media
    AS 
    
        v_media INTEGER := 0;

        v_criterio_aprovacao INTEGER := 0;

        v_ano_letivo VARCHAR2(4) := TO_CHAR(SYSDATE, 'RRRR');

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
    END pr_calcula_media;

END pkg_calcula_medias;

/

SET SERVEROUTPUT ON
BEGIN
    pkg_calcula_medias.pr_calcula_media;
END;