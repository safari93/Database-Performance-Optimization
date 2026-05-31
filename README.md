# Database Operations, Backup & Disaster Recovery Automation

## Overview

This repository contains a collection of SQL Server administration solutions designed to support enterprise database operations, including:

* Automated database performance monitoring
* Scheduled database backups
* Database restoration procedures
* Disaster recovery preparation
* Database maintenance and storage management

The solution was developed to ensure high availability, operational resilience, and rapid recovery of critical reconciliation databases.

---

## Key Components

### 1. Database Performance Monitoring

A SQL Server Agent Job named:

```text
Capture All DBs Performance
```

collects performance metrics from user databases every 15 minutes and stores the results in a centralized monitoring repository (`DBA_Perf`).

#### Features

* Automated performance snapshots
* Historical performance analysis
* Capacity planning support
* Slow query investigation
* Trend analysis

#### Execution

```sql
EXEC DBA_Perf.dbo.Capture_AllDBs
    @LookbackHours = 6,
    @IncludeSystemDBs = 0,
    @AutoEnableQueryStore = 0;
```

#### Schedule

| Setting        | Value            |
| -------------- | ---------------- |
| Frequency      | Daily            |
| Interval       | Every 15 Minutes |
| Retry Attempts | 3                |
| Retry Interval | 5 Minutes        |

---

### 2. Automated Database Backup Solution

A SQL Server Agent Job named:

```text
10_Admin_Backup
```

performs scheduled backups of critical reconciliation databases.

#### Databases Protected

* B_RECON_MAIN
* B_RECON_PROCESS
* B_RECON_PROCESS_EXT
* B_RECON_PROCESS_EXT2
* B_RECON_SETTLE
* B_RECON_STAGING

#### Backup Features

* Full database backups
* Backup compression
* Rotating backup files by weekday
* Automated database maintenance
* Log file size reduction
* Storage optimization

#### Maintenance Process

Before backup execution:

1. Recovery model temporarily changed to SIMPLE
2. Database files shrunk
3. Transaction log files shrunk
4. Recovery model restored to FULL
5. Backup generated

Example:

```sql
ALTER DATABASE B_RECON_MAIN
SET RECOVERY SIMPLE;

DBCC SHRINKFILE (B_RECON_MAIN, 1000);
DBCC SHRINKFILE (B_RECON_MAIN_Log, 1);

ALTER DATABASE B_RECON_MAIN
SET RECOVERY FULL;
```

#### Backup Schedule

| Setting     | Value   |
| ----------- | ------- |
| Frequency   | Daily   |
| Start Time  | 23:30   |
| Backup Type | Full    |
| Compression | Enabled |

#### Backup Storage

```text
D:\BackupRecon\
```

Example file:

```text
B_RECON_MAIN_7_Full.bak
```

---

### 3. Disaster Recovery & Database Restoration

The repository includes tested restoration procedures for recovering critical databases from backup files.

#### Supported Database Restores

* B_RECON_MAIN
* B_RECON_PROCESS
* B_RECON_PROCESS_EXT
* B_RECON_SETTLE
* B_RECON_STAGING

#### Restore Process

The recovery procedure:

1. Places the database offline
2. Forces rollback of active transactions
3. Restores the database from backup
4. Relocates MDF and LDF files
5. Replaces existing database files

Example:

```sql
ALTER DATABASE [B_RECON_MAIN]
SET OFFLINE WITH ROLLBACK IMMEDIATE;

ALTER DATABASE [B_RECON_MAIN]
SET ONLINE;

RESTORE DATABASE [B_RECON_MAIN]
FROM DISK = 'C:\Backup\B_RECON_MAIN_7_Full.bak'
WITH
    MOVE 'B_RECON_MAIN'
        TO 'C:\Data\B_RECON_MAIN_Data.mdf',
    MOVE 'B_RECON_MAIN_Log'
        TO 'C:\Data\B_RECON_MAIN_Log.ldf',
    REPLACE;
```

#### Recovery Objectives

| Objective             | Purpose                               |
| --------------------- | ------------------------------------- |
| Database Availability | Minimize downtime                     |
| Data Protection       | Preserve critical reconciliation data |
| Disaster Recovery     | Rapid restoration after failure       |
| Business Continuity   | Maintain operational readiness        |

---

## Solution Architecture

```text
SQL Server Agent
        │
        ├── Performance Monitoring Job
        │         │
        │         ▼
        │     DBA_Perf Database
        │
        ├── Backup Automation Job
        │         │
        │         ▼
        │    Backup Repository
        │
        └── Restore Procedures
                  │
                  ▼
           Disaster Recovery
```

---

## Repository Structure

```text
Database-Operations-DR/
│
├── performance-monitoring/
│   ├── Capture_All_DBs_Performance.sql
│
├── backup-automation/
│   ├── 10_Admin_Backup.sql
│
├── disaster-recovery/
│   ├── Restore_B_RECON_MAIN.sql
│   ├── Restore_B_RECON_PROCESS.sql
│   ├── Restore_B_RECON_PROCESS_EXT.sql
│   ├── Restore_B_RECON_SETTLE.sql
│   └── Restore_B_RECON_STAGING.sql
│
└── documentation/
    └── README.md
```

---

## Technologies

* Microsoft SQL Server
* SQL Server Agent
* T-SQL
* Backup Compression
* Database Recovery
* Performance Monitoring

---

## Skills Demonstrated

* SQL Server Administration
* Backup & Recovery Management
* Disaster Recovery Planning
* Performance Monitoring
* Database Maintenance
* Capacity Planning
* Business Continuity Support
* Enterprise Database Operations

---

## Author

Honore Safari

Senior Database Administrator | Enterprise Systems Engineer | Full-Stack Developer
