Time Dimension Load (With Brazilian Holidays) - PLSQL
/*
Author: Erick Furst
Date: 08/20/2015
Description: Process for loading the Time Dimension.
*/
--------------------------------------------------

--Carga dimensão Ano (Year dimension load)
declare
  Data DATE;
  DataIni DATE;
  DataFim DATE;
  Data_Movel DATE;
BEGIN
  DataIni := to_date('2000/01/01','yyyy/mm/dd');
  DataFim := to_date('2040/12/31','yyyy/mm/dd');
  Data := DataIni;
WHILE Data <= DataFim LOOP
      INSERT INTO DIM_ANO ( NUM_ANO, NUM_ANO_ANT )
      VALUES ( TO_CHAR(extract(YEAR from Data)), TO_CHAR(extract(YEAR from Data)-1) );
      Data := add_months(Data,12);
      Data := add_months(Data,1) - extract(DAY from (add_months(Data,1)));
END LOOP;
COMMIT;
END;
-- select * from ano
--------------------------------------------------

--Carga dimensão Semestre (Six month period dimension load)
declare
  Data DATE;
  DataIni DATE;
  DataFim DATE;
  Data_Movel DATE;

BEGIN
  DataIni := to_date('2000/01/01','yyyy/mm/dd');
  DataFim := to_date('2040/12/31','yyyy/mm/dd');
   Data := DataIni;
WHILE Data <= DataFim LOOP
      INSERT INTO  DIM_SEMESTRE(NUM_ANO_SMT, DES_ANO_SMT, NUM_SMT, DES_SMT, NUM_ANO )
      VALUES
          (
            TO_CHAR(extract(YEAR from Data)) || DECODE(TO_NUMBER(TO_CHAR(Data,'Q'))
            ,1,'01'
            ,2,'01'
            ,3,'02'
            ,4,'02'),
            DECODE(TO_NUMBER(TO_CHAR(Data,'Q'))
            ,1,'1º Semestre de '
            ,2,'1º Semestre de '
            ,3,'2º Semestre de '
            ,4,'2º Semestre de ') || TO_CHAR(extract(YEAR from Data)),
            DECODE(TO_NUMBER(TO_CHAR(Data,'Q'))
            ,1,'01'
            ,2,'01'
            ,3,'02'
            ,4,'02'),
            DECODE(TO_NUMBER(TO_CHAR(Data,'Q'))
            ,1,'1º Semestre'
            ,2,'1º Semestre'
            ,3,'2º Semestre'
            ,4,'2º Semestre'),
            TO_CHAR(extract(YEAR from Data))
          );
      Data := add_months(Data,6);
      Data := add_months(Data,1) - extract(DAY from (add_months(Data,1)));

END LOOP;
COMMIT;
END;
-- select * from semestre
--------------------------------------------------

--Carga dimensão trimestre (Quarter dimension load)

declare
  Data DATE;
  DataIni DATE;
  DataFim DATE;
  Data_Movel DATE;
BEGIN
  DataIni := to_date('2000/01/01','yyyy/mm/dd');
  DataFim := to_date('2040/12/31','yyyy/mm/dd');
   Data := DataIni;
WHILE Data <= DataFim LOOP
      INSERT INTO  DIM_TRIMESTRE(NUM_ANO_TRM, DES_ANO_TRM, NUM_TRM, DES_TRM, NUM_ANO_SMT)
      VALUES
          (
            TO_CHAR(extract(YEAR from Data)) || DECODE(TO_NUMBER(TO_CHAR(Data,'Q'))
            ,1,'01'
            ,2,'02'
            ,3,'03'
            ,4,'04'),
         
            DECODE(TO_NUMBER(TO_CHAR(Data,'Q'))
            ,1,'1º Trimestre de '
            ,2,'2º Trimestre de '
            ,3,'3º Trimestre de '
            ,4,'4º Trimestre de ') || TO_CHAR(extract(YEAR from Data)),
           
            DECODE(TO_NUMBER(TO_CHAR(Data,'Q'))
            ,1,'01'
            ,2,'02'
            ,3,'03'
            ,4,'04'),
         
         
            DECODE(TO_NUMBER(TO_CHAR(Data,'Q'))
            ,1,'1º Trimestre'
            ,2,'2º Trimestre'
            ,3,'3º Trimestre'
            ,4,'4º Trimestre'),
                     
            TO_CHAR(extract(YEAR from Data)) || DECODE(TO_NUMBER(TO_CHAR(Data,'Q'))
            ,1,'01'
            ,2,'01'
            ,3,'02'
            ,4,'02')
          );
      Data := add_months(Data,3);
      Data := add_months(Data,1) - extract(DAY from (add_months(Data,1)));
END LOOP;
COMMIT;
END;
-- select * from trimestre
--------------------------------------------------

--Carga dimensão mês (month dimension load)
declare
  Data DATE;
  DataIni DATE;
  DataFim DATE;
  Data_Movel DATE;
BEGIN
  DataIni := to_date('2000/01/01','yyyy/mm/dd');
  DataFim := to_date('2040/12/31','yyyy/mm/dd');
   Data := DataIni;
WHILE Data <= DataFim LOOP
      INSERT INTO DIM_MES (NUM_ANO_MES, DES_ANO_MES, NUM_MES, DES_MES, DES_MES_ABV, NUM_ANO_TRM,
                             NUM_ANO_ANT_MES, NUM_ANO_MES_ANT, NUM_ANO_MES_INI_MDL_VLR)
      VALUES
          (
             TO_CHAR(extract(YEAR from Data)) || TO_CHAR(Data, 'MM'),
           
            (CASE extract(MONTH from Data)
                  WHEN (1)    THEN ('Janeiro')
                  WHEN (2)    THEN ('Fevereiro')
                  WHEN (3)    THEN ('Março')
                  WHEN (4)    THEN ('Abril')
                  WHEN (5)    THEN ('Maio')
                  WHEN (6)    THEN ('Junho')
                  WHEN (7)    THEN ('Julho')
                  WHEN (8)    THEN ('Agosto')
                  WHEN (9)    THEN ('Setembro')
                  WHEN (10)   THEN ('Outubro')
                  WHEN (11)   THEN ('Novembro')
                  WHEN (12)   THEN ('Dezembro')
            END) || ' de ' || TO_CHAR(extract(YEAR from Data)),
         
            TO_CHAR(Data, 'MM'),
         
            (CASE extract(MONTH from Data)
                  WHEN (1)    THEN ('Janeiro')
                  WHEN (2)    THEN ('Fevereiro')
                  WHEN (3)    THEN ('Março')
                  WHEN (4)    THEN ('Abril')
                  WHEN (5)    THEN ('Maio')
                  WHEN (6)    THEN ('Junho')
                  WHEN (7)    THEN ('Julho')
                  WHEN (8)    THEN ('Agosto')
                  WHEN (9)    THEN ('Setembro')
                  WHEN (10)   THEN ('Outubro')
                  WHEN (11)   THEN ('Novembro')
                  WHEN (12)   THEN ('Dezembro')
            END),          
         
            (CASE extract(MONTH from Data)
                  WHEN (1)    THEN ('Jan')
                  WHEN (2)    THEN ('Fev')
                  WHEN (3)    THEN ('Mar')
                  WHEN (4)    THEN ('Abr')
                  WHEN (5)    THEN ('Mai')
                  WHEN (6)    THEN ('Jun')
                  WHEN (7)    THEN ('Jul')
                  WHEN (8)    THEN ('Ago')
                  WHEN (9)    THEN ('Set')
                  WHEN (10)   THEN ('Out')
                  WHEN (11)   THEN ('Nov')
                  WHEN (12)   THEN ('Dez')
            END),          

         
            TO_CHAR(extract(YEAR from Data)) || DECODE(TO_NUMBER(TO_CHAR(Data,'Q'))
            ,1,'01'
            ,2,'02'
            ,3,'03'
            ,4,'04'),
         
            TO_NUMBER(TO_CHAR(extract(YEAR from Data)) || TO_CHAR(Data, 'MM'))-100,
         
            CASE WHEN extract(MONTH from Data) <> 1
                 THEN TO_NUMBER(TO_CHAR(extract(YEAR from Data)) || TO_CHAR(Data, 'MM'))-1
                 ELSE TO_NUMBER(TO_CHAR(extract(YEAR from Data)) || TO_CHAR(Data, 'MM'))-89
            END,
         
            TO_NUMBER(TO_CHAR(extract(YEAR from ADD_MONTHS(Data,-3))) || TO_CHAR(ADD_MONTHS(Data,-3), 'MM'))
         
          );

      Data := add_months(Data,1);
      Data := add_months(Data,1) - extract(DAY from (add_months(Data,1)));
END LOOP;
COMMIT;
END;
-- SELECT * FROM MES ORDER BY 1
--------------------------------------------------

--Carga dimensão Data (Day dimension load)
declare
  Data           DATE;
  DataIni        DATE;
  DataFim        DATE;
  Data_Movel     DATE;
  VarA           INT;
  VarB           INT;
  VarC           INT;
  VarD           INT;
  VarE           INT;
  VarF           INT;
  VarG           INT;
  VarH           INT;
  VarI           INT;
  VarAno         INT;
  MesPascoa      INT;
  DiaPascoa      INT;
  DataPascoaNum  INT;
  DataPascoa     DATE;
  DataCarnaval   DATE;
  DataQuartaCinzas DATE;
  DataSextaSanta DATE;
  DataCorpusChristi DATE;

BEGIN

  DataIni := to_date('2000/01/01','yyyy/mm/dd');
  DataFim := to_date('2040/12/31','yyyy/mm/dd');

  Data := DataIni;
  data_movel := DataFim;

WHILE Data <= DataFim LOOP

      --Código para cálculo de feriado móvel.
      VarAno := extract(YEAR from Data);
      VarA := TRUNC(VarAno/100);
      VarB := VarAno-(19*TRUNC(VarAno/19));
      VarC := TRUNC((VarA-17)/25);
      VarD := VarA-TRUNC(VarA/4)-TRUNC((VarA-VarC)/3)+19*VarB+15;
      VarE := VarD-30*TRUNC(VarD/30);
      VarF := VarE-(TRUNC(VarE/28)*(1-TRUNC(VarE/28))*TRUNC(29/(VarE+1))*TRUNC(21-VarB/11));
      VarG := VarAno+TRUNC(VarAno/4)+VarF+2-VarA+TRUNC(VarA/4);
      VarH := VarG-(7*TRUNC(VarG/7));
      VarI := VarF-VarH;
      MesPascoa := 3+TRUNC((VarI+40)/44);
      DiaPascoa := VarI+28-31*TRUNC(MesPascoa/4);

      DataPascoaNum := (VarAno * 100 + MesPascoa) * 100 + DiaPascoa;
      DataPascoa := TO_DATE(DataPascoaNum, 'yyyymmdd');
      DataCarnaval := DataPascoa - 47;
      DataQuartaCinzas := DataCarnaval + 1;
      DataSextaSanta :=  DataPascoa - 2;
      DataCorpusChristi := DataPascoa + 60;


      INSERT INTO DIM_DATA (  DAT_DIA,   NUM_ANO_MES,  NUM_DIA_SEM,  DES_DIA_SEM,  DES_DIA_SEM_ABV, IND_DIA_UTL,  IND_FRD,  DES_FRD,
                          DAT_DIA_ANT,  DAT_PRI_DIA_MES,  DAT_ULT_DIA_MES,  DAT_INI_MDL_VLR,  NUM_ANO,
                          NUM_ANO_SMT,  NUM_ANO_TRM,  DAT_ANO_ANT,  DAT_ULT_DIA_MES_ANT )
      VALUES
      (
      TO_DATE(Data,'DD/MM/YY'),
      TO_NUMBER(TO_CHAR(extract(YEAR from Data)) || TO_CHAR(Data, 'MM')),
      TO_NUMBER( TO_CHAR (Data, 'D') ),
      CASE  TO_NUMBER( TO_CHAR (Data, 'D') )
                 WHEN 1 THEN 'Domingo'
                 WHEN 2 THEN 'Segunda-feira'
                 WHEN 3 THEN 'Terça-feira'
                 WHEN 4 THEN 'Quarta-feira'
                 WHEN 5 THEN 'Quinta-feira'
                 WHEN 6 THEN 'Sexta-feira'
                 WHEN 7 THEN 'Sábado'                                                                                                                
      END,
      CASE  TO_NUMBER( TO_CHAR (Data, 'D') )
                 WHEN 1 THEN 'Dom'
                 WHEN 2 THEN 'Seg'
                 WHEN 3 THEN 'Ter'
                 WHEN 4 THEN 'Qua'
                 WHEN 5 THEN 'Qui'
                 WHEN 6 THEN 'Sex'
                 WHEN 7 THEN 'Sáb'                                                                                                                
      END,

      CASE WHEN EXTRACT(MONTH from Data) * 100 + EXTRACT(DAY from Data)
           IN (101, 421, 501, 907, 1012, 1102, 1115, 1225, 125, 709, 1120,
--               EXTRACT(MONTH from DataCarnaval) * 100 + EXTRACT(DAY from DataCarnaval),
--               EXTRACT(MONTH from DataQuartaCinzas) * 100 + EXTRACT(DAY from DataQuartaCinzas),
               EXTRACT(MONTH from DataSextaSanta) * 100 + EXTRACT(DAY from DataSextaSanta),
               EXTRACT(MONTH from DataCorpusChristi) * 100 + EXTRACT(DAY from DataCorpusChristi) )
           OR ( TO_NUMBER( TO_CHAR (Data, 'D') ) IN (1,7) )
           THEN 'N'
           ELSE 'S'
      END,
      CASE WHEN EXTRACT(MONTH from Data) * 100 + EXTRACT(DAY from Data)
           IN (101, 421, 501, 907, 1012, 1102, 1115, 1225, 125, 709, 1120,
--               EXTRACT(MONTH from DataCarnaval) * 100 + EXTRACT(DAY from DataCarnaval),
--               EXTRACT(MONTH from DataQuartaCinzas) * 100 + EXTRACT(DAY from DataQuartaCinzas),
               EXTRACT(MONTH from DataSextaSanta) * 100 + EXTRACT(DAY from DataSextaSanta),
               EXTRACT(MONTH from DataCorpusChristi) * 100 + EXTRACT(DAY from DataCorpusChristi) )
           THEN 'S'
           ELSE 'N'
      END,
      CASE EXTRACT(MONTH from Data) * 100 + EXTRACT(DAY from Data)
           WHEN 101 THEN 'Confraternização Universal' --01/01
           WHEN 421 THEN 'Tiradentes' -- 21/04
           WHEN 501 THEN 'Dia do Trabalho' -- 01/05
           WHEN 907 THEN 'Idependência do Brasil' -- 07/09
           WHEN 1012 THEN 'Nossa Sra. Aparecida' -- 12/10
           WHEN 1102 THEN 'Finados' -- 02/11
           WHEN 1115 THEN 'Proclamação da República' -- 15/11
           WHEN 1225 THEN 'Natal' -- 25/12
           WHEN 125 THEN 'Aniversário de São Paulo' -- 25/01
           WHEN 709 THEN 'Revolução Constitucionalista de 1932' -- 09/07
           WHEN 1120 THEN 'Consciência Negra' -- 20/11          
           WHEN EXTRACT(MONTH from DataPascoa) * 100 + EXTRACT(DAY from DataPascoa) THEN 'Páscoa'
           WHEN EXTRACT(MONTH from DataCarnaval) * 100 + EXTRACT(DAY from DataCarnaval) THEN 'Carnaval'
           WHEN EXTRACT(MONTH from DataQuartaCinzas) * 100 + EXTRACT(DAY from DataQuartaCinzas) THEN 'Quarta-feira de Cinzas'
           WHEN EXTRACT(MONTH from DataSextaSanta) * 100 + EXTRACT(DAY from DataSextaSanta) THEN 'Sexta-feira da Paixão'
           WHEN EXTRACT(MONTH from DataCorpusChristi) * 100 + EXTRACT(DAY from DataCorpusChristi) THEN 'Corpus Christi'
           ELSE ('NA')
     END ,
     TO_CHAR(Data - 1,'DD/MM/YYYY'),
     TO_CHAR((Data - extract(DAY from (Data))) + 1,'DD/MM/YYYY'),  
     TO_CHAR(ADD_MONTHS(Data,1) - extract(DAY from (Data)),'DD/MM/YYYY') ,
     TO_CHAR((ADD_MONTHS(Data,-3) - extract(DAY from (Data))) + 1,'DD/MM/YYYY'),
     TO_CHAR(extract(YEAR from Data)),
     TO_CHAR(extract(YEAR from Data)) || DECODE(TO_NUMBER(TO_CHAR(Data,'Q'))
            ,1,'01'
            ,2,'01'
            ,3,'02'
            ,4,'02'),
     TO_CHAR(extract(YEAR from Data)) || DECODE(TO_NUMBER(TO_CHAR(Data,'Q'))
            ,1,'01'
            ,2,'02'
            ,3,'03'
            ,4,'04'),
     add_months(Data,-12),
     TO_CHAR(Data - extract(DAY from Data),'DD/MM/YYYY')
      );
         
      Data := Data + 1;
END LOOP;
COMMIT;

END;
