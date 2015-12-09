using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Domain;
using System.Web.Http.Cors;

namespace ERC.Tasks_light.Controllers
{
    
    public class TasksController : ApiController
    {
        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        [Route("api/Tasks/GetUserTasks/{userid}")]
        public Task[] GetUserTasks(int userid)
        {
            return TaskManager.GetUserTasks(userid);
        }
        // Get MeetingInfo Function
        //[HttpGet]
        //[Route("api/Tasks/GetMeetingHistory/{adminid}")]
        //public User[] GetMeetingHistory(int adminid)
        //{
        //    return TaskManager.GetMeetingHistory(adminid);
        //}

        [HttpGet]
        [Route("api/Tasks/GetUserTaskInfo/{TaskId}")]
        public TaskInfo GetUserTaskInfo(int TaskId)
        {
            return TaskManager.GetTaskInfo(TaskId);
        }
        // POST: api/Tasks
        [System.Web.Http.Route("api/tasks/AddTask")]
        [System.Web.Http.HttpPost]
        public int AddTask(Task _obj)
        {
            try
            {
               return  TaskManager.AddTask(_obj);
               
            }
            catch (Exception ex) { return 0; }
        }
       
        // POST: api/Tasks
        [System.Web.Http.Route("api/tasks/AssignedToUser/{id}")]
        [System.Web.Http.HttpPost]
        public bool AssignedToUser(User[] _obj, int id)
        {
            try
            {
                TaskManager.AssignUserList(_obj, id);
                return true;
            }
            catch (Exception ex) { return false; }
        }

        // DELETE: api/Tasks/5
        [System.Web.Http.Route("api/tasks/DeleteTasks/{id}")]
        [System.Web.Http.HttpDelete]
        public IHttpActionResult DeleteTasks(int id)
        {            
            if (id == 0)
            {
                return NotFound();
            }            
            TaskManager.RemoveTask(id);
            return Ok("Deleted successfully.");
        }

        [HttpGet] 
        [Route("api/tasks/GetUsers/{Uid}")] 
        public User[] GetUsers(int Uid) 
        { 
            return TaskManager.GetUsers(Uid); 
        }
        [System.Web.Http.Route("api/tasks/EditTask")]
        [System.Web.Http.HttpPost]
        public bool EditTask(Task _obj)
        {
            try
            {
                TaskManager.EditTask(_obj);
                return true;
            }
            catch (Exception ex) { return false; }
        }
         [HttpGet]
         [Route("api/tasks/GetPerDayTaskForCalendar/{cdate}/{UserId}")]
        public Task[] GetPerDayTaskForCalendar(DateTime cdate, int UserId) 
        {
            return TaskManager.GetPerDayTasks(cdate, UserId);
            
        }
        [HttpGet]
        [Route("api/tasks/GetWeeklyTaskForCalendar/{sdate}/{edate}/{UserId}")]
         public List<Task[]> GetPerDayTaskForCalendar(DateTime sdate, DateTime edate, int UserId) 
        {
            return TaskManager.GetWeeklyTaskForCalendar(sdate, edate, UserId);
            
        }
        
         [HttpGet]
         [Route("api/tasks/GetPerMonthTaskForCalendar/{sdate}/{userId}")]
        public List<Task[]> GetPerMonthTaskForCalendar(DateTime sdate, int userId) 
        {
            return TaskManager.GetPerMonthTaskForCalendar(sdate, userId);
            
        }
         // POST: api/TagTask
         [System.Web.Http.Route("api/tasks/SaveTags/{id}")]
         [System.Web.Http.HttpPost]
         public bool SaveTags(Tag _obj, int id)
         {
             try
             {
                 TagManager.SaveTags(_obj, id);
                 return true;
             }
             catch (Exception ex) { return false; }
         }
         // DELETE: api/TagId/5
         [System.Web.Http.Route("api/tasks/DeleteTag/{id}")]
         [System.Web.Http.HttpDelete]
         public IHttpActionResult DeleteTag(int id)
         {
             if (id == 0)
             {
                 return NotFound();
             }
             TagManager.DeleteTag(id);
             return Ok("Deleted successfully.");
         }
         // DELETE: api/TagId/5
         [System.Web.Http.Route("api/tasks/RemoveAssignedUser/{UserId}/{TaskId}")]
         [System.Web.Http.HttpDelete]
         public IHttpActionResult RemoveAssignedUser(int UserId, int TaskId)
         {
             if (UserId == 0 || TaskId == 0)
             {
                 return NotFound();
             }
             TaskManager.RemoveAssignedUser(UserId, TaskId);
             return Ok("Remove successfully.");
         }
         // Mark: api/TaskId/1
         [System.Web.Http.Route("api/tasks/MarkTaskComplete/{TaskId}/{userId}")]
         [System.Web.Http.HttpPost]
         public IHttpActionResult MarkTaskComplete(int TaskId, int userId)
         {
             TaskManager. MarkTaskComplete(TaskId,userId);
             return Ok("Mark successfully.");
         }
         // Add: api/TagId/5
         [System.Web.Http.Route("api/tasks/SaveAdminUsers/{CheckedUser}/{userId}")]
         [System.Web.Http.HttpPost]
         public IHttpActionResult SaveAdminUsers(string CheckedUser, int userId)
         {
          TaskManager.SaveAdminUsers(CheckedUser,userId);
          return Ok("SaveAdminUsers successfully.");
         }
         [HttpGet]
         [Route("api/tasks/GetAdminUsers/{userId}")]
         public AdminUser[] GetAdminUsers(int userId)
         {
             return TaskManager.GetAdminUsers(userId);

         }
        
    }
}
