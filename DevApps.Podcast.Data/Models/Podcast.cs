using System;
using System.Web;

namespace DevApps.Podcast.Data.Models
{
    public class Podcast
    {
        private Configuration _configuration;

        public Podcast(Configuration configuration)
        {
            _configuration = configuration;
        }

        public int PodcastID { get; set; }
        public string PodcastKey { get; set; }
        public DateTime PublicationDate { get; set; }
        public PodcastSummary Summary { get; set; }
        public string Notes { get; set; }
        public PodcastAudio Audio { get; set; }
        public PodcastVideo Video { get; set; }

        public Uri PodcastUri
        {
            get
            {
                return new Uri(Configuration.WebSiteBaseUri, $"podcast/{this.PodcastKey}");
            }
        }
    }

    public class PodcastSummary
    {
        public PodcastSummary(Podcast podcast)
        {

        }

        public string Title { get; set; }
        public PodcastAuthor[] Authors { get; set; }
        public string Description { get; set; }
    }

    public class PodcastAuthor
    {
        public PodcastAuthor(Podcast podcast)
        {

        }
        public string Name { get; set; }
        public string Url { get; set; }
        public string Email { get; set; }
    }

    public class PodcastAudio : PodcastMedia
    {
        public PodcastAudio(Podcast podcast) : base(podcast)
        { }
    }

    public class PodcastVideo : PodcastMedia
    {
        public PodcastVideo(Podcast podcast) : base(podcast)
        { }

        public string YoutubeKey { get; set; }
    }

    public abstract class PodcastMedia
    {
        private Podcast _podcast;

        public PodcastMedia(Podcast podcast)
        {
            _podcast = podcast;
        }

        public string RemoteUrl { get; set; }

        public string PublicUrl
        {
            get
            {
                if (this is PodcastAudio)
                    return new Uri(Configuration.WebSiteBaseUri, $"File/Audio/{_podcast.PodcastKey}.mp3").ToString();
                else
                    return new Uri(Configuration.WebSiteBaseUri, $"File/Video/{_podcast.PodcastKey}.mp4").ToString();
            }
        }
        public uint Size { get; set; }

        public TimeSpan Duration { get; set; }

        public int Downloaded { get; set; }
    }
}
