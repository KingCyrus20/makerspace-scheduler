namespace MakerspaceSchedulerProject
{
    partial class EmployeeEditor
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
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.SundayColumn = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.MondayColumn = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.TuesdayColumn = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.WednesdayColumn = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.ThursdayColumn = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.FridayColumn = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.SaturdayColumn = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToAddRows = false;
            this.dataGridView1.AllowUserToDeleteRows = false;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.SundayColumn,
            this.MondayColumn,
            this.TuesdayColumn,
            this.WednesdayColumn,
            this.ThursdayColumn,
            this.FridayColumn,
            this.SaturdayColumn});
            this.dataGridView1.Location = new System.Drawing.Point(12, 12);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowTemplate.Height = 28;
            this.dataGridView1.Size = new System.Drawing.Size(745, 458);
            this.dataGridView1.TabIndex = 0;
            // 
            // SundayColumn
            // 
            this.SundayColumn.HeaderText = "Sunday";
            this.SundayColumn.Name = "SundayColumn";
            // 
            // MondayColumn
            // 
            this.MondayColumn.HeaderText = "Monday";
            this.MondayColumn.Name = "MondayColumn";
            // 
            // TuesdayColumn
            // 
            this.TuesdayColumn.HeaderText = "Tuesday";
            this.TuesdayColumn.Name = "TuesdayColumn";
            // 
            // WednesdayColumn
            // 
            this.WednesdayColumn.HeaderText = "Wednesday";
            this.WednesdayColumn.Name = "WednesdayColumn";
            // 
            // ThursdayColumn
            // 
            this.ThursdayColumn.HeaderText = "Thursday";
            this.ThursdayColumn.Name = "ThursdayColumn";
            // 
            // FridayColumn
            // 
            this.FridayColumn.HeaderText = "Friday";
            this.FridayColumn.Name = "FridayColumn";
            // 
            // SaturdayColumn
            // 
            this.SaturdayColumn.HeaderText = "Saturday";
            this.SaturdayColumn.Name = "SaturdayColumn";
            // 
            // EmployeeEditor
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1060, 611);
            this.Controls.Add(this.dataGridView1);
            this.Name = "EmployeeEditor";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.DataGridViewCheckBoxColumn SundayColumn;
        private System.Windows.Forms.DataGridViewCheckBoxColumn MondayColumn;
        private System.Windows.Forms.DataGridViewCheckBoxColumn TuesdayColumn;
        private System.Windows.Forms.DataGridViewCheckBoxColumn WednesdayColumn;
        private System.Windows.Forms.DataGridViewCheckBoxColumn ThursdayColumn;
        private System.Windows.Forms.DataGridViewCheckBoxColumn FridayColumn;
        private System.Windows.Forms.DataGridViewCheckBoxColumn SaturdayColumn;
    }
}