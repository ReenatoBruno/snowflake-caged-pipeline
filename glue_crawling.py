import unicodedata

# Reading file from Glue schema

text = open("caged_schema.txt", "r", encoding="utf-8").read()

rows = [r.strip() for r in text.split("\n") if r.strip()]

columns = []
types = []

i = 0
while i < len(rows):
    if rows[i].isdigit():
        name = rows[i+1]
        type_ = rows[i+2]

        # remove acentos automaticamente
        clean_name = ''.join(
            c for c in unicodedata.normalize('NFKD', name)
            if not unicodedata.combining(c)
        )

        columns.append(clean_name)
        types.append(type_)
        i += 5
    else:
        i += 1

# 1. Column name + type
print("\n--- COLUMN AND TYPE ---\n")
for c, t in zip(columns, types):
    print(f"{c} {t.upper()},")

# 2. Only the column name
print("\n--- COLUMN'S NAME ---\n")
for c in columns:
    print(c)

# SELECT Silver

print("\n--- SELECT SILVER ---\n")
for c, t in zip(columns, types):
    if t.lower() == "bigint":
        print(f"    TRY_TO_NUMBER(data_raw:{c}::STRING),")
    else:
        print(f"    data_raw:{c}::STRING,")




columns = [
    ("competencias_mov", "NUMBER"),
    ("regiao", "NUMBER"),
    ("uf", "NUMBER"),
    ("municipio", "NUMBER"),
    ("secao", "VARCHAR"),
    ("subclasse", "NUMBER"),
    ("saldo_movimentacao", "NUMBER"),
    ("cbo2002_ocupacao", "NUMBER"),
    ("categoria", "NUMBER"),
    ("grau_de_instrucao", "NUMBER"),
    ("idade", "NUMBER"),
    ("horas_contratuais", "NUMBER(5,2)"),
    ("raca_cor", "NUMBER"),
    ("sexo", "NUMBER"),
    ("tipo_empregador", "NUMBER"),
    ("tipo_estabelecimento", "NUMBER"),
    ("tipo_movimentacao", "NUMBER"),
    ("tipo_deficiencia", "NUMBER"),
    ("ind_trab_intermitente", "NUMBER"),
    ("ind_trab_parcial", "NUMBER"),
    ("salario", "NUMBER(18,2)"),
    ("tam_estab_jan", "NUMBER"),
    ("indicador_aprendiz", "NUMBER"),
    ("origem_da_informacao", "NUMBER"),
    ("competencia_dec", "NUMBER"),
    ("indicador_fora_do_prazo", "NUMBER"),
    ("unidade_salario_codigo", "NUMBER"),
    ("valor_salario_fixo", "NUMBER(18,2)")
]

# Gera SELECT com SPLIT automático
for i, (name, dtype) in enumerate(columns):
    print(f"    SPLIT(data_raw, ';')[{i}]::{dtype} AS {name},")
