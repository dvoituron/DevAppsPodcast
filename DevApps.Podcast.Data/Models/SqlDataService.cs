using Apps72.Dev.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace DevApps.Podcast.Data.Models
{
    /// <summary>
    /// Service to retrieve all data
    /// </summary>
    public class SqlDataService : IDataService
    {
        private readonly string _connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DevAppsConnectionString"].ConnectionString;
        private static Configuration _configuration = null;
        private static SocialInformation _siteHeader = null;
        private static IEnumerable<Podcast> _podcasts = null;

        /// <summary>
        /// <see cref="IDataService.Configuration"/>
        /// </summary>
        public Configuration Configuration
        {
            get
            {
                this.LoadConfigurationAndHeaders();
                return _configuration;
            }
        }

        /// <summary>
        /// <see cref="IDataService.Version"/>
        /// </summary>
        public Version Version
        {
            get
            {
                return this.Configuration.Version;
            }
        }

        /// <summary>
        /// <see cref="IDataService.GetLastPodcasts"/>
        /// </summary>
        public IEnumerable<Podcast> GetLastPodcasts()
        {
            if (_podcasts == null)
                _podcasts = this.GetLastPodcastsFromDatabase();

            return _podcasts;
        }

        /// <summary>
        /// <see cref="IDataService.GetPodcast(int)"/>
        /// </summary>
        public Podcast GetPodcast(int podcastID)
        {
            Podcast podcast = _podcasts?.FirstOrDefault(i => i.PodcastID == podcastID);

            if (podcast != null)
                return podcast;
            else
                return this.GetLastPodcastsFromDatabase(podcastID)?.FirstOrDefault();
        }

        /// <summary>
        /// <see cref="IDataService.GetPodcastID(string)"/>
        /// </summary>
        /// <param name="shortUrl"></param>
        /// <returns></returns>
        public int? GetPodcastID(string shortUrl)
        {
            Podcast podcast = _podcasts?.FirstOrDefault(i => i.PodcastKey == shortUrl);

            if (podcast != null)
                return podcast.PodcastID;
            else
            {
                using (SqlDatabaseCommand cmd = this.GetDatabaseCommand())
                {
                    cmd.CommandText.AppendLine(" SELECT PodcastID FROM Podcast WHERE PodcastKey = @Key ");
                    cmd.Parameters.AddWithValue("@Key", shortUrl);
                    return cmd.ExecuteScalar<int?>();
                }
            }
        }

        /// <summary>
        /// <see cref="IDataService.GetSiteHeader"/>
        /// </summary>
        /// <returns></returns>
        public SocialInformation GetSiteHeader()
        {
            this.LoadConfigurationAndHeaders();
            return _siteHeader;
        }

        public SocialInformation GetSocialInformation(int podcastID)
        {
            this.LoadConfigurationAndHeaders();

            // Global social information
            SocialInformation socialInformation = new SocialInformation()
            {
                Name = _siteHeader.Name,
                Authors = _siteHeader.Authors,
                Language = _siteHeader.Language,
                GoogleAnalyticsKey = _siteHeader.GoogleAnalyticsKey,
                TwitterUrl = _siteHeader.TwitterUrl,
                TwitterAccount = _siteHeader.TwitterAccount,
                CopyrightName = _siteHeader.CopyrightName,
                CopyrightUrl = _siteHeader.CopyrightUrl,
                CopyrightEmail = _siteHeader.CopyrightEmail,
                CategoriesKeywords = _siteHeader.CategoriesKeywords,
                ImageUrl = _siteHeader.ImageUrl,
                Creator = _siteHeader.Creator,
                FeedAudioUrl = _siteHeader.FeedAudioUrl,
                FeedVideoUrl = _siteHeader.FeedVideoUrl,
                FeedTitle = _siteHeader.FeedTitle
            };

            // Custom social information
            Podcast podcast = this.GetPodcast(podcastID);
            socialInformation.Title = podcast.Summary.Title;
            socialInformation.Description = podcast.Summary.Description;
            socialInformation.Url = podcast.PodcastUri.ToString();

            return socialInformation;
        }

        /// <summary>
        /// Returns a SqlDatabaseCommand to execute SQL Queries with ConnectionString included in web.config
        /// </summary>
        /// <returns></returns>
        private SqlDatabaseCommand GetDatabaseCommand()
        {
            return new SqlDatabaseCommand(_connectionString);
        }

        /// <summary>
        /// Load all configurations parameters et Header values
        /// </summary>
        private void LoadConfigurationAndHeaders()
        {
            if (_configuration == null)
                _configuration = new Configuration();

            if (_siteHeader == null)
                _siteHeader = new SocialInformation();

            using (SqlDatabaseCommand cmd = this.GetDatabaseCommand())
            {
                // Gets all configuration values
                cmd.CommandText.AppendLine(" SELECT Name, Value FROM Configuration ");
                var allConfigValues = cmd.ExecuteTable((row) =>
                {
                    return new
                    {
                        Name = row.Field<string>("Name"),
                        Value = row.Field<string>("Value")
                    };
                });

                // Filtering Name / Value
                foreach (var item in allConfigValues)
                {
                    switch (item.Name)
                    {
                        case "MaximumOfPodcastsOnHomePage":
                            _configuration.MaximumOfPodcastsOnHomePage = Int32.Parse(item.Value);
                            break;
                        case "DisqusShortnameKey":
                            _configuration.DisqusShortnameKey = item.Value;
                            break;
                        case "SiteUrl":
                            _configuration.SiteUrl = new Uri(item.Value);
                            _siteHeader.Url = item.Value;
                            break;
                        case "Version":
                            _configuration.Version = new Version(item.Value);
                            break;
                        case "AzureStorageCredentials":
                            string[] splitted = item.Value.Split(';');
                            _configuration.AzureStorageCredentials = new KeyValuePair<string, string>(splitted[0], splitted[1]);
                            break;
                        case "SiteName":
                            _siteHeader.Title = item.Value;
                            _siteHeader.Name = item.Value;
                            break;
                        case "SiteDescription":
                            _siteHeader.Description = item.Value;
                            break;
                        case "SiteAuthor":
                            _siteHeader.Authors = item.Value;
                            break;
                        case "SiteLanguage":
                            _siteHeader.Language = item.Value;
                            break;
                        case "GoogleAnalyticsKey":
                            _siteHeader.GoogleAnalyticsKey = item.Value;
                            break;
                        case "TwitterUrl":
                            _siteHeader.TwitterUrl = item.Value;
                            break;
                        case "TwitterAccount":
                            _siteHeader.TwitterAccount = item.Value;
                            break;
                        case "CopyrightName":
                            _siteHeader.CopyrightName = item.Value;
                            break;
                        case "CopyrightUrl":
                            _siteHeader.CopyrightUrl = item.Value;
                            break;
                        case "CopyrightEmail":
                            _siteHeader.CopyrightEmail = item.Value;
                            break;
                        case "CategoriesKeywords":
                            _siteHeader.CategoriesKeywords = item.Value;
                            break;
                        case "ImageUrl":
                            _siteHeader.ImageUrl = item.Value;
                            break;
                        case "Creator":
                            _siteHeader.Creator = item.Value;
                            break;
                        case "FeedAudioUrl":
                            _siteHeader.FeedAudioUrl = item.Value;
                            break;
                        case "FeedVideoUrl":
                            _siteHeader.FeedVideoUrl = item.Value;
                            break;
                        case "FeedTitle":
                            _siteHeader.FeedTitle = item.Value;
                            break;
                    }
                }
            }
        }

        /// <summary>
        /// Returns the N last podcasts.
        /// </summary>
        /// <returns></returns>
        private IEnumerable<Podcast> GetLastPodcastsFromDatabase()
        {
            return this.GetLastPodcastsFromDatabase(0);
        }

        /// <summary>
        /// Returns only the specified podcast
        /// </summary>
        /// <param name="podcastID"></param>
        /// <returns></returns>
        private IEnumerable<Podcast> GetLastPodcastsFromDatabase(int podcastID)
        {
            int maxRows = Configuration.MaximumOfPodcastsOnHomePage;

            using (SqlDatabaseCommand cmd = this.GetDatabaseCommand())
            {
                string onlyOnePodcast = podcastID > 0 ? $" AND PodcastID = {podcastID}" : String.Empty;

                // Search all authors for last podcasts
                cmd.Clear();
                cmd.CommandText.AppendLine($" SELECT PodcastID, Name, Url ");
                cmd.CommandText.AppendLine($"   FROM PodcastAuthor ");
                cmd.CommandText.AppendLine($"  INNER JOIN PodcastAuthorLink ON PodcastAuthorLink.PodcastAuthorID = PodcastAuthor.PodcastAuthorID ");
                cmd.CommandText.AppendLine($"  WHERE PodcastAuthorLink.PodcastID IN (SELECT TOP {maxRows} PodcastID FROM Podcast ORDER BY PublicationDate DESC) ");
                cmd.CommandText.AppendLine(onlyOnePodcast);

                var authors = cmd.ExecuteTable((row) =>
                {
                    return new
                    {
                        PodcastID = row.Field<int>("PodcastID"),
                        Name = row.Field<string>("Name"),
                        Url = row.Field<string>("Url"),
                    };
                });

                // Select last podcasts
                cmd.Clear();
                cmd.CommandText.AppendLine($" SELECT TOP {maxRows} * ");
                cmd.CommandText.AppendLine($"   FROM Podcast ");
                cmd.CommandText.AppendLine($"  WHERE 1=1 " + onlyOnePodcast);
                cmd.CommandText.AppendLine($"  ORDER BY PublicationDate DESC ");

                return cmd.ExecuteTable((row) =>
                {
                    int id = row.Field<int>("PodcastID");

                    Podcast podcast = new Podcast(this.Configuration);
                    podcast.PodcastID = id;
                    podcast.PodcastKey = row.Field<string>("PodcastKey");
                    podcast.PublicationDate = row.Field<DateTime>("PublicationDate");
                    podcast.Summary = new PodcastSummary(podcast)
                    {
                        Title = row.Field<string>("SummaryTitle"),
                        Description = row.Field<string>("SummaryDescription"),
                        Authors = authors.Where(i => i.PodcastID == id)
                                         .OrderBy(i => i.Name)
                                         .Select(i => new PodcastAuthor(podcast)
                                         {
                                             Name = i.Name,
                                             Email = String.Empty,
                                             Url = i.Url
                                         })
                                         .ToArray()
                    };
                    podcast.Notes = row.Field<string>("Notes");
                    podcast.Audio = new PodcastAudio(podcast)
                    {
                        RemoteUrl = row.Field<string>("AudioUrl"),
                        Size = (uint)row.Field<int>("AudioSize"),
                        Duration = row.Field<TimeSpan>("AudioDuration"),
                    };
                    podcast.Video = new PodcastVideo(podcast)
                    {
                        RemoteUrl = row.Field<string>("VideoUrl"),
                        Size = (uint)row.Field<int>("VideoSize"),
                        Duration = row.Field<TimeSpan>("VideoDuration"),
                        YoutubeKey = row.Field<string>("VideoYoutubeKey"),
                    };

                    return podcast;
                });

            }
        }
    }
}
