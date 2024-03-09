--Consultas
/*Devuelve un listado con todos los pedidos que se han realizado. 
Los pedidos deben estar ordenados por la fecha de realización, mostrando en primer lugar los pedidos más recientes.*/
SELECT * FROM pedido ORDER BY fecha ASC;

/*Devuelve todos los datos de los dos pedidos de mayor valor.*/
SELECT * FROM pedido ORDER BY total DESC;

/*Devuelve un listado con los identificadores de los clientes que han realizado algún pedido. Tenga en cuenta que no debe mostrar identificadores que estén repetidos.*/
SELECT DISTINCT id_cliente FROM pedido;

/*Devuelve un listado de todos los pedidos que se realizaron durante el año 2017, cuya cantidad total sea superior a 500€.*/
--select * from pedido;
SELECT total AS lista_pedidos FROM pedido WHERE EXTRACT(YEAR FROM fecha) = 2017 AND total > 500;

/*Devuelve un listado con el nombre y los apellidos de los comerciales que tienen una comisión entre 0.05 y 0.11.*/
SELECT CONCAT_WS(' ',nombre,apellido1,apellido2) AS lista_comerciales
FROM comercial
WHERE comisión >= 0.05 OR comisión >= 0.11;

/*Devuelve el valor de la comisión de mayor valor que existe en la tabla comercial.*/
SELECT MAX(comisión) AS comision_mayor FROM comercial;

/*Devuelve el identificador, nombre y primer apellido de aquellos clientes cuyo segundo apellido no es NULL.
El listado deberá estar ordenado alfabéticamente por apellidos y nombre.*/
SELECT id,nombre,apellido1 FROM cliente WHERE apellido2 IS NOT NULL ORDER BY apellido1,apellido2,nombre;

/*Devuelve un listado de los nombres de los clientes que empiezan por A y terminan por n y también los nombres que empiezan por P. 
El listado deberá estar ordenado alfabéticamente.*/
SELECT nombre FROM cliente WHERE nombre LIKE 'A%' AND nombre LIKE '%n' OR nombre LIKE 'P%';

/*Devuelve un listado de los nombres de los clientes que no empiezan por A. El listado deberá estar ordenado alfabéticamente.*/
SELECT nombre FROM cliente WHERE nombre LIKE 'A%' ORDER BY nombre ASC;

/*Devuelve un listado con los nombres de los comerciales que terminan por el o O. Tenga en cuenta que se deberán eliminar los nombres repetidos.*/
SELECT DISTINCT nombre FROM comercial WHERE nombre LIKE '%el'OR nombre LIKE '%o';

/*Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido. 
El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.*/

SELECT DISTINCT C.id,C.nombre,C.apellido1,C.apellido2 
FROM cliente C
JOIN pedido P ON P.id_cliente = C.id
WHERE P.id_cliente IS NOT NULL
ORDER BY C.nombre,C.apellido1,C.apellido2  ASC;

/*Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. 
El resultado debe mostrar todos los datos de los pedidos y del cliente. 
El listado debe mostrar los datos de los clientes ordenados alfabéticamente.*/
--select * from cliente;
--select * from pedido;
SELECT DISTINCT C.*,P.* FROM cliente C 
JOIN pedido P ON P.id_cliente = C.id
WHERE P.id_cliente IS NOT NULL
ORDER BY C.nombre,C.apellido1,C.apellido2  ASC;

/*Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial. 
El resultado debe mostrar todos los datos de los pedidos y de los comerciales. 
El listado debe mostrar los datos de los comerciales ordenados alfabéticamente.*/
SELECT * FROM comercial;
SELECT DISTINCT C.*, P.* FROM comercial C 
JOIN pedido P ON P.id_comercial = C.id
ORDER BY C.nombre,C.apellido1,C.apellido2  ASC;

/*Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado y con los datos de los comerciales asociados a cada pedido.*/
SELECT DISTINCT C.*,P.*,CO.* FROM cliente C
JOIN pedido P ON P.id_cliente = C.id
JOIN comercial CO ON CO.id = P.id_comercial
WHERE P.id_cliente IS NOT NULL;

/*Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, 
cuya cantidad esté entre 300 € y 1000 €.*/
SELECT DISTINCT CONCAT_WS(' ',C.nombre,C.apellido1,C.apellido2) AS lista_clientes FROM cliente C
JOIN pedido P ON P.id_cliente = C.id
WHERE EXTRACT(YEAR FROM P.fecha) = 2017;

/*Devuelve el nombre y los apellidos de todos los comerciales que ha participado en algún pedido realizado por María Santana Moreno.*/
SELECT DISTINCT CO.nombre,CO.apellido1,CO.apellido2 FROM comercial CO
JOIN pedido P ON P.id_comercial = CO.id
JOIN cliente C ON C.id = P.id_cliente
WHERE C.id = 6;

/*Devuelve el nombre de todos los clientes que han realizado algún pedido con el comercial Daniel Sáez Vega.*/
SELECT DISTINCT C.nombre,C.apellido1,C.apellido2 FROM cliente C 
JOIN pedido P ON P.id_cliente = C.id
JOIN comercial CO ON CO.id = P.id_comercial
WHERE CO.id = 1;

/*Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado. 
Este listado también debe incluir los clientes que no han realizado ningún pedido. 
El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los clientes.*/
SELECT C.*, P.* FROM cliente C 
LEFT JOIN pedido P ON P.id_cliente = C.id
ORDER BY C.apellido1,C.apellido2,C.nombre;

/*Devuelve un listado con todos los comerciales junto con los datos de los pedidos que han realizado. 
Este listado también debe incluir los comerciales que no han realizado ningún pedido. 
El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los comerciales.*/
SELECT DISTINCT CO.*,P.* 
FROM comercial CO
LEFT JOIN pedido P ON P.id_comercial = CO.id
ORDER BY CO.apellido1,CO.apellido2,CO.nombre;

/*Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.*/
SELECT C.*,P.* 
FROM cliente C
LEFT JOIN pedido P ON P.id_cliente = C.id
WHERE P IS NULL;

/*Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido.*/
SELECT CO.*,P.*
FROM comercial CO 
LEFT JOIN pedido P ON P.id_comercial = CO.id
WHERE P IS NULL;

/*Devuelve un listado con los clientes que no han realizado ningún pedido y de los comerciales que no han participado en ningún pedido. 
Ordene el listado alfabéticamente por los apellidos y el nombre. 
En en listado deberá diferenciar de algún modo los clientes y los comerciales.*/
SELECT CONCAT_WS(' ',C.*) AS lista_clientes,CONCAT_WS(' ',CO.*) AS lista_comerciales
FROM cliente C 
LEFT JOIN pedido P ON P.id_cliente = C.id
JOIN comercial CO ON CO.id = P.id_comercial
WHERE P.* IS NULL
ORDER BY lista_clientes, lista_comerciales;



/*¿Se podrían realizar las consultas anteriores con NATURAL LEFT JOIN o NATURAL RIGHT JOIN? Justifique su respuesta.*/
--En estos casos no ya que los NATURAL traen directamente los mismo datos que tengan el mismo nombre o tipo,
--osea no trae solo los de la derecha o izquierda se base en repeticiones de los datos seria mas adecuado LETF JOIN O RIGHT JOIN
--Es parecido a un join pero resume el codigo no distinque entre derecha y izquierda

/*Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.*/
SELECT SUM(total) AS total_pedidos FROM pedido;

/*Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.*/
SELECT AVG(total) AS media_pedidos FROM pedido;

/*Calcula el número total de comerciales distintos que aparecen en la tabla pedido.*/
SELECT COUNT(DISTINCT P.id_comercial) AS total_comerciales FROM pedido P;

/*Calcula el número total de clientes que aparecen en la tabla cliente.*/
SELECT COUNT(*) AS total_clientes FROM cliente;

/*Calcula cuál es la mayor cantidad que aparece en la tabla pedido.*/
SELECT MAX(total) FROM pedido;

/*Calcula cuál es la menor cantidad que aparece en la tabla pedido.*/
SELECT MIN(total) FROM pedido;

/*Calcula cuál es el valor máximo de categoría para cada una de las ciudades que aparece en la tabla cliente.*/
SELECT MAX(categoría) AS valor_maximo_categoria FROM cliente;

/*Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes. 
Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes cantidades el mismo día. 
Se pide que se calcule cuál es el pedido de máximo valor para cada uno de los días en los que un cliente ha realizado un pedido. 
Muestra el identificador del cliente, nombre, apellidos, la fecha y el valor de la cantidad.*/

SELECT C.id, C.nombre, C.apellido1, C.apellido2, P.fecha, P.total AS maximo_pedido
FROM cliente C
JOIN pedido P ON P.id_cliente = C.id
JOIN (
    SELECT id_cliente, fecha, MAX( DISTINCT total) AS max_total
    FROM pedido
    GROUP BY id_cliente, fecha
) AS maximos
ON P.id_cliente = maximos.id_cliente AND P.fecha = maximos.fecha AND P.total = maximos.max_total;

/*Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes, 
teniendo en cuenta que sólo queremos mostrar aquellos pedidos que superen eñ total de 2000 €.*/
SELECT C.id, C.nombre, C.apellido1, C.apellido2, P.fecha, P.total AS maximo_pedido
FROM cliente C
JOIN pedido P ON P.id_cliente = C.id
JOIN (
    SELECT id_cliente, fecha, MAX(total) AS max_total
    FROM pedido
    GROUP BY id_cliente, fecha
	) AS maximos
ON P.id_cliente = maximos.id_cliente AND P.fecha = maximos.fecha AND P.total = maximos.max_total
WHERE P.total > 2000;

/*Calcula el máximo valor de los pedidos realizados para cada uno de los comerciales durante la fecha 2016-08-17. 
Muestra el identificador del comercial, nombre, apellidos y total.*/
SELECT MAX(total) FROM pedido WHERE fecha ='2016-08-17';

/*Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes. 
Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido. 
Estos clientes también deben aparecer en el listado indicando que el número de pedidos realizados es 0.*/
 
SELECT C.id,C.nombre,C.apellido1,C.apellido2,COUNT(P.id) AS total_pedidos 
FROM cliente C
LEFT JOIN pedido P ON P.id_cliente = C.id
GROUP BY C.id, C.nombre, C.apellido1,C.apellido2;

 /*Devuelve un listado con el identificador de cliente, nombre y apellidos 
 y el número total de pedidos que ha realizado cada uno de clientes durante el año 2017.*/
 
SELECT C.id,C.nombre,C.apellido1,C.apellido2,COUNT(P.id) AS total_pedidos 
FROM cliente C
LEFT JOIN pedido P ON P.id_cliente = C.id
WHERE EXTRACT(YEAR FROM fecha) = 2017
GROUP BY C.id, C.nombre, C.apellido1,C.apellido2;

/*Devuelve un listado que muestre el identificador de cliente, nombre, primer apellido 
y el valor de la máxima cantidad del pedido realizado por cada uno de los clientes. 
El resultado debe mostrar aquellos clientes que no han realizado ningún pedido indicando que la máxima cantidad de sus pedidos realizados es 0. 
Puede hacer uso de la función IFNULL.*/
select * from cliente;
SELECT C.id,C.nombre,C.apellido1,C.apellido2,MAX(P.total) AS maxima_cantidad_pedido
FROM cliente C
LEFT JOIN pedido P ON P.id_cliente = C.id
GROUP BY C.id,C.nombre,C.apellido1,C.apellido2
;
/*Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.*/
SELECT pedido.*
FROM pedido
JOIN (
    SELECT EXTRACT(YEAR FROM fecha) AS año, MAX(total) AS maximo_valor
    FROM pedido
    GROUP BY EXTRACT(YEAR FROM fecha)
) AS maximos_por_año
ON pedido.total = maximos_por_año.maximo_valor
AND EXTRACT(YEAR FROM pedido.fecha) = maximos_por_año.año;

/*Devuelve el número total de pedidos que se han realizado cada año.*/
SELECT EXTRACT(YEAR FROM fecha) AS año, COUNT(*) AS total_pedidos
FROM pedido
GROUP BY EXTRACT(YEAR FROM fecha);

/*Devuelve un listado con todos los pedidos que ha realizado Adela Salas Díaz. (Sin utilizar INNER JOIN).*/
SELECT * FROM pedido
WHERE id_cliente = (
    SELECT id FROM cliente
    WHERE nombre = 'Adela Salas Díaz' OR id = 4
);

/*Devuelve el número de pedidos en los que ha participado el comercial Daniel Sáez Vega. (Sin utilizar INNER JOIN)*/
SELECT * FROM pedido
WHERE id_comercial = (
	SELECT id FROM comercial
	WHERE nombre ='Daniel' OR apellido1 = 'Sáez' OR apellido2= 'Vega' OR id = 1
);
/*Devuelve los datos del cliente que realizó el pedido más caro en el año 2019. (Sin utilizar INNER JOIN)*/
SELECT * FROM cliente 
WHERE id = (
    SELECT id_cliente FROM pedido
    WHERE total = (
        SELECT MAX(total)
        FROM pedido
        WHERE EXTRACT(YEAR FROM fecha) = 2019
    )
    AND EXTRACT(YEAR FROM fecha) = 2019
);
/*Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz Santana.*/
SELECT fecha, MIN(total) AS menor_pedido FROM pedido
WHERE id_cliente = 8 GROUP BY fecha;

/*Devuelve un listado con los datos de los clientes y los pedidos,
de todos los clientes que han realizado un pedido durante el año 2017 con un valor mayor
o igual al valor medio de los pedidos realizados durante ese mismo año.*/

SELECT C.*, P.*FROM cliente C 
JOIN pedido P ON P.id_cliente = C.id
WHERE EXTRACT(YEAR FROM P.fecha) = 2017 
AND P.total >= (
    SELECT AVG(total)
    FROM pedido
    WHERE EXTRACT(YEAR FROM fecha) = 2017
);

/*Devuelve el pedido más caro que existe en la tabla pedido sin hacer uso de MAX, ORDER BY ni LIMIT.*/
SELECT *
FROM pedido AS p1
WHERE p1.total >= ALL (
    SELECT total
    FROM pedido AS p2
    WHERE p2.total IS NOT NULL
);
/*Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando ANY o ALL).*/
select * from pedido;
SELECT *
FROM cliente AS c1
WHERE c1.id NOT IN (
    SELECT id_cliente
    FROM pedido
);

/*Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando ANY o ALL).*/
SELECT *
FROM comercial AS c1
WHERE c1.id NOT IN (
    SELECT id_comercial
    FROM pedido
);

/*Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando IN o NOT IN).*/
SELECT *
FROM cliente AS c1
WHERE c1.id NOT IN (
    SELECT id_cliente
    FROM pedido
);
/*Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando IN o NOT IN).*/
SELECT *
FROM comercial AS c1
WHERE c1.id NOT IN (
    SELECT id_comercial
    FROM pedido
);

/*Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando EXISTS o NOT EXISTS).*/
SELECT *FROM cliente AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM pedido AS p
    WHERE p.id_cliente = c.id
);

/*Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando EXISTS o NOT EXISTS).*/
SELECT * FROM comercial AS CO
WHERE NOT EXISTS (
	SELECT 1
	FROM pedido AS p 
	WHERE p.id_comercial = CO.id
);
