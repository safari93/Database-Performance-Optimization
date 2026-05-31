--1
Use Master
GO
alter database [B_RECON_PROCESS]
  set offline with rollback immediate
  alter database [B_RECON_PROCESS]
  set online
GO
 
Restore Database [B_RECON_PROCESS] from Disk = 'C:\AllData\CurrentWork\A_Code\BK\Data\Backup\B_RECON_PROCESS_7_Full.bak'
with move 'B_RECON_PROCESS' to  'C:\AllData\CurrentWork\A_Code\BK\Data\LiveData\B_RECON_PROCESS_Data.mdf',
move 'B_RECON_PROCESS_Log' to  'C:\AllData\CurrentWork\A_Code\BK\Data\LiveData\B_RECON_PROCESS_Log.ldf', replace
GO
 
--2
Use Master
GO
alter database [B_RECON_PROCESS_EXT]
  set offline with rollback immediate
  alter database [B_RECON_PROCESS_EXT]
  set online
GO
 
Restore Database [B_RECON_PROCESS_EXT] from Disk = 'C:\AllData\CurrentWork\A_Code\BK\Data\Backup\B_RECON_PROCESS_EXT_6_Full.bak'
with move 'B_RECON_PROCESS_EXT' to  'C:\AllData\CurrentWork\A_Code\BK\Data\LiveData\B_RECON_PROCESS_EXT_Data.mdf',
        move 'B_RECON_PROCESS_EXT_Log' to  'C:\AllData\CurrentWork\A_Code\BK\Data\LiveData\B_RECON_PROCESS_EXT_Log.ldf', replace
GO
 
--3 
Use Master
GO
alter database [B_RECON_SETTLE]
  set offline with rollback immediate
  alter database [B_RECON_SETTLE]
  set online
GO
 
Restore Database [B_RECON_SETTLE] from Disk = 'C:\AllData\CurrentWork\A_Code\BK\Data\Backup\B_RECON_SETTLE_7_Full.bak'
with move 'B_RECON_SETTLE' to  'C:\AllData\CurrentWork\A_Code\BK\Data\LiveData\B_RECON_SETTLE_Data.mdf',
move 'B_RECON_SETTLE_Log' to  'C:\AllData\CurrentWork\A_Code\BK\Data\LiveData\B_RECON_SETTLE_Log.ldf', replace
GO

--4
Use Master
GO
alter database [B_RECON_STAGING]
  set offline with rollback immediate
  alter database [B_RECON_STAGING]
  set online
GO
 
Restore Database [B_RECON_STAGING] from Disk = 'C:\AllData\CurrentWork\A_Code\BK\Data\Backup\B_RECON_STAGING_7_Full.bak'
with move 'B_RECON_STAGING' to  'C:\AllData\CurrentWork\A_Code\BK\Data\LiveData\B_RECON_STAGING_Data.mdf',
move 'B_RECON_STAGING_Log' to  'C:\AllData\CurrentWork\A_Code\BK\Data\LiveData\B_RECON_STAGING_Log.ldf', replace
GO

--5
Use Master
GO
alter database [B_RECON_MAIN]
  set offline with rollback immediate
  alter database [B_RECON_MAIN]
  set online
GO
 
Restore Database [B_RECON_MAIN] from Disk = 'C:\AllData\CurrentWork\A_Code\BK\Data\Backup\B_RECON_MAIN_7_Full.bak'
with move 'B_RECON_MAIN' to  'C:\AllData\CurrentWork\A_Code\BK\Data\LiveData\B_RECON_MAIN_Data.mdf',
move 'B_RECON_MAIN_Log' to  'C:\AllData\CurrentWork\A_Code\BK\Data\LiveData\B_RECON_MAIN_Log.ldf', replace
GO

 
 
