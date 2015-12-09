namespace ERCTasks
{
    partial class Form1
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
            this.lbTaskList = new System.Windows.Forms.ListBox();
            this.btnRefresh = new System.Windows.Forms.Button();
            this.btnAddTask = new System.Windows.Forms.Button();
            this.btnDelete = new System.Windows.Forms.Button();
            this.lbTaskName = new System.Windows.Forms.Label();
            this.lbTaskDesc = new System.Windows.Forms.Label();
            this.lbTaskInfo = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // lbTaskList
            // 
            this.lbTaskList.FormattingEnabled = true;
            this.lbTaskList.Location = new System.Drawing.Point(12, 12);
            this.lbTaskList.Name = "lbTaskList";
            this.lbTaskList.Size = new System.Drawing.Size(120, 355);
            this.lbTaskList.TabIndex = 0;
            this.lbTaskList.SelectedIndexChanged += new System.EventHandler(this.lbTaskList_SelectedIndexChanged);
            // 
            // btnRefresh
            // 
            this.btnRefresh.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left)));
            this.btnRefresh.ForeColor = System.Drawing.SystemColors.WindowText;
            this.btnRefresh.Location = new System.Drawing.Point(12, 404);
            this.btnRefresh.Name = "btnRefresh";
            this.btnRefresh.Size = new System.Drawing.Size(120, 29);
            this.btnRefresh.TabIndex = 1;
            this.btnRefresh.Text = "Refresh";
            this.btnRefresh.UseVisualStyleBackColor = true;
            this.btnRefresh.Click += new System.EventHandler(this.btnRefresh_Click);
            // 
            // btnAddTask
            // 
            this.btnAddTask.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left)));
            this.btnAddTask.ForeColor = System.Drawing.SystemColors.WindowText;
            this.btnAddTask.Location = new System.Drawing.Point(12, 373);
            this.btnAddTask.Name = "btnAddTask";
            this.btnAddTask.Size = new System.Drawing.Size(52, 26);
            this.btnAddTask.TabIndex = 2;
            this.btnAddTask.Text = "Add";
            this.btnAddTask.UseVisualStyleBackColor = true;
            this.btnAddTask.Click += new System.EventHandler(this.btnAddTask_Click);
            // 
            // btnDelete
            // 
            this.btnDelete.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left)));
            this.btnDelete.ForeColor = System.Drawing.SystemColors.WindowText;
            this.btnDelete.Location = new System.Drawing.Point(80, 373);
            this.btnDelete.Name = "btnDelete";
            this.btnDelete.Size = new System.Drawing.Size(52, 26);
            this.btnDelete.TabIndex = 3;
            this.btnDelete.Text = "Delete";
            this.btnDelete.UseVisualStyleBackColor = true;
            // 
            // lbTaskName
            // 
            this.lbTaskName.AutoSize = true;
            this.lbTaskName.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbTaskName.Location = new System.Drawing.Point(155, 25);
            this.lbTaskName.Name = "lbTaskName";
            this.lbTaskName.Size = new System.Drawing.Size(0, 22);
            this.lbTaskName.TabIndex = 4;
            // 
            // lbTaskDesc
            // 
            this.lbTaskDesc.AutoSize = true;
            this.lbTaskDesc.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbTaskDesc.Location = new System.Drawing.Point(156, 71);
            this.lbTaskDesc.Name = "lbTaskDesc";
            this.lbTaskDesc.Size = new System.Drawing.Size(0, 18);
            this.lbTaskDesc.TabIndex = 5;
            // 
            // lbTaskInfo
            // 
            this.lbTaskInfo.AutoSize = true;
            this.lbTaskInfo.Location = new System.Drawing.Point(159, 199);
            this.lbTaskInfo.Name = "lbTaskInfo";
            this.lbTaskInfo.Size = new System.Drawing.Size(0, 13);
            this.lbTaskInfo.TabIndex = 6;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(797, 443);
            this.Controls.Add(this.lbTaskInfo);
            this.Controls.Add(this.lbTaskDesc);
            this.Controls.Add(this.lbTaskName);
            this.Controls.Add(this.btnDelete);
            this.Controls.Add(this.btnAddTask);
            this.Controls.Add(this.btnRefresh);
            this.Controls.Add(this.lbTaskList);
            this.ForeColor = System.Drawing.SystemColors.WindowText;
            this.Name = "Form1";
            this.Text = "ERC Tasks";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ListBox lbTaskList;
        private System.Windows.Forms.Button btnRefresh;
        private System.Windows.Forms.Button btnAddTask;
        private System.Windows.Forms.Button btnDelete;
        private System.Windows.Forms.Label lbTaskName;
        private System.Windows.Forms.Label lbTaskDesc;
        private System.Windows.Forms.Label lbTaskInfo;
    }
}

