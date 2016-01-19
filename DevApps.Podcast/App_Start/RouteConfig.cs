using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace DevApps.Podcast
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
               name: "AzureLogs",
               url: "Logs/{action}",
               defaults: new { controller = "Logs" }
           );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{id}",  // "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "FileDownloader",
                url: "File/{action}/{id}",
                defaults: new { controller = "File", action = "Audio" }
            );
        }
    }
}
