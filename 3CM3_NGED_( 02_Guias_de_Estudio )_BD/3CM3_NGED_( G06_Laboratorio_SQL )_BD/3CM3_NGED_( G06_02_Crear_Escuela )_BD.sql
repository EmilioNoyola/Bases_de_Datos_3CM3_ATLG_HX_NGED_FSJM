/* Base ESCUELA: alumnos, materias y calificaciones (pregunta 21 del examen) */
USE master;
GO
IF DB_ID('Escuela') IS NOT NULL
BEGIN
    ALTER DATABASE Escuela SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Escuela;
END
GO
CREATE DATABASE Escuela;
GO
USE Escuela;
GO
CREATE TABLE Alumno (
    idAlumno  INT NOT NULL,
    nombre    VARCHAR(60) NOT NULL,
    carrera   VARCHAR(10) NOT NULL,
    CONSTRAINT PK_Alumno PRIMARY KEY (idAlumno)
);
CREATE TABLE Materia (
    idMateria  INT NOT NULL,
    nombre     VARCHAR(60) NOT NULL,
    creditos   INT NOT NULL,
    CONSTRAINT PK_Materia PRIMARY KEY (idMateria)
);
CREATE TABLE Calificacion (
    idAlumno      INT NOT NULL,
    idMateria     INT NOT NULL,
    calificacion  DECIMAL(4,2) NOT NULL,
    CONSTRAINT PK_Calificacion PRIMARY KEY (idAlumno, idMateria),
    CONSTRAINT FK_Calificacion_Alumno FOREIGN KEY (idAlumno)
        REFERENCES Alumno (idAlumno),
    CONSTRAINT FK_Calificacion_Materia FOREIGN KEY (idMateria)
        REFERENCES Materia (idMateria),
    CONSTRAINT CK_Calificacion_calificacion CHECK (calificacion BETWEEN 0 AND 10)
);
GO
INSERT INTO Alumno (idAlumno, nombre, carrera) VALUES
    (1, 'Emilio Noyola', 'ISC'),
    (2, 'Ximena Duarte', 'ISC'),
    (3, 'Iván Robles', 'LCD'),
    (4, 'Renata Solís', 'IIA');
INSERT INTO Materia (idMateria, nombre, creditos) VALUES
    (1, 'Bases de Datos', 8),
    (2, 'Análisis y Diseño de Algoritmos', 8),
    (3, 'Finanzas Empresariales', 6);
INSERT INTO Calificacion (idAlumno, idMateria, calificacion) VALUES
    (1, 1, 9.5),
    (1, 2, 8.0),
    (1, 3, 9.0),
    (2, 1, 7.5),
    (2, 2, 6.0),
    (3, 1, 10.0),
    (3, 3, 8.5);
GO
SELECT 'Base Escuela lista' AS Mensaje;
