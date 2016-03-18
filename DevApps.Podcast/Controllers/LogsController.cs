using DevApps.Podcast.Data.Models;
using DevApps.Podcast.Data.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DevApps.Podcast.Controllers
{
    public class LogsController : ControllerBase
    {
        // GET: Podcast
        public ActionResult Summary()
        {
            var logItemsGrouped = from i in this.Locator.Statistics.PodcastSummaries
                                  group i by i.PodcastID into g
                                  select new LogSummaryViewModel()
                                  {
                                      Filename = $"{g.First().PodcastID:000}. {g.First().SummaryTitle}",
                                      Mp3Views = g.First(i => i.FileType == "mp3").Downloaded,
                                      Mp4Views = g.First(i => i.FileType == "mp4").Downloaded,
                                      YoutubeViews = g.First(i => i.FileType == "youtube").Downloaded
                                  };

            ViewBag.StartDate = DateTime.Now;
            return View(logItemsGrouped.OrderBy(i => i.Filename).ToArray());
        }

        // GET: Podcast
        public ActionResult Summary2()
        {
            AzureLogs logs = new AzureLogs(this.Locator.Home.Configuration);

            logs.OnlyForExtensions.Add("mp3");
            logs.OnlyForExtensions.Add("mp4");

            // Download all log files
            // TODO: To optimized
            var logItems = logs.GetLogItems();
            //var logItems = logs.GetLogItems(new DateTime(2016, 01, 01));

            var logItemsGrouped = from i in logItems
                                  group i by i.RequestFilename.Replace(".mp3", "").Replace(".mp4", "") into g
                                  select new LogSummaryViewModel()
                                  {
                                      Filename = g.Key,
                                      Mp3Views = g.Count(i => i.RequestedObjectKey.EndsWith(".mp3")),
                                      Mp4Views = g.Count(i => i.RequestedObjectKey.EndsWith(".mp4"))
                                  };

            ViewBag.StartDate = logItems.Min(i => i.RequestStartTime);
            return View(logItemsGrouped.OrderBy(i => i.Filename).ToArray());
        }

        /// <summary>
        /// Clear all data stored in cached objects.
        /// </summary>
        /// <returns></returns>
        public ActionResult ClearCache()
        {
            this.Locator.DataService.ClearCache();
            return View();
        }
    }
}