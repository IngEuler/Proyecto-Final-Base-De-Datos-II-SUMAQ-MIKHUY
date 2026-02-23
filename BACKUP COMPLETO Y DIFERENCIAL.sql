
--BACKUP COMPLETO

BACKUP DATABASE SUMAQ_MIKHUY_BD
TO DISK = 'C:\ciclo 4 (Universidad)\Base de datos 2\unidad 3\ejercicos de la unidad 3\SUMAQ_full.bak';

-- 1. RESPALDO COMPLETO (Full Backup)
-- Se realiza semanalmente según tu política descrita
BACKUP DATABASE [SUMAQ_MIKHUY_BD]
TO DISK = N'C:\Backups\SUMAQ_Full.bak' 
WITH NOFORMAT, NOINIT, 
NAME = N'SUMAQ_MIKHUY-Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD, STATS = 10;
GO

-- 2. RESPALDO DIFERENCIAL
-- Se realiza diariamente para capturar cambios
BACKUP DATABASE [SUMAQ_MIKHUY_BD]
TO DISK = N'C:\Backups\SUMAQ_Diff.bak' 
WITH DIFFERENTIAL, NOFORMAT, NOINIT, 
NAME = N'SUMAQ_MIKHUY-Differential Backup', 
SKIP, NOREWIND, NOUNLOAD, STATS = 10;
GO

-- 3. RESPALDO DE LOGS (Transaccional)
-- Se realiza cada 2 horas
BACKUP LOG [SUMAQ_MIKHUY_BD]
TO DISK = N'C:\Backups\SUMAQ_Log.trn' 
WITH NOFORMAT, NOINIT, 
NAME = N'SUMAQ_MIKHUY-Transaction Log Backup', 
SKIP, NOREWIND, NOUNLOAD, STATS = 10;
GO
