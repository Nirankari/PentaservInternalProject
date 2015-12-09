using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain
{
    public class Task
    {
        /// <summary>
        /// primary key
        /// </summary>
        public int TaskId;

        /// <summary>
        /// task description
        /// </summary>
        public string TaskDesc;

        /// <summary>
        /// optional due date. 
        /// when this is set, recurrences are not evaluated past the set value
        /// </summary>
        public DateTime? TaskDueDate; 

        /// <summary>
        /// SLA time deadline 
        /// 24 hour format
        /// </summary>
        public int TaskDueHour, TaskDueMinutes;

        /// <summary>
        /// Recurrence settings
        /// we only consider business days
        /// </summary>
        public string RecurrencePattern; // daily, weekly, monthly

        /// <summary>
        /// If positive, RecurrenceBusinessDayStep is n days past the start of the interval
        /// otherwise, it is -n days past the last business day of the chosen interval
        /// </summary>
        public int RecurrenceBusinessDayStep; // recur every BusinessDayStep days

        /// <summary>
        /// Task Name
        /// </summary>
        public string TaskName;

        /// <summary>
        /// Mark as complete
        /// </summary>
        public int isComplete;

        /// <summary>
        /// new field added customer
        /// </summary>
        public string Customer;
        /// <summary>
        /// new field added AdminId
        /// </summary>
        public int AdminId;
        public List<Description> Description  { get; set; }
        public string AssignedUserName;
        public DateTime? CreatedDate; 
      
    }
}
