ALTER ROLE [db_owner] ADD MEMBER [sqluser];


GO
ALTER ROLE [db_accessadmin] ADD MEMBER [sqluser];


GO
ALTER ROLE [db_securityadmin] ADD MEMBER [sqluser];


GO
ALTER ROLE [db_ddladmin] ADD MEMBER [sqluser];


GO
ALTER ROLE [db_backupoperator] ADD MEMBER [sqluser];


GO
ALTER ROLE [db_datareader] ADD MEMBER [sqluser];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [sqluser];

