-- ingenieros
SELECT e.nombre,i.escuela FROM ingenieros i
JOIN empleados e on e.id_empleado = i.empleado_id;
-- jefes y sus delegados
select e.nombre as jefe,j.nombre as delegado from empleados e
join empleados j on e.id_empleado = j.empleado_jefe_id;
-- tecnicos y sus habilidades
select e.nombre,th.hablidad,th.experiencia from tecnicos t
join tecnico_habilidades th on t.id_tecnico = th.tecnico_id
join empleados e on e.id_empleado = t.empleado_id