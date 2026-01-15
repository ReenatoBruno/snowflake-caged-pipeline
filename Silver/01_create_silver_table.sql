USE ROLE SYSADMIN;
USE WAREHOUSE WH_CAGED_XS;
USE DATABASE DB_CAGED;
USE SCHEMA SILVER;

-- Create Silver table with proper types and standardized names
CREATE OR REPLACE TABLE TBL_CAGED_MOVEMENTS (

-- Audit metadata
    _silver_row_id NUMBER IDENTITY(1,1) PRIMARY KEY,
    _bronze_row_id NUMBER NOT NULL,
    _source_file STRING,
    _bronze_load_timestamp TIMESTAMP_NTZ,
    _silver_processed_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    
-- Data quality flags
    _is_valid BOOLEAN,
    _validation_errors STRING,
    
-- Business keys
    competencia_mov STRING,
    competencia_dec STRING,
    
-- Dimensions
    regiao STRING,
    uf STRING,
    municipio STRING,
    secao STRING,
    subclasse STRING,
    categoria STRING,
    cbo2002_ocupacao STRING,
    grau_de_instrucao STRING,
    raca_cor STRING,
    sexo STRING,
    tipo_empregador STRING,
    tipo_estabelecimento STRING,
    tipo_movimentacao STRING,
    tipo_de_deficiencia STRING,
    origem_da_informacao STRING,
    unidade_salario_codigo STRING,

-- Numeric measures
    idade NUMBER(3,0),                   
    horas_contratuais NUMBER(5,2),        
    salario NUMBER(18,2),                 
    saldo_movimentacao NUMBER(10,0),      
    tam_estab_jan NUMBER(10,0),           
    valor_salario_fixo NUMBER(18,2),

-- Flags/Indicators
    ind_trab_intermitente BOOLEAN,
    ind_trab_parcial BOOLEAN,
    indicador_aprendiz BOOLEAN,
    indicador_fora_do_prazo BOOLEAN
)
COMMENT = 'Silver layer: CAGED cleaned and typed employment movements data with standardized column names';

SHOW TABLES LIKE 'TBL_CAGED_MOVEMENTS';

DESC TABLE TBL_CAGED_MOVEMENTS;