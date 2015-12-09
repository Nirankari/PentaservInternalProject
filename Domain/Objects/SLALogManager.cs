using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Configuration;
using Dapper;

namespace Domain
{
    public class SLALogManager
    {
        private static readonly string ConnectionString = ConfigurationManager.AppSettings.Get("Connection");
        public static void SLALogEntry(SLALog log)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                db.Open();
                var q = @"IF NOT EXISTS(SELECT * FROM [Collect2000].[ERCTasks].[SLALog] WHERE taskId = @taskId ) INSERT INTO [Collect2000].[ERCTasks].[SLALog] 
                         (TaskId, SLAMet, SubmittedByUserId, SubmittedTime)
                         VALUES (@taskId, @slaMet, @userId, @time)";
                db.Query(q, new
                {
                    taskId = log.TaskId,
                    slaMet = log.SLAMet,
                    userId = log.SubmittedByUserId,
                    time = log.SubmittedTime
                });
            }
        }
    }
}
