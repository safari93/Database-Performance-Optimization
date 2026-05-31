USE [msdb]
GO

/****** Object:  Job [10_Admin_Backup]    Script Date: 5/31/2026 9:48:04 AM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 5/31/2026 9:48:04 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'10_Admin_Backup', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'BK\lniyongabo', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Backup]    Script Date: 5/31/2026 9:48:04 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Backup', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--USE B_RECON_LEGACY;
--GO
---- Truncate the log by changing the database recovery model to SIMPLE.
--ALTER DATABASE B_RECON_LEGACY
--SET RECOVERY SIMPLE;
--GO
--DBCC SHRINKFILE (B_RECON_LEGACY, 1000);  
--GO
--DBCC SHRINKFILE (B_RECON_LEGACY_Log, 1);
--GO
---- Reset the database recovery model.
--ALTER DATABASE B_RECON_LEGACY
--SET RECOVERY FULL;
--GO

--Use Master
--GO
--DECLARE @DBName varchar(255)
--DECLARE @Path VARCHAR(255)
--DECLARE @Seq varchar(50)
--set @DBName=''B_RECON_LEGACY''
--SET @Seq=CAST(DATEPART(WEEKDAY,GETDATE()) as varchar(1))
--Set @Path=''D:\BackupRecon\'' + replace(@DBName,''.'',''_'') + ''_'' + @Seq + ''_Full.bak''

--BACKUP DATABASE @DBName TO DISK = @Path WITH FORMAT,
--    NAME = N''B_RECON_LEGACY Full Backup'', SKIP, NOREWIND, COMPRESSION, NOUNLOAD,  STATS = 10
--GO

USE B_RECON_MAIN;
GO
-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE B_RECON_MAIN
SET RECOVERY SIMPLE;
GO
DBCC SHRINKFILE (B_RECON_MAIN, 1000);  
GO
DBCC SHRINKFILE (B_RECON_MAIN_Log, 1);
GO
-- Reset the database recovery model.
ALTER DATABASE B_RECON_MAIN
SET RECOVERY FULL;
GO

Use Master
GO
DECLARE @DBName varchar(255)
DECLARE @Path VARCHAR(255)
DECLARE @Seq varchar(50)
set @DBName=''B_RECON_MAIN''
SET @Seq=CAST(DATEPART(WEEKDAY,GETDATE()) as varchar(1))
Set @Path=''D:\BackupRecon\'' + replace(@DBName,''.'',''_'') + ''_'' + @Seq + ''_Full.bak''

BACKUP DATABASE @DBName TO DISK = @Path WITH FORMAT,
    NAME = N''B_RECON_MAIN Full Backup'', SKIP, NOREWIND, COMPRESSION, NOUNLOAD,  STATS = 10
GO

USE B_RECON_PROCESS;
GO
-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE B_RECON_PROCESS
SET RECOVERY SIMPLE;
GO
DBCC SHRINKFILE (B_RECON_PROCESS, 1000);  
GO
DBCC SHRINKFILE (B_RECON_PROCESS_Log, 1);
GO
-- Reset the database recovery model.
ALTER DATABASE B_RECON_PROCESS
SET RECOVERY FULL;
GO

Use Master
GO
DECLARE @DBName varchar(255)
DECLARE @Path VARCHAR(255)
DECLARE @Seq varchar(50)
set @DBName=''B_RECON_PROCESS''
SET @Seq=CAST(DATEPART(WEEKDAY,GETDATE()) as varchar(1))
Set @Path=''D:\BackupRecon\'' + replace(@DBName,''.'',''_'') + ''_'' + @Seq + ''_Full.bak''

BACKUP DATABASE @DBName TO DISK = @Path WITH FORMAT,
    NAME = N''B_RECON_PROCESS Full Backup'', SKIP, NOREWIND, COMPRESSION, NOUNLOAD,  STATS = 10
GO

USE B_RECON_PROCESS_EXT;
GO
-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE B_RECON_PROCESS_EXT
SET RECOVERY SIMPLE;
GO
DBCC SHRINKFILE (B_RECON_PROCESS_EXT, 1000);  
GO
DBCC SHRINKFILE (B_RECON_PROCESS_EXT_Log, 1);
GO
-- Reset the database recovery model.
ALTER DATABASE B_RECON_PROCESS_EXT
SET RECOVERY FULL;
GO

Use Master
GO
DECLARE @DBName varchar(255)
DECLARE @Path VARCHAR(255)
DECLARE @Seq varchar(50)
set @DBName=''B_RECON_PROCESS_EXT''
SET @Seq=CAST(DATEPART(WEEKDAY,GETDATE()) as varchar(1))
Set @Path=''D:\BackupRecon\'' + replace(@DBName,''.'',''_'') + ''_'' + @Seq + ''_Full.bak''

BACKUP DATABASE @DBName TO DISK = @Path WITH FORMAT,
    NAME = N''B_RECON_PROCESS_EXT Full Backup'', SKIP, NOREWIND, COMPRESSION, NOUNLOAD,  STATS = 10
GO

USE B_RECON_PROCESS_EXT2;
GO
-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE B_RECON_PROCESS_EXT2
SET RECOVERY SIMPLE;
GO
DBCC SHRINKFILE (B_RECON_PROCESS_EXT2, 1000);  
GO
DBCC SHRINKFILE (B_RECON_PROCESS_EXT2_Log, 1);
GO
-- Reset the database recovery model.
ALTER DATABASE B_RECON_PROCESS_EXT2
SET RECOVERY FULL;
GO

Use Master
GO
DECLARE @DBName varchar(255)
DECLARE @Path VARCHAR(255)
DECLARE @Seq varchar(50)
set @DBName=''B_RECON_PROCESS_EXT2''
SET @Seq=CAST(DATEPART(WEEKDAY,GETDATE()) as varchar(1))
Set @Path=''D:\BackupRecon\'' + replace(@DBName,''.'',''_'') + ''_'' + @Seq + ''_Full.bak''

BACKUP DATABASE @DBName TO DISK = @Path WITH FORMAT,
    NAME = N''B_RECON_PROCESS_EXT2 Full Backup'', SKIP, NOREWIND, COMPRESSION, NOUNLOAD,  STATS = 10
GO


USE B_RECON_SETTLE;
GO
-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE B_RECON_SETTLE
SET RECOVERY SIMPLE;
GO
DBCC SHRINKFILE (B_RECON_SETTLE, 1000);  
GO
DBCC SHRINKFILE (B_RECON_SETTLE_Log, 1);
GO
-- Reset the database recovery model.
ALTER DATABASE B_RECON_SETTLE
SET RECOVERY FULL;
GO

Use Master
GO
DECLARE @DBName varchar(255)
DECLARE @Path VARCHAR(255)
DECLARE @Seq varchar(50)
set @DBName=''B_RECON_SETTLE''
SET @Seq=CAST(DATEPART(WEEKDAY,GETDATE()) as varchar(1))
Set @Path=''D:\BackupRecon\'' + replace(@DBName,''.'',''_'') + ''_'' + @Seq + ''_Full.bak''

BACKUP DATABASE @DBName TO DISK = @Path WITH FORMAT,
    NAME = N''B_RECON_SETTLE Full Backup'', SKIP, NOREWIND, COMPRESSION, NOUNLOAD,  STATS = 10
GO

USE B_RECON_STAGING;
GO
-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE B_RECON_STAGING
SET RECOVERY SIMPLE;
GO
DBCC SHRINKFILE (B_RECON_STAGING, 1000);  
GO
DBCC SHRINKFILE (B_RECON_STAGING_Log, 1);
GO
-- Reset the database recovery model.
ALTER DATABASE B_RECON_STAGING
SET RECOVERY FULL;
GO

Use Master
GO
DECLARE @DBName varchar(255)
DECLARE @Path VARCHAR(255)
DECLARE @Seq varchar(50)
set @DBName=''B_RECON_STAGING''
SET @Seq=CAST(DATEPART(WEEKDAY,GETDATE()) as varchar(1))
Set @Path=''D:\BackupRecon\'' + replace(@DBName,''.'',''_'') + ''_'' + @Seq + ''_Full.bak''

BACKUP DATABASE @DBName TO DISK = @Path WITH FORMAT,
    NAME = N''B_RECON_STAGING Full Backup'', SKIP, NOREWIND, COMPRESSION, NOUNLOAD,  STATS = 10
GO



', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Schedule1', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20231201, 
		@active_end_date=99991231, 
		@active_start_time=233000, 
		@active_end_time=235959, 
		@schedule_uid=N'4204f167-b4cf-47b9-87a5-a8f657cbbd08'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


