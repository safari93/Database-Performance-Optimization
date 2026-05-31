# Capture All DBs Performance

## Overview

This project provides a SQL Server Agent job that automates the collection of database performance metrics across user databases. The job captures performance snapshots and stores them in a dedicated monitoring database (`DBA_Perf`) for analysis, troubleshooting, and capacity planning.

## Purpose

The objective of this solution is to:

* Continuously monitor database performance
* Identify performance bottlenecks and trends
* Support proactive database administration
* Provide historical performance data for troubleshooting
* Enable data-driven capacity planning and optimization

## Features

* Automated SQL Server Agent Job
* Runs every 15 minutes
* Captures performance metrics from all user databases
* Configurable lookback period
* Automatic retry mechanism on failure
* Centralized storage in the `DBA_Perf` database

## Job Configuration

### Job Name

`Capture All DBs Performance`

### Schedule

| Setting    | Value            |
| ---------- | ---------------- |
| Frequency  | Daily            |
| Interval   | Every 15 Minutes |
| Start Time | 00:00            |
| End Time   | 23:59            |

### Retry Policy

| Setting        | Value     |
| -------------- | --------- |
| Retry Attempts | 3         |
| Retry Interval | 5 Minutes |

## Execution Logic

The SQL Agent job executes the following stored procedure:

```sql
EXEC DBA_Perf.dbo.Capture_AllDBs
    @LookbackHours = 6,
    @IncludeSystemDBs = 0,
    @AutoEnableQueryStore = 0;
```

### Parameters

| Parameter             | Description                                        |
| --------------------- | -------------------------------------------------- |
| @LookbackHours        | Number of hours of historical data to analyze      |
| @IncludeSystemDBs     | Excludes SQL Server system databases when set to 0 |
| @AutoEnableQueryStore | Prevents automatic Query Store activation          |

## Architecture

SQL Server Agent
↓
Capture Job
↓
Capture_AllDBs Stored Procedure
↓
DBA_Perf Database
↓
Performance Analysis & Reporting

## Prerequisites

* SQL Server Agent enabled
* DBA_Perf database created
* Capture_AllDBs stored procedure deployed
* Appropriate SQL Server permissions

## Deployment

1. Create the `DBA_Perf` database.
2. Deploy the `Capture_AllDBs` stored procedure.
3. Execute the job creation script.
4. Verify successful job creation in SQL Server Agent.
5. Monitor initial executions and validate captured data.

## Use Cases

* Database performance monitoring
* Capacity planning
* Slow query investigation
* Trend analysis
* Production health monitoring
* Enterprise DBA operations

## Technologies

* Microsoft SQL Server
* T-SQL
* SQL Server Agent
* Query Performance Monitoring

## Author

Honore Safari

Senior Database Administrator | Enterprise Systems Engineer | Full-Stack Developer

