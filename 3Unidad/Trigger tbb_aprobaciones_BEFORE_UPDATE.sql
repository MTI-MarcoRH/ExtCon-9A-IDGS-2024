CREATE DEFINER=`carlos.crespo`@`%` TRIGGER `tbb_aprobaciones_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_aprobaciones` FOR EACH ROW BEGIN
	set new.fecha_actualizacion = current_timestamp();
END