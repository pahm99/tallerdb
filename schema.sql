CREATE TABLE empleados(
    id_empleado         SERIAl PRIMARY KEY NOT NULL UNIQUE,
    nombre              VARCHAR NOT NULL, -- longitud maxima
    ap_paterno          VARCHAR NOT NULL,
    ap_materno          VARCHAR NOT NULL,
    salario             NUMERIC NOT NULL,
    telefono            VARCHAR(12) NOT NULL UNIQUE,
    RFC                 VARCHAR(18) NOT NULL UNIQUE,
    CURP                VARCHAR(18) NOT NULL UNIQUE,
    dir_calle           VARCHAR(100) NOT NULL,
    dir_localidad       VARCHAR(100) NOT NULL,
    dir_municipio       VARCHAR NOT NULL, -- lo correcto seria un catalogo de municipios
    dir_cp              VARCHAR(20) NOT NULL,
    dir_estado          VARCHAR NOT NULL,
    dir_no_int          VARCHAR(20),
    dir_no_ext          VARCHAR(20),
    empleado_jefe_id    INT REFERENCES empleados(id_empleado)
);  

CREATE TABLE ingenieros(
    id_ingeniero    SERIAL PRIMARY KEY NOT NULL UNIQUE,
    especialidad    VARCHAR(150) NOT NULL,
    escuela         VARCHAR NOT NULL,
    fecha_egreso    DATE NOT NULL,
    empleado_id     INT REFERENCES empleados(id_empleado) NOT NULL
);

CREATE TABLE tecnicos(
    id_tecnico      SERIAL PRIMARY KEY NOT NULL UNIQUE,
    observaciones   TEXT,
    empleado_id     INT REFERENCES empleados(id_empleado) NOT NULL
);

CREATE TABLE tecnico_habilidades(
    tecnico_habildiad_id    SERIAL PRIMARY KEY NOT NULL,
    hablidad                VARCHAR NOT NULL,
    experiencia             TEXT NOT NULL,
    tecnico_id              INT REFERENCES tecnicos(id_tecnico)
);


CREATE TABLE administrativos(
    id_administrativo   SERIAL PRIMARY KEY NOT NULL UNIQUE,
    observaciones       TEXT,
    empleado_id         INT REFERENCES empleados(id_empleado) NOT NULL
);

CREATE TABLE administrativo_estudios(
    id_adminstrativo_estudio    SERIAL PRIMARY KEY NOT NULL UNIQUE,
    curso_estudio               VARCHAR NOT NULL,
    descripción                 TEXT,
    administrativo_id           INT REFERENCES administrativos(id_administrativo) NOT NULL
);

CREATE TABLE pagos(
    id_pago     SERIAL PRIMARY KEY NOT NULL UNIQUE,
    subtotal    NUMERIC NOT NULL,
    bono        NUMERIC DEFAULT 0,
    descuento   NUMERIC DEFAULT 0,
    total       NUMERIC NOT NULL,
    fecha_pago  DATE DEFAULT now(),
    empleado_id INT REFERENCES empleados(id_empleado) NOT NULL
);

CREATE TABLE clientes(
    id_cliente      SERIAL PRIMARY KEY NOT NULL UNIQUE,
    nombre          VARCHAR NOT NULL,
    ap_paterno      VARCHAR NOT NULL,
    ap_materno      VARCHAR NOT NULL,
    rfc             VARCHAR(18) NOT NULL UNIQUE,
    curp            VARCHAR(18) NOT NULL UNIQUE,
    dir_calle       VARCHAR(100) NOT NULL,
    dir_localidad   VARCHAR(100) NOT NULL,
    dir_municipio   VARCHAR NOT NULL,
    dir_estado      VARCHAR NOT NULL,
    dir_cp          VARCHAR(20) NOT NULL,
    dir_no_int      VARCHAR(20),
    dir_no_ext      VARCHAR(20),
    observaciones   TEXT
);


create table cliente_contactos(
    id_cliente_contacto SERIAL PRIMARY KEY NOT NULL UNIQUE,
    nombre              VARCHAR NOT NULL,
    telefono            VARCHAR(15) NOT NULL,
    email               VARCHAR(100) NOT NULL UNIQUE,
    cliente_id          INT REFERENCES clientes(id_cliente) NOT NULL
);

CREATE TABLE marcas(
    id_marca    SERIAL PRIMARY KEY NOT NULL UNIQUE,
    nombre      VARCHAR NOT NULL UNIQUE
);

CREATE TABLE autos(
    id_auto         SERIAL PRIMARY KEY NOT NULL UNIQUE,
    fecha_alta      DATE DEFAULT now() NOT NULL,
    modelo          VARCHAR(50) NOT NULL,
    observaciones   TEXT,
    placas          VARCHAR(15) NOT NULL ,
    marca_id        INT REFERENCES marcas(id_marca) NOT NULL ,
    cliente_id      INT REFERENCES clientes(id_cliente) NOT NULL
);

CREATE TABLE ordenes_trabajos(
    id_orden_trabajo    SERIAL PRIMARY KEY NOT NULL UNIQUE,
    fecha_registro      DATE DEFAULT now(),
    sintomas            TEXT NOT NULL ,
    aprobado            BOOLEAN DEFAULT FALSE,
    subtotal            NUMERIC NOT NULL ,
    descuento           NUMERIC DEFAULT 0,
    total               NUMERIC NOT NULL ,
    auto_id             INT REFERENCES autos(id_auto) NOT NULL
);


CREATE TABLE proveedores(
    id_proveedor        SERIAL PRIMARY KEY NOT NULL UNIQUE,
    nombre              VARCHAR NOT NULL UNIQUE,
    observaciones       TEXT
);

CREATE TABLE refacciones(
    id_refaccion    SERIAL PRIMARY KEY NOT NULL UNIQUE,
    nombre          VARCHAR NOT NULL,
    costo           NUMERIC NOT NULL,
    proveedor_id    INT REFERENCES proveedores(id_proveedor) NOT NULL
);


CREATE TABLE orden_trabajo_equipo(
    orden_trabajo_equipo_id     SERIAL PRIMARY KEY NOT NULL UNIQUE,
    empleado_id                 INT REFERENCES empleados(id_empleado) NOT NULL,
    es_lider                    BOOL DEFAULT false,
    orden_trabajo_id            INT REFERENCES ordenes_trabajos(id_orden_trabajo) NOT NULL
);


CREATE TABLE servicios(
    id_servicio SERIAL PRIMARY KEY NOT NULL UNIQUE,
    nombre      VARCHAR NOT NULL,
    descripcion TEXT NOT NULL,
    costo       NUMERIC NOT NULl
);

CREATE TABLE orden_trabajo_servicios(
    id_orden_trabajo_servicio   SERIAL PRIMARY KEY NOT NULL UNIQUE,
    ---
    servicio_id                 INT REFERENCES servicios(id_servicio) NOT NULL,
    subtotal_servicio           NUMERIC NOT NULL,
    descuento_servicio          NUMERIC NOT NULL,
    total_servicio              NUMERIC NOT NULL, --- el servicio con descuento
    refaccion_id                INT REFERENCES refacciones(id_refaccion) NOT NULL,
    costo_refacion_unitario     NUMERIC NOT NULL,
    cantidad_refaciones         INT NOT NULL,
    subtotal_refaciones         NUMERIC NOT NULL, -- total de las refacciones sin descuento
    descuento_refaccion         NUMERIC NOT NULL,
    costo_refacion_total        NUMERIC NOT NULL, -- total de las refaccione con descuento
    total                       NUMERIC NOT NULL, -- es la suma del servicio total + refaciones total
    orden_trabajo_id            INT REFERENCES ordenes_trabajos(id_orden_trabajo) NOT NULL
);


