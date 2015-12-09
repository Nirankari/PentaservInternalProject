namespace ERCTasks
{
    partial class AddTask
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.txtTaskName = new System.Windows.Forms.TextBox();
            this.txtTaskDesc = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.grpRecur = new System.Windows.Forms.GroupBox();
            this.rdOneTime = new System.Windows.Forms.RadioButton();
            this.rdReccurring = new System.Windows.Forms.RadioButton();
            this.dtOneTimeDate = new System.Windows.Forms.DateTimePicker();
            this.lbPattern = new System.Windows.Forms.ComboBox();
            this.cbBusinessDay = new System.Windows.Forms.ComboBox();
            this.label3 = new System.Windows.Forms.Label();
            this.cbHours = new System.Windows.Forms.ComboBox();
            this.cbMinutes = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.btnAddTask = new System.Windows.Forms.Button();
            this.lbEmailList = new System.Windows.Forms.ListBox();
            this.label6 = new System.Windows.Forms.Label();
            this.txtEmail = new System.Windows.Forms.TextBox();
            this.btnAddEmail = new System.Windows.Forms.Button();
            this.grpRecur.SuspendLayout();
            this.SuspendLayout();
            // 
            // txtTaskName
            // 
            this.txtTaskName.Location = new System.Drawing.Point(15, 25);
            this.txtTaskName.Name = "txtTaskName";
            this.txtTaskName.Size = new System.Drawing.Size(330, 20);
            this.txtTaskName.TabIndex = 0;
            // 
            // txtTaskDesc
            // 
            this.txtTaskDesc.Location = new System.Drawing.Point(15, 67);
            this.txtTaskDesc.Multiline = true;
            this.txtTaskDesc.Name = "txtTaskDesc";
            this.txtTaskDesc.Size = new System.Drawing.Size(330, 110);
            this.txtTaskDesc.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(62, 13);
            this.label1.TabIndex = 2;
            this.label1.Text = "Task Name";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 51);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(87, 13);
            this.label2.TabIndex = 3;
            this.label2.Text = "Task Description";
            // 
            // grpRecur
            // 
            this.grpRecur.Controls.Add(this.rdOneTime);
            this.grpRecur.Controls.Add(this.rdReccurring);
            this.grpRecur.Location = new System.Drawing.Point(15, 194);
            this.grpRecur.Name = "grpRecur";
            this.grpRecur.Size = new System.Drawing.Size(84, 249);
            this.grpRecur.TabIndex = 5;
            this.grpRecur.TabStop = false;
            this.grpRecur.Text = "Recurrence Options";
            // 
            // rdOneTime
            // 
            this.rdOneTime.AutoSize = true;
            this.rdOneTime.Location = new System.Drawing.Point(6, 213);
            this.rdOneTime.Name = "rdOneTime";
            this.rdOneTime.Size = new System.Drawing.Size(71, 17);
            this.rdOneTime.TabIndex = 1;
            this.rdOneTime.TabStop = true;
            this.rdOneTime.Text = "One Time";
            this.rdOneTime.UseVisualStyleBackColor = true;
            // 
            // rdReccurring
            // 
            this.rdReccurring.AutoSize = true;
            this.rdReccurring.Location = new System.Drawing.Point(6, 28);
            this.rdReccurring.Name = "rdReccurring";
            this.rdReccurring.Size = new System.Drawing.Size(71, 17);
            this.rdReccurring.TabIndex = 0;
            this.rdReccurring.TabStop = true;
            this.rdReccurring.Text = "Recurring";
            this.rdReccurring.UseVisualStyleBackColor = true;
            // 
            // dtOneTimeDate
            // 
            this.dtOneTimeDate.Location = new System.Drawing.Point(105, 407);
            this.dtOneTimeDate.Name = "dtOneTimeDate";
            this.dtOneTimeDate.Size = new System.Drawing.Size(184, 20);
            this.dtOneTimeDate.TabIndex = 2;
            // 
            // lbPattern
            // 
            this.lbPattern.FormattingEnabled = true;
            this.lbPattern.Location = new System.Drawing.Point(105, 214);
            this.lbPattern.Name = "lbPattern";
            this.lbPattern.Size = new System.Drawing.Size(159, 21);
            this.lbPattern.TabIndex = 6;
            this.lbPattern.SelectedIndexChanged += new System.EventHandler(this.lbPattern_SelectedIndexChanged);
            // 
            // cbBusinessDay
            // 
            this.cbBusinessDay.FormattingEnabled = true;
            this.cbBusinessDay.Location = new System.Drawing.Point(105, 253);
            this.cbBusinessDay.Name = "cbBusinessDay";
            this.cbBusinessDay.Size = new System.Drawing.Size(126, 21);
            this.cbBusinessDay.TabIndex = 7;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(237, 257);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(91, 17);
            this.label3.TabIndex = 8;
            this.label3.Text = "business day";
            // 
            // cbHours
            // 
            this.cbHours.FormattingEnabled = true;
            this.cbHours.Location = new System.Drawing.Point(105, 300);
            this.cbHours.Name = "cbHours";
            this.cbHours.Size = new System.Drawing.Size(55, 21);
            this.cbHours.TabIndex = 9;
            // 
            // cbMinutes
            // 
            this.cbMinutes.FormattingEnabled = true;
            this.cbMinutes.Location = new System.Drawing.Point(105, 350);
            this.cbMinutes.Name = "cbMinutes";
            this.cbMinutes.Size = new System.Drawing.Size(55, 21);
            this.cbMinutes.TabIndex = 10;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(105, 284);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(53, 13);
            this.label4.TabIndex = 11;
            this.label4.Text = "Hour Due";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(105, 334);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(67, 13);
            this.label5.TabIndex = 12;
            this.label5.Text = "Minutes Due";
            // 
            // btnAddTask
            // 
            this.btnAddTask.Location = new System.Drawing.Point(270, 541);
            this.btnAddTask.Name = "btnAddTask";
            this.btnAddTask.Size = new System.Drawing.Size(94, 31);
            this.btnAddTask.TabIndex = 13;
            this.btnAddTask.Text = "Add Task";
            this.btnAddTask.UseVisualStyleBackColor = true;
            this.btnAddTask.Click += new System.EventHandler(this.btnAddTask_Click);
            // 
            // lbEmailList
            // 
            this.lbEmailList.FormattingEnabled = true;
            this.lbEmailList.Location = new System.Drawing.Point(15, 477);
            this.lbEmailList.Name = "lbEmailList";
            this.lbEmailList.Size = new System.Drawing.Size(120, 95);
            this.lbEmailList.TabIndex = 14;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(12, 461);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(33, 13);
            this.label6.TabIndex = 15;
            this.label6.Text = "Alerts";
            // 
            // txtEmail
            // 
            this.txtEmail.Location = new System.Drawing.Point(141, 477);
            this.txtEmail.Name = "txtEmail";
            this.txtEmail.Size = new System.Drawing.Size(100, 20);
            this.txtEmail.TabIndex = 16;
            // 
            // btnAddEmail
            // 
            this.btnAddEmail.Location = new System.Drawing.Point(141, 503);
            this.btnAddEmail.Name = "btnAddEmail";
            this.btnAddEmail.Size = new System.Drawing.Size(100, 23);
            this.btnAddEmail.TabIndex = 17;
            this.btnAddEmail.Text = "Add Email";
            this.btnAddEmail.UseVisualStyleBackColor = true;
            this.btnAddEmail.Click += new System.EventHandler(this.btnAddEmail_Click);
            // 
            // AddTask
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(376, 584);
            this.Controls.Add(this.btnAddEmail);
            this.Controls.Add(this.txtEmail);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.lbEmailList);
            this.Controls.Add(this.btnAddTask);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.cbMinutes);
            this.Controls.Add(this.cbHours);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.cbBusinessDay);
            this.Controls.Add(this.lbPattern);
            this.Controls.Add(this.dtOneTimeDate);
            this.Controls.Add(this.grpRecur);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtTaskDesc);
            this.Controls.Add(this.txtTaskName);
            this.Name = "AddTask";
            this.Text = "AddTask";
            this.Load += new System.EventHandler(this.AddTask_Load);
            this.grpRecur.ResumeLayout(false);
            this.grpRecur.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox txtTaskName;
        private System.Windows.Forms.TextBox txtTaskDesc;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.GroupBox grpRecur;
        private System.Windows.Forms.RadioButton rdOneTime;
        private System.Windows.Forms.RadioButton rdReccurring;
        private System.Windows.Forms.DateTimePicker dtOneTimeDate;
        private System.Windows.Forms.ComboBox lbPattern;
        private System.Windows.Forms.ComboBox cbBusinessDay;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.ComboBox cbHours;
        private System.Windows.Forms.ComboBox cbMinutes;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Button btnAddTask;
        private System.Windows.Forms.ListBox lbEmailList;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox txtEmail;
        private System.Windows.Forms.Button btnAddEmail;
    }
}