-- No es necesario crear una función adicional para la creación de más espacios, 
--ya que el procedimiento almacenado `sp_poblar_espacios` cubre todas las necesidades
 --actuales de inserción de registros en la tabla `tbc_espacios`. Este procedimiento 
 --realiza las inserciones de manera jerárquica y predefinida, garantizando la correcta 
 --relación entre los distintos niveles de espacios. Además, incluye validaciones
 --  de seguridad y operaciones de mantenimiento como actualizaciones y eliminaciones.
  
-- Las inserciones en el procedimiento son para datos predefinidos y estáticos, 
--lo que significa que los valores específicos de los registros a insertar 
--ya están determinados y no necesitan ser dinámicos
