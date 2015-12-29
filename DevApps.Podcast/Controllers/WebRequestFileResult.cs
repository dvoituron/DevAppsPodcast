using System;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace DevApps.Podcast.Controllers
{
    /// <summary>
    /// See http://www.tomdupont.net/2014/06/stream-fileresult-from-one-web-server-to-another-with-mvc.html
    /// </summary>
    public class WebRequestFileResult : FileResult
    {
        private const int BufferSize = 32768; // 32 KB
        private const string DispositionHeader = "Content-Disposition";
        private const string LengthHeader = "Content-Length";

        private readonly string _url;

        public WebRequestFileResult(string url)
            : base("application/octet-stream")
        {
            if (String.IsNullOrWhiteSpace(url))
                throw new ArgumentNullException("url", "Url is required");

            _url = url;
        }

        protected override void WriteFile(HttpResponseBase localResponse)
        {
            var webRequest = WebRequest.Create(_url);

            using (var remoteResponse = webRequest.GetResponse())
            using (var remoteStream = remoteResponse.GetResponseStream())
            {
                if (remoteStream == null)
                    throw new NullReferenceException(
                        "Request returned null stream: " + _url);

                var dispositionKey = remoteResponse.Headers.AllKeys.FirstOrDefault(
                    k => k.Equals(
                        DispositionHeader,
                        StringComparison.InvariantCultureIgnoreCase));

                if (!String.IsNullOrWhiteSpace(dispositionKey))
                    localResponse.AddHeader(
                        DispositionHeader,
                        remoteResponse.Headers[DispositionHeader]);

                var contentLenthString = remoteResponse.ContentLength
                    .ToString(CultureInfo.InvariantCulture);

                localResponse.ContentType = remoteResponse.ContentType;
                localResponse.AddHeader(LengthHeader, contentLenthString);

                var buffer = new byte[BufferSize];
                var loopCount = 0;

                while (true)
                {
                    if (!localResponse.IsClientConnected)
                        break;

                    var read = remoteStream.Read(buffer, 0, BufferSize);

                    if (read <= 0)
                        break;

                    localResponse.OutputStream.Write(buffer, 0, read);

                    // Flush after 1 MB; note that this
                    // will prevent server side caching.
                    loopCount++;
                    if (loopCount % 32 == 0)
                        localResponse.Flush();
                }
            }
        }
    }
}
