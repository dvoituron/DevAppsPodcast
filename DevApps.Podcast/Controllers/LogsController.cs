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
    }
}