using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Windows.Devices.Enumeration;
using System.Windows.Threading;
using System.Collections.ObjectModel;
using BLE_UI.BLE;
using System.Diagnostics;
using Windows.Devices.Bluetooth.GenericAttributeProfile;
using Windows.Devices.Bluetooth;
using Windows.Storage.Streams;
using Windows.Security.Cryptography;
using System.Runtime.InteropServices.WindowsRuntime;
using System.IO;
using System.Globalization;


namespace BLE_UI
{
    public partial class BLE_UI : Form
    {

        String VERSION_TEXT = "00.00.03";

        public BLE_UI()
        {
            InitializeComponent();
            dispatcher = Dispatcher.CurrentDispatcher;
        }

        private ObservableCollection<BluetoothLEAttributeDisplay> ServiceCollection = new ObservableCollection<BluetoothLEAttributeDisplay>();
        private ObservableCollection<BluetoothLEAttributeDisplay> CharacteristicCollection = new ObservableCollection<BluetoothLEAttributeDisplay>();

        private DeviceWatcher deviceWatcher;
        private ObservableCollection<BluetoothLEDeviceDisplay> KnownDevices = new ObservableCollection<BluetoothLEDeviceDisplay>();
        private List<DeviceInformation> UnknownDevices = new List<DeviceInformation>();
        public static DeviceInformation SelectedDevice { get; set; }

        // Only one registered characteristic at a time.
        private GattCharacteristic registeredCharacteristic;
        private GattCharacteristic selectedCharacteristic;
        private GattPresentationFormat presentationFormat;

        private BluetoothLEDevice bluetoothLeDevice = null;

        private bool subscribedForNotifications = false;

        String FileText = "";
        String FileName = "";

        public bool Cuboid_Visible = false;

        #region Error Codes
        readonly int E_BLUETOOTH_ATT_WRITE_NOT_PERMITTED = unchecked((int)0x80650003);
        readonly int E_BLUETOOTH_ATT_INVALID_PDU = unchecked((int)0x80650004);
        readonly int E_ACCESSDENIED = unchecked((int)0x80070005);
        readonly int E_DEVICE_NOT_AVAILABLE = unchecked((int)0x800710df); // HRESULT_FROM_WIN32(ERROR_DEVICE_NOT_AVAILABLE)
        #endregion

        float[] Quaternion = new float[4];
        static Cuboid.Cuboid Cuboid9DoF = new Cuboid.Cuboid(new string[] { @"C:\Users\Right.png", @"C:\Users\Left.png", @"C:\Users\Back.png", @"C:\Users\Front.png", @"C:\Users\Top.png", @"C:\Users\Bottom.png" });
        static BackgroundWorker backgroundWorker9Dof = new BackgroundWorker();
        bool DoF_Enabled = false;

        private void BLE_UI_Load(object sender, EventArgs e)
        {
            //start quaternion variables here
            versionLabel.Text = VERSION_TEXT;
        }

        private void SearchBtn_Click(object sender, EventArgs e)
        {
            if (deviceWatcher == null)
            {
                findingDeviceList.Clear();
                DeviceList.Items.Clear();
                StartBleDeviceWatcher();
                SearchBtn.Text = "Searching";
            }
            else
            {
                StopBleDeviceWatcher();
                SearchBtn.Text = "Search";
            }
        }


        /// <summary>
        /// Starts a device watcher that looks for all nearby Bluetooth devices (paired or unpaired). 
        /// Attaches event handlers to populate the device collection.
        /// </summary>
        private void StartBleDeviceWatcher()
        {
            // Additional properties we would like about the device.
            // Property strings are documented here https://msdn.microsoft.com/en-us/library/windows/desktop/ff521659(v=vs.85).aspx
            string[] requestedProperties = { "System.Devices.Aep.DeviceAddress", "System.Devices.Aep.IsConnected", "System.Devices.Aep.Bluetooth.Le.IsConnectable" };

            // BT_Code: Example showing paired and non-paired in a single query.
            string aqsAllBluetoothLEDevices = "(System.Devices.Aep.ProtocolId:=\"{bb7bb05e-5972-42b5-94fc-76eaa7084d49}\")";

            deviceWatcher =
                    DeviceInformation.CreateWatcher(
                        aqsAllBluetoothLEDevices,
                        requestedProperties,
                        DeviceInformationKind.AssociationEndpoint);

            // Register event handlers before starting the watcher.
            deviceWatcher.Added += DeviceWatcher_Added;
            deviceWatcher.Updated += DeviceWatcher_Updated;
            deviceWatcher.Removed += DeviceWatcher_Removed;
            deviceWatcher.EnumerationCompleted += DeviceWatcher_EnumerationCompleted;
            deviceWatcher.Stopped += DeviceWatcher_Stopped;

            // Start over with an empty collection.
            KnownDevices.Clear();

            // Start the watcher. Active enumeration is limited to approximately 30 seconds.
            // This limits power usage and reduces interference with other Bluetooth activities.
            // To monitor for the presence of Bluetooth LE devices for an extended period,
            // use the BluetoothLEAdvertisementWatcher runtime class. See the BluetoothAdvertisement
            // sample for an example.
            deviceWatcher.Start();
        }

        /// <summary>
        /// Stops watching for all nearby Bluetooth devices.
        /// </summary>
        private void StopBleDeviceWatcher()
        {
            if (deviceWatcher != null)
            {
                // Unregister the event handlers.
                deviceWatcher.Added -= DeviceWatcher_Added;
                deviceWatcher.Updated -= DeviceWatcher_Updated;
                deviceWatcher.Removed -= DeviceWatcher_Removed;
                deviceWatcher.EnumerationCompleted -= DeviceWatcher_EnumerationCompleted;
                deviceWatcher.Stopped -= DeviceWatcher_Stopped;

                // Stop the watcher.
                deviceWatcher.Stop();
                deviceWatcher = null;

                //Item name test
                //SyncList();
            }
        }

        private BluetoothLEDeviceDisplay FindBluetoothLEDeviceDisplay(string id)
        {
            foreach (BluetoothLEDeviceDisplay bleDeviceDisplay in KnownDevices)
            {
                if (bleDeviceDisplay.Id == id)
                {
                    return bleDeviceDisplay;
                }
            }
            return null;
        }

        private DeviceInformation FindUnknownDevices(string id)
        {
            foreach (DeviceInformation bleDeviceInfo in UnknownDevices)
            {
                if (bleDeviceInfo.Id == id)
                {
                    return bleDeviceInfo;
                }
            }
            return null;
        }

        private bool ListCheck(List<DeviceInformation> devList, string inputId)
        {
            foreach (var x in devList)
            {
                if (x.Id == inputId)
                {
                    return false;
                }
            }
            return true;
        }

        private List<DeviceInformation> ConvertToListFromListBx(System.Windows.Forms.ListBox lst)
        {
            List<DeviceInformation> returnList = new List<DeviceInformation>();
            if (lst.Items.Count > 1)
            {
                foreach (var x in lst.Items)
                {
                    returnList.Add((DeviceInformation)x);
                }
            }
            return returnList;
        }

        List<DeviceInformation> findingDeviceList = new List<DeviceInformation>();
        private async void DeviceWatcher_Added(DeviceWatcher sender, DeviceInformation deviceInfo)
        {
            // We must update the collection on the UI thread because the collection is databound to a UI element.
            await dispatcher.InvokeAsync(() =>
            {
                lock (this)
                {
                    Debug.WriteLine(string.Format("Added {0}{1}", deviceInfo.Id, deviceInfo.Name));

                    // Protect against race condition if the task runs after the app stopped the deviceWatcher.
                    if (sender == deviceWatcher)
                    {
                        // Make sure device isn't already present in the list.
                        if (FindBluetoothLEDeviceDisplay(deviceInfo.Id) == null && ListCheck(findingDeviceList, deviceInfo.Id))
                        {
                            if (deviceInfo.Name != string.Empty)
                            {
                                // If device has a friendly name display it immediately.
                                KnownDevices.Add(new BluetoothLEDeviceDisplay(deviceInfo));
                                findingDeviceList.Add(deviceInfo);
                                DeviceList.Items.Add(deviceInfo.Name);
                            }
                            else
                            {
                                // Add it to a list in case the name gets updated later. 
                                UnknownDevices.Add(deviceInfo);
                            }
                        }
                    }
                }
            });
        }

        private async void DeviceWatcher_Updated(DeviceWatcher sender, DeviceInformationUpdate deviceInfoUpdate)
        {
            // We must update the collection on the UI thread because the collection is databound to a UI element.
            await dispatcher.InvokeAsync(() =>
            {
                lock (this)
                {
                    Debug.WriteLine(String.Format("Updated {0}{1}", deviceInfoUpdate.Id, ""));

                    // Protect against race condition if the task runs after the app stopped the deviceWatcher.
                    if (sender == deviceWatcher)
                    {
                        BluetoothLEDeviceDisplay bleDeviceDisplay = FindBluetoothLEDeviceDisplay(deviceInfoUpdate.Id);
                        if (bleDeviceDisplay != null)
                        {
                            // Device is already being displayed - update UX.
                            bleDeviceDisplay.Update(deviceInfoUpdate);
                            return;
                        }

                        DeviceInformation deviceInfo = FindUnknownDevices(deviceInfoUpdate.Id);
                        if (deviceInfo != null)
                        {
                            deviceInfo.Update(deviceInfoUpdate);
                            // If device has been updated with a friendly name it's no longer unknown.
                            if (deviceInfo.Name != String.Empty)
                            {
                                KnownDevices.Add(new BluetoothLEDeviceDisplay(deviceInfo));
                                UnknownDevices.Remove(deviceInfo);
                            }
                        }
                    }
                }
            });
        }

        private async void DeviceWatcher_Removed(DeviceWatcher sender, DeviceInformationUpdate deviceInfoUpdate)
        {
            // We must update the collection on the UI thread because the collection is databound to a UI element.
            await dispatcher.InvokeAsync(() =>
            {
                lock (this)
                {
                    Debug.WriteLine(string.Format("Removed {0}{1}", deviceInfoUpdate.Id, ""));

                    // Protect against race condition if the task runs after the app stopped the deviceWatcher.
                    if (sender == deviceWatcher)
                    {
                        // Find the corresponding DeviceInformation in the collection and remove it.
                        BluetoothLEDeviceDisplay bleDeviceDisplay = FindBluetoothLEDeviceDisplay(deviceInfoUpdate.Id);
                        if (bleDeviceDisplay != null)
                        {
                            KnownDevices.Remove(bleDeviceDisplay);
                        }

                        DeviceInformation deviceInfo = FindUnknownDevices(deviceInfoUpdate.Id);
                        if (deviceInfo != null)
                        {
                            UnknownDevices.Remove(deviceInfo);
                        }
                    }
                }
            });
        }

        private async void DeviceWatcher_EnumerationCompleted(DeviceWatcher sender, object e)
        {
            // We must update the collection on the UI thread because the collection is databound to a UI element.
            await dispatcher.InvokeAsync(() =>
            {
            });
        }

        private async void DeviceWatcher_Stopped(DeviceWatcher sender, object e)
        {
            // We must update the collection on the UI thread because the collection is databound to a UI element.
            await dispatcher.InvokeAsync(() =>
            {
            });

        }


        private void DeviceList_SelectedIndexChanged(object sender, EventArgs e)
        {
            ConnectBtn.Enabled = true;

            try
            {
                foreach (var item in findingDeviceList)
                {
                    if (item.Name == DeviceList.SelectedItem.ToString())
                    {
                        SelectedDevice = item;
                        break;
                    }
                    else
                    {
                        SelectedDevice = null;
                    }
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        private void Characteristic_ValueChanged(GattCharacteristic sender, GattValueChangedEventArgs args)
        {
            // BT_Code: An Indicate or Notify reported that the value has changed.
            // Display the new value with a timestamp.
            var newValue = FormatValueByPresentation(args.CharacteristicValue, presentationFormat);
        }

        private async Task<bool> ClearBluetoothLEDeviceAsync()
        {
            if (subscribedForNotifications)
            {
                // Need to clear the CCCD from the remote device so we stop receiving notifications
                var result = await registeredCharacteristic.WriteClientCharacteristicConfigurationDescriptorAsync(GattClientCharacteristicConfigurationDescriptorValue.None);
                if (result != GattCommunicationStatus.Success)
                {
                    return false;
                }
                else
                {
                    selectedCharacteristic.ValueChanged -= Characteristic_ValueChanged;
                    subscribedForNotifications = false;
                }
            }
            bluetoothLeDevice?.Dispose();
            bluetoothLeDevice = null;
            return true;
        }

        private async void ConnectBtn_Click(object sender, EventArgs e)
        {
            if (bluetoothLeDevice == null)
            {
                if (!await ClearBluetoothLEDeviceAsync())
                {
                    MessageBox.Show("Error: Unable to reset state, try again.");
                    ConnectBtn.Enabled = false;
                    return;
                }

                try
                {
                    bluetoothLeDevice = await BluetoothLEDevice.FromIdAsync(SelectedDevice.Id);

                    if (bluetoothLeDevice == null)
                    {
                        MessageBox.Show("Failed to connect to device.");
                    }
                }
                catch (Exception ex) when (ex.HResult == E_DEVICE_NOT_AVAILABLE)
                {
                    MessageBox.Show("Bluetooth radio is not on.");
                }

                if (bluetoothLeDevice != null)
                {
                    // Note: BluetoothLEDevice.GattServices property will return an empty list for unpaired devices. For all uses we recommend using the GetGattServicesAsync method.
                    // BT_Code: GetGattServicesAsync returns a list of all the supported services of the device (even if it's not paired to the system).
                    // If the services supported by the device are expected to change during BT usage, subscribe to the GattServicesChanged event.
                    GattDeviceServicesResult result = await bluetoothLeDevice.GetGattServicesAsync(BluetoothCacheMode.Uncached);

                    if (result.Status == GattCommunicationStatus.Success)
                    {
                        var services = result.Services;
                        foreach (var service in services)
                        {
                            ServiceCollection.Add(new BluetoothLEAttributeDisplay(service));
                        }


                        ServiceList.DataSource = ServiceCollection;
                        ServiceList.DisplayMember = "Name";
                    }
                    ConnectBtn.Text = "Disconnect";
                    SearchBtn_Click(sender,  e);
                }
            }
            else
            {
                bluetoothLeDevice.Dispose(); // according to docs, this one line should be enough to disconnect
                bluetoothLeDevice = null;
                GC.Collect();
                ConnectBtn.Text = "Connect";
                ConnectBtn.Enabled = false;
                CuboidBtn.Enabled = false;
                ReadBtn.Enabled = false;
                SubBtn.Enabled = false;
                SendBtn1.Enabled = false;
                SendBtn2.Enabled = false;
                SendBtn3.Enabled = false;
                DoF_Enabled = false;
                KnownDevices.Clear();
                DeviceList.Items.Clear();
                ServiceCollection.Clear();
                CharacteristicCollection.Clear();
                ServiceList.DataSource = ServiceCollection;
                CharacteristicCollection.Clear();
                CharList.DataSource = CharacteristicCollection;
            }
        }



        #region bluetooth interface functions
        private void AddValueChangedHandler()
        {
            SubBtn.Text = "Unsubscribe";
            if (!subscribedForNotifications)
            {
                registeredCharacteristic = selectedCharacteristic;
                registeredCharacteristic.ValueChanged += Characteristic_ValueChanged;
                subscribedForNotifications = true;
            }
        }

        private void RemoveValueChangedHandler()
        {
            SubBtn.Text = "Subscribe";
            if (subscribedForNotifications)
            {
                registeredCharacteristic.ValueChanged -= Characteristic_ValueChanged;
                registeredCharacteristic = null;
                subscribedForNotifications = false;
            }
        }
        
        private async void btnRead_Click(object sender, EventArgs e)
        {
            // BT_Code: Read the actual value from the device by using Uncached.
            GattReadResult result = await selectedCharacteristic.ReadValueAsync(BluetoothCacheMode.Uncached);
            if (result.Status == GattCommunicationStatus.Success)
            {
                string formattedResult = FormatValueByPresentation(result.Value, presentationFormat);
            }
            else
            {
                MessageBox.Show($"Read failed: {result.Status}");
            }
        }

        public static byte[] StringToByteArray(string hex)
        {
            return Enumerable.Range(0, hex.Length)
                             .Where(x => x % 2 == 0)
                             .Select(x => Convert.ToByte(hex.Substring(x, 2), 16))
                             .ToArray();
        }

        byte[] convertHexStringToBuffer(String hexString)
        {
            if(hexString.Length % 2 != 0)
            {
                MessageBox.Show("Please insert string with lenght multiple of 2");
                return null;
            }

            if (hexString.Contains(" "))
            {
                MessageBox.Show("Please insert string without space");
                return null;
            }

            byte[] data = new byte[hexString.Length / 2];
            for (int index = 0; index < data.Length; index++)
            {
                string byteValue = hexString.Substring(index * 2, 2);
                data[index] = byte.Parse(byteValue, NumberStyles.HexNumber, CultureInfo.InvariantCulture);
            }

            return data;
        }

        private async void SendBtn1_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(SendBx1.Text))
            {
                if (HEX1.Checked)
                {
                    byte[] convertedBuffrer = convertHexStringToBuffer(SendBx1.Text);
                    if (convertedBuffrer == null)
                        return;
                    var writeBuffer = convertedBuffrer.AsBuffer();
                    var writeSuccessful = await WriteBufferToSelectedCharacteristicAsync(writeBuffer);
                }
                else
                {
                    var writeBuffer = CryptographicBuffer.ConvertStringToBinary(SendBx1.Text, BinaryStringEncoding.Utf8);
                    var writeSuccessful = await WriteBufferToSelectedCharacteristicAsync(writeBuffer);
                }
            }
            else
            {
                MessageBox.Show("No data to write to device");
            }
        }

        private async void SendBtn2_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(SendBx2.Text))
            {
                if (HEX2.Checked)
                {
                    byte[] convertedBuffrer = convertHexStringToBuffer(SendBx2.Text);
                    if (convertedBuffrer == null)
                        return;
                    var writeBuffer = convertedBuffrer.AsBuffer();
                    var writeSuccessful = await WriteBufferToSelectedCharacteristicAsync(writeBuffer);
                }
                else
                {
                    var writeBuffer = CryptographicBuffer.ConvertStringToBinary(SendBx2.Text, BinaryStringEncoding.Utf8);
                    var writeSuccessful = await WriteBufferToSelectedCharacteristicAsync(writeBuffer);
                }
            }
            else
            {
                MessageBox.Show("No data to write to device");
            }
        }

        private async void SendBtn3_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(SendBx3.Text))
            {
                if (HEX3.Checked)
                {
                    byte[] convertedBuffrer = convertHexStringToBuffer(SendBx3.Text);
                    if (convertedBuffrer == null)
                        return;
                    var writeBuffer = convertedBuffrer.AsBuffer();
                    var writeSuccessful = await WriteBufferToSelectedCharacteristicAsync(writeBuffer);
                }
                else
                {
                    var writeBuffer = CryptographicBuffer.ConvertStringToBinary(SendBx3.Text, BinaryStringEncoding.Utf8);
                    var writeSuccessful = await WriteBufferToSelectedCharacteristicAsync(writeBuffer);
                }
            }
            else
            {
                MessageBox.Show("No data to write to device");
            }
        }

        private async Task<bool> WriteBufferToSelectedCharacteristicAsync(IBuffer buffer)
        {
            try
            {
                // BT_Code: Writes the value from the buffer to the characteristic.
                var result = await selectedCharacteristic.WriteValueWithResultAsync(buffer);

                if (result.Status == GattCommunicationStatus.Success)
                {
                    MessageBox.Show("Successfully wrote value to device");
                    return true;
                }
                else
                {
                    MessageBox.Show($"Write failed: {result.Status}");
                    return false;
                }
            }
            catch (Exception ex) when (ex.HResult == E_BLUETOOTH_ATT_INVALID_PDU)
            {
                MessageBox.Show(ex.Message);
                return false;
            }
            catch (Exception ex) when (ex.HResult == E_BLUETOOTH_ATT_WRITE_NOT_PERMITTED || ex.HResult == E_ACCESSDENIED)
            {
                // This usually happens when a device reports that it support writing, but it actually doesn't.
                MessageBox.Show(ex.Message);
                return false;
            }
        }

        private async void SubBtn_Click(object sender, EventArgs e)
        {
            var cccdValue = GattClientCharacteristicConfigurationDescriptorValue.None;

            if (!subscribedForNotifications)
            {
                // initialize status
                GattCommunicationStatus status = GattCommunicationStatus.Unreachable;
                if (selectedCharacteristic.CharacteristicProperties.HasFlag(GattCharacteristicProperties.Indicate))
                {
                    cccdValue = GattClientCharacteristicConfigurationDescriptorValue.Indicate;
                }
                else if (selectedCharacteristic.CharacteristicProperties.HasFlag(GattCharacteristicProperties.Notify))
                {
                    cccdValue = GattClientCharacteristicConfigurationDescriptorValue.Notify;
                }

                try
                {
                    // BT_Code: Must write the CCCD in order for server to send indications.
                    // We receive them in the ValueChanged event handler.
                    status = await selectedCharacteristic.WriteClientCharacteristicConfigurationDescriptorAsync(cccdValue);

                    if (status == GattCommunicationStatus.Success)
                    {
                        AddValueChangedHandler();
                        MessageBox.Show("Successfully subscribed for value changes");
                    }
                    else
                    {
                        MessageBox.Show($"Error registering for value changes: {status}");
                    }
                }
                catch (UnauthorizedAccessException ex)
                {
                    // This usually happens when a device reports that it support indicate, but it actually doesn't.
                    MessageBox.Show(ex.Message);
                }
                catch (Exception ex)
                {
                    // This usually happens when a device reports that it support indicate, but it actually doesn't.
                    MessageBox.Show(ex.Message);
                }
            }
            else
            {
                try
                {
                    // BT_Code: Must write the CCCD in order for server to send notifications.
                    // We receive them in the ValueChanged event handler.
                    // Note that this sample configures either Indicate or Notify, but not both.
                    var result = await
                            selectedCharacteristic.WriteClientCharacteristicConfigurationDescriptorAsync(
                                GattClientCharacteristicConfigurationDescriptorValue.None);
                    if (result == GattCommunicationStatus.Success)
                    {
                        RemoveValueChangedHandler();
                        MessageBox.Show("Successfully un-registered for notifications");
                    }
                    else
                    {
                        MessageBox.Show($"Error un-registering for notifications: {result}");
                    }
                }
                catch (UnauthorizedAccessException ex)
                {
                    // This usually happens when a device reports that it support notify, but it actually doesn't.
                    MessageBox.Show(ex.Message);
                }
                catch (Exception ex)
                {
                    // This usually happens when a device reports that it support indicate, but it actually doesn't.
                    MessageBox.Show(ex.Message);
                }
            }
        }


        /// <summary>
        /// Process the raw data received from the device into application usable data,
        /// according the the Bluetooth Heart Rate Profile.
        /// https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.characteristic.heart_rate_measurement.xml&u=org.bluetooth.characteristic.heart_rate_measurement.xml
        /// This function throws an exception if the data cannot be parsed.
        /// </summary>
        /// <param name="data">Raw data received from the heart rate monitor.</param>
        /// <returns>The heart rate measurement value.</returns>
        private static ushort ParseHeartRateValue(byte[] data)
        {
            // Heart Rate profile defined flag values
            const byte heartRateValueFormat = 0x01;

            byte flags = data[0];
            bool isHeartRateValueSizeLong = ((flags & heartRateValueFormat) != 0);

            if (isHeartRateValueSizeLong)
            {
                return BitConverter.ToUInt16(data, 1);
            }
            else
            {
                return data[1];
            }
        }

        #region crc hi-low
        private byte[] aucCRCLo = {
            0x00, 0xC0, 0xC1, 0x01, 0xC3, 0x03, 0x02, 0xC2, 0xC6, 0x06, 0x07, 0xC7,
            0x05, 0xC5, 0xC4, 0x04, 0xCC, 0x0C, 0x0D, 0xCD, 0x0F, 0xCF, 0xCE, 0x0E,
            0x0A, 0xCA, 0xCB, 0x0B, 0xC9, 0x09, 0x08, 0xC8, 0xD8, 0x18, 0x19, 0xD9,
            0x1B, 0xDB, 0xDA, 0x1A, 0x1E, 0xDE, 0xDF, 0x1F, 0xDD, 0x1D, 0x1C, 0xDC,
            0x14, 0xD4, 0xD5, 0x15, 0xD7, 0x17, 0x16, 0xD6, 0xD2, 0x12, 0x13, 0xD3,
            0x11, 0xD1, 0xD0, 0x10, 0xF0, 0x30, 0x31, 0xF1, 0x33, 0xF3, 0xF2, 0x32,
            0x36, 0xF6, 0xF7, 0x37, 0xF5, 0x35, 0x34, 0xF4, 0x3C, 0xFC, 0xFD, 0x3D,
            0xFF, 0x3F, 0x3E, 0xFE, 0xFA, 0x3A, 0x3B, 0xFB, 0x39, 0xF9, 0xF8, 0x38,
            0x28, 0xE8, 0xE9, 0x29, 0xEB, 0x2B, 0x2A, 0xEA, 0xEE, 0x2E, 0x2F, 0xEF,
            0x2D, 0xED, 0xEC, 0x2C, 0xE4, 0x24, 0x25, 0xE5, 0x27, 0xE7, 0xE6, 0x26,
            0x22, 0xE2, 0xE3, 0x23, 0xE1, 0x21, 0x20, 0xE0, 0xA0, 0x60, 0x61, 0xA1,
            0x63, 0xA3, 0xA2, 0x62, 0x66, 0xA6, 0xA7, 0x67, 0xA5, 0x65, 0x64, 0xA4,
            0x6C, 0xAC, 0xAD, 0x6D, 0xAF, 0x6F, 0x6E, 0xAE, 0xAA, 0x6A, 0x6B, 0xAB,
            0x69, 0xA9, 0xA8, 0x68, 0x78, 0xB8, 0xB9, 0x79, 0xBB, 0x7B, 0x7A, 0xBA,
            0xBE, 0x7E, 0x7F, 0xBF, 0x7D, 0xBD, 0xBC, 0x7C, 0xB4, 0x74, 0x75, 0xB5,
            0x77, 0xB7, 0xB6, 0x76, 0x72, 0xB2, 0xB3, 0x73, 0xB1, 0x71, 0x70, 0xB0,
            0x50, 0x90, 0x91, 0x51, 0x93, 0x53, 0x52, 0x92, 0x96, 0x56, 0x57, 0x97,
            0x55, 0x95, 0x94, 0x54, 0x9C, 0x5C, 0x5D, 0x9D, 0x5F, 0x9F, 0x9E, 0x5E,
            0x5A, 0x9A, 0x9B, 0x5B, 0x99, 0x59, 0x58, 0x98, 0x88, 0x48, 0x49, 0x89,
            0x4B, 0x8B, 0x8A, 0x4A, 0x4E, 0x8E, 0x8F, 0x4F, 0x8D, 0x4D, 0x4C, 0x8C,
            0x44, 0x84, 0x85, 0x45, 0x87, 0x47, 0x46, 0x86, 0x82, 0x42, 0x43, 0x83,
            0x41, 0x81, 0x80, 0x40
        };

        private byte[] aucCRCHi = {
            0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
            0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
            0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
            0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
            0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
            0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
            0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
            0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
            0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
            0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
            0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
            0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
            0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
            0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
            0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
            0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
            0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
            0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
            0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
            0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
            0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
            0x00, 0xC1, 0x81, 0x40
        };

        #endregion

#endregion

        #region v360 Functions

        private string FormatValueByPresentation(IBuffer buffer, GattPresentationFormat format)
        {
            //Console.WriteLine("Deneme");
            //WriteBLEString("DENEME"); //note that: use this function to send a string
            // BT_Code: For the purpose of this sample, this function converts only UInt32 and
            // UTF-8 buffers to readable text. It can be extended to support other formats if your app needs them.
            byte[] data;
            CryptographicBuffer.CopyToByteArray(buffer, out data);
            if (data != null)
            {
                WriteBufferToWindow(data);
                return "Data parsed";           
            }
            return "Data is NULL";
        }


        //main function that gets quaternions and calibrate 3d model
        private async void WriteBufferToWindow(byte[] data)
        {
            if (data.Length == 0)
            {
                Console.WriteLine("Error, data len is ZERO");
                return;
            }

            byte[] byte_QData = data;

            String bufferString = "";
            for (int i = 0; i < data.Length; i++) //fill the buffer
            {
                String dummy = data[i].ToString("X");
                if (dummy.Length == 1)
                    dummy = "0" + dummy;

                dummy = dummy + " ";
                bufferString = bufferString + dummy;
            }

            String dateTimePrecisionNom = DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss.fff");

            String LogString = (DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss.fff") + "  >  " + bufferString + Environment.NewLine);
            //write this buffer to screen
   
                this.Invoke(new MethodInvoker(delegate ()
                {
                    if(screenEnableCB.Checked)
                        DataList.AppendText(LogString);
                }));

            if (DoF_Enabled == false)
            {
                DoF_Enabled = true;

                backgroundWorker9Dof.DoWork += new DoWorkEventHandler(delegate { Cuboid9DoF.ShowDialog(); });
                backgroundWorker9Dof.RunWorkerAsync();
            }

            if (byte_QData.Length > 15)
            {
                Quaternion[0] = BitConverter.ToSingle(byte_QData, 0);
                Quaternion[1] = BitConverter.ToSingle(byte_QData, 4);
                Quaternion[2] = BitConverter.ToSingle(byte_QData, 8);
                Quaternion[3] = BitConverter.ToSingle(byte_QData, 12);
                Cuboid9DoF.RotationMatrix = ConvertToRotationMatrix(ConvertToConjugate(Quaternion)); // --> AHRS 
            }

            if (!FileName.Equals(""))
            {
                try {
                    byte[] resultofbyte = Encoding.ASCII.GetBytes(LogString);

                    using (FileStream SourceStream = File.Open(FileName, FileMode.OpenOrCreate))
                    {
                        SourceStream.Seek(0, SeekOrigin.End);
                        await SourceStream.WriteAsync(resultofbyte, 0, resultofbyte.Length);
                    }
                }
                catch
                {

                }
                    
            }
        }


        static public float[] ConvertToConjugate(float[] Quaternion)
        {
            return new float[] { Quaternion[0], -Quaternion[1], -Quaternion[2], -Quaternion[3] };
        }

        private void frmClient_Load(object sender, EventArgs e)
        {

        }
    
        private bool CharListCheck(ObservableCollection<BluetoothLEAttributeDisplay> devList, string inputName)
        {
            foreach (var x in devList)
            {
                if (x.Name == inputName)
                {
                    return false;
                }
            }
            return true;
        }

        private async void ServiceList_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            //auto select third element "SimpleKeyService". Close this if you use different hardware
            ServiceList.SelectedIndex = ServiceList.Items.Count - 1;

            BluetoothLEAttributeDisplay attributeInfoDisp = (BluetoothLEAttributeDisplay)ServiceList.SelectedItem;
            CharacteristicCollection.Clear();
            RemoveValueChangedHandler();

            IReadOnlyList<GattCharacteristic> characteristics = null;
            try
            {
                // Ensure we have access to the device.
                var accessStatus = await attributeInfoDisp.service.RequestAccessAsync();
                if (accessStatus == DeviceAccessStatus.Allowed)
                {
                    // BT_Code: Get all the child characteristics of a service. Use the cache mode to specify uncached characterstics only 
                    // and the new Async functions to get the characteristics of unpaired devices as well. 
                    var result = await attributeInfoDisp.service.GetCharacteristicsAsync(BluetoothCacheMode.Uncached);
                    if (result.Status == GattCommunicationStatus.Success)
                    {
                        characteristics = result.Characteristics;
                    }
                    else
                    {
                        MessageBox.Show("Error accessing service.");
                        // On error, act as if there are no characteristics.
                        characteristics = new List<GattCharacteristic>();
                    }
                }
                else
                {
                    // Not granted access
                    MessageBox.Show("Error accessing service.");

                    // On error, act as if there are no characteristics.
                    characteristics = new List<GattCharacteristic>();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Restricted service. Can't read characteristics: " + ex.Message);
                // On error, act as if there are no characteristics.
                characteristics = new List<GattCharacteristic>();
            }
            foreach (GattCharacteristic c in characteristics)
            {
                var temp_disp = new BluetoothLEAttributeDisplay(c);

                if (CharListCheck(CharacteristicCollection, temp_disp.Name))
                {
                    CharacteristicCollection.Add(temp_disp);
                }
            }

            CharList.DataSource = null;
            CharList.Items.Clear();
            CharList.DataSource = CharacteristicCollection;         
            CharList.DisplayMember = "Name";
        }

        private async void CharList_SelectedIndexChanged(object sender, EventArgs e)
        {
            CuboidBtn.Enabled = true;
            ReadBtn.Enabled = true;
            SubBtn.Enabled = true;
            SendBtn1.Enabled = true;
            SendBtn2.Enabled = true;
            SendBtn3.Enabled = true;
            ClearBtn.Enabled = true;

            selectedCharacteristic = null;

            var attributeInfoDisp = (BluetoothLEAttributeDisplay)CharList.SelectedItem;
            if (attributeInfoDisp == null)
            {
                return;
            }

            selectedCharacteristic = attributeInfoDisp.characteristic;
            if (selectedCharacteristic == null)
            {
                MessageBox.Show("No characteristic selected");
                return;
            }
            
            // Get all the child descriptors of a characteristics. Use the cache mode to specify uncached descriptors only 
            // and the new Async functions to get the descriptors of unpaired devices as well. 
            var result = await selectedCharacteristic.GetDescriptorsAsync(BluetoothCacheMode.Uncached);
            if (result.Status != GattCommunicationStatus.Success)
            {
                MessageBox.Show("Descriptor read failure: " + result.Status.ToString());
            }

            // BT_Code: There's no need to access presentation format unless there's at least one. 
            presentationFormat = null;
            if (selectedCharacteristic.PresentationFormats.Count > 0)
            {

                if (selectedCharacteristic.PresentationFormats.Count.Equals(1))
                {
                    // Get the presentation format since there's only one way of presenting it
                    presentationFormat = selectedCharacteristic.PresentationFormats[0];
                }
                else
                {
                    // It's difficult to figure out how to split up a characteristic and encode its different parts properly.
                    // In this case, we'll just encode the whole thing to a string to make it easy to print out.
                }
            }
        }

        static public float[] ConvertToRotationMatrix(float[] Quaternion)
        {
            //x-imu source
            /*float R11 = 2 * Quaternion[0] * Quaternion[0] - 1 + 2 * Quaternion[1] * Quaternion[1];
            float R12 = 2 * (Quaternion[1] * Quaternion[2] + Quaternion[0] * Quaternion[3]);
            float R13 = 2 * (Quaternion[1] * Quaternion[3] - Quaternion[0] * Quaternion[2]);
            float R21 = 2 * (Quaternion[1] * Quaternion[2] - Quaternion[0] * Quaternion[3]);
            float R22 = 2 * Quaternion[0] * Quaternion[0] - 1 + 2 * Quaternion[2] * Quaternion[2];
            float R23 = 2 * (Quaternion[2] * Quaternion[3] + Quaternion[0] * Quaternion[1]);
            float R31 = 2 * (Quaternion[1] * Quaternion[3] + Quaternion[0] * Quaternion[2]);
            float R32 = 2 * (Quaternion[2] * Quaternion[3] - Quaternion[0] * Quaternion[1]);
            float R33 = 2 * Quaternion[0] * Quaternion[0] - 1 + 2 * Quaternion[3] * Quaternion[3];*/


            //dogus's edition
            float R11 = 1 - (2 * Quaternion[2] * Quaternion[2]) - (2 * Quaternion[3] * Quaternion[3]);
            float R12 = (2 * Quaternion[1] * Quaternion[2]) - (2 * Quaternion[0] * Quaternion[3]);
            float R13 = (2 * Quaternion[1] * Quaternion[3]) + (2 * Quaternion[0] * Quater