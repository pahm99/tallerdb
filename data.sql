INSERT INTO empleados(
                      id_empleado,
                      nombre,
                      ap_paterno,
                      ap_materno,
                      salario,
                      telefono,
                      rfc,
                      curp,
                      dir_calle,
                      dir_localidad,
                      dir_municipio,
                      dir_estado,
                      dir_cp,
                      dir_no_int,
                      dir_no_ext,
                      empleado_jefe_id
                      )
VALUES (
        1,
        'Pedro Alonso',
        'Herrera',
        'Mauricio',
        22500,
        '5582995359',
        'HEMP991207HDF32',
        'HEMP991207HDFRRD06',
        'Av Benito juarez',
        'Iztapalapa',
        'El Molino Tezonco',
        'CDMX',
        '09960',
        'Mz 37',
        'Lt 9',
        NULL
        );

INSERT INTO ingenieros(id_ingeniero,escuela, especialidad, fecha_egreso, empleado_id)
VALUES (1,'Escuela Superior de Computo','Ingeneria en Sistemas Computacionales','2025-06-18',1);

---

INSERT INTO empleados(
                      id_empleado,
                      nombre,
                      ap_paterno,
                      ap_materno,
                      salario,
                      telefono,
                      rfc,
                      curp,
                      dir_calle,
                      dir_localidad,
                      dir_municipio,
                      dir_estado,
                      dir_cp,
                      dir_no_int,
                      dir_no_ext,
                      empleado_jefe_id
                      )
VALUES (
        2,
        'Luis',
        'Melga',
        'Moreno',
        10000,
        '5511912389',
        'LUME121457JDF34',
        'LUME121457JDFLLD07',
        'Av Calle 11',
        'Iztapalapa',
        'San Andres',
        'CDMX',
        '07780',
        'N\A',
        'N\A',
        1
        );

INSERT INTO tecnicos(id_tecnico, observaciones, empleado_id)
VALUES
(1,NULL,2);

INSERT INTO tecnico_habilidades(hablidad, experiencia, tecnico_id)
VALUES
('Correcion de cajas automaticas','5 años en General Motors',1),
('Mantenimiento de clutch','3 años en Chevrolet',1);


---
INSERT INTO empleados(
                      id_empleado,
                      nombre,
                      ap_paterno,
                      ap_materno,
                      salario,
                      telefono,
                      rfc,
                      curp,
                      dir_calle,
                      dir_localidad,
                      dir_municipio,
                      dir_estado,
                      dir_cp,
                      dir_no_int,
                      dir_no_ext,
                      empleado_jefe_id
                      )
VALUES (
        3,
        'Marcos',
        'Ventura',
        'Nuñez',
        8000,
        '5514183999',
        'MVN324689JDK78',
        'MVN324689JDKQQ09',
        'Av principal',
        'Topilejo',
        'Centro',
        'CDMX',
        '00089',
        'N\A',
        'N\A',
        1
        );

INSERT INTO tecnicos(id_tecnico, observaciones, empleado_id)
VALUES (2,'RECIEN TITULADO',3);

INSERT INTO tecnico_habilidades(hablidad, experiencia, tecnico_id)
VALUES('Pintura de chasis','10 Años, negocio particular',2);

INSERT INTO tecnico_habilidades(hablidad, experiencia, tecnico_id)
VALUES('ojaletero','10 Años, negocio particular',2);

--


INSERT INTO empleados(
                      id_empleado,
                      nombre,
                      ap_paterno,
                      ap_materno,
                      salario,
                      telefono,
                      rfc,
                      curp,
                      dir_calle,
                      dir_localidad,
                      dir_municipio,
                      dir_estado,
                      dir_cp,
                      dir_no_int,
                      dir_no_ext,
                      empleado_jefe_id
                      )
VALUES (
        4,
        'Jorge',
        'Leon',
        'Luna',
        12000,
        '2221912389',
        'JUL121457JDF34',
        'JUL121457JDFLLD07',
        'Av Calle 11',
        'centro',
        'Soltepec',
        'Puebla',
        '08780',
        'N\A',
        'N\A',
        1
        );

INSERT INTO administrativos(id_administrativo, observaciones, empleado_id)
VALUES (1,NULL,4);

INSERT INTO administrativo_estudios(curso_estudio, descripción, administrativo_id)
VALUES
('adminstraccion de empreas','tomando en voca 13','1');
---
INSERT INTO pagos(id_pago, subtotal, bono, descuento, total, fecha_pago, empleado_id)
VALUES
(1,22500,500,0,23000,now(),1),
(2,10000,5000,1000,14000,now() + cast('3 days' as interval),2),
(3,8000,0,1000,7000,now() - cast('5 days' as interval),3);

INSERT INTO pagos(id_pago, subtotal, bono, descuento, total, fecha_pago, empleado_id)
VALUES
(4,22500,0,0,22500,now() + cast('1 day' as interval),1);
--
INSERT INTO clientes(
                     id_cliente,
                     nombre,
                     ap_paterno,
                     ap_materno,
                     rfc,
                     curp,
                     dir_calle,
                     dir_localidad,
                     dir_municipio,
                     dir_estado,
                     dir_cp,
                     dir_no_int,
                     dir_no_ext,
                     observaciones)
VALUES
(1,
 'Daniel',
 'Mena',
 'Perez',
 'MEPD021207HDF64',
 'MEPD021207HDFNRNA9',
 'Av. las bombas',
 'centro',
 'Gustavo A.Madero',
 'CDMX',
 '09960',
 'N\A',
 'N\A',
 NULL
 );

INSERT INTO clientes(
                     id_cliente,
                     nombre,
                     ap_paterno,
                     ap_materno,
                     rfc,
                     curp,
                     dir_calle,
                     dir_localidad,
                     dir_municipio,
                     dir_estado,
                     dir_cp,
                     dir_no_int,
                     dir_no_ext,
                     observaciones)
VALUES
(2,
 'Oscar',
 'Herrera',
 'Mauricio',
 'HEMO850605HDF74',
 'HEMO850605HDFRRS05',
 'Calle principal',
 'centro',
 'huamantla',
 'Tlaxcala',
 '08860',
 'N\A',
 'N\A',
 NULL
 );



INSERT INTO cliente_contactos(nombre, telefono, email, cliente_id)
VALUES
    ('numero personal','539333702','martink@aol.com',1),
    ('asistente','6856304062','larry@me.com',1);


---

INSERT INTO marcas(id_marca, nombre)
VALUES
    (1,'Audi'),
    (2,'Mercedez'),
    (3,'Ford'),
    (4,'Toyota'),
    (5,'Kia'),
    (6,'Dodge'),
    (7,'Chevrolet');

INSERT INTO autos(fecha_alta,modelo, observaciones, placas, marca_id, cliente_id)
VALUES
(now(),'2018','Es auto importadp','CDMX-1236',1,1),
(now() - cast('1 day' as interval),'2022',NULL,'PUE-1268',4,1);


INSERT INTO autos(fecha_alta,modelo,observaciones,placas,marca_id,cliente_id)
VALUES (now() - cast('5 days' as interval),'2015 demon',NULL,'TLX-45610',1,2);

--


INSERT INTO servicios(id_servicio, nombre, descripcion, costo)
VALUES
    (1,'Calibración y Balanceo','Se realiza un ajuste de cabecelas y de los componentes del motor',4200),
    (2,'Cambio de Aceita','Se cambia el aceite de frenos, direccion y caja',1200),
    (3,'Cambio de freno por llante','Se realiza un cambio completo de las piezas del freno',4600),
    (4,'Limpiado de motor','Limpeiza profunda de la maquinaria',1500),
    (5,'Cambio de bujias','Cambio de las bujias del motor',800),
    (6,'Cambio de llanantas','Cambio de llantas por preferencia del usuario',500);

INSERT INTO proveedores(id_proveedor, nombre)
VALUES
    (1,'Motorcraft'),
    (2,'Michelin'),
    (3,'Duracell'),
    (4,'Autozone');

INSERT INTO refacciones(id_refaccion, nombre, costo, proveedor_id)
VALUES
    (1,'Bateria',3500,3),
    (2,'Llantas',4300,2),
    (3,'Bujias',1200,1),
    (4,'limpiadores',800,4);


-- ORDEN DE TRABAJO 1

INSERT INTO ordenes_trabajos(
                             id_orden_trabajo,
                             fecha_registro,
                             sintomas,
                             aprobado,
                             subtotal,
                             descuento,
                             total,
                             auto_id)
VALUES
(1,now() - cast('1 day' as interval),'Se apaga en las subidas',false,13400,0,14100,1);

INSERT INTO orden_trabajo_equipo(empleado_id, orden_trabajo_id,es_lider)
VALUES
    (1,1,true);
INSERT INTO orden_trabajo_equipo(empleado_id, orden_trabajo_id) VALUES (2,1);

INSERT INTO orden_trabajo_servicios(
                                    servicio_id,
                                    subtotal_servicio,
                                    descuento_servicio,
                                    total_servicio,
                                    refaccion_id,
                                    costo_refacion_unitario,
                                    descuento_refaccion,
                                    cantidad_refaciones,
                                    subtotal_refaciones,
                                    costo_refacion_total,
                                    total,
                                    orden_trabajo_id)
VALUES
(5,800,0,800,3,1200,0,4,4800,4800,5600,1),
(5,500,100,400,2,4300,300,2,8600,8000,8500,1);


-- ORDEN DE TRABAJO 2
INSERT INTO ordenes_trabajos(
                             id_orden_trabajo,
                             fecha_registro,
                             sintomas,
                             aprobado,
                             subtotal,
                             descuento,
                             total,
                             auto_id)
VALUES
(2,now() - cast('5 days' as interval),'necesita nuevas llantas',false,17700,1200,16500,2);

INSERT INTO orden_trabajo_equipo(empleado_id, orden_trabajo_id,es_lider) VALUES (3,2,true);

INSERT INTO orden_trabajo_servicios(
                                    servicio_id,
                                    subtotal_servicio,
                                    descuento_servicio,
                                    total_servicio,
                                    refaccion_id,
                                    costo_refacion_unitario,
                                    descuento_refaccion,
                                    cantidad_refaciones,
                                    subtotal_refaciones,
                                    costo_refacion_total,
                                    total,
                                    orden_trabajo_id)
VALUES
(6,500,0,500,2,4300,300,4,17200,16000,16500,2);


--
