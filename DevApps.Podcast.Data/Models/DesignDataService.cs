using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DevApps.Podcast.Data.Models
{
    public class DesignDataService : IDataService
    {
        private List<Podcast> _allPodcasts = new List<Podcast>();

        /// <summary>
        /// Initialiazes a new instance of DesignDataService
        /// </summary>
        public DesignDataService()
        {
            for (int i = 1; i < 50; i++)
            {
                Podcast podcast = new Podcast(this.Configuration);
                podcast.PodcastID = i;
                podcast.PodcastKey = $"P{i}";
                podcast.PublicationDate = new DateTime(2015, 7, 7, 21, 0, 0).AddDays(i);
                podcast.Summary = new PodcastSummary(podcast)
                {
                    Title = $"Nouvelles fonctionnalités du C# 6.0 (n°{i})",
                    Authors = new PodcastAuthor[]
                    {
                        new PodcastAuthor(podcast) { Name = "Denis Voituron", Url = "https://twitter.com/denisvoituron" },
                        new PodcastAuthor(podcast) { Name =  "Christophe Peugnet", Url = "https://twitter.com/tossnet1" },
                        new PodcastAuthor(podcast) { Name =  "Laurent Bugnion", Url = "https://twitter.com/tossnet1" }
                    },
                    Description = $"{i} - Le 20 juillet prochain, Microsoft lancera la nouvelle version de Visual Studio. Elle intègre nativement les nouvelles fonctionnalités du C# 6.0 : Dans ce premier podcast, je présente ces nouvelles syntaxes et nouvelles commandes du C# 6.0.",
                };
                podcast.Notes = "<h3>Podcast Notes</h3>Voici quelques liens sur ASP.NET MVC et Arnaud.<ul><li><a href=\"https://leanpub.com/aspnetmvc\" target=\"_blank\">Learn ASP.NET MVC - Livre d'Arnaud sur Leanpub.com</a></li></ul>";
                podcast.Audio = new PodcastAudio(podcast)
                {
                    RemoteUrl = "http://podcastdevapps.blob.core.windows.net/mp3/Podcast-01-NewFeaturesCSharp6.mp3",
                    Size = 15031484,
                    Duration = new TimeSpan(0, 15, 39),
                };
                podcast.Video = new PodcastVideo(podcast)
                {
                    RemoteUrl = "http://podcastdevapps.blob.core.windows.net/mp4/Podcast-01-NewFeaturesCSharp6.mp4",
                    Size = 42212019,
                    Duration = new TimeSpan(0, 15, 39),
                    YoutubeKey = "yAieIX4-V4s"
                };

                _allPodcasts.Add(podcast);

            }

        }

        /// <summary>
        /// <see cref="IDataService.Version"/>
        /// </summary>
        public Version Version
        {
            get
            {
                return new Version(1, 0, 0);
            }
        }

        /// <summary>
        /// <see cref="IDataService.GetConfiguration"/>
        /// </summary>
        /// <returns></returns>
        public Configuration Configuration
        {
            get
            {
                return new Configuration()
                {
                    MaximumOfPodcastsOnHomePage = 5,
                    DisqusShortnameKey = "devapps",
                    SiteUrl = new Uri("http://devapps.be"),
                    Version = new Version(1, 0, 0),
                };
            }
        }

        /// <summary>
        /// <see cref="IDataService.GetLastPodcasts"/>
        /// </summary>
        /// <returns></returns>
        public IEnumerable<Podcast> GetLastPodcasts()
        {
            return _allPodcasts.OrderByDescending(i => i.PublicationDate).Take(this.Configuration.MaximumOfPodcastsOnHomePage);
        }

        /// <summary>
        /// <see cref="IDataService.GetSocialInformation(int)"/>
        /// </summary>
        /// <param name="podcastID"></param>
        /// <returns></returns>
        public SocialInformation GetSocialInformation(int podcastID)
        {
            SocialInformation data = new SocialInformation();

            data.Name = "DevApps Podcasts";
            data.Authors = "Denis Voituron / Christophe Peugnet";
            data.Language = "fr-fr";
            data.GoogleAnalyticsKey = "UA-65328357-1";
            data.TwitterUrl = "https://twitter.com/DevAppsPodcast";
            data.TwitterAccount = "@DevAppsPodcast";
            data.CopyrightName = "Denis Voituron";
            data.CopyrightUrl = "http://www.dvoituron.be";
            data.CopyrightEmail = "dvoituron@outlook.com";
            data.CategoriesKeywords = "Programming;Talk;Français;Podcast;Microsoft;Technology=Software How-To;Technology=Gadgets";
            data.ImageUrl = "http://devapps.be/images/logo1400.png";
            data.Creator = "@DevAppsPodcast";
            data.FeedAudioUrl = "http://devapps.be/feed";
            data.FeedVideoUrl = "http://devapps.be/video";
            data.FeedTitle = "DevApps Podcasts, par Denis Voituron et Christophe Peugnet";

            Podcast podcast = this.GetPodcast(podcastID);

            // Header for Home Page
            if (podcast == null)
            {
                data.Title = "DevApps Podcasts";
                data.Description = "DevApps - Actualité, Développement et Architecture en technologies .NET. Présenté par Denis Voituron et Christophe Peugnet, ce podcast ce veut technique et convivial.";
                data.Url = "http://devapps.be";
            }

            // Header for podcast
            else
            {
                data.Title = podcast.Summary.Title;
                data.Description = podcast.Summary.Description;
                data.Url = $"http://devapps.be/podcast/{podcast.PodcastID}";
            }

            return data;
        }

        /// <summary>
        /// <see cref="IDataService.GetPodcast(int)"/>
        /// </summary>
        /// <param name="podcastID"></param>
        /// <returns></returns>
        public Podcast GetPodcast(int podcastID)
        {
            return _allPodcasts.FirstOrDefault(i => i.PodcastID == podcastID);
        }

        /// <summary>
        /// <see cref="IDataService.GetPodcastID(string)"/>
        /// </summary>
        /// <param name="shortUrl"></param>
        /// <returns></returns>
        public int? GetPodcastID(string shortUrl)
        {
            return _allPodcasts.FirstOrDefault(i => String.Compare(i.PodcastKey, shortUrl, true) == 0)?.PodcastID;
        }

        /// <summary>
        /// <see cref="IDataService.GetSiteHeader"/>
        /// </summary>
        /// <returns></returns>
        public SocialInformation GetSiteHeader()
        {
            return this.GetSocialInformation(0);
        }

        /// <summary>
        /// <see cref="IDataService.WriteStatisticItem(int)"/>
        /// </summary>
        /// <param name="podcastID"></param>
        /// <param name="fileExtension"></param>
        public void WriteStatisticItem(int podcastID, string fileExtension)
        {
            Debug.WriteLine($"This podcast '{podcastID}'has been read.");
        }

        /// <summary>
        /// /
        /// </summary>
        /// <returns></returns>
        public IEnumerable<PodcastForStatistic> GetStatistics()
        {
            throw new NotImplementedException();
        }

        public void ClearCache()
        {
            throw new NotImplementedException();
        }
    }
}
