CREATE OR REPLACE FUNCTION fnc_obtem_media (p_primeiro_bimestre IN INTEGER,
                                            p_segundo_bimestre IN INTEGER,
                                            p_terceiro_bimestre IN INTEGER,
                                            p_quarto_bimestre IN INTEGER ) RETURN INTEGER
AS
    --variável local da function
    media INTEGER := 0;

BEGIN
    
    media := ( p_primeiro_bimestre + p_segundo_bimestre + p_terceiro_bimestre + p_quarto_bimestre / 4 );
    
    RETURN media;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERRO [fnc_obtem_media] => '||SQLERRM(SQLCODE));
        
END fnc_obtem_media;

/

--function para retornar resultado se foi aprovado.

CREATE OR REPLACE FUNCTION fnc_is_aprovado (p_criterio_aprovacao IN INTEGER, p_media IN INTEGER) RETURN VARCHAR2
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
        DBMS_OUTPUT.PUT_LINE('ERRO [fnc_isAprovado] => '||SQLERRM(SQLCODE));
        
END fnc_is_aprovado;