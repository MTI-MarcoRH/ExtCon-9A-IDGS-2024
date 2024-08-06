--No es necesario crear una función adicional para la creación de más espacios,
-- ya que el procedimiento almacenado `sp_poblar_espacios` cubre todas las 
--necesidades actuales de inserción de registros en la tabla `tbc_espacios`. 
--Este procedimiento realiza las inserciones de manera jerárquica y predefinida,
-- garantizando la correcta relación entre los distintos niveles de espacios.

-- Además, incluye validaciones de seguridad y operaciones de mantenimiento 
--como actualizaciones y eliminaciones. Dado que los datos son predefinidos
-- y estáticos, no hay necesidad de una población dinámica de datos.


