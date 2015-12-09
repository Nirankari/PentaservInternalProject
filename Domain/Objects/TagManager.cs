using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using System.Configuration;
namespace Domain
{
    public static class TagManager
    {
       private static readonly string ConnectionString = ConfigurationManager.AppSettings.Get("Connection");

       public static void SaveTags(Tag tags, int taskId)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                db.Open();
                var q = @"INSERT INTO [Collect2000].[ERCTasks].[Tags] 
                        (tag)
                        VALUES (@TagDescription);SELECT SCOPE_IDENTITY();";
             var tagID=   db.Query<int>(q, new
                {
                    TagDescription = tags.tag

                });
                var q1 = @"INSERT INTO [Collect2000].[ERCTasks].[TaskTags] 
                        (TagId,TaskId)
                        VALUES (@TagID,@TaskID);";
                db.Query<int>(q1, new
                {
                    TagID = tagID,
                    TaskID = taskId

                });

            }
        }

       public static void DeleteTag(int tagId)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                db.Open();
                var q = @"DELETE FROM [collect2000].[ERCTasks].[Tags] WHERE TagId = @TagId";
                db.Query(q, new { TagId = tagId });
                var q1 = @"DELETE FROM [collect2000].[ERCTasks].[TaskTags] WHERE TagId = @TagId";
                db.Query(q1, new { TagId = tagId });

            }
        }
        
       public static void SaveImportedTags(string tags, int taskId)
       {
           using (var db = new SqlConnection(ConnectionString))
           {
               db.Open();
               var q = @"IF NOT EXISTS (SELECT * FROM [Collect2000].[ERCTasks].[Tags] WHERE tag=@tags) BEGIN INSERT INTO [Collect2000].[ERCTasks].[Tags] (tag) VALUES (@tags);SELECT SCOPE_IDENTITY(); END";
               var tagID = db.Query<int>(q, new
               {
                   tags =tags

               }).FirstOrDefault<int>(); 

               if (tagID > 0)
               {
                   var q1 = @"INSERT INTO [Collect2000].[ERCTasks].[TaskTags] 
                        (TagId,TaskId)
                        VALUES (@TagID,@TaskID);";
                   db.Query<int>(q1, new
                   {
                       TagID = tagID,
                       TaskID = taskId

                   });
               }

           }
       }
    }
}
