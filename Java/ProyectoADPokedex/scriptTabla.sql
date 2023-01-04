CREATE TABLE
    POKEMON
    (
        ENTRADA         INT(50) NOT NULL,
        NOMBRE          VARCHAR(50) NOT NULL,
        TIPO_PRINCIPAL  VARCHAR(50),
        TIPO_SECUNDARIO VARCHAR(50),
        HABILIDAD       VARCHAR(50),
        REGION          VARCHAR(50),
        ALTURA          FLOAT,
        PESO            FLOAT,
        CONSTRAINT PRIMARY KEY (ENTRADA)
    )
    COMMENT='Aqu� se guardar� informaci�n de distintos pokemones'