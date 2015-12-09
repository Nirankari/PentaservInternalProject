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
using System.Data.SqlClient;
using Dapper;
using System.Configuration;

namespace ERCTasks
{
    public partial class AddTask : Form
    {
        private static readonly string ConnectionString = ConfigurationManager.AppSettings.Get("Connection");
        public AddTask()
        {
            InitializeComponent();
        }

        private void AddTask_Load(object sender, EventArgs e)
        {
            dtOneTimeDate.Format = DateTimePickerFormat.Custom;
            dtOneTimeDate.CustomFormat = "yyyy-MM-dd  HH:mm ";
            lbPattern.Items.AddRange(new string[] { "Daily", "Weekly", "Monthly"});
            lbPattern.SelectedIndex = 0;
            resetBusinessDays();
            cbHours.Items.AddRange(Enumerable.Range(0, 24).ToArray().Cast<object>().ToArray<object>());
            cbMinutes.Items.AddRange(Enumerable.Range(0, 60).ToArray().Cast<object>().ToArray<object>());
            cbHours.SelectedIndex = 0;
            cbMinutes.SelectedIndex = 0;
            rdReccurring.Checked = true;
        }

        /// <summary>
        /// encodes the recurrence into an integer index with range of [-n, n] which is the nth business day from the start or end of the chosen interval
        /// constraints: index != 0
        /// </summary>
        /// <param name="labels"></param>
        /// <param name="selected"></param>
        /// <returns></returns>
        private int calculateIndex(string[] labels, int selected)
        {
            if ( selected < 6 )
            {
                // index is never zero!
                return selected + 1;
            }else
            {
                return selected - labels.Length;
            }
        }
        private static readonly string[] labelsWeek = new string[] { "Every first", "Every second", "Every third",
                                        "Every fourth", "Every fifth", "Every sixth",
                                        "Sixth from EOW", "Fifth from EOW", "Fourth from EOW", "Third from EOW",
                                        "Second from EOW", "First from EOW"};
        private static readonly string[] labelsMonth = new string[] { "Every first", "Every second", "Every third",
                                        "Every fourth", "Every fifth", "Every sixth",
                                        "Sixth from EOM", "Fifth from EOM", "Fourth from EOM", "Third from EOM",
                                        "Second from EOM", "First from EOM"};
        private void resetBusinessDays()
        {
            cbBusinessDay.Items.Clear();
            var pattern = lbPattern.SelectedItem.ToString().ToLower();
            switch (pattern)
            {
                case "daily":
                {
                        cbBusinessDay.Items.Add("every");
                    break;
                }
                case "weekly":
                {
                        cbBusinessDay.Items.AddRange(labelsWeek);
                        break;
                }
                case "monthly":
                {
                        cbBusinessDay.Items.AddRange(labelsMonth);
                        break;
                }

            }
            cbBusinessDay.SelectedIndex = 0;
        }
        private void lbPattern_SelectedIndexChanged(object sender, EventArgs e)
        {
            resetBusinessDays();   
        }
        
        private void btnAddTask_Click(object sender, EventArgs e)
        {
            Domain.Task _task = null;
            if ( txtTaskName.Text.Trim().Length <= 10 || txtTaskDesc.Text.Trim().Length <= 10 )
            {
                MessageBox.Show("Your inputs need to be more descriptive.");
                return;
            }
            _task = new Domain.Task()
            {
                TaskName = txtTaskName.Text.Trim(),
                TaskDesc = txtTaskDesc.Text.Trim(),
                TaskDueHour = (int)cbHours.SelectedItem,
                TaskDueMinutes = (int)cbMinutes.SelectedItem,
                TaskDueDate = dtOneTimeDate.Value,
                RecurrenceBusinessDayStep = calculateIndex(labelsWeek, cbBusinessDay.SelectedIndex),
                RecurrencePattern = lbPattern.SelectedItem.ToString()
            };
            if ( rdReccurring.Checked )
                _task.TaskDueDate = null;
            var taskId = TaskManager.AddTask(_task);
            // add emails to alerter list
            foreach (var email in lbEmailList.Items)
            {
                using(var db = new SqlConnection(ConnectionString))
                {
                    db.Open();
                    var q = @"INSERT INTO [Collect2000].[ERCTasks].[TasksAlerterEmail] (TaskId, Email) VALUES (@taskId, @Email)";
                    db.Query(q, new { taskId = taskId, Email = email });
                }
            }
            MessageBox.Show("Task successfully added");
            this.Close();
        }

        private void btnAddEmail_Click(object sender, EventArgs e)
        {
            lbEmailList.Items.Add(txtEmail.Text);
        }
    }
}
