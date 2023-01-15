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