CREATE DATABASE Prueba1
USE Prueba1

CREATE TABLE Departamentos
(
    Id int,
    Nombre varchar(20)
);

CREATE TABLE Empleados
(
    Nombre varchar(20),
    DepartamentoId int
);

INSERT INTO Departamentos VALUES(31, 'Sales');
INSERT INTO Departamentos VALUES(33, 'Engineering');
INSERT INTO Departamentos VALUES(34, 'Clerical');
INSERT INTO Departamentos VALUES(35, 'Marketing');

INSERT INTO Empleados VALUES('Rafferty', 31);
INSERT INTO Empleados VALUES('Jones', 33);
INSERT INTO Empleados VALUES('Heisenberg', 33);
INSERT INTO Empleados VALUES('Robinson', 34);
INSERT INTO Empleados VALUES('Smith', 34);
INSERT INTO Empleados VALUES('Williams', NULL);

SELECT * FROM Departamentos 
SELECT * FROM Empleados

--=======================================
--=========INNER JOIN====================
--=======================================
--Lista los empleados e indica el nombre del depto al que pertenecen

SELECT * FROM Empleados E 
INNER JOIN Departamentos D
ON E.DepartamentoId=D.id

--=======================================
--=========LEFT JOIN=====================
--=======================================
/*Da prioridad a la tabla de la izquierda, si no existe coincidencia para algunas de las filas 
de la tabla de la derecha, de igual forma todos los resultados de la primera tabla se muestran
*/

SELECT 
E.Nombre AS 'Empleado', --campos tabla empleado
D.Nombre AS 'Departamento'-- campos tabla departamento
FROM Empleados E --Nombre Tabla 1
LEFT JOIN Departamentos D --Nombre Tabla 2
ON E.DepartamentoId=D.id  --Elemento coindicente o FK

/*La tabla departamentos es la tabla de la derecha, si no encuentra coincidencias, se mostrarán los
valores correspondientes, pero sino, aparecerá NULL en los resultados*/

--=======================================
--=========RIGHT JOIN====================
--=======================================
/*Da prioridad a la tabla de la DERECHA, si no existe coincidencia para algunas de las filas 
de la tabla de la izquierda, de igual forma todos los resultados de la primera tabla se muestran
*/
SELECT 
E.Nombre AS 'Empleado', --campos tabla empleado
D.Nombre AS 'Departamento'-- campos tabla departamento
FROM Empleados E --Nombre Tabla 1
RIGHT JOIN Departamentos D --Nombre Tabla 2
ON E.DepartamentoId=D.id  --Elemento coindicente o FK

/*La tabla empleados es la tabla de la izquierda, si no encuentra coincidencias, se mostrarán los
valores correspondientes, pero sino, aparecerá NULL en los resultados
Es decir si no hay ningún empleado trabajando en un departamento determinadl, se mostrará NULL. Pero
el departamento aparecerá de igual forma
*/

--=======================================
--=========FULL JOIN=====================
--=======================================

--Muestra todos los departamentos y empleados que existen en la BD

SELECT 
E.Nombre AS 'Empleado', --campos tabla empleado
D.Nombre AS 'Departamento'-- campos tabla departamento
FROM Empleados E --Nombre Tabla 1
FULL JOIN Departamentos D --Nombre Tabla 2
ON E.DepartamentoId=D.id 

/*Se muestra el empleado Willians a pesar que no está asignado a ningún departamento, y se muestra 
el Departamento Marketing a pesar que aún nadie esta trabajando ahí*/


--=======================================
--=========FULL OUTER JOIN===============
--=======================================

--Muestra todos los departamentos y empleados 
-- que estan asignados a algún departamento.

SELECT 
E.Nombre AS 'Nombre', --campos tabla empleado
D.Nombre AS 'Departamento'-- campos tabla departamento
FROM Empleados E --Nombre Tabla 1
FULL OUTER JOIN Departamentos D --Nombre Tabla 2
ON E.DepartamentoId=D.id 
WHERE E.Nombre IS NULL -- Tabla de la derecha
OR D.Nombre IS NULL    -- Tabla de la izquierda

--=======================================
--=========LEFT OUTER JOIN===============
--=======================================
/*Nos permite traer la lista de empleados que aún no han sido asignados a ningún departamento 
de trabajo*/
SELECT 
E.Nombre AS 'Empleado', --campos tabla empleado
D.Nombre AS 'Departamento'-- campos tabla departamento
FROM Empleados E --Nombre Tabla 1
LEFT OUTER JOIN Departamentos D --Nombre Tabla 2
ON E.DepartamentoId=D.id 
WHERE D.Nombre IS NULL -- Tabla de la Derecha

--=======================================
--=========RIGHT OUTER JOIN==============
--=======================================
SELECT 
E.Nombre AS 'Empleado', --campos tabla empleado
D.Nombre AS 'Departamento'-- campos tabla departamento
FROM Empleados E --Nombre Tabla 1
RIGHT OUTER JOIN Departamentos D --Nombre Tabla 2
ON E.DepartamentoId=D.id 
WHERE E.Nombre IS NULL -- Tabla de la Izquierda
 
 /*¿POR QUÉ NO ARROJA NADA?*/
 SELECT * FROM Empleados E, Departamentos D
 WHERE E.NOMBRE=D.NOMBRE 

