using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;
using Domain;
using Dapper;
using System.Net;
using System.Net.Mail;

namespace SLARedLight
{
    /// <summary>
    /// Marks unmet SLAs - the service will trigger alerting events
    /// </summary>
    class Program
    {
        private class SLAR
        {
            public int Id { get; set; }
            public int TaskId { get; set; }
            public DateTime Created { get; set; }
        }
        private static SLAR[] GetMarkedRecords(DateTime created)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                db.Open();
                var q = @"SELECT * FROM [Collect2000].[ERCTasks].[SLARedLightTrack] WHERE Created = @created";
                return db.Query<SLAR>(q, new { created = created }).ToArray<SLAR>();
            }
        }
        private static readonly string ConnectionString = ConfigurationManager.AppSettings.Get("Connection");
        private static void MarkRecord(int TaskId)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                db.Open();
                var q = @"INSERT INTO [Collect2000].[ERCTasks].[SLARedLightTrack] (TaskId) VALUES(@taskId)";
                db.Query(q, new { taskId = TaskId });
            }
        }
        private static void SendEmails(IEnumerable<string> bcc, TaskInfo task)
        {
            using (var email = new MailMessage())
            {
                foreach (var address in bcc)
                    email.Bcc.Add(address);
                email.From = new MailAddress("alerts@erctasks.com");
                email.Subject = String.Format("Alert! '%s' SLA not met", task.task.TaskName);
                email.Body = String.Format(@"

                            <html>
                            <head></head>
                            <body>
                               <h2>%s</h2>
                               <h5>%s</h5>
                               <br />
                            </body>
                            </html>", task.task.TaskName, task.task.TaskDesc);
                email.IsBodyHtml = true;
                using (var smtp = new SmtpClient(ConfigurationManager.AppSettings.Get("SMTPAddress")))
                {
                    smtp.Credentials = new NetworkCredential(ConfigurationManager.AppSettings.Get("SMTPUser"), ConfigurationManager.AppSettings.Get("SMTPPassword"));
                    smtp.Send(email);
                }
            }
        }
        private static void EmailAlerts(TaskInfo task)
        {
            var emailList = task.AssignedTo.Select(p => p.Email);
            SendEmails(emailList, task);
        }
        static void Main(string[] args)
        {
            while (true)
            {
                using (var db = new SqlConnection(ConnectionString))
                {
                    db.Open();
                    // filter records that are already marked for the day
                    var marked = GetMarkedRecords(DateTime.Today);
                    var tasks = TaskManager.GetTasks(DateTime.Today, 1).Where(p => !marked.Any(k => k.TaskId == p.TaskId));
                    var hourNow = DateTime.Now.Hour;
                    var minutesNow = DateTime.Now.Minute;
                    foreach (var task in tasks)
                    {
                        if (task.TaskDueDate != null && task.TaskDueDate < DateTime.Now)
                        {
                            MarkRecord(task.TaskId);
                           // EmailAlerts(task);
                        }
                        else if (task.TaskDueHour < hourNow || (task.TaskDueHour == hourNow && task.TaskDueMinutes < minutesNow))
                        {
                            MarkRecord(task.TaskId);
                          //  EmailAlerts(task);
                        }
                    }
                }
                System.Threading.Thread.Sleep(1000);
            }
        }
    }
}
