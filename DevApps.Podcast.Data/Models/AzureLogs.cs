using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Auth;
using Microsoft.WindowsAzure.Storage.Blob;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DevApps.Podcast.Data.Models
{
    /// <summary>
    ///  AzureLogs for Blobs
    /// </summary>
    public class AzureLogs
    {
        private string _accountName;
        private string _keyValue;
        private const string CONTAINER_NAME = "$logs";

        /// <summary>
        /// Initializes a new instance of AzureLogs for Blobs
        /// </summary>
        public AzureLogs(Configuration configuration)
        {
            _accountName = configuration.AzureStorageCredentials.Key;
            _keyValue = configuration.AzureStorageCredentials.Value;

            this.OnlyForExtensions = new List<string>();
            StorageCredentials credentials = new StorageCredentials(_accountName, _keyValue);
            CloudStorageAccount storageAccount = new CloudStorageAccount(credentials, false);

            CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
            CloudBlobContainer container = blobClient.GetContainerReference(CONTAINER_NAME);

            var allBlobs = container.ListBlobs(string.Empty, true, BlobListingDetails.All, null, null);
            this.AllLogBlobs = new List<CloudBlockBlob>(allBlobs.Select(i => i as CloudBlockBlob).OrderBy(i => i.Name));
            this.OnlyOperationTypes = new List<string>(new string[] { "GetBlob" });
        }

        /// <summary>
        /// Gets or sets a list of extension to filter GetLogItems methods (mp3, mp4).
        /// </summary>
        public List<string> OnlyForExtensions { get; set; }

        /// <summary>
        /// Gets or sets a list of type of operations to filter GetLogItems methods (default: "GetBlob").
        /// </summary>
        public List<string> OnlyOperationTypes { get; set; }

        /// <summary>
        /// Returns all log items readed in all log filename blobs for specified date.
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public IEnumerable<AzureLogItem> GetLogItems(DateTime date)
        {
            var dayBlobs = this.AllLogBlobs.Where(b => b.Name.Contains($"/{date.Year}/{date.Month.ToString("00")}/{date.Day.ToString("00")}/"));
            return this.GetLogItems(dayBlobs);
        }

        /// <summary>
        /// Returns all log items readed in all log filename blobs for all dates.
        /// </summary>
        /// <returns></returns>
        public IEnumerable<AzureLogItem> GetLogItems()
        {
            var dayBlobs = this.AllLogBlobs;
            return this.GetLogItems(dayBlobs);
        }

        /// <summary>
        /// Returns all log items readed specified blob filename.
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public IEnumerable<AzureLogItem> GetLogItems(string filename)
        {
            var dayBlob = this.AllLogBlobs.FirstOrDefault(b => String.Compare(b.Name, filename, true) == 0);
            return this.GetLogItems(new CloudBlockBlob[] { dayBlob });
        }

        /// <summary>
        /// Returns the content of specified blobs, filtered by extensions
        /// </summary>
        /// <param name="blobs"></param>
        /// <returns></returns>
        private IEnumerable<AzureLogItem> GetLogItems(IEnumerable<CloudBlockBlob> blobs)
        {
            List<AzureLogItem> logs = new List<AzureLogItem>();
            bool withExtensions = this.OnlyForExtensions.Count() > 0;
            bool withOperations = this.OnlyOperationTypes.Count() > 0;

            foreach (var blob in blobs)
            {
                string blobContent = string.Empty;

                try
                {
                    blobContent = blob.DownloadText();
                }
                catch (Exception)
                {
                }

                foreach (string line in blobContent.Split(new char[] { '\n' }, StringSplitOptions.RemoveEmptyEntries))
                {
                    AzureLogItem logItem = new AzureLogItem(line);
                    if (!withOperations || this.OnlyOperationTypes.Any(operation => logItem.OperationType == operation))
                    {
                        if (!withExtensions || this.OnlyForExtensions.Any(ext => logItem.RequestedObjectKey.EndsWith(ext)))
                        {
                            logs.Add(new AzureLogItem(line));
                        }
                    }
                }
            }
            return logs.OrderBy(i => i.RequestStartTime);
        }

        /// <summary>
        /// Returns a list with all log filenames.
        /// </summary>
        public string[] FilenamesList
        {
            get
            {
                return this.AllLogBlobs.Select(i => i.Name).ToArray();
            }
        }

        /// <summary>
        /// Returns all Azure Logger Blobs informations.
        /// </summary>
        /// <returns></returns>
        public IEnumerable<CloudBlockBlob> GetAllBlobs()
        {
            return this.AllLogBlobs;
        }

        /// <summary>
        /// Gets or sets all Azure Logger Blobs informations.
        /// </summary>
        private List<CloudBlockBlob> AllLogBlobs { get; set; }
    }

    [DebuggerDisplay("{RequestFilename}")]
    public struct AzureLogItem
    {
        public AzureLogItem(string logLine)
        {
            string[] fieldValues = SplitLog(logLine);

            if (fieldValues.Length > 29)
            {
                VersionNumber = fieldValues[0];
                RequestStartTime = DateTime.Parse(fieldValues[1]);
                OperationType = fieldValues[2];
                RequestStatus = fieldValues[3];
                HttpStatusCode = fieldValues[4];
                EndToEndLatencyInMs = fieldValues[5];
                ServerLatencyInMs = fieldValues[6];
                AuthenticationType = fieldValues[7];
                RequesterAccountName = fieldValues[8];
                OwnerAccountName = fieldValues[9];
                ServiceType = fieldValues[10];
                RequestUrl = fieldValues[11];
                RequestedObjectKey = fieldValues[12];
                RequestIdHeader = fieldValues[13];
                OperationCount = fieldValues[14];
                RequesterIpAddress = fieldValues[15];
                RequestVersionHeader = fieldValues[16];
                RequestHeaderSize = fieldValues[17];
                RequestPacketSize = fieldValues[18];
                ResponseHeaderSize = fieldValues[19];
                ResponsePacketSize = fieldValues[20];
                RequestContentLength = fieldValues[21];
                RequestMd5 = fieldValues[22];
                ServerMd5 = fieldValues[23];
                EtagIdentifier = fieldValues[24];
                LastModifiedTime = fieldValues[25];
                ConditionsUsed = fieldValues[26];
                UserAgentHeader = fieldValues[27];
                ReferrerHeader = fieldValues[28];
                ClientRequestId = fieldValues[29];
            }
            else
            {
                VersionNumber = String.Empty;
                RequestStartTime = DateTime.MinValue;
                OperationType = String.Empty;
                RequestStatus = String.Empty;
                HttpStatusCode = String.Empty;
                EndToEndLatencyInMs = String.Empty;
                ServerLatencyInMs = String.Empty;
                AuthenticationType = String.Empty;
                RequesterAccountName = String.Empty;
                OwnerAccountName = String.Empty;
                ServiceType = String.Empty;
                RequestUrl = String.Empty;
                RequestedObjectKey = String.Empty;
                RequestIdHeader = String.Empty;
                OperationCount = String.Empty;
                RequesterIpAddress = String.Empty;
                RequestVersionHeader = String.Empty;
                RequestHeaderSize = String.Empty;
                RequestPacketSize = String.Empty;
                ResponseHeaderSize = String.Empty;
                ResponsePacketSize = String.Empty;
                RequestContentLength = String.Empty;
                RequestMd5 = String.Empty;
                ServerMd5 = String.Empty;
                EtagIdentifier = String.Empty;
                LastModifiedTime = String.Empty;
                ConditionsUsed = String.Empty;
                UserAgentHeader = String.Empty;
                ReferrerHeader = String.Empty;
                ClientRequestId = String.Empty;
            }
        }

        private static string[] SplitLog(string value)
        {
            // Value: "a";b;c;"d;e";"";f;g 
            // Step1: "a"  b  c  "d  e"  ""  f  g
            // Step2: a  b  c  d;e  f  ''  g
            const string quote = "\"";
            const char separator = ';';

            string[] step1 = value.Replace("&quot;", "&quot").Split(separator);
            StringCollection step2 = new StringCollection();
            bool isQuoteOpened = false;

            for (int i = 0; i < step1.Length; i++)
            {
                string item = step1[i];

                // "a" - ""
                if (item.StartsWith(quote) && item.EndsWith(quote) && item.Length > 1)
                {
                    step2.Add(item.Substring(1, item.Length - 2));
                }

                // "d
                else if (item.StartsWith(quote))
                {
                    isQuoteOpened = true;
                    step2.Add(item.Substring(1));
                }

                // e"
                else if (item.EndsWith(quote))
                {
                    if (isQuoteOpened)
                    {
                        int lastIndex = step2.Count - 1;
                        step2[lastIndex] += String.Concat(separator, item.Substring(0, item.Length - 1));
                    }
                    else
                    {
                        throw new InvalidOperationException("End separator without start separator.");
                    }
                    isQuoteOpened = false;
                }

                // b - c - f - g
                else
                {
                    if (isQuoteOpened)
                    {
                        int lastIndex = step2.Count - 1;
                        step2[lastIndex] += String.Concat(separator, item);
                    }
                    else
                    {
                        step2.Add(item);
                    }

                }
            }

            string[] result = new string[step2.Count];
            step2.CopyTo(result, 0);
            return result;
        }

        public string VersionNumber { get; set; }
        public DateTime RequestStartTime { get; set; }
        public string OperationType { get; set; }
        public string RequestStatus { get; set; }
        public string HttpStatusCode { get; set; }
        public string EndToEndLatencyInMs { get; set; }
        public string ServerLatencyInMs { get; set; }
        public string AuthenticationType { get; set; }
        public string RequesterAccountName { get; set; }
        public string OwnerAccountName { get; set; }
        public string ServiceType { get; set; }
        public string RequestUrl { get; set; }
        public string RequestedObjectKey { get; set; }
        public string RequestIdHeader { get; set; }
        public string OperationCount { get; set; }
        public string RequesterIpAddress { get; set; }
        public string RequestVersionHeader { get; set; }
        public string RequestHeaderSize { get; set; }
        public string RequestPacketSize { get; set; }
        public string ResponseHeaderSize { get; set; }
        public string ResponsePacketSize { get; set; }
        public string RequestContentLength { get; set; }
        public string RequestMd5 { get; set; }
        public string ServerMd5 { get; set; }
        public string EtagIdentifier { get; set; }
        public string LastModifiedTime { get; set; }
        public string ConditionsUsed { get; set; }
        public string UserAgentHeader { get; set; }
        public string ReferrerHeader { get; set; }
        public string ClientRequestId { get; set; }

        public string RequestFilename
        {
            get
            {
                return this.RequestedObjectKey.Split('/').Last();
            }
        }
    }
}
