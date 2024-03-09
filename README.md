# bd_ventasPostgres

## Examen final de Postgres - Consultas

### Listado de pedidos

## Devuelve un listado con todos los pedidos que se han realizado. Los pedidos deben estar ordenados por la fecha de realización, mostrando en primer lugar los pedidos más recientes.

```sql
SELECT * FROM pedido ORDER BY fecha ASC;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/14bbe3ea-e9a6-4e3a-ac31-c4dcaba6f1ec)

## Devuelve todos los datos de los dos pedidos de mayor valor.

```sql
SELECT * FROM pedido ORDER BY total DESC;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/0497c7f3-6c81-433f-859f-74a23d8aa0d7)

## Devuelve un listado con los identificadores de los clientes que han realizado algún pedido. Tenga en cuenta que no debe mostrar identificadores que estén repetidos.
```sql
SELECT DISTINCT id_cliente FROM pedido;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/09327cb2-0991-495e-acf2-4cfa239ac416)

## Devuelve un listado de todos los pedidos que se realizaron durante el año 2017, cuya cantidad total sea superior a 500€.
```sql
SELECT total AS lista_pedidos FROM pedido WHERE EXTRACT(YEAR FROM fecha) = 2017 AND total > 500;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/3a04c06b-0442-4a2b-848c-27289f77e089)

## Devuelve un listado con el nombre y los apellidos de los comerciales que tienen una comisión entre 0.05 y 0.11.
```sql
SELECT CONCAT_WS(' ',nombre,apellido1,apellido2) AS lista_comerciales
FROM comercial
WHERE comisión >= 0.05 OR comisión >= 0.11;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/f16946c0-ff65-4d99-bce6-2d7b41899920)

## Devuelve el valor de la comisión de mayor valor que existe en la tabla comercial
```sql
SELECT MAX(comisión) AS comision_mayor FROM comercial;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/c09a7712-0afa-4d07-bca7-87d48d227935)

## Devuelve el identificador, nombre y primer apellido de aquellos clientes cuyo segundo apellido no es NULL.
El listado deberá estar ordenado alfabéticamente por apellidos y nombre.
```sql
SELECT id,nombre,apellido1 FROM cliente WHERE apellido2 IS NOT NULL ORDER BY apellido1,apellido2,nombre;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/4ff17572-19e3-457c-ae5a-5de4bff8410a)

## Devuelve un listado de los nombres de los clientes que empiezan por A y terminan por n y también los nombres que empiezan por P. 
El listado deberá estar ordenado alfabéticamente.
```sql
SELECT nombre FROM cliente WHERE nombre LIKE 'A%' AND nombre LIKE '%n' OR nombre LIKE 'P%';

```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/8228f3c1-da82-4780-b2bb-972e295a9d7b)

## Devuelve un listado de los nombres de los clientes que no empiezan por A. El listado deberá estar ordenado alfabéticamente.
```sql
SELECT nombre FROM cliente WHERE nombre LIKE 'A%' ORDER BY nombre ASC;

```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/38958088-5062-4f10-a1ab-3f556e088045)

## Devuelve un listado con los nombres de los comerciales que terminan por el o O. Tenga en cuenta que se deberán eliminar los nombres repetidos.
```sql
SELECT DISTINCT nombre FROM comercial WHERE nombre LIKE '%el'OR nombre LIKE '%o';

```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/f4385bce-06fe-4b18-993b-3b0863be5e02)

## Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido. 
El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.
```sql
SELECT DISTINCT C.id,C.nombre,C.apellido1,C.apellido2 
FROM cliente C
JOIN pedido P ON P.id_cliente = C.id
WHERE P.id_cliente IS NOT NULL
ORDER BY C.nombre,C.apellido1,C.apellido2  ASC;

```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/3b341ad1-8c08-484c-ba7b-eb26a6902ece)

## Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. 
El resultado debe mostrar todos los datos de los pedidos y del cliente. 
El listado debe mostrar los datos de los clientes ordenados alfabéticamente.
```sql
SELECT DISTINCT C.*,P.* FROM cliente C 
JOIN pedido P ON P.id_cliente = C.id
WHERE P.id_cliente IS NOT NULL
ORDER BY C.nombre,C.apellido1,C.apellido2  ASC;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/5a65da2d-d8d3-4527-b2db-8106a5b654bf)

## Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial. 
El resultado debe mostrar todos los datos de los pedidos y de los comerciales. 
El listado debe mostrar los datos de los comerciales ordenados alfabéticamente.
```sql
SELECT * FROM comercial;
SELECT DISTINCT C.*, P.* FROM comercial C 
JOIN pedido P ON P.id_comercial = C.id
ORDER BY C.nombre,C.apellido1,C.apellido2  ASC;

```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/f02e59fe-20aa-43b6-9531-d74b7418bdf6)

## Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado y con los datos de los comerciales asociados a cada pedido.
```sql
SELECT DISTINCT C.*,P.*,CO.* FROM cliente C
JOIN pedido P ON P.id_cliente = C.id
JOIN comercial CO ON CO.id = P.id_comercial
WHERE P.id_cliente IS NOT NULL;

```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/82e2f8b8-56e4-4084-a8e0-43e440e35521)

## Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, 
cuya cantidad esté entre 300 € y 1000 €.
```sql
SELECT DISTINCT CONCAT_WS(' ',C.nombre,C.apellido1,C.apellido2) AS lista_clientes FROM cliente C
JOIN pedido P ON P.id_cliente = C.id
WHERE EXTRACT(YEAR FROM P.fecha) = 2017;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/9d0deeb2-16c8-4aa3-8f95-db49825fb918)
## Devuelve el nombre y los apellidos de todos los comerciales que ha participado en algún pedido realizado por María Santana Moreno.
```sql
SELECT DISTINCT CO.nombre,CO.apellido1,CO.apellido2 FROM comercial CO
JOIN pedido P ON P.id_comercial = CO.id
JOIN cliente C ON C.id = P.id_cliente
WHERE C.id = 6;

```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/b297ed97-5860-4c83-ba67-47bf2bedde6f)

## Devuelve el nombre de todos los clientes que han realizado algún pedido con el comercial Daniel Sáez Vega.
```sql
SELECT DISTINCT C.nombre,C.apellido1,C.apellido2 FROM cliente C 
JOIN pedido P ON P.id_cliente = C.id
JOIN comercial CO ON CO.id = P.id_comercial
WHERE CO.id = 1;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/5bd65f57-b13c-445b-8f35-000b7d057152)

## Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado. 
Este listado también debe incluir los clientes que no han realizado ningún pedido. 
El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los clientes.
```sql
SELECT C.*, P.* FROM cliente C 
LEFT JOIN pedido P ON P.id_cliente = C.id
ORDER BY C.apellido1,C.apellido2,C.nombre;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/cb177fd4-eb87-4fbe-af85-bc0a86746b98)

## Devuelve un listado con todos los comerciales junto con los datos de los pedidos que han realizado. 
Este listado también debe incluir los comerciales que no han realizado ningún pedido. 
El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los comerciales.
##
```sql
SELECT DISTINCT CO.*,P.* 
FROM comercial CO
LEFT JOIN pedido P ON P.id_comercial = CO.id
ORDER BY CO.apellido1,CO.apellido2,CO.nombre;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/d1973871-458f-4301-8f03-f1946c1bd59a)

## Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.
```sql
SELECT C.*,P.* 
FROM cliente C
LEFT JOIN pedido P ON P.id_cliente = C.id
WHERE P IS NULL;

```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/8804dd29-e257-478a-bca0-4cfef8f8a4ed)

## Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido.
```sql
SELECT CO.*,P.*
FROM comercial CO 
LEFT JOIN pedido P ON P.id_comercial = CO.id
WHERE P IS NULL;

```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/b5b1d2c6-04f5-475e-8311-d281a1c0ca0c)

## Devuelve un listado con los clientes que no han realizado ningún pedido y de los comerciales que no han participado en ningún pedido. 
Ordene el listado alfabéticamente por los apellidos y el nombre. 
En en listado deberá diferenciar de algún modo los clientes y los comerciales.
```sql
SELECT CONCAT_WS(' ',C.*) AS lista_clientes,CONCAT_WS(' ',CO.*) AS lista_comerciales
FROM cliente C 
LEFT JOIN pedido P ON P.id_cliente = C.id
JOIN comercial CO ON CO.id = P.id_comercial
WHERE P.* IS NULL
ORDER BY lista_clientes, lista_comerciales;

```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/d0ab9bb2-fb2d-4f0c-aa87-862291880cf3)

##¿Se podrían realizar las consultas anteriores con NATURAL LEFT JOIN o NATURAL RIGHT JOIN? Justifique su respuesta.*/
### --En estos casos no ya que los NATURAL traen directamente los mismo datos que tengan el mismo nombre o tipo, 
### --osea no trae solo los de la derecha o izquierda se base en repeticiones de los datos seria mas adecuado LETF JOIN O RIGHT JOIN
### --Es parecido a un join pero resume el codigo no distinque entre derecha y izquierda

## Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido
```sql
SELECT SUM(total) AS total_pedidos FROM pedido;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/688ce79f-c814-4d6b-9878-d44dda94bedd)

## Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido
```sql
SELECT AVG(total) AS media_pedidos FROM pedido;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/be8c362c-b4c6-4b9f-acff-a9fe4ab31e43)

## Calcula el número total de comerciales distintos que aparecen en la tabla pedido.
```sql
SELECT COUNT(DISTINCT P.id_comercial) AS total_comerciales FROM pedido P;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/e88a4586-a8c3-4a4e-9dda-c5294e333938)

## Calcula el número total de clientes que aparecen en la tabla cliente.

```sql
SELECT COUNT(*) AS total_clientes FROM cliente;

```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/3563f2ce-5ba9-4a50-ac61-749b1113110b)

## Calcula cuál es la mayor cantidad que aparece en la tabla pedido.
```sql
SELECT MAX(total) FROM pedido;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/7bce5dd4-bea0-475a-a6fe-29e84de9737d)

## Calcula cuál es la menor cantidad que aparece en la tabla pedido
```sql
SELECT MIN(total) FROM pedido;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/1a5c94b5-3932-434a-b89c-603b95d97ddf)

## Calcula cuál es el valor máximo de categoría para cada una de las ciudades que aparece en la tabla cliente
```sql
SELECT MAX(categoría) AS valor_maximo_categoria FROM cliente;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/52e563b0-ba83-4edd-b1a3-9e1ebccc3ab3)

## Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes. 
Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes cantidades el mismo día. 
Se pide que se calcule cuál es el pedido de máximo valor para cada uno de los días en los que un cliente ha realizado un pedido. 
Muestra el identificador del cliente, nombre, apellidos, la fecha y el valor de la cantidad.
```sql
SELECT C.id, C.nombre, C.apellido1, C.apellido2, P.fecha, P.total AS maximo_pedido
FROM cliente C
JOIN pedido P ON P.id_cliente = C.id
JOIN (
    SELECT id_cliente, fecha, MAX( DISTINCT total) AS max_total
    FROM pedido
    GROUP BY id_cliente, fecha
) AS maximos
ON P.id_cliente = maximos.id_cliente AND P.fecha = maximos.fecha AND P.total = maximos.max_total;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/17fd413d-8904-418e-adbf-510c3948d954)

## Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes, 
teniendo en cuenta que sólo queremos mostrar aquellos pedidos que superen eñ total de 2000 €.
```sql
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
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/944dc387-e9f1-4e3e-bb3c-0fe072eeb890)

## Calcula el máximo valor de los pedidos realizados para cada uno de los comerciales durante la fecha 2016-08-17. 
Muestra el identificador del comercial, nombre, apellidos y total.
```sql
SELECT MAX(total) FROM pedido WHERE fecha ='2016-08-17';

```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/14de7e1c-f6b6-496a-85c2-54733b329196)

## Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido. Estos clientes también deben aparecer en el listado indicando que el número de pedidos realizados es 0.
```sql
 
SELECT C.id,C.nombre,C.apellido1,C.apellido2,COUNT(P.id) AS total_pedidos 
FROM cliente C
LEFT JOIN pedido P ON P.id_cliente = C.id
GROUP BY C.id, C.nombre, C.apellido1,C.apellido2;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/5ac8105c-5a9f-445c-8f00-91f3e3f89e15)

## Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes durante el año 2017.
```sql
SELECT C.id,C.nombre,C.apellido1,C.apellido2,COUNT(P.id) AS total_pedidos 
FROM cliente C
LEFT JOIN pedido P ON P.id_cliente = C.id
WHERE EXTRACT(YEAR FROM fecha) = 2017
GROUP BY C.id, C.nombre, C.apellido1,C.apellido2;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/ad8b0b05-1025-4ca6-8053-9b40d9bb4bd0)

## Devuelve un listado que muestre el identificador de cliente, nombre, primer apellido 
## y el valor de la máxima cantidad del pedido realizado por cada uno de los clientes. 
## El resultado debe mostrar aquellos clientes que no han realizado ningún pedido indicando que la máxima cantidad de sus pedidos realizados es 0. 
## Puede hacer uso de la función IFNULL.
```sql
select * from cliente;
SELECT C.id,C.nombre,C.apellido1,C.apellido2,MAX(P.total) AS maxima_cantidad_pedido
FROM cliente C
LEFT JOIN pedido P ON P.id_cliente = C.id
GROUP BY C.id,C.nombre,C.apellido1,C.apellido2
;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/54039861-4fa8-4d06-82c9-9fc210d88ee3)

## Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.
```sql
SELECT pedido.*
FROM pedido
JOIN (
    SELECT EXTRACT(YEAR FROM fecha) AS año, MAX(total) AS maximo_valor
    FROM pedido
    GROUP BY EXTRACT(YEAR FROM fecha)
) AS maximos_por_año
ON pedido.total = maximos_por_año.maximo_valor
AND EXTRACT(YEAR FROM pedido.fecha) = maximos_por_año.año;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/59b294d5-c4ae-4c1f-b6a1-071d7d3490c2)

## Devuelve un listado con todos los pedidos que ha realizado Adela Salas Díaz. (Sin utilizar INNER JOIN).
```sql
SELECT * FROM pedido
WHERE id_cliente = (
    SELECT id FROM cliente
    WHERE nombre = 'Adela Salas Díaz' OR id = 4
);

```
## Devuelve el número de pedidos en los que ha participado el comercial Daniel Sáez Vega. (Sin utilizar INNER JOIN)
```sql
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
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/114ab601-1939-4754-93c7-07df84f28410)

## Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz Santana.
```sql
SELECT fecha, MIN(total) AS menor_pedido FROM pedido
WHERE id_cliente = 8 GROUP BY fecha;
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/4144514e-9cf3-4a35-90b8-60f4cc82ca36)

## *Devuelve un listado con los datos de los clientes y los pedidos,de todos los clientes que han realizado un pedido durante el año 2017 con un valor mayor o igual al valor medio de los pedidos realizados durante ese mismo año.
```sql
SELECT C.*, P.*FROM cliente C 
JOIN pedido P ON P.id_cliente = C.id
WHERE EXTRACT(YEAR FROM P.fecha) = 2017 
AND P.total >= (
    SELECT AVG(total)
    FROM pedido
    WHERE EXTRACT(YEAR FROM fecha) = 2017
);
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/fe6c0f21-c12f-4c2b-b7cd-061d08683283)

## *Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando ANY o ALL).
```sql
select * from pedido;
SELECT *
FROM cliente AS c1
WHERE c1.id NOT IN (
    SELECT id_cliente
    FROM pedido
);

```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/87999ec0-bcfa-4868-843b-805ea8cfb54f)

## Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando ANY o ALL).
```sql
SELECT *
FROM comercial AS c1
WHERE c1.id NOT IN (
    SELECT id_comercial
    FROM pedido
);
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/462f8d96-95e3-4a03-b7e3-9c0466c4a8a5)

## *Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando IN o NOT IN).
```sql
SELECT *
FROM cliente AS c1
WHERE c1.id NOT IN (
    SELECT id_cliente
    FROM pedido
);
```
##
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/5a131a78-4b54-4f4d-9af5-334d4a4e6cd2)

## Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando IN o NOT IN).*/
```sql
SELECT *
FROM comercial AS c1
WHERE c1.id NOT IN (
    SELECT id_comercial
    FROM pedido
);

```
## *Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando EXISTS o NOT EXISTS).

```sql
SELECT *FROM cliente AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM pedido AS p
    WHERE p.id_cliente = c.id
);
```
![image](https://github.com/Dianaalejandra1446/bd_ventasPostgres/assets/139186201/a9b54733-8d43-4f72-ae70-551ac934a044)

## Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando EXISTS o NOT EXISTS)
```sql
SELECT * FROM comercial AS CO
WHERE NOT EXISTS (
	SELECT 1
	FROM pedido AS p 
	WHERE p.id_comercial = CO.id
);
```

