using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain
{
    public class SLALog
    {
        public int Id { get; set; }
        public int TaskId { get; set; }
        public bool SLAMet { get; set; }
        public int SubmittedByUserId { get; set; }
        public DateTime SubmittedTime { get; set; }
        public DateTime Created { get; set; }
    }
}
