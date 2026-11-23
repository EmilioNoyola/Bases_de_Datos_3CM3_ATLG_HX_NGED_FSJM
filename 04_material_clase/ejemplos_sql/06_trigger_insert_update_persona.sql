USE AEROLINEAS 

SELECT * FROM PERSONA 

-- CREAMOS LA TABLA BIT�CORA donde guadaremos la informaci�n a auditar 
CREATE TABLE Bitacora_persona
(
ID INT IDENTITY NOT NULL, 
operacion VARCHAR(10) DEFAULT NULL, 
usuario VARCHAR(40) DEFAULT NULL,
host VARCHAR(30) DEFAULT NULL,
modificado DATETIME DEFAULT NULL, 
tabla VARCHAR(40) NOT NULL, 
PRIMARY KEY (ID)
)

SELECT * FROM  Bitacora_persona

-- DELETE FROM  Bitacora_persona

-- CREAMOS TRIGGER DE INSERT PARA LA TABLA PERSONA 
CREATE TRIGGER TR_INS_Persona
ON Persona
AFTER INSERT
AS BEGIN 
	INSERT INTO Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('INSERT',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Persona')
END 

-- INSERTAMOS DATOS DE UNA PERSONA 

INSERT INTO PERSONA (nombre,paterno,materno,direccionId,telefono,nacimiento,sexo) VALUES ('Diana','Hern�ndez','Robles','2','55897455','19890801','1')

-- DELETE FROM PERSONA WHERE IdPersona='21' and NOMBRE='DIANA'



-----------------------------------------------------------
-----------------------BITACORA DE ACTUALIZACION-----------
-----------------------------------------------------------

CREATE TABLE Bitacora_persona_UPD 
(
ID INT IDENTITY NOT NULL, 
operacion VARCHAR(10) DEFAULT NULL, 
usuario VARCHAR(40) DEFAULT NULL,
host VARCHAR(30) DEFAULT NULL,
modificado DATETIME DEFAULT NULL,
PK VARCHAR(5) NOT NULL, 
tabla VARCHAR(40) NOT NULL,
campo VARCHAR(30) NOT NULL,
valor VARCHAR(30) NOT NULL,
valor_nuevo  VARCHAR(30),
accion_inversa  VARCHAR(200),
PRIMARY KEY (ID)
)

select * from Bitacora_persona_UPD 


-- TRIGGER UPDATE 

CREATE TRIGGER TR_UPD_Persona
ON Persona
AFTER UPDATE --TRIGGER DE TIPO UPDATE 
AS  
set nocount on   --Para que no cuente las filas afectadas de la sesi�n del usuario 
---------------------------------------------
-----------VALORES NUEVOS--------------------
---------------------------------------------
DECLARE @@IdPersona INT
DECLARE @@nombre VARCHAR(25)
DECLARE @@paterno VARCHAR(25)
DECLARE @@materno VARCHAR(25)
DECLARE @@direccionId INT
DECLARE @@telefono VARCHAR(25)
DECLARE @@nacimiento DATETIME
DECLARE @@sexo BIT

---------------------------------------------
-----------VALORES ANTIGUOS------------------
---------------------------------------------
DECLARE @@IdPersona_d INT
DECLARE @@nombre_d VARCHAR(25)
DECLARE @@paterno_d VARCHAR(25)
DECLARE @@materno_d VARCHAR(25)
DECLARE @@direccionId_d INT
DECLARE @@telefono_d VARCHAR(25)
DECLARE @@nacimiento_d DATETIME
DECLARE @@sexo_d BIT

--Declaramos el cursos que recorrer� las tuplas de inserted
declare cursor_inserta_persona cursor
for select  IdPersona,nombre,paterno, materno, direccionId, telefono,nacimiento,sexo
 FROM inserted   --TABLA INSERTED
for read only
open cursor_inserta_persona


--Declaramos el cursos que recorrer� las tuplas de deleted
declare cursor_borra_persona cursor
for select IdPersona,nombre,paterno, materno, direccionId, telefono,nacimiento,sexo
 FROM deleted --TABLA DELETED
for read only

open cursor_borra_persona
--Llenamos variables
fetch next from cursor_inserta_persona into @@IdPersona,@@nombre,@@paterno, @@materno, @@direccionId, @@telefono,@@nacimiento,@@sexo
fetch next from cursor_borra_persona into  @@IdPersona_d,@@nombre_d,@@paterno_d, @@materno_d, @@direccionId_d, @@telefono_d,@@nacimiento_d,@@sexo_d

while (@@fetch_status <> -1) /* no sea eof*/
BEGIN

IF @@IdPersona IS NOT NULL 
BEGIN  --valida si el registro no es nullo
IF @@nombre <> @@nombre_d
	BEGIN
		INSERT INTO Bitacora_persona_UPD(operacion, usuario, host,modificado,PK,tabla,campo,valor,valor_nuevo,accion_inversa)
		SELECT 'UPDATE',SUSER_NAME(),@@SERVERNAME,GETDATE(),@@IdPersona,'Persona','Nombre', @@nombre_d,@@nombre, 'UPDATE Persona SET nombre = ' +CHAR(39)+@@nombre_d+CHAR(39)+ ' WHERE IdPersona =' +CHAR(39)+CONVERT(NVARCHAR(3),@@IdPersona)+char(39)
	END
IF @@paterno <> @@paterno_d
	BEGIN
		INSERT INTO Bitacora_persona_UPD(operacion, usuario, host,modificado,PK,tabla,campo,valor,valor_nuevo,accion_inversa)
		SELECT 'UPDATE',SUSER_NAME(),@@SERVERNAME,GETDATE(),@@IdPersona,'Persona','Paterno', @@paterno_d,@@paterno, 'UPDATE Persona SET nombre = ' +CHAR(39)+@@paterno_d+CHAR(39)+ ' WHERE IdPersona =' +CHAR(39)+CONVERT(NVARCHAR(3),@@IdPersona)+char(39)
	END


END --cierra begin valida si el registro no es nullo

-- Incrementamos el registro
fetch next from cursor_inserta_persona into @@IdPersona,@@nombre,@@paterno, @@materno, @@direccionId, @@telefono,@@nacimiento,@@sexo
fetch next from cursor_borra_persona into  @@IdPersona_d,@@nombre_d,@@paterno_d, @@materno_d, @@direccionId_d, @@telefono_d,@@nacimiento_d,@@sexo_d

END -- Cierra While

-- Se cierra Cursor  "SIEMPRE DEBE HACERSE"
close cursor_inserta_persona
deallocate  cursor_inserta_persona

close cursor_borra_persona
deallocate  cursor_borra_persona


----------------------------------------------------
----------------------------------------------------


SELECT * FROM PERSONA 

SELECT * FROM  Bitacora_persona
SELECT * FROM  Bitacora_persona_UPD 
SELECT * FROM  Bitacora..Bitacora_persona_UPD 

-- ACTUALIZAMOS DATOS DE UNA PERSONA 

UPDATE PERSONA SET Nombre='Diana'
WHERE IdPersona ='22'

