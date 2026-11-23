<h1 align="center">Bases de Datos</h1>

<p align="center"><strong>Escuela Superior de Cómputo · Instituto Politécnico Nacional</strong><br>Ingeniería en Sistemas Computacionales · Tercer semestre</p>

<p align="center">
  <a href="https://www.escom.ipn.mx/htmls/oferta/mapaCurrISC2020.php"><img src="https://img.shields.io/badge/ISC-Plan_2020-6D1A42?style=flat-square" alt="ISC · Plan 2020"></a>
  <img src="https://img.shields.io/badge/Semestre-III-334155?style=flat-square" alt="Semestre III">
  <img src="https://img.shields.io/badge/Grupo-3CM3-1E5A7A?style=flat-square" alt="Grupo 3CM3">
</p>

<p align="center"><a href="#programa-de-estudios">Programa de estudios</a> &nbsp;·&nbsp; <a href="#contenido-del-repositorio">Contenido</a> &nbsp;·&nbsp; <a href="#uso-del-material">Uso del material</a> &nbsp;·&nbsp; <a href="#referencias">Referencias</a></p>

---

Diseño de modelos de datos, normalización, álgebra relacional y prácticas de SQL Server. Incluye enunciados, soluciones, diagramas, respaldos y la documentación académica del proyecto Hospital Arboleda.

| Acceso directo | Qué encontrarás |
|---|---|
| [Abrir el laboratorio SQL](02_guias/g06_laboratorio_sql/) | Guía y archivos de apoyo para practicar consultas. |
| [Trabajar con Aerolíneas](01_tareas/act09_consultas_aerolineas/) | Consultas, reportes, restauración y respaldos. |
| [Consultar el proyecto Hospital Arboleda](05_proyectos/hospital_arboleda/) | [Informes, demostraciones y anexos de las dos entregas](https://github.com/EmilioNoyola/Hospital-Arboleda/tree/main/output/3CM3_Hospital_Arboleda). |

## Programa de estudios

Pasar de los requerimientos de información a un modelo de datos y a su implementación en un gestor relacional.

Síntesis del [programa oficial de la unidad de aprendizaje](https://www.escom.ipn.mx/docs/oferta/uaISC2020/basesDatos_ISC2020.pdf), perteneciente al **Plan ISC 2020**.

**Carga semanal:** 3 horas de teoría y 1.5 de práctica. **Créditos:** 7.5 TEPIC / 5.9 SATCA.

| Unidad | Eje de estudio | Alcance |
|:---:|---|---|
| I | Conceptos y gestores | Datos, modelos y organización de un sistema de bases de datos. |
| II | Diseño conceptual | Entidades, atributos, relaciones y restricciones. |
| III | Diseño relacional | Tablas, llaves, dependencias y normalización. |
| IV | Consultas formales | Operaciones del álgebra y del cálculo relacional. |
| V | Implementación con SQL | Definición, consulta y manipulación de datos. |

**Antecedentes académicos:** Matemáticas Discretas.

El programa describe el alcance de la asignatura. Las carpetas siguientes muestran el material efectivamente disponible en esta colección.

## Contenido del repositorio

| Carpeta | Contenido |
|---|---|
| [Actividades y tareas](01_tareas/) · `01_tareas` | Modelos de datos, ER, normalización, álgebra relacional y SQL; diagrama del SAES. |
| [Guías](02_guias/) · `02_guias` | Parciales, DFD, álgebra relacional y laboratorio SQL. |
| [Apuntes](03_apuntes/) · `03_apuntes` | Cuaderno de Bases de Datos. |
| [Material de clase](04_material_clase/) · `04_material_clase` | Diapositivas de álgebra relacional en PDF y PowerPoint. |
| [Proyecto final](05_proyectos/) · `05_proyectos` | Documentación y enlace al repositorio independiente de Hospital Arboleda. |

Los trabajos individuales del grupo 3CM3 llevan el número de actividad, el nombre de la actividad, el apellido paterno y los nombres del autor. Los trabajos del equipo 1 llevan `1` y las iniciales `ATLG_FSJM_HX_NGED`. En Hospital Arboleda, 01 y 02 identifican los avances del proyecto. Las actividades de origen conservan su número de clase.

## Uso del material

### Trabajar con las actividades SQL

Utiliza Microsoft SQL Server y SQL Server Management Studio; `sqlcmd` es útil para ejecutar scripts desde terminal. Los archivos `.bak` son respaldos de bases de datos, no documentos SQL editables.

| Material | Función |
|---|---|
| [Actividad 07](01_tareas/act07_consultas_basicas_sql/) | Consultas básicas y base de práctica. |
| [Actividad 08](01_tareas/act08_creacion_bd/) | Creación de Aerolíneas, diagrama y respaldo. |
| [Actividad 09](01_tareas/act09_consultas_aerolineas/) | Consultas sobre Aerolíneas, respaldo de clase y resultados de la actividad. |

Abre primero el reporte y el enunciado. Antes de ejecutar un `.sql`, revisa la base indicada por `USE`, las rutas y las instrucciones de creación, modificación o borrado. Las actividades son independientes: no hay un único script que deba ejecutar todo el repositorio.

Los scripts de restauración usan `C:\Users\Public\Documents`, una ubicación accesible al servicio SQL Server en el entorno de clase. Ajusta esa ruta si trabajas en otro equipo; la cuenta del servicio debe poder leer el respaldo. Verificar o restaurar una copia de práctica evita sobrescribir una base que estés utilizando.

En los reportes de las actividades 07 a 09 aparecen los nombres de archivo usados al tomar las capturas. Los anexos correspondientes se encuentran aquí.

| Actividad | Script presentado | Respaldo generado |
|---|---|---|
| 07 | [consultas_basicas.sql](01_tareas/act07_consultas_basicas_sql/3CM3_07_ConsultasBasicasSQL_Noyola_EmilioDamian.sql) | `3CM3_07_RespaldoPrueba_Noyola_EmilioDamian.bak` (copia local) |
| 08 | [bd_aerolineas.sql](01_tareas/act08_creacion_bd/3CM3_08_CreacionBDAerolineas_Noyola_EmilioDamian.sql) | [aerolineas.bak](01_tareas/act08_creacion_bd/3CM3_08_RespaldoAerolineas_Noyola_EmilioDamian.bak) |
| 09 | [consultas_aerolineas.sql](01_tareas/act09_consultas_aerolineas/3CM3_09_ConsultasAerolineas_Noyola_EmilioDamian.sql) | [aerolineas_consultas.bak](01_tareas/act09_consultas_aerolineas/3CM3_09_RespaldoConsultasAerolineas_Noyola_EmilioDamian.bak) |

### Hospital Arboleda

El código de la aplicación está en [Hospital-Arboleda](https://github.com/EmilioNoyola/Hospital-Arboleda), un repositorio privado independiente. Esta materia conserva su documentación y el submódulo [`05_proyectos/hospital_arboleda`](05_proyectos/hospital_arboleda).

<details>
<summary><strong>Descargar el código del submódulo</strong></summary>

Si tu cuenta tiene acceso al repositorio de Hospital, ejecuta desde la raíz de esta materia:

```powershell
git submodule update --init --recursive
```

Después sigue el README de Hospital para instalar, iniciar y respaldar la aplicación. El acceso a la materia no concede acceso automático al repositorio privado.

</details>

<details>
<summary><strong>Clonar el repositorio y descargar archivos grandes</strong></summary>

```powershell
git clone https://github.com/EmilioNoyola/Bases_de_Datos_3CM3_ATLG_HX_NGED_FSJM.git bases_datos
cd bases_datos
git lfs install
git lfs pull
```

Algunos recursos se almacenan con Git LFS. Instálalo antes de descargarlos; si ves un archivo de texto que empieza por `version https://git-lfs.github.com/spec/v1`, falta obtener el contenido con `git lfs pull`.

</details>

## Referencias

- [Programa oficial de Bases de Datos — PDF](https://www.escom.ipn.mx/docs/oferta/uaISC2020/basesDatos_ISC2020.pdf): unidades, carga académica, evaluación y bibliografía institucional.
- [Catálogo de unidades de aprendizaje de ISC 2020](https://www.escom.ipn.mx/htmls/oferta/mapaCurrISC2020.php): programas oficiales publicados por ESCOM.
- [Mapa curricular de ISC 2020 — PDF](https://www.escom.ipn.mx/docs/oferta/mapaCurricularISC2020.pdf): ubicación de la materia en la carrera.

---

**Repositorios relacionados:** [Hospital Arboleda](https://github.com/EmilioNoyola/Hospital-Arboleda) · [Análisis y Diseño de Algoritmos](https://github.com/EmilioNoyola/Analisis_y_Disenho_de_Algoritmos_3CM1_ATLG_NGED).

Colección académica de [Emilio Noyola](https://github.com/EmilioNoyola). La autoría de cada entrega se indica en su portada o en el código correspondiente.
