using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DevApps.Podcast.Data.Models
{
    public interface IDataService
    {
        /// <summary>
        /// Returrns all global podcast information used by social networks
        /// </summary>
        /// <param name="podcastID">ID of displayed podcast</param>
        /// <returns></returns>
        SocialInformation GetSocialInformation(int podcastID);

        /// <summary>
        /// Returrns general site information
        /// </summary>
        /// <returns></returns>
        SocialInformation GetSiteHeader();

        /// <summary>
        /// Returns all configuration parameters
        /// </summary>
        /// <returns></returns>
        Configuration Configuration { get; }

        /// <summary>
        /// Returns a list of last podcasts, based on PublicationDate (Configuration.MaximumOfPodcastsOnHomePage)
        /// </summary>
        /// <returns></returns>
        IEnumerable<Podcast> GetLastPodcasts();

        /// <summary>
        /// Returns the specified podcast (or null if not found)
        /// </summary>
        /// <param name="podcastID"></param>
        /// <returns></returns>
        Podcast GetPodcast(int podcastID);

        /// <summary>
        /// Returns the PodcastID associated to this URL
        /// </summary>
        /// <param name="shortUrl"></param>
        /// <returns></returns>
        int? GetPodcastID(string shortUrl);

        /// <summary>
        /// Gets the database version
        /// </summary>
        Version Version { get; }

        /// <summary>
        /// Write a statistic item in a DB
        /// </summary>
        /// <param name="podcastID">ID of podcast to trace</param>
        /// <param name="fileExtension">Extension of file read</param>
        void WriteStatisticItem(int podcastID, string fileExtension);

        /// <summary>
        /// Returns light Podcast objects
        /// </summary>
        /// <returns></returns>
        IEnumerable<PodcastForStatistic> GetStatistics();

        /// <summary>
        /// Clear all data stored in cached objects.
        /// </summary>
        void ClearCache();
    }
}
