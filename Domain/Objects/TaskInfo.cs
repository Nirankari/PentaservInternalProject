using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain
{
    public class TaskInfo
    {
        public Task task;
        public Tag[] tags;
        public User[] AssignedTo;

        public override string ToString()
        {
            return task.TaskName;
        }
    }
}
