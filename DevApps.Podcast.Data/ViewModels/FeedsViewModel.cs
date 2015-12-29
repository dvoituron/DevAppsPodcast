using System;
using System.Collections.Generic;
using System.Linq;
using DevApps.Podcast.Data.Models;

namespace DevApps.Podcast.Data.ViewModels
{
    public class FeedsViewModel : ViewModelBase
    {
        private const string _rssVersion = "2.0";   // RSS Version
        private const byte _ttl = 30;               // Default TimeToLive (30 minutes)

        /// <summary>
        /// Initializes a new instance of FeedsViewModel
        /// </summary>
        /// <param name="dataService"></param>
        public FeedsViewModel(Data.Models.IDataService dataService)
        {
            this.Header = dataService.GetSiteHeader();
            this.Configuration = dataService.Configuration;
            this.Podcasts = dataService.GetLastPodcasts();
        }

        /// <summary>
        /// Gets all last podcasts
        /// </summary>
        public IEnumerable<Models.Podcast> Podcasts { get; private set; }

        /// <summary>
        /// Gets the Audio feed
        /// </summary>
        /// <returns></returns>
        public rss GetAudioFeed()
        {
            return this.GetFeed(isAudio: true);
        }

        /// <summary>
        /// Gets the Audio feed
        /// </summary>
        /// <returns></returns>
        public rss GetVideoFeed()
        {
            return this.GetFeed(isAudio: false);
        }

        /// <summary>
        /// Gets the RSS feed
        /// </summary>
        /// <returns></returns>
        private rss GetFeed(bool isAudio)
        {
            rss root = new rss() { version = _rssVersion };

            Models.Podcast lastPodcast = this.Podcasts.OrderByDescending(i => i.PublicationDate).FirstOrDefault();

            root.channel = new rssChannel()
            {
                ttl = _ttl,
                title = this.Header.Title,
                link = this.Header.Url,
                language = this.Header.Language,
                description = this.Header.Description,
                copyright = $"Copyright {DateTime.Today:yyyy} - {this.Header.CopyrightName}",
                managingEditor = $"{this.Header.CopyrightEmail} ({this.Header.CopyrightName})",
                webMaster = $"{this.Header.CopyrightEmail} ({this.Header.CopyrightName})",
                pubDate = lastPodcast.PublicationDate.ToPodcastDateTimeString(),
                lastBuildDate = lastPodcast.PublicationDate.ToPodcastDateTimeString(),
                link1 = new link()
                {
                    href = (isAudio ? this.Header.FeedAudioUrl : this.Header.FeedVideoUrl),
                    rel = "self",
                    type = "application/rss+xml"
                },
                image = new rssChannelImage()
                {
                    url = this.Header.ImageUrl,
                    title = this.Header.Title,
                    link = this.Header.Url,
                    width = 144,
                    height = 400,
                    description = this.Header.Description
                },
                category = this.GetCategories(),
                subtitle = this.Header.Description,
                @explicit = "no",
                author = this.Header.Authors,
                summary = this.Header.Description,
                owner = new owner()
                {
                    name = this.Header.Authors,
                    email = this.Header.CopyrightEmail
                },
                image1 = new image() { href = this.Header.ImageUrl },
                category1 = this.GetCategoriesKeyValue().ToArray(),
                item = this.GetListOfPodcasts(isAudio)
            };

            return root;
        }

        /// <summary>
        /// Returns the list of category keys.
        /// </summary>
        /// <returns></returns>
        public string[] GetCategories()
        {
            return this.Header.CategoriesKeywords.Split(';')
                            .Select(i => i.IndexOf('=') > 0 ? i.Split('=')[0] : i)
                            .Distinct()
                            .ToArray();
        }

        /// <summary>
        /// Returns the list of categories
        /// </summary>
        /// <returns></returns>
        private IEnumerable<category> GetCategoriesKeyValue()
        {
            var categories = this.Header.CategoriesKeywords.Split(';')
                                .Select(i => i.IndexOf('=') > 0 ? new { Key = i.Split('=')[0], Value = i.Split('=')[1] } : null)
                                .Where(i => i != null)
                                .Distinct()
                                .ToArray();

            return categories.Select(i => new category()
                    {
                        text = i.Key,
                        category1 = new categoryCategory() { text = i.Value }
                    });
        }

        /// <summary>
        /// Returns the list of podcats properties
        /// </summary>
        /// <param name="isAudio">audio or video feed</param>
        /// <returns></returns>
        private rssChannelItem[] GetListOfPodcasts(bool isAudio)
        {
            List<rssChannelItem> items = new List<rssChannelItem>();

            foreach (Models.Podcast podcast in this.Podcasts.OrderByDescending(i => i.PublicationDate))
            {
                string podcastUrl = podcast.PodcastUri.AbsoluteUri;

                rssChannelItem item = new rssChannelItem()
                {
                    title = podcast.Summary.Title,
                    link = podcastUrl,
                    pubDate = podcast.PublicationDate.ToPodcastDateTimeString(),
                    description = podcast.Summary.Description,
                    source = new rssChannelItemSource() { url = podcastUrl, Value = podcast.Summary.Title },
                    guid = new rssChannelItemGuid() { isPermaLink = true, Value = podcastUrl },
                    author = podcast.Summary.Authors.GetAuthorsAsText(),
                    subtitle = this.Header.Description,
                    summary = podcast.Summary.Description,
                };

                if (isAudio)
                {
                    item.enclosure = new rssChannelItemEnclosure()
                    {
                        url = podcast.Audio.PublicUrl,
                        type = "audio/mp3",
                        length = podcast.Audio.Size
                    };
                    item.duration = podcast.Audio.Duration.ToPodcastTimeString();
                }
                else
                {
                    item.enclosure = new rssChannelItemEnclosure()
                    {
                        url = podcast.Video.PublicUrl,
                        type = "video/mp4",
                        length = podcast.Video.Size
                    };
                    item.duration = podcast.Video.Duration.ToPodcastTimeString();
                }

                items.Add(item);
            }

            return items.ToArray();
        }
    }
}
