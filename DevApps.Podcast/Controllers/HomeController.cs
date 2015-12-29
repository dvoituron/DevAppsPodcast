using System;
using System.Web.Mvc;

namespace DevApps.Podcast.Controllers
{
    public class HomeController : ControllerBase
    {
        // GET: Home
        public ActionResult Index()
        {
            // Gets an instance of IoC DataService
            var home = this.Locator.Home;

            return View(home);
        }
    }
}