namespace BLE_UI
{
    partial class BLE_UI
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

        System.Windows.Threading.Dispatcher dispatcher;

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.SendBx3 = new System.Windows.Forms.TextBox();
            this.SendBtn3 = new System.Windows.Forms.Button();
            this.SendBx2 = new System.Windows.Forms.TextBox();
            this.SendBtn2 = new System.Windows.Forms.Button();
            this.SendBx1 = new System.Windows.Forms.TextBox();
            this.SendBtn1 = new System.Windows.Forms.Button();
            this.HEX3 = new System.Windows.Forms.CheckBox();
            this.HEX1 = new System.Windows.Forms.CheckBox();
            this.HEX2 = new System.Windows.Forms.CheckBox();
            this.DeviceList = new System.Windows.Forms.ListBox();
            this.ConnectBtn = new System.Windows.Forms.Button();
            this.SearchBtn = new System.Windows.Forms.Button();
            this.CharList = new System.Windows.Forms.ListBox();
            this.ServiceList = new System.Windows.Forms.ListBox();
            this.CharLbl = new System.Windows.Forms.Label();
            this.SerLbl = new System.Windows.Forms.Label();
            this.ReadBtn = new System.Windows.Forms.Button();
            this.SubBtn = new System.Windows.Forms.Button();
            this.CuboidBtn = new System.Windows.Forms.Button();
            this.SaveBtn = new System.Windows.Forms.Button();
            this.screenEnableCB = new System.Windows.Forms.CheckBox();
            this.DataList = new System.Windows.Forms.RichTextBox();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.versionLabel = new System.Windows.Forms.Label();
            this.ClearBtn = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // SendBx3
            // 
            this.SendBx3.Location = new System.Drawing.Point(80, 662);
            this.SendBx3.Margin = new System.Windows.Forms.Padding(4);
            this.SendBx3.Name = "SendBx3";
            this.SendBx3.Size = new System.Drawing.Size(926, 22);
            this.SendBx3.TabIndex = 14;
            // 
            // SendBtn3
            // 
            this.SendBtn3.Enabled = false;
            this.SendBtn3.Location = new System.Drawing.Point(1028, 647);
            this.SendBtn3.Margin = new System.Windows.Forms.Padding(4);
            this.SendBtn3.Name = "SendBtn3";
            this.SendBtn3.Size = new System.Drawing.Size(92, 52);
            this.SendBtn3.TabIndex = 13;
            this.SendBtn3.Text = "Send";
            this.SendBtn3.UseVisualStyleBackColor = true;
            this.SendBtn3.Click += new System.EventHandler(this.SendBtn3_Click);
            // 
            // SendBx2
            // 
            this.SendBx2.Location = new System.Drawing.Point(80, 585);
            this.SendBx2.Margin = new System.Windows.Forms.Padding(4);
            this.SendBx2.Name = "SendBx2";
            this.SendBx2.Size = new System.Drawing.Size(926, 22);
            this.SendBx2.TabIndex = 12;
            // 
            // SendBtn2
            // 
            this.SendBtn2.Enabled = false;
            this.SendBtn2.Location = new System.Drawing.Point(1028, 570);
            this.SendBtn2.Margin = new System.Windows.Forms.Padding(4);
            this.SendBtn2.Name = "SendBtn2";
            this.SendBtn2.Size = new System.Drawing.Size(92, 52);
            this.SendBtn2.TabIndex = 11;
            this.SendBtn2.Text = "Send";
            this.SendBtn2.UseVisualStyleBackColor = true;
            this.SendBtn2.Click += new System.EventHandler(this.SendBtn2_Click);
            // 
            // SendBx1
            // 
            this.SendBx1.Location = new System.Drawing.Point(80, 508);
            this.SendBx1.Margin = new System.Windows.Forms.Padding(4);
            this.SendBx1.Name = "SendBx1";
            this.SendBx1.Size = new System.Drawing.Size(926, 22);
            this.SendBx1.TabIndex = 9;
            // 
            // SendBtn1
            // 
            this.SendBtn1.Enabled = false;
            this.SendBtn1.Location = new System.Drawing.Point(1028, 494);
            this.SendBtn1.Margin = new System.Windows.Forms.Padding(4);
            this.SendBtn1.Name = "SendBtn1";
            this.SendBtn1.Size = new System.Drawing.Size(92, 52);
            this.SendBtn1.TabIndex = 8;
            this.SendBtn1.Text = "Send";
            this.SendBtn1.UseVisualStyleBackColor = true;
            this.SendBtn1.Click += new System.EventHandler(this.SendBtn1_Click);
            // 
            // HEX3
            // 
            this.HEX3.AutoSize = true;
            this.HEX3.Location = new System.Drawing.Point(16, 665);
            this.HEX3.Margin = new System.Windows.Forms.Padding(4);
            this.HEX3.Name = "HEX3";
            this.HEX3.Size = new System.Drawing.Size(58, 21);
            this.HEX3.TabIndex = 15;
            this.HEX3.Text = "HEX";
            this.HEX3.UseVisualStyleBackColor = true;
            // 
            // HEX1
            // 
            this.HEX1.AutoSize = true;
            this.HEX1.Location = new System.Drawing.Point(16, 510);
            this.HEX1.Margin = new System.Windows.Forms.Padding(4);
            this.HEX1.Name = "HEX1";
            this.HEX1.Size = new System.Drawing.Size(58, 21);
            this.HEX1.TabIndex = 18;
            this.HEX1.Text = "HEX";
            this.HEX1.UseVisualStyleBackColor = true;
            // 
            // HEX2
            // 
            this.HEX2.AutoSize = true;
            this.HEX2.Location = new System.Drawing.Point(16, 587);
            this.HEX2.Margin = new System.Windows.Forms.Padding(4);
            this.HEX2.Name = "HEX2";
            this.HEX2.Size = new System.Drawing.Size(58, 21);
            this.HEX2.TabIndex = 19;
            this.HEX2.Text = "HEX";
            this.HEX2.UseVisualStyleBackColor = true;
            // 
            // DeviceList
            // 
            this.DeviceList.FormattingEnabled = true;
            this.DeviceList.ItemHeight = 16;
            this.DeviceList.Location = new System.Drawing.Point(1131, 97);
            this.DeviceList.Margin = new System.Windows.Forms.Padding(4);
            this.DeviceList.Name = "DeviceList";
            this.DeviceList.Size = new System.Drawing.Size(277, 388);
            this.DeviceList.TabIndex = 21;
            this.DeviceList.SelectedIndexChanged += new System.EventHandler(this.DeviceList_SelectedIndexChanged);
            // 
            // ConnectBtn
            // 
            this.ConnectBtn.Enabled = false;
            this.ConnectBtn.Location = new System.Drawing.Point(1131, 14);
            this.ConnectBtn.Margin = new System.Windows.Forms.Padding(4);
            this.ConnectBtn.Name = "ConnectBtn";
            this.ConnectBtn.Size = new System.Drawing.Size(131, 52);
            this.ConnectBtn.TabIndex = 22;
            this.ConnectBtn.Text = "Connect";
            this.ConnectBtn.UseVisualStyleBackColor = true;
            this.ConnectBtn.Click += new System.EventHandler(this.ConnectBtn_Click);
            // 
            // SearchBtn
            // 
            this.SearchBtn.Location = new System.Drawing.Point(1276, 14);
            this.SearchBtn.Margin = new System.Windows.Forms.Padding(4);
            this.SearchBtn.Name = "SearchBtn";
            this.SearchBtn.Size = new System.Drawing.Size(131, 52);
            this.SearchBtn.TabIndex = 23;
            this.SearchBtn.Text = "Search";
            this.SearchBtn.UseVisualStyleBackColor = true;
            this.SearchBtn.Click += new System.EventHandler(this.SearchBtn_Click);
            // 
            // CharList
            // 
            this.CharList.FormattingEnabled = true;
            this.CharList.ItemHeight = 16;
            this.CharList.Location = new System.Drawing.Point(1131, 626);
            this.CharList.Margin = new System.Windows.Forms.Padding(4);
            this.CharList.Name = "CharList";
            this.CharList.Size = new System.Drawing.Size(277, 84);
            this.CharList.TabIndex = 24;
            this.CharList.SelectedIndexChanged += new System.EventHandler(this.CharList_SelectedIndexChanged);
            // 
            // ServiceList
            // 
            this.ServiceList.FormattingEnabled = true;
            this.ServiceList.ItemHeight = 16;
            this.ServiceList.Location = new System.Drawing.Point(1131, 508);
            this.ServiceList.Margin = new System.Windows.Forms.Padding(4);
            this.ServiceList.Name = "ServiceList";
            this.ServiceList.Size = new System.Drawing.Size(277, 84);
            this.ServiceList.TabIndex = 25;
            this.ServiceList.SelectedIndexChanged += new System.EventHandler(this.ServiceList_SelectedIndexChanged_1);
            // 
            // CharLbl
            // 
            this.CharLbl.AutoSize = true;
            this.CharLbl.Location = new System.Drawing.Point(1127, 606);
            this.CharLbl.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.CharLbl.Name = "CharLbl";
            this.CharLbl.Size = new System.Drawing.Size(120, 17);
            this.CharLbl.TabIndex = 27;
            this.CharLbl.Text = "Characteristic List";
            // 
            // SerLbl
            // 
            this.SerLbl.AutoSize = true;
            this.SerLbl.Location = new System.Drawing.Point(1131, 489);
            this.SerLbl.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.SerLbl.Name = "SerLbl";
            this.SerLbl.Size = new System.Drawing.Size(81, 17);
            this.SerLbl.TabIndex = 28;
            this.SerLbl.Text = "Service List";
            // 
            // ReadBtn
            // 
            this.ReadBtn.Enabled = false;
            this.ReadBtn.Location = new System.Drawing.Point(382, 712);
            this.ReadBtn.Margin = new System.Windows.Forms.Padding(4);
            this.ReadBtn.Name = "ReadBtn";
            this.ReadBtn.Size = new System.Drawing.Size(131, 52);
            this.ReadBtn.TabIndex = 29;
            this.ReadBtn.Text = "Read";
            this.ReadBtn.UseVisualStyleBackColor = true;
            this.ReadBtn.Click += new System.EventHandler(this.btnRead_Click);
            // 
            // SubBtn
            // 
            this.SubBtn.Enabled = false;
            this.SubBtn.Location = new System.Drawing.Point(668, 712);
            this.SubBtn.Margin = new System.Windows.Forms.Padding(4);
            this.SubBtn.Name = "SubBtn";
            this.SubBtn.Size = new System.Drawing.Size(131, 52);
            this.SubBtn.TabIndex = 30;
            this.SubBtn.Text = "Subscribe";
            this.SubBtn.UseVisualStyleBackColor = true;
            this.SubBtn.Click += new System.EventHandler(this.SubBtn_Click);
            // 
            // CuboidBtn
            // 
            this.CuboidBtn.Enabled = false;
            this.CuboidBtn.Location = new System.Drawing.Point(80, 712);
            this.CuboidBtn.Margin = new System.Windows.Forms.Padding(4);
            this.CuboidBtn.Name = "CuboidBtn";
            this.CuboidBtn.Size = new System.Drawing.Size(131, 52);
            this.CuboidBtn.TabIndex = 31;
            this.CuboidBtn.Text = "3D";
            this.CuboidBtn.UseVisualStyleBackColor = true;
            this.CuboidBtn.Click += new System.EventHandler(this.CuboidBtn_Click);
            // 
            // SaveBtn
            // 
            this.SaveBtn.Location = new System.Drawing.Point(1134, 718);
            this.SaveBtn.Margin = new System.Windows.Forms.Padding(4);
            this.SaveBtn.Name = "SaveBtn";
            this.SaveBtn.Size = new System.Drawing.Size(128, 52);
            this.SaveBtn.TabIndex = 32;
            this.SaveBtn.Text = "File Location";
            this.SaveBtn.UseVisualStyleBackColor = true;
            this.SaveBtn.Click += new System.EventHandler(this.SaveBtn_Click);
            // 
            // screenEnableCB
            // 
            this.screenEnableCB.AutoSize = true;
            this.screenEnableCB.Checked = true;
            this.screenEnableCB.CheckState = System.Windows.Forms.CheckState.Checked;
            this.screenEnableCB.Location = new System.Drawing.Point(857, 712);
            this.screenEnableCB.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.screenEnableCB.Name = "screenEnableCB";
            this.screenEnableCB.Size = new System.Drawing.Size(131, 21);
            this.screenEnableCB.TabIndex = 33;
            this.screenEnableCB.Text = "Screen Enabled";
            this.screenEnableCB.UseVisualStyleBackColor = true;
            this.screenEnableCB.CheckedChanged += new System.EventHandler(this.screenEnableCB_CheckedChanged);
            // 
            // DataList
            // 
            this.DataList.Font = new System.Drawing.Font("Microsoft Sans Serif", 7F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.DataList.Location = new System.Drawing.Point(16, 14);
            this.DataList.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.DataList.Name = "DataList";
            this.DataList.Size = new System.Drawing.Size(1109, 470);
            this.DataList.TabIndex = 34;
            this.DataList.Text = "";
            // 
            // openFileDialog1
            // 
            this.openFileDialog1.FileName = "openFileDialog1";
            // 
            // versionLabel
            // 
            this.versionLabel.AutoSize = true;
            this.versionLabel.Location = new System.Drawing.Point(1131, 74);
            this.versionLabel.Name = "versionLabel";
            this.versionLabel.Size = new System.Drawing.Size(56, 17);
            this.versionLabel.TabIndex = 36;
            this.versionLabel.Text = "Version";
            // 
            // ClearBtn
            // 
            this.ClearBtn.Enabled = false;
            this.ClearBtn.Location = new System.Drawing.Point(1068, 14);
            this.ClearBtn.Margin = new System.Windows.Forms.Padding(4);
            this.ClearBtn.Name = "ClearBtn";
            this.ClearBtn.Size = new System.Drawing.Size(57, 32);
            this.ClearBtn.TabIndex = 37;
            this.ClearBtn.Text = "Clear";
            this.ClearBtn.UseVisualStyleBackColor = true;
            this.ClearBtn.Click += new System.EventHandler(this.ClearBtn_Click);
            // 
            // BLE_UI
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1439, 780);
            this.Controls.Add(this.ClearBtn);
            this.Controls.Add(this.versionLabel);
            this.Controls.Add(this.DataList);
            this.Controls.Add(this.screenEnableCB);
            this.Controls.Add(this.SaveBtn);
            this.Controls.Add(this.CuboidBtn);
            this.Controls.Add(this.SubBtn);
            this.Controls.Add(this.ReadBtn);
            this.Controls.Add(this.SerLbl);
            this.Controls.Add(this.CharLbl);
            this.Controls.Add(this.ServiceList);
            this.Controls.Add(this.CharList);
            this.Controls.Add(this.SearchBtn);
            this.Controls.Add(this.ConnectBtn);
            this.Controls.Add(this.DeviceList);
            this.Controls.Add(this.HEX2);
            this.Controls.Add(this.HEX1);
            this.Controls.Add(this.HEX3);
            this.Controls.Add(this.SendBx3);
            this.Controls.Add(this.SendBtn3);
            this.Controls.Add(this.SendBx2);
            this.Controls.Add(this.SendBtn2);
            this.Controls.Add(this.SendBx1);
            this.Controls.Add(this.SendBtn1);
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "BLE_UI";
            this.Text = "Save";
            this.Load += new System.EventHandler(this.BLE_UI_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox SendBx3;
        private System.Windows.Forms.Button SendBtn3;
        private System.Windows.Forms.TextBox SendBx2;
        private System.Windows.Forms.Button SendBtn2;
        private System.Windows.Forms.TextBox SendBx1;
        private System.Windows.Forms.Button SendBtn1;
        public System.Windows.Forms.CheckBox HEX3;
        public System.Windows.Forms.CheckBox HEX1;
        public System.Windows.Forms.CheckBox HEX2;
        private System.Windows.Forms.ListBox DeviceList;
        private System.Windows.Forms.Button ConnectBtn;
        private System.Windows.Forms.Button SearchBtn;
        private System.Windows.Forms.ListBox CharList;
        private System.Windows.Forms.ListBox ServiceList;
        private System.Windows.Forms.Label CharLbl;
        private System.Windows.Forms.Label SerLbl;
        private System.Windows.Forms.Button ReadBtn;
        private System.Windows.Forms.Button SubBtn;
        private System.Windows.Forms.Button CuboidBtn;
        private System.Windows.Forms.Button SaveBtn;
        private System.Windows.Forms.CheckBox screenEnableCB;
        private System.Windows.Forms.RichTextBox DataList;
        private System.Windows.Forms.OpenFileDialog openFileDialog1;
        private System.Windows.Forms.Label versionLabel;
        private System.Windows.Forms.Button ClearBtn;
    }
}

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            