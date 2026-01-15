USE ROLE SYSADMIN; 
USE WAREHOUSE WH_CAGED_XS;
USE DATABASE DB_CAGED; 
USE SCHEMA BRONZE;

CREATE OR REPLACE TABLE TBL_CAGED_MOVEMENTS(
-- Audit metadata
    _row_id NUMBER IDENTITY (1,1) PRIMARY KEY, 
    _source_file STRING, 
    _load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(), 
    _file_row_number NUMBER, 

-- Business data columns (all STRING to preserve raw values)
    competenciamov STRING,
    regiao STRING,
    uf STRING,
    municipio STRING,
    secao STRING,
    subclasse STRING,
    saldomovimentacao STRING,
    cbo2002ocupacao STRING,
    categoria STRING,
    graudeinstrucao STRING,
    idade STRING,
    horascontratuais STRING,
    racacor STRING,
    sexo STRING,
    tipoempregador STRING,
    tipoestabelecimento STRING,
    tipomovimentacao STRING,
    tipodedeficiencia STRING,
    indtrabintermitente STRING,
    indtrabparcial STRING,       
    salario STRING,
    tamestabjan STRING,
    indicadoraprendiz STRING,
    origemdainformacao STRING,
    competenciadec STRING,
    indicadordeforadoprazo STRING,
    unidadesalariocodigo STRING,
    valorsalariofixo STRING
)
COMMENT = 'Bronze layer: CAGED employment movements raw data from Ministry of Labor - minimal preprocessing (special characters removed, original structure preserved)';

SHOW TABLES LIKE 'TBL_CAGED_MOVEMENTS';

DESC TABLE TBL_CAGED_MOVEMENTS;
    
