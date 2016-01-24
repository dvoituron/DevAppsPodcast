using DevApps.Podcast.Data.ViewModels;
using System;
using System.Web.Mvc;

namespace DevApps.Podcast.Controllers
{
    /// <summary>
    /// Manage the File streams
    /// </summary>
    public class FileController : ControllerBase
    {
        /// <summary>
        /// Returns the audio stream for the specified PodcastID or PodcastKey
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Audio(string id)
        {
            Data.Models.Podcast podcast = this.GetPodcast(id);
            this.Locator.DataService.WriteStatisticItem(podcast != null ? podcast.PodcastID : 0, "mp3");
            return new WebRequestFileResult(podcast.Audio.RemoteUrl);
        }

        /// <summary>
        /// Returns the video stream for the specified PodcastID or PodcastKey
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Video(string id)
        {
            Data.Models.Podcast podcast = this.GetPodcast(id);
            this.Locator.DataService.WriteStatisticItem(podcast != null ? podcast.PodcastID : 0, "mp4");
            return new WebRequestFileResult(podcast.Video.RemoteUrl);
        }

        /// <summary>
        /// Returns the associated Podcast
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        private Data.Models.Podcast GetPodcast(string id)
        {
            return this.Locator.Podcast(id.Replace(".mp3", string.Empty).Replace(".mp4", string.Empty))?.Podcast;
        }
    }
}
