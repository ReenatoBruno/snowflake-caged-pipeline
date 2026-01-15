USE ROLE SYSADMIN;
USE WAREHOUSE WH_CAGED_XS;
USE DATABASE DB_CAGED;
USE SCHEMA SILVER;

-- Transform and load Bronze data into Silver
INSERT INTO TBL_CAGED_MOVEMENTS (
    _bronze_row_id,
    _source_file,
    _bronze_load_timestamp,
    _is_valid,
    _validation_errors,
    competencia_mov,
    competencia_dec,
    regiao,
    uf,
    municipio,
    secao,
    subclasse,
    categoria,
    cbo2002_ocupacao,
    grau_de_instrucao,
    raca_cor,
    sexo,
    tipo_empregador,
    tipo_estabelecimento,
    tipo_movimentacao,
    tipo_de_deficiencia,
    origem_da_informacao,
    unidade_salario_codigo,
    idade,
    horas_contratuais,
    salario,
    saldo_movimentacao,
    tam_estab_jan,
    valor_salario_fixo,
    ind_trab_intermitente,
    ind_trab_parcial,
    indicador_aprendiz,
    indicador_fora_do_prazo
)
SELECT 
    -- Metadata from Bronze
    _row_id AS _bronze_row_id,
    _source_file,
    _load_timestamp AS _bronze_load_timestamp,
    
    -- Data quality validation
    CASE 
        WHEN competenciamov IS NULL 
          OR TRIM(competenciamov) = '' 
          OR uf IS NULL 
          OR TRIM(uf) = ''
        THEN FALSE 
        ELSE TRUE 
    END AS _is_valid,

    -- Validation errors - CAPTURES MULTIPLE ERRORS
    NULLIF(
        CONCAT_WS('',
            CASE WHEN competenciamov IS NULL OR TRIM(competenciamov) = '' 
                THEN 'Missing competencia; ' ELSE '' END,
            CASE WHEN uf IS NULL OR TRIM(uf) = '' 
                THEN 'Missing UF; ' ELSE '' END
        ),
        ''
    ) AS _validation_errors,
    
    -- String columns - cleaned (TRIM, UPPER where appropriate)
    TRIM(competenciamov) AS competencia_mov,
    TRIM(competenciadec) AS competencia_dec,
    UPPER(TRIM(regiao)) AS regiao,
    UPPER(TRIM(uf)) AS uf,
    TRIM(municipio) AS municipio,
    TRIM(secao) AS secao,
    TRIM(subclasse) AS subclasse,
    TRIM(categoria) AS categoria,
    TRIM(cbo2002ocupacao) AS cbo2002_ocupacao,
    TRIM(graudeinstrucao) AS grau_de_instrucao,
    TRIM(racacor) AS raca_cor,
    UPPER(TRIM(sexo)) AS sexo,
    TRIM(tipoempregador) AS tipo_empregador,
    TRIM(tipoestabelecimento) AS tipo_estabelecimento,
    TRIM(tipomovimentacao) AS tipo_movimentacao,
    TRIM(tipodedeficiencia) AS tipo_de_deficiencia,
    TRIM(origemdainformacao) AS origem_da_informacao,
    TRIM(unidadesalariocodigo) AS unidade_salario_codigo,
    
    -- Numeric conversions with NULL handling
    TRY_CAST(idade AS NUMBER) AS idade,
    TRY_CAST(horascontratuais AS NUMBER) AS horas_contratuais,
    TRY_CAST(salario AS NUMBER) AS salario,
    TRY_CAST(saldomovimentacao AS NUMBER) AS saldo_movimentacao,
    TRY_CAST(tamestabjan AS NUMBER) AS tam_estab_jan,
    TRY_CAST(valorsalariofixo AS NUMBER) AS valor_salario_fixo,
    
    -- Boolean conversions (assuming 1=TRUE, 0=FALSE, NULL=FALSE)
    CASE 
        WHEN TRIM(indtrabintermitente) = '1' THEN TRUE 
        ELSE FALSE 
    END AS ind_trab_intermitente,
    
    CASE 
        WHEN TRIM(indtrabparcial) = '1' THEN TRUE 
        ELSE FALSE 
    END AS ind_trab_parcial,
    
    CASE 
        WHEN TRIM(indicadoraprendiz) = '1' THEN TRUE 
        ELSE FALSE 
    END AS indicador_aprendiz,
    
    CASE 
        WHEN TRIM(indicadordeforadoprazo) = '1' THEN TRUE 
        ELSE FALSE 
    END AS indicador_fora_do_prazo
    
FROM BRONZE.TBL_CAGED_MOVEMENTS;

-- Quick verification
SELECT COUNT(*) AS rows_inserted FROM TBL_CAGED_MOVEMENTS;
