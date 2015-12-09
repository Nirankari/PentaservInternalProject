using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain
{
  public  class Description
    {
        /// <summary>
        /// primary key
        /// </summary>
        public int id;

        /// <summary>
        /// task description
        /// </summary>
       
        public int TaskId;

        
        public int AdminId;

        public string TaskDesc;
        public string DisplayName;

        public DateTime CreatedDate;
    }
}
