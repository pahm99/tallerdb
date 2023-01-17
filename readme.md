# Proyecto base de datos en Postgres, taller mecanico

## Problema

Un taller mecánico desea un sistema para control de sus operaciones. Considere lo siguiente:

En el taller se tienen diferentes tipos de empleados: Ingeniero, técnicos y administrativos. De todos se necesitan sus nombres, dirección y teléfonos de contacto (casa, celular, etc). De los Ingenieros se necesita saber su área de especialidad, la escuela y fecha de graduación. De los técnicos se desea saber sus habilidades y nivel de experiencia en dichas habilidades. Los administrativos por otro lado tienen estudios que se desean conocer (carrera, cursos, etc).

Todos los tienen un salario base quincenal, pero dicho pago varia de acuerdo a descuentos y bonos de productividad, se desea tener el control de todos los pagos para fines contables, también todos tienen un jefe único que es con el que se reportan y tratan las situaciones que se presentan, excepto el gerente general que no tiene jefe. Si un empleado falta un dia, se le realiza un descuento equivalente al 10% de su salario base actual.

Es necesario tener el registro de los clientes, en especial el rfc, nombre y dirección para facturación, aunque otros datos como la antigüedad desde que se dio de alta y edad se requieren para promociones. También es importante notar que se pueden tener como clientes a empresas, en cuyo caso se tendría como contacto a una o varias personas.

De los autos nos interesa saber a que cliente pertenecen, marca, modelo y placas.

Cuando un cliente lleva un auto se dan de alta los síntomas, quejas o servicios solicitados por el cliente. Posteriormente un ingeniero lo recibe y forma un equipo de trabajo para revisarlo. Este equipo de revisión, forzosamente debe tener por lo menos un ingeniero y puede o no tener mas integrantes ya sean técnicos o ingenieros. Una vez revisado, se hace el diagnostico, se cotiza (incluidas refacciones) y si el cliente esta de acuerdo con la cotización se realiza la reparación correspondiente por el mismo u otro equipo.

Los equipos de trabajo no son fijos y cambian con cada trabajo realizado. Además, aunque todos tienen un jefe inmediato, en los equipos de trabajo también se especifica un líder.

Las reparaciones se realizan en áreas específicas, cada una de las cuales tiene medidas diferentes (largo, ancho y alto) y su respectiva herramienta.

Las refacciones usadas no se tienen en inventario y se piden a los proveedores cuando se necesitan. Los servicios ofrecidos, tales como mano de obra, revisión general, ajuste de frenos, etc. existen en un catalogo y tienen un precio sugerido. Aunque las refacciones son solicitadas por los mecánicos, los únicos que pueden comprarla son administrativos. Las refacciones compradas para la reparación y su costo se almacenan para fines contables.

Tanto en la cotización como en la reparación se incluyen los servicios y las refecciones consumidas, asi como el 16% de iva, esta información se debe almacenar para fines contables.

## Diagrama ER

![Diagrama ER](./EntidadRelacion.svg)

## Esquema Relacional

TODO

## Descripción de tablas

### empleados

**Objetivo:** Son todos los empleados que pertenecen al taller mecanico

**Atributos:**

| Nombre     | Tipo de dato | Longitud | Descripción                  | Restriccion                                             |
|------------|--------------|----------|------------------------------|---------------------------------------------------------|
| id_emplado | serial       | -        | identificador de la tabla    | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria | 
| nombre     | varchar      | max      | nombre del empleado          | 1) no nulo                                              |
| ap_paterno | varchar      | max      | ap. paterno del empleado     | 1) no nulo                                              |
| salario    | numeric      | default  | Salario base del empleado    | 1) no nulo                                              |
| telefono   | varchar      | 12       | numero personal del empleado | 1) no nulo  <br/> 2) valor unico                        |
| RFC        | varchar      | 18       | RFC del empleado             | 1) no nulo <br/>  2) valor unico                        |
| CURP       | varchar      | 18       | CURP del empleado            | 1) no nulo  <br/> 2) valor unico                        |
|

**dispadores:**

**SQL:**
```postgresql
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

```
### ingenieros

**Atributos:**

**Objetivo:**

| Nombre       | Tipo de dato | Longitud | Descripción                  | Restriccion                                               |
|--------------|--------------|----------|------------------------------|-----------------------------------------------------------|
| id_ingeniero | serial       | -        | identificador de la tabla    | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria   |

**dispadores:**

**SQL:**
```postgresql
CREATE TABLE ingenieros(
    id_ingeniero    SERIAL PRIMARY KEY NOT NULL UNIQUE,
    especialidad    VARCHAR(150) NOT NULL,
    escuela         VARCHAR NOT NULL,
    fecha_egreso    DATE NOT NULL,
    empleado_id     INT REFERENCES empleados(id_empleado) NOT NULL
);
```
### tecnicos

**Atributos:**

**Objetivo:**

| Nombre     | Tipo de dato | Longitud | Descripción                  | Restriccion                                               |
|------------|--------------|----------|------------------------------|-----------------------------------------------------------|
| id_tecnico | serial       | -        | identificador de la tabla    | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria   |

**dispadores:**

**SQL:**
```postgresql
CREATE TABLE tecnicos(
    id_tecnico      SERIAL PRIMARY KEY NOT NULL UNIQUE,
    observaciones   TEXT,
    empleado_id     INT REFERENCES empleados(id_empleado) NOT NULL
);

```
### tecnicos_habilidades

**Atributos:**

**Objetivo:**

| Nombre               | Tipo de dato | Longitud | Descripción                  | Restriccion                                               |
|----------------------|--------------|----------|------------------------------|-----------------------------------------------------------|
| id_tecnico_habilidad | serial       | -        | identificador de la tabla    | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria   |

**dispadores:**

**SQL:**
```postgresql

CREATE TABLE tecnico_habilidades(
    tecnico_habildiad_id    SERIAL PRIMARY KEY NOT NULL,
    hablidad                VARCHAR NOT NULL,
    experiencia             TEXT NOT NULL,
    tecnico_id              INT REFERENCES tecnicos(id_tecnico)
);
```
### administrativos

**Atributos:**

**Objetivo:**

| Nombre           | Tipo de dato | Longitud | Descripción                  | Restriccion                                               |
|------------------|--------------|----------|------------------------------|-----------------------------------------------------------|
| id_admnistrativo | serial       | -        | identificador de la tabla    | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria   |

**dispadores:**

**SQL:**
```postgresql
CREATE TABLE administrativos(
    id_administrativo   SERIAL PRIMARY KEY NOT NULL UNIQUE,
    observaciones       TEXT,
    empleado_id         INT REFERENCES empleados(id_empleado) NOT NULL
);
```
### administrativos_estudios

**Atributos:**

**Objetivo:**

| Nombre               | Tipo de dato | Longitud | Descripción                  | Restriccion                                               |
|----------------------|--------------|----------|------------------------------|-----------------------------------------------------------|
| id_administrativo_id | serial       | -        | identificador de la tabla    | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria   |
|

**dispadores:**

**SQL:**
```postgresql
CREATE TABLE administrativo_estudios(
    id_adminstrativo_estudio    SERIAL PRIMARY KEY NOT NULL UNIQUE,
    curso_estudio               VARCHAR,
    descripción                 TEXT,
    administrativo_id           INT REFERENCES administrativos(id_administrativo) NOT NULL
);

```

### pagos

**Atributos:**

**Objetivo:**


| Nombre  | Tipo de dato | Longitud | Descripción                  | Restriccion                                               |
|---------|--------------|----------|------------------------------|-----------------------------------------------------------|
| id_pago | serial       | -        | identificador de la tabla    | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria   |

**dispadores:**

**SQL:**
```postgresql
CREATE TABLE pagos(
    id_pago     SERIAL PRIMARY KEY NOT NULL UNIQUE,
    subtotal    NUMERIC NOT NULL,
    bono        NUMERIC DEFAULT 0,
    descuento   NUMERIC DEFAULT 0,
    total       NUMERIC NOT NULL,
    fecha_pago  DATE DEFAULT now(),
    empleado_id INT REFERENCES empleados(id_empleado) NOT NULL
);
```
### marcas

**Atributos:**

**Objetivo:**

| Nombre   | Tipo de dato | Longitud | Descripción                  | Restriccion                                               |
|----------|--------------|----------|------------------------------|-----------------------------------------------------------|
| id_marca | serial       | -        | identificador de la tabla    | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria   | 

**dispadores:**

**SQL:**
```postgresql
CREATE TABLE marcas(
    id_marca    SERIAL PRIMARY KEY NOT NULL UNIQUE,
    nombre      VARCHAR
);
```
### autos

**Atributos:**

**Objetivo:**

| Nombre  | Tipo de dato | Longitud | Descripción                  | Restriccion                                               |
|---------|--------------|----------|------------------------------|-----------------------------------------------------------|
| id_auto | serial       | -        | identificador de la tabla    | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria   |

**dispadores:**

**SQL:**
```postgresql
CREATE TABLE autos(
    id_auto         SERIAL PRIMARY KEY NOT NULL UNIQUE,
    fecha_alta      DATE DEFAULT now(),
    modelo          VARCHAR(50) NOT NULL,
    observaciones   TEXT,
    placas          VARCHAR(15) NOT NULL ,
    marca_id        INT REFERENCES marcas(id_marca) NOT NULL ,
    cliente_id      INT REFERENCES clientes(id_cliente) NOT NULL
);
```
### clientes

**Atributos:**

**Objetivo:**

| Nombre     | Tipo de dato | Longitud | Descripción                  | Restriccion                                               |
|------------|--------------|----------|------------------------------|-----------------------------------------------------------|
| id_cliente | serial       | -        | identificador de la tabla    | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria   |

**dispadores:**

**SQL:**
```postgresql
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
```
### clientes_contactos

**Atributos:**

**Objetivo:**

| Nombre              | Tipo de dato | Longitud | Descripción                  | Restriccion                                               |
|---------------------|--------------|----------|------------------------------|-----------------------------------------------------------|
| id_cliente_contacto | serial       | -        | identificador de la tabla    | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria   | 

**dispadores:**

**SQL:**
```postgresql
create table cliente_contactos(
    id_cliente_contacto SERIAL PRIMARY KEY NOT NULL UNIQUE,
    nombre              VARCHAR NOT NULL,
    telefono            VARCHAR(15) NOT NULL,
    email               VARCHAR(100) NOT NULL,
    cliente_id          INT REFERENCES clientes(id_cliente) NOT NULL
);
```
### proveedores

**Atributos:**

**Objetivo:**

| Nombre       | Tipo de dato | Longitud | Descripción                  | Restriccion                                               |
|--------------|--------------|----------|------------------------------|-----------------------------------------------------------|
| id_proveedor | serial       | -        | identificador de la tabla    | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria   | 

**dispadores:**

**SQL:**
```postgresql
CREATE TABLE proveedores(
    id_proveedor        SERIAL PRIMARY KEY NOT NULL UNIQUE,
    nombre              VARCHAR NOT NULL,
    observaciones       TEXT
);
```
### refacciones

**Atributos:**

**Objetivo:**

| Nombre       | Tipo de dato | Longitud | Descripción                  | Restriccion                                               |
|--------------|--------------|----------|------------------------------|-----------------------------------------------------------|
| id_refaccion | serial       | -        | identificador de la tabla    | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria   |

**dispadores:**

**SQL:**
```postgresql
CREATE TABLE refacciones(
    id_refaccion    SERIAL PRIMARY KEY NOT NULL UNIQUE,
    nombre          VARCHAR NOT NULL,
    costo           NUMERIC NOT NULL,
    proveedor_id    INT REFERENCES proveedores(id_proveedor) NOT NULL
);
```
### servicios

**Atributos:**

**Objetivo:**

| Nombre      | Tipo de dato | Longitud | Descripción                  | Restriccion                                               |
|-------------|--------------|----------|------------------------------|-----------------------------------------------------------|
| id_servicio | serial       | -        | identificador de la tabla    | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria   |

**dispadores:**

**SQL:**
```postgresql
CREATE TABLE servicios(
    id_servicio SERIAL PRIMARY KEY NOT NULL UNIQUE,
    nombre      VARCHAR NOT NULL,
    descripcion TEXT NOT NULL,
    costo       NUMERIC
);
```
### orden_trabajo

**Atributos:**

**Objetivo:**

| Nombre           | Tipo de dato | Longitud | Descripción                  | Restriccion                                               |
|------------------|--------------|----------|------------------------------|-----------------------------------------------------------|
| id_orden_trabajo | serial       | -        | identificador de la tabla    | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria   | 

**dispadores:**

**SQL:**
```postgresql
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
```
### orden_trabajo_equipo

**Atributos:**

**Objetivo:**

| Nombre                  | Tipo de dato | Longitud | Descripción                  | Restriccion                                               |
|-------------------------|--------------|----------|------------------------------|-----------------------------------------------------------|
| id_orden_trabajo_equipo | serial       | -        | identificador de la tabla    | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria   |

**dispadores:**

**SQL:**
```postgresql
CREATE TABLE orden_trabajo_equipo(
    orden_trabajo_equipo_id     SERIAL PRIMARY KEY NOT NULL UNIQUE,
    empleado_id                 INT REFERENCES empleados(id_empleado) NOT NULL,
    es_lider                    BOOL DEFAULT false,
    orden_trabajo_id            INT REFERENCES ordenes_trabajos(id_orden_trabajo) NOT NULL
);

```
### orden_trabajo_servicios

**Atributos:**

**Objetivo:**

| Nombre                    | Tipo de dato | Longitud | Descripción                  | Restriccion                                               |
|---------------------------|--------------|----------|------------------------------|-----------------------------------------------------------|
| id_orden_trabajo_servicio | serial       | -        | identificador de la tabla    | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria   |

```postgresql
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
```

## Consultas SQL
```postgresql
-- 1.-
select
    e.nombre as empleado,
    m.nombre as marca,
    a.modelo,
    a.placas,
    c.nombre as cliente,
    r.nombre as refaccion,
    p.nombre as proveedor
from empleados e
join orden_trabajo_equipo ote on e.id_empleado = ote.empleado_id
join ordenes_trabajos ot on ote.orden_trabajo_id = ot.id_orden_trabajo
join autos a on ot.auto_id = a.id_auto
join marcas m on a.marca_id = m.id_marca
join clientes c on a.cliente_id = c.id_cliente
join orden_trabajo_servicios ots on ot.id_orden_trabajo = ots.orden_trabajo_id
join refacciones r on ots.refaccion_id = r.id_refaccion
join proveedores p on r.proveedor_id = p.id_proveedor
where empleado_id in (select empleado_id from tecnicos)
or empleado_id in(select empleado_id from ingenieros);
-- 2
select
    sum(ots.subtotal_refaciones) as subtotal_refacciones,
    sum(ots.descuento_refaccion * ots.cantidad_refaciones) as descuento_refacciones,
    sum(ots.costo_refacion_total) as total_refacciones,
    p.nombre as proveedor
from orden_trabajo_servicios ots
join refacciones r on ots.refaccion_id = r.id_refaccion
join proveedores p on r.proveedor_id = p.id_proveedor
group by p.id_proveedor;
-- 3
-- y nos traemos a los empleados, excluyendo a los trabajadores que si trabajaron estos tres ultimos dias
select * from empleados where not id_empleado in (
    -- traemos a los que si trabajaron es ultimos 3 dias
    select e.id_empleado from ordenes_trabajos ot
    join orden_trabajo_equipo ote on ot.id_orden_trabajo = ote.orden_trabajo_id
    right join empleados e on e.id_empleado = ote.empleado_id
    where extract(days from age(now(),ot.fecha_registro)) < 3
);
-- 4 total por servicio, considerando tambien las refaccione usadas
select sum(ots.total),s.nombre from orden_trabajo_servicios ots
join servicios s on ots.servicio_id = s.id_servicio
group by s.id_servicio;
-- 5
select 'total de empleados' as tipo_egreso,sum(total) as total from pagos
union
select 'total de ingenieros' as tipo_egreso, sum(total) as total
from pagos where empleado_id in (select ingenieros.empleado_id from ingenieros)
union
select 'total de tecnicos' as tipo_egreso, sum(total) as total from pagos
where empleado_id in (select empleado_id from tecnicos)
union
select 'total de adminstrativos' as tipo_egreo,coalesce(sum(total),0) as total from pagos
where empleado_id in (select empleado_id from administrativos)
union
select
    'total de gasto en refaccions' as tipo_egreso,
    sum(ots.costo_refacion_total) as total
from orden_trabajo_servicios ots
union
select
    'total' as tipo_egreso,
    (
        select
        (select sum(total) as total from pagos) +
        (
            select sum(total) as total
            from pagos where empleado_id in (select ingenieros.empleado_id from ingenieros)
        ) +
        (
            select sum(total) as total from pagos
            where empleado_id in (select empleado_id from tecnicos)
        ) +
        (
            select coalesce(sum(total),0) as total from pagos
            where empleado_id in (select empleado_id from administrativos)
        ) +
        (select sum(ots.costo_refacion_total) as total from orden_trabajo_servicios ots)

    ) as total
order by tipo_egreso;
```