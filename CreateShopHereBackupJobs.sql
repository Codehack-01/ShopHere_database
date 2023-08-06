--BACKUP ORDERDETAILS DAILY TO A TXT FILE
USE [msdb]
GO
DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'DailyOrderDetailsStorage', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'Store Transactions.OrderDetails on a text file', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'TagwaiDaniel\Tagwai Daniel', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'DailyOrderDetailsStorage', @server_name = N'TAGWAIDANIEL'
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'DailyOrderDetailsStorage', @step_name=N'Storage', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC xp_cmdshell ''bcp "SELECT * FROM ShopHere.Transactions.OrderDetails" queryout "C:\DbBackups\OrderDetailsBackup.txt" -T -c -t,''', 
		@database_name=N'ShopHere', 
		@flags=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_name=N'DailyOrderDetailsStorage', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'Store Transactions.OrderDetails on a text file', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'TagwaiDaniel\Tagwai Daniel', 
		@notify_email_operator_name=N'', 
		@notify_page_operator_name=N''
GO
USE [msdb]
GO
DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name=N'DailyOrderDetailsStorage', @name=N'OrderDetailsStorage', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=127, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20211115, 
		@active_end_date=99991231, 
		@active_start_time=125000, 
		@active_end_time=235959, @schedule_id = @schedule_id OUTPUT
select @schedule_id
GO


----------------------------
--DAILY DATABASE BACKUP CODE
USE [msdb]
GO
DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'DailyDBBackup', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'Backup the ShopHere Database Daily', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'TagwaiDaniel\Tagwai Daniel', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'DailyDBBackup', @server_name = N'TAGWAIDANIEL'
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'DailyDBBackup', @step_name=N'Backup Code', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP DATABASE ShopHere
TO DISK = ''C:\DBBackups\ShopHere.bak''', 
		@database_name=N'ShopHere', 
		@flags=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_name=N'DailyDBBackup', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'Backup the ShopHere Database Daily', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'TagwaiDaniel\Tagwai Daniel', 
		@notify_email_operator_name=N'', 
		@notify_page_operator_name=N''
GO
USE [msdb]
GO
DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name=N'DailyDBBackup', @name=N'DailySchedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20211118, 
		@active_end_date=99991231, 
		@active_start_time=120000, 
		@active_end_time=235959, @schedule_id = @schedule_id OUTPUT
select @schedule_id
GO