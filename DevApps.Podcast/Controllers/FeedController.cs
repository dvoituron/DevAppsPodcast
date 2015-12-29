using System;
using System.Web.Mvc;
using System.Xml.Serialization;

namespace DevApps.Podcast.Controllers
{
    public class FeedController : ControllerBase
    {
        // GET: Feeds
        public ActionResult Index()
        {
            // NameSpace
            XmlSerializerNamespaces ns = new XmlSerializerNamespaces();
            ns.Add("itunes", "http://www.itunes.com/dtds/podcast-1.0.dtd");
            ns.Add("atom", "http://www.w3.org/2005/Atom");

            return new XmlResult(this.Locator.Feeds.GetAudioFeed(), ns);
        }
    }
}
