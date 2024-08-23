TABLA DERIVADA CIRUGIA CONSUMIBLES 

call sp_poblar_pacientes_dinamico('1234', 200);
select * from tbb_pacientes;
-- 2 poblar espacios medicos
call sp_poblar_espacios('xYz$123');
select*from tbc_espacios;
-- 3 poblar cirugias
call sp_poblar_cirugias_dinamico(200);
select*from tbb_cirugias;
-- 4 poblar consumibles
call sp_poblar_consumibles('xYz$123');
select*from consumibles;
-- 5 cirugias consumibles
call sp_poblar_cirugia_consumibles_dinamico('100');
select * from tbd_cirugia_consumibles;
