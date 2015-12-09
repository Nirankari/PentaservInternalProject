using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TasksDriver
{
    class Program
    {
        static void Main(string[] args)
        {
            var start_date = DateTime.Today.AddDays(-DateTime.Today.Day+1);
            var culture = new System.Globalization.CultureInfo("en-US");
            for(var day = 0; day < DateTime.DaysInMonth(DateTime.Today.Year, DateTime.Today.Month); day++)
            {
                var date = start_date.AddDays(day);
                Console.WriteLine("{0} {1}", culture.DateTimeFormat.GetDayName(date.DayOfWeek), date);
                var tasks = Domain.TaskManager.GetTasks(date, 1);
                Console.WriteLine("\t{0} tasks for today\n", tasks.Length);
                foreach (var task in tasks)
                    Console.WriteLine("\t {0}", task.TaskName);
                Console.WriteLine();
            }
            Console.Read();
        }
    }
}
