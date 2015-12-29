using System.Web.Mvc;
using System.Web.Routing;

namespace DevApps.Podcast
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            // Create and register the IoC Unity resolver
            DependencyResolver.SetResolver(new Models.UnityLocator().UnityDependencyResolver);

            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }
    }
}
