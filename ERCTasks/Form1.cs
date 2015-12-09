using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Domain;

namespace ERCTasks
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btnAddTask_Click(object sender, EventArgs e)
        {
            var addTask = new AddTask();
            addTask.ShowDialog();
            refreshTaskList();
        }
        private void refreshTaskList()
        {
            lbTaskList.Items.Clear();
            lbTaskList.Items.AddRange(TaskManager.GetTasks(DateTime.Now, 1));
        }
        private void btnRefresh_Click(object sender, EventArgs e)
        {
            refreshTaskList();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            refreshTaskList();
        }

        private void lbTaskList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (lbTaskList.SelectedIndex < 0) return;
            var selected = (Domain.TaskInfo)lbTaskList.Items[lbTaskList.SelectedIndex];
            if (selected == null) return;
            lbTaskName.Text = selected.task.TaskName;
            lbTaskDesc.Text = selected.task.TaskDesc;
            if ( selected.task.RecurrencePattern != null )
            {
                lbTaskInfo.Text = String.Format("Task set to recur every {0} business day {1} at {2}:{3}", selected.task.RecurrenceBusinessDayStep, selected.task.RecurrencePattern, selected.task.TaskDueHour, selected.task.TaskDueMinutes);
            }else
            {
                lbTaskInfo.Text = String.Format("Task set to take place {0}", selected.task.TaskDueDate);
            }
        }
    }
}
