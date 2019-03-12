namespace ShapeEditor
{
    partial class MainForm
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
            this.shapePictureBox = new System.Windows.Forms.PictureBox();
            this.interpretTextArea = new System.Windows.Forms.TextBox();
            this.interpretButton = new System.Windows.Forms.Button();
            this.errorLabel = new System.Windows.Forms.Label();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.saveToFileButton = new System.Windows.Forms.Button();
            this.openFIleButton = new System.Windows.Forms.Button();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.saveFileDialog1 = new System.Windows.Forms.SaveFileDialog();
            ((System.ComponentModel.ISupportInitialize)(this.shapePictureBox)).BeginInit();
            this.tabControl1.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.tabPage2.SuspendLayout();
            this.SuspendLayout();
            // 
            // shapePictureBox
            // 
            this.shapePictureBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.shapePictureBox.Location = new System.Drawing.Point(12, 25);
            this.shapePictureBox.Name = "shapePictureBox";
            this.shapePictureBox.Size = new System.Drawing.Size(562, 460);
            this.shapePictureBox.TabIndex = 0;
            this.shapePictureBox.TabStop = false;
            this.shapePictureBox.Paint += new System.Windows.Forms.PaintEventHandler(this.shapePictureBox_Paint);
            // 
            // interpretTextArea
            // 
            this.interpretTextArea.Font = new System.Drawing.Font("Consolas", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.interpretTextArea.Location = new System.Drawing.Point(0, 0);
            this.interpretTextArea.Multiline = true;
            this.interpretTextArea.Name = "interpretTextArea";
            this.interpretTextArea.Size = new System.Drawing.Size(332, 373);
            this.interpretTextArea.TabIndex = 1;
            this.interpretTextArea.KeyDown += new System.Windows.Forms.KeyEventHandler(this.interpretTextArea_KeyDown);
            // 
            // interpretButton
            // 
            this.interpretButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.interpretButton.Location = new System.Drawing.Point(0, 379);
            this.interpretButton.Name = "interpretButton";
            this.interpretButton.Size = new System.Drawing.Size(332, 46);
            this.interpretButton.TabIndex = 2;
            this.interpretButton.Text = "Apply";
            this.interpretButton.UseVisualStyleBackColor = true;
            this.interpretButton.Click += new System.EventHandler(this.interpretButton_Click);
            // 
            // errorLabel
            // 
            this.errorLabel.BackColor = System.Drawing.SystemColors.ControlLight;
            this.errorLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.errorLabel.ForeColor = System.Drawing.Color.Firebrick;
            this.errorLabel.Location = new System.Drawing.Point(12, 492);
            this.errorLabel.Name = "errorLabel";
            this.errorLabel.Size = new System.Drawing.Size(914, 42);
            this.errorLabel.TabIndex = 3;
            this.errorLabel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tabPage1);
            this.tabControl1.Controls.Add(this.tabPage2);
            this.tabControl1.Location = new System.Drawing.Point(580, 25);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(346, 464);
            this.tabControl1.TabIndex = 4;
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.interpretTextArea);
            this.tabPage1.Controls.Add(this.interpretButton);
            this.tabPage1.Location = new System.Drawing.Point(4, 29);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(338, 431);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Interpret";
            // 
            // tabPage2
            // 
            this.tabPage2.BackColor = System.Drawing.SystemColors.Control;
            this.tabPage2.Controls.Add(this.saveToFileButton);
            this.tabPage2.Controls.Add(this.openFIleButton);
            this.tabPage2.Location = new System.Drawing.Point(4, 29);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage2.Size = new System.Drawing.Size(338, 431);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "Save\\Load";
            // 
            // saveToFileButton
            // 
            this.saveToFileButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.saveToFileButton.Location = new System.Drawing.Point(3, 379);
            this.saveToFileButton.Name = "saveToFileButton";
            this.saveToFileButton.Size = new System.Drawing.Size(332, 46);
            this.saveToFileButton.TabIndex = 4;
            this.saveToFileButton.Text = "Save to file";
            this.saveToFileButton.UseVisualStyleBackColor = true;
            this.saveToFileButton.Click += new System.EventHandler(this.saveToFileButton_Click);
            // 
            // openFIleButton
            // 
            this.openFIleButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.openFIleButton.Location = new System.Drawing.Point(3, 327);
            this.openFIleButton.Name = "openFIleButton";
            this.openFIleButton.Size = new System.Drawing.Size(332, 46);
            this.openFIleButton.TabIndex = 3;
            this.openFIleButton.Text = "Open file";
            this.openFIleButton.UseVisualStyleBackColor = true;
            this.openFIleButton.Click += new System.EventHandler(this.openFileButton_Click);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(938, 543);
            this.Controls.Add(this.tabControl1);
            this.Controls.Add(this.errorLabel);
            this.Controls.Add(this.shapePictureBox);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D;
            this.Name = "MainForm";
            this.Text = "Shape editor";
            this.Load += new System.EventHandler(this.MainForm_Load);
            ((System.ComponentModel.ISupportInitialize)(this.shapePictureBox)).EndInit();
            this.tabControl1.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.tabPage1.PerformLayout();
            this.tabPage2.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.PictureBox shapePictureBox;
        private System.Windows.Forms.TextBox interpretTextArea;
        private System.Windows.Forms.Button interpretButton;
        private System.Windows.Forms.Label errorLabel;
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.TabPage tabPage2;
        private System.Windows.Forms.Button openFIleButton;
        private System.Windows.Forms.OpenFileDialog openFileDialog1;
        private System.Windows.Forms.Button saveToFileButton;
        private System.Windows.Forms.SaveFileDialog saveFileDialog1;
    }
}

