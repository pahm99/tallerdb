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








--- EXTRA QUERY ---
-- total pagado (egresado por cliente)
select e.nombre as nombre,'empleado' as tipo,sum(pagos.total) as egreso from pagos
join empleados e on e.id_empleado = pagos.empleado_id
group by e.id_empleado;
-- pagos de empleados
select e.nombre,pagos.total from pagos
join empleados e on e.id_empleado = pagos.empleado_id;
-- autos del clientes
select c.nombre,m.nombre,autos.id_auto from autos
join clientes c on autos.cliente_id = c.id_cliente
join marcas m on autos.marca_id = m.id_marca;



-- servicios
select ot.id_orden_trabajo,s.nombre,ots.total,ot.total from ordenes_trabajos ot
join orden_trabajo_servicios ots on ot.id_orden_trabajo = ots.orden_trabajo_id
join servicios s on ots.servicio_id = s.id_servicio
