using System;
using System.Web;

namespace DevApps.Podcast.Data.Models
{
    public class Configuration
    {
        public int MaximumOfPodcastsOnHomePage { get; set; }

        public string DisqusShortnameKey { get; set; }

        public Uri SiteUrl { get; set; }

        public Version Version { get; set; }

        public static Uri WebSiteBaseUri
        {
            get
            {
                return new Uri(String.Concat(HttpContext.Current.Request.Url.Scheme, "://", HttpContext.Current.Request.Url.Authority, HttpContext.Current.Request.ApplicationPath));
            }
        }
    }
}
