using DevApps.Podcast.Data.ViewModels;
using System;
using System.Web.Mvc;

namespace DevApps.Podcast.Controllers
{
    public class PodcastController : ControllerBase
    {
        // GET: Podcast
        public ActionResult Index(string id)
        {            
            PodcastViewModel podcast = this.Locator.Podcast(id);            
            return View(podcast);
        }
    }
}