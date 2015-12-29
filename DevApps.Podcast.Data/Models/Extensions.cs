using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DevApps.Podcast.Data.Models
{
    /// <summary>
    /// Extension methods
    /// </summary>
    public static class Extensions
    {
        /// <summary>
        /// Convert the datetime to "Mon, 06 Jul 2015 19:00:00 GMT"
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static string ToPodcastDateTimeString(this DateTime value)
        {
            return value.ToUniversalTime().ToString("ddd, dd MMM yyyy HH:mm:ss \"GMT\"", CultureInfo.InvariantCulture);
        }

        /// <summary>
        /// Convert the datetime to "Mon, 06 Jul 2015 19:00:00 GMT"
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static string ToPodcastTimeString(this TimeSpan value)
        {
            return value.ToString(@"hh\:mm\:ss");
        }

        /// <summary>
        /// Transform the list of podcast's authors to a string with links
        /// </summary>
        /// <param name="authors"></param>
        /// <returns></returns>
        public static string GetAuthorsAsLinks(this PodcastAuthor[] authors)
        {
            return String.Join(" / ", authors.Select(i => $"<a href=\"{i.Url}\" target=\"_blank\">{i.Name}</a>"));
        }

        /// <summary>
        /// Transform the list of podcast's authors to a string with links
        /// </summary>
        /// <param name="authors"></param>
        /// <returns></returns>
        public static string GetAuthorsAsText(this PodcastAuthor[] authors)
        {
            return String.Join(" / ", authors.Select(i => i.Name));
        }

        /// <summary>
        /// Combine URI and relativeUri
        /// </summary>
        /// <param name="authors"></param>
        /// <returns></returns>
        public static Uri Combine(this Uri baseUri, string relativeUri)
        {
            return new Uri(baseUri, relativeUri);
        }
    }
}
