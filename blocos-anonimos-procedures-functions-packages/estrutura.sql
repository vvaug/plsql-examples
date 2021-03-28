CREATE TABLE TB_ALUNOS ( MATRICULA INTEGER,
                         NOME VARCHAR2(100) 
                        );
/
CREATE TABLE TB_NOTAS ( ANO_LETIVO INTEGER, 
                        MATRICULA_ALUNO INTEGER, 
                        NOTA_PRIMEIRO_BIM INTEGER,
                        NOTA_SEGUNDO_BIM INTEGER,
                        NOTA_TERCEIRO_BIM INTEGER,
                        NOTA_QUARTO_BIM INTEGER
                      );
                      
/
CREATE TABLE TB_PARAMETRIZACAO_MEDIA_APROVACAO
                ( ANO_LETIVO INTEGER,
                  MEDIA INTEGER
                 );

INSERT INTO TB_ALUNOS (MATRICULA, NOME) VALUES (12345, 'Matheus Ramos Lima');
INSERT INTO TB_ALUNOS (MATRICULA, NOME) VALUES (12453, 'Victor Augusto da Silva');
INSERT INTO TB_ALUNOS (MATRICULA, NOME) VALUES (13451, 'Wellington Jose');
--INSERT INTO TB_ALUNOS VALUES (12345, 'Matheus Ramos Lima');
/

INSERT INTO TB_NOTAS (ANO_LETIVO,
                      MATRICULA_ALUNO,
                      NOTA_PRIMEIRO_BIM,
                      NOTA_SEGUNDO_BIM,
                      NOTA_TERCEIRO_BIM,
                      NOTA_QUARTO_BIM
                      ) VALUES (2021,
                                12345,
                                6,
                                7,
                                0,
                                2);
                                
INSERT INTO TB_NOTAS (ANO_LETIVO,
                      MATRICULA_ALUNO,
                      NOTA_PRIMEIRO_BIM,
                      NOTA_SEGUNDO_BIM,
                      NOTA_TERCEIRO_BIM,
                      NOTA_QUARTO_BIM
                      ) VALUES (2021,
                                12453,
                                6,
                                5,
                                5,
                                1);
                                
INSERT INTO TB_NOTAS (ANO_LETIVO,
                      MATRICULA_ALUNO,
                      NOTA_PRIMEIRO_BIM,
                      NOTA_SEGUNDO_BIM,
                      NOTA_TERCEIRO_BIM,
                      NOTA_QUARTO_BIM
                      ) VALUES (2021,
                                13451,
                                8,
                                9,
                                10,
                                10);

INSERT INTO TB_PARAMETRIZACAO_MEDIA_APROVACAO (ANO_LETIVO,
                                               MEDIA)
                                               VALUES (2020,
                                                       6);
                                                       
INSERT INTO TB_PARAMETRIZACAO_MEDIA_APROVACAO (ANO_LETIVO,
                                               MEDIA)
                                               VALUES (2021,
                                                       8);

COMMIT;