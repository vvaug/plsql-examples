SET SERVEROUTPUT ON

/*
    Comandos os quais não podemos utilizar em um bloco PL/SQL:
    DDL(Data Definition Language):
        CREATE
        DROP
        ALTER
        TRUNCATE
        COMMENT
        RENAME
    
    DCL(Data Control Language):
        GRANT
        REVOKE
    
    com Dynamic SQL, podemos facilmente executar esses comandos em tempo de execução de nosso bloco PL/SQL
    utilizando o comando EXECUTE IMMEDIATE

*/

DECLARE
    
    v_table_name VARCHAR2(100) := 'DYNAMIC_TABLE';
    
    v_sql VARCHAR2(2000) := NULL; 

BEGIN
    
    v_sql := 'DROP TABLE '|| v_table_name;
    
    --------------------------------------------------------------
    BEGIN
        EXECUTE IMMEDIATE v_sql;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
    ---------------------------------------------------------------

    v_sql := 'CREATE TABLE '|| v_table_name || ' ( '||
             'ID INTEGER, RANDOM_NUM INTEGER ) ';
    
    -------------------------------------------------------------------------------
    BEGIN
        EXECUTE IMMEDIATE v_sql;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERRO AO CRIAR TABELA => '||SQLERRM(SQLCODE));
            RETURN;
    END;
    -------------------------------------------------------------------------------
    DBMS_OUTPUT.PUT_LINE('Tabela: '|| v_table_name ||' criada com sucesso');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERRO => '||SQLERRM(SQLCODE));
    
END;