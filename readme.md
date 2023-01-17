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

**Objetivo:** Son todos los empleados que pertenecen al taller mecanico, su informacion personal y dirección


| Nombre             | Tipo de dato | Longitud | Descripción                   | Restriccion                                             |
|--------------------|--------------|----------|-------------------------------|---------------------------------------------------------|
| id_emplado         | serial       | -        | identificador de la tabla     | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria | 
| nombre             | varchar      | max      | nombre del empleado           | 1) no nulo                                              |
| ap_paterno         | varchar      | max      | ap. paterno del empleado      | 1) no nulo                                              |
| salario            | numeric      | default  | Salario base del empleado     | 1) no nulo                                              |
| telefono           | varchar      | 12       | numero personal del empleado  | 1) no nulo  <br/> 2) valor unico                        |
| RFC                | varchar      | 18       | RFC del empleado              | 1) no nulo <br/>  2) valor unico                        |
| CURP               | varchar      | 18       | CURP del empleado             | 1) no nulo  <br/> 2) valor unico                        |
| dir_calle          | varchar      | 100      | dirección calle               | 1) no nulo                                              |
| dir_localidad      | varchar      | 100      | direccion localidad           | 1) no nulo                                              |
| dir_cp             | varchar      | 20       | codigo postal                 | 1) no nulo                                              |
| dir_estado         | varchar      | max      | estado de residencia          | 1) no nulo                                              |
| dir_no_int         | varchar      | 20       | no. interior o otro similar   |                                                         |
| dir_no_ext         | varchar      | 20       | no. exterior o otro similar   |                                                         |
| empleado_jefe_id   | int          | default  | ID del empleado que su jefe   | hace referencia a si mismo para indicar su jefe         |

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

**Objetivo:** Es para aquellos empleados que son ingenieros y sus atributos extras, es decir, empleados especializados

| Nombre        | Tipo de dato | Longitud | Descripción                             | Restriccion                                                             |
|---------------|--------------|----------|-----------------------------------------|-------------------------------------------------------------------------|
| id_ingeniero  | serial       | -        | identificador de la tabla               | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria                 |
| especialidad  | varchar      | 150      | la especialidad como ingeniero          | 1) no nulo                                                              |
| escuela       | varchar      | max      | escuela de la que egreso                | 1) no nulo                                                              |
| fecha_egreso  | date         |          | feche en la que egreso                  | 1) no nulo                                                              |
| empleado_id   | int          |          | referencia del empleado especializado   | 1) no nulo, 2) hace referencia  la tabla de empleados con id _empleado  | 

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

**Objetivo:** Para los empleados que son _especializados_ en técnicos

| Nombre        | Tipo de dato | Longitud | Descripción               | Restriccion                                                            |
|---------------|--------------|----------|---------------------------|------------------------------------------------------------------------|
| id_tecnico    | serial       | -        | identificador de la tabla | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria                |
| observaciones | TEXT         |          | observaciones extras      | -                                                                      |
| empleado_id   | INT          |          | referencia a empleados    | 1) no nulo <br/> 2) referencia a la tabla de empleados con id_empleado |

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

**Objetivo:** almacena las habilidades que tiene el técnico (empleado especializado)

| Nombre               | Tipo de dato | Longitud | Descripción                                     | Restriccion                                                             |
|----------------------|--------------|----------|-------------------------------------------------|-------------------------------------------------------------------------|
| id_tecnico_habilidad | serial       | -        | identificador de la tabla                       | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria                 |
| habilidad            | VARCHAR      | max      | que habilidad es                                | 1) no nulo                                                              |
| tecnico_id           | INT         |          | la llave del tecnico que pertece la habilidad   | 1) no nulo <br/> 2) referencias con la tabla de tecnicos con id_tecnico |

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

**Objetivo:** Almacenar los empleados especializado como administrativos

| Nombre           | Tipo de dato | Longitud | Descripción                          | Restriccion                                                               |
|------------------|--------------|----------|--------------------------------------|---------------------------------------------------------------------------|
| id_admnistrativo | serial       | -        | identificador de la tabla            | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria                   |
| observaciones    | TEXT         |          | observaciones opcionales             |                                                                           |
| empleado_id      | INT          |          | id del empleado que se especializo   | 1) no null 2) <br/> 2) referencia a la table de empleados con id_empleado |
|

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

**Objetivo:** Almacenar los estudios de los administrativos

| Nombre               | Tipo de dato | Longitud | Descripción                      | Restriccion                                                |
|----------------------|--------------|----------|----------------------------------|------------------------------------------------------------|
| id_administrativo_id | serial       | -        | identificador de la tabla        | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria    |
| curso_estudio        | VARCHAR      | max      | nombre del curso                 | 1) no nulo                                                 |
| descripcion          | TEXT         |          | descripción extra sobre el curso |                                                            |
| administrativo_id    | INT          |          | id del empleado especializado    | 1) no nulo <br/> 2) referencia a empleados con id_empleado |

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

**Objetivo:** Almacenar el historico de pagos de los empleados


| Nombre        | Tipo de dato | Longitud | Descripción                         | Restriccion                                             |
|---------------|--------------|----------|-------------------------------------|---------------------------------------------------------|
| id_pago       | serial       |          | identificador de la tabla           | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria |
| subtotal      | NUMERIC      |          | lo que se le pago en ese momento    | 1) no null                                              |
| bono          | NUMERIC      |          | bono extra sobre su pago            | 1) cero por defecto                                     |
| descuento     | NUMERIC      |          | descuento o penilizacion            | 1) cero por defecto                                     |
| total         | NUMERIC      |          | es el (bono + subtotal) - descuento | 1) no null                                              |
| fecha_pago    | DATE         |          | fecha cuando se realizo el pago     | 1) default hoy (now())                                  |
| empleado_id   | INT          |          | id del empleado que se pago         | 1) no null <br/> 2) hace a empleados con id_empleado    |

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

**Objetivo:** Almacenar el Cátalogo de marcas

| Nombre   | Tipo de dato | Longitud | Descripción               | Restriccion                                              |
|----------|--------------|----------|---------------------------|----------------------------------------------------------|
| id_marca | serial       | -        | identificador de la tabla | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria  |
| nombre   | VARCHAR      | max      | nombre de la marca        | 1) no nulo <br/> 2) valor unico                          |

**dispadores:**
- Evitar que se pueda modificar los datos de la tabla

**SQL:**
```postgresql
CREATE TABLE marcas(
    id_marca    SERIAL PRIMARY KEY NOT NULL UNIQUE,
    nombre      VARCHAR
);
```
### autos

**Objetivo:**

| Nombre        | Tipo de dato | Longitud | Descripción                                     | Restriccion                                              |
|---------------|--------------|----------|-------------------------------------------------|----------------------------------------------------------|
| id_auto       | serial       | -        | identificador de la tabla                       | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria  |
| fecha_alta    | DATE         |          | fecha cuando se registro el auto                | 1) valor por defecto hoy  <br/> no nulo                  |  
| modelo        | VARCHAR      | 50       | modelo del carro, ya sea año o modelo especial  | 1) valor no nulo                                         |
| observaciones | TEXT         |          | Observaciones extras opcionales                 |                                                          |
| placas        | VARCHAR      | 15       | valor de las placas                             | 1) no nulo                                               |
| marca_id      | INT          |          | referencia a que es este carro                  | 1) no nulo <br/> 2) referencia a marcas con id_marca     |
| cliente_id    | INT          |          | referencia al id cliente que pertence el carro  | 2) no nulo <br/> 2) referencia a clientes con id_cliente |

**dispadores:**
- evitar la modificacion del campo fecha_alta

**SQL:**
```postgresql
CREATE TABLE autos(
    id_auto         SERIAL PRIMARY KEY NOT NULL UNIQUE,
    fecha_alta      DATE DEFAULT now() NOT NULL,
    modelo          VARCHAR(50) NOT NULL,
    observaciones   TEXT,
    placas          VARCHAR(15) NOT NULL ,
    marca_id        INT REFERENCES marcas(id_marca) NOT NULL ,
    cliente_id      INT REFERENCES clientes(id_cliente) NOT NULL
);
```
### clientes

**Objetivo:** Almacenar a los clientes que se les atiende

| Nombre        | Tipo de dato | Longitud | Descripción                 | Restriccion                                             |
|---------------|--------------|----------|-----------------------------|---------------------------------------------------------|
| id_cliente    | serial       | -        | identificador de la tabla   | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria |
| nombre        | VARCHAR      | max      | nombre del cliente          | 1) no nulo                                              |
| ap_paerno     | VARCHAR      | max      | su appelido paterno         | 2) no nulo                                              |
| rfc           | VARCHAR      | 18       |                             | 1) no nulo <br/> 2) valor unico                         |
| curp          | VARCHAR      | 18       |                             | 1) no nulo <br/> 2) valor unico                         |
| dir_calle     | VARCHAR      | 100      | dirección calle             | 1) no nulo                                              |
| dir_localidad | VARCHAR      | 100      | direccion localidad         | 1) no nulo                                              |
| dir_cp        | VARCHAR      | 20       | codigo postal               | 1) no nulo                                              |
| dir_estado    | VARCHAR      | max      | estado de residencia        | 1) no nulo                                              |
| dir_no_int    | VARCHAR      | 20       | no. interior o otro similar |                                                         |
| dir_no_ext    | VARCHAR      | 20       | no. exterior o otro similar |                                                         |
| observacion   | TEXT         |          | observacione opcionales     |                                                         |

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


**Objetivo:** Almacena los contactos de un cliente

| Nombre              | Tipo de dato | Longitud | Descripción                              | Restriccion                                                         |
|---------------------|--------------|----------|------------------------------------------|---------------------------------------------------------------------|
| id_cliente_contacto | serial       | -        | identificador de la tabla                | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria             |
| nombre              | VARCHAR      |          | nombre del contacto                      | 1) no nulo                                                          |
| telefono            | VARCHAR      | 15       | numero telefonico                        | 1) no nulo                                                          |
| email               | VARCHAR      | 100      | email de contacto                        | 1) no nulo <br/> 2) valor unico                                     |
| cliente_id          | INT          |          | id cliente quien pertenece el contacto   | 1) no nulo <br/> 2) referenci a la tabla de clientes con id_cliente |


**dispadores:**

**SQL:**
```postgresql
create table cliente_contactos(
    id_cliente_contacto SERIAL PRIMARY KEY NOT NULL UNIQUE,
    nombre              VARCHAR NOT NULL,
    telefono            VARCHAR(15) NOT NULL,
    email               VARCHAR(100) NOT NULL UNIQUE,
    cliente_id          INT REFERENCES clientes(id_cliente) NOT NULL
);
```
### proveedores


**Objetivo:** Almacena a nuestro proveedores

| Nombre         | Tipo de dato | Longitud | Descripción                | Restriccion                                             |
|----------------|--------------|----------|----------------------------|---------------------------------------------------------|
| id_proveedor   | serial       | -        | identificador de la tabla  | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria |
| nombre         | VARCHAR      | max      | nombre del proveedor       | 1) no nulo <br/> 2) valor unico                         |
| observaciones  | TEXT         |          | observaciones opcionales   |                                                         | 

**dispadores:**

**SQL:**
```postgresql
CREATE TABLE proveedores(
    id_proveedor        SERIAL PRIMARY KEY NOT NULL UNIQUE,
    nombre              VARCHAR NOT NULL UNIQUE,
    observaciones       TEXT
);
```
### refacciones


**Objetivo:** Cátalogo de proveedores

| Nombre         | Tipo de dato | Longitud | Descripción                           | Restriccion                                                     |
|----------------|--------------|----------|---------------------------------------|-----------------------------------------------------------------|
| id_refaccion   | serial       | -        | identificador de la tabla             | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria         |
| nombre         | VARCHAR      |          | nombre de la refacción                | 1) no nulo                                                      |
| costo          | NUMERIC      |          | costo en su momomento de la refaccion | 1) valor no nulo <br/> 2) mayor a cero                          |
| proveedor_id   | INT          |          | referencia del quien lo provee        | 1) no nulo <br/> 2) referencia con proveedores con id_proveedor |

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


**Objetivo:** Cátalgo de servicios

| Nombre      | Tipo de dato | Longitud | Descripción                        | Restriccion                                             |
|-------------|--------------|----------|------------------------------------|---------------------------------------------------------|
| id_servicio | serial       | -        | identificador de la tabla          | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria |
| nombre      | VARCHAR      | max      | nombre del serivicio               | 1) no nulo                                              |
| descripcion | TEXT         | max      | descripcion de la refaccion        | 1) no nulo                                              |
| costo       | NUMERIC      |          | costo del servicio en su momento   | 1) no nulo <br/> 2) mayor a cero                        |

**dispadores:**

**SQL:**
```postgresql
CREATE TABLE servicios(
    id_servicio SERIAL PRIMARY KEY NOT NULL UNIQUE,
    nombre      VARCHAR NOT NULL,
    descripcion TEXT NOT NULL,
    costo       NUMERIC NOT NULL
);
```
### orden_trabajo


**Objetivo:** Almacena los trabajos realizados hacia un carro de un cliente

| Nombre           | Tipo de dato | Longitud | Descripción                         | Restriccion                                             |
|------------------|--------------|----------|-------------------------------------|---------------------------------------------------------|
| id_orden_trabajo | serial       | -        | identificador de la tabla           | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria |
| fecha_registro   | DATE         |          | fecha de registro                   | 1) valor por defecto hoy                                |
| sintomas         | TEXT         |          | sintomas del carro                  | 1) no nulo                                              |
| aprobado         | BOOLEAN      |          | si pasa el visto bueno, se trabaja  | 1) valor por defecto nulo                               |
| subtotal         | NUMERIC      |          | el importe sin descuentos y sin iva | 1) no nulo <br/> mayor que cero                         |
| descuento        | NUMERIC      |          | Descuento total                     | 1) valor por defecto cero                               |
| total            | NUMERIC      |          | el (subtotal + iva) - descuento     | 1) no nulo                                              |
| auto_id          | INT          |          | referencia al auto que se trabaja   | 1) no nulo <br/> 2) referencia a autos con id_auto      |

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


**Objetivo:** Almacena a los empleados que van a trabajar son un orden de trabajo 

| Nombre                  | Tipo de dato | Longitud | Descripción                        | Restriccion                                                          |
|-------------------------|--------------|----------|------------------------------------|----------------------------------------------------------------------|
| id_orden_trabajo_equipo | serial       | -        | identificador de la tabla          | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria              |
| empleado_id             | INT          |          | referencia a empleados             | 1) no nulo  <br/> 2) referencia a empleados con id_emplado           |
| es_lider                | BOOLEAN      |          | indica si este miembro es el lider | 1) valor por defecto false                                           |
| orden_trabajo_id        | INT          |          | referencia a la orden de trabajo   | 1) no nulo <br/> 2) referencia a orden_trabajos con id_orden_trabajo |

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


**Objetivo:** Almacena los servicios realizados a una orden de trabajo y por ende al carro, asi como refacciones usadas

| Nombre                    | Tipo de dato | Longitud | Descripción                                     | Restriccion                                                           |
|---------------------------|--------------|----------|-------------------------------------------------|-----------------------------------------------------------------------|
| id_orden_trabajo_servicio | serial       | -        | identificador de la tabla                       | 1) valor unico,<br/> 2) no nulo <br/> 3) llave primaria               |
| servicio_id               | INT          |          | referencia del servicio a realizar              | 1) no nulo <br/> 2) referencia a servicios con id_servicio            |
| subtotal_servicio         | NUMERIC      |          | el subtotal de servicio sin descuento           | 1) no nulo <br/> 2) mayor a cero                                      |
| descuento_servicio        | NUMERIC      |          | el descuento total del servicio                 | 1) no nulo                                                            |
| total_servicio            | NUMERIC      |          | el subtotal servicio - el descuento de servicio | 1) no nulo                                                            |
| refaccion_id              | INT          |          | referencia a la refaccion utilizada             | 1) no nulo <br/> 2) referencia refacciones con id_refaccion           |
| costo_refacion_unitario   | NUMERIC      |          | costo unitario de la refaccion en el momento    | 1) no nulo  <br/> mayor a cero                                        |
| cantidad_refaciones       | INT          |          | cantidad refacciones utilizadas                 | 1) no nulo <br/> 2) mayor a cero                                      |
| subtotal_refacciones      | NUMERIC      |          | costo refaccion unitario * cantidad             | 1) no nulo <br/> 2) mayor a cero                                      | 
| descuento refacciones     | NUMERIC      |          | descuento unicatario sobre la refaccion         | 1) no nulo <br/> 2= mayor a cero                                      |
| costo_refaccion_total     | NUMERIC      |          | es total de refacciones + total de serivicios   | 1) no nulo  <br/> 2) mayor a cero                                     |
| orden_trabajo_id          | INT          |          | referencia a la roden de trabajo                | 1) no nulo <br/> 2) referencia a ordenes_trabajo con id_orden_trabajo |

**dispadores:** evitar modificar la tabla y valores calculados

## SQL
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