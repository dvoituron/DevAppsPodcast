using DevApps.Podcast.Models;
using System.Web.Mvc;

namespace DevApps.Podcast.Controllers
{
    /// <summary>
    /// Definition of a ControllerBase with a Locator property to find all referenced ViewModels
    /// </summary>
    public abstract class ControllerBase : Controller
    {
        /// <summary>
        /// Gets the View Model Locator
        /// </summary>
        public UnityLocator Locator
        {
            get
            {
                return DependencyResolver.Current.GetService<UnityLocator>();
            }
        }
    }
}
