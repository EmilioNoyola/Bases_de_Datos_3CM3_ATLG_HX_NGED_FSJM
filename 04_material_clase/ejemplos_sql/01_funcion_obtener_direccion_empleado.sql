
CREATE	FUNCTION	ObtenerDireccionEmpleado	(@IdEmpleado	INT)	
RETURNS	@tbEmpleadoDireccion	TABLE(	
IdEmpleado 	 	INT	
,	nombreCompleto VARCHAR(100)	
,	direccionCompleta VARCHAR(100)	
)	
AS	
BEGIN	
INSERT	INTO	@tbEmpleadoDireccion
SELECT	a.idEmpleado,	
	 				nombre	+	'	'	+	paterno	+	'	'	+	ISNULL(materno,''),	
	 				calle	+	'	'	+	numero	+	'	'	+	colonia	+	'	'	+	codigoPostal
FROM	Empleado 	 	a	
INNER	JOIN	persona 	 	b	
on	a.idPersona	=	b.IdPersona
INNER	JOIN	Direccion 	 	c	
on	b.direccionId	=	c.direccionId
WHERE	a.idJefe	<>	null
and	a.idEmpleado	=	@IdEmpleado
RETURN	
END	