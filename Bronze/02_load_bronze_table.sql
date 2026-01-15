USE ROLE SYSADMIN;
USE WAREHOUSE WH_CAGED_XS;
USE DATABASE DB_CAGED;
USE SCHEMA BRONZE;

-- Load data from S3 stage into Bronze table
COPY INTO TBL_CAGED_MOVEMENTS
FROM (
    SELECT 
        DEFAULT,
        METADATA$FILENAME,
        CURRENT_TIMESTAMP(),
        METADATA$FILE_ROW_NUMBER,
        
        -- Data columns from file ($1, $2, $3...)
        $1,   -- competenciamov
        $2,   -- regiao
        $3,   -- uf
        $4,   -- municipio
        $5,   -- secao
        $6,   -- subclasse
        $7,   -- saldomovimentacao
        $8,   -- cbo2002ocupacao
        $9,   -- categoria
        $10,  -- graudeinstrucao
        $11,  -- idade
        $12,  -- horascontratuais
        $13,  -- racacor
        $14,  -- sexo
        $15,  -- tipoempregador
        $16,  -- tipoestabelecimento
        $17,  -- tipomovimentacao
        $18,  -- tipodedeficiencia
        $19,  -- indtrabintermitente
        $20,  -- indtrabparcial
        $21,  -- salario 
        $22,  -- tamestabjan 
        $23,  -- indicadoraprendiz 
        $24,  -- origemdainformacao 
        $25,  -- competenciadec 
        $26,  -- indicadordeforadoprazo 
        $27,  -- unidadesalariocodigo 
        $28   -- valorsalariofixo 
    FROM @s3_caged_stage
)
FILE_FORMAT = FF_CAGED_TXT
ON_ERROR = 'CONTINUE'
PURGE = FALSE;

-- Verify load results
SELECT 
    COUNT(*) AS total_rows_loaded,
    COUNT(DISTINCT _source_file) AS total_files_loaded,
    MIN(_load_timestamp) AS first_load_time,
    MAX(_load_timestamp) AS last_load_time
FROM TBL_CAGED_MOVEMENTS;

-- View sample data with metadata
SELECT 
    _row_id,
    _source_file,
    _load_timestamp,
    _file_row_number,
    competenciamov,
    regiao,
    uf,
    municipio,
    indtrabintermitente,
    indtrabparcial  
FROM TBL_CAGED_MOVEMENTS 
LIMIT 10;

