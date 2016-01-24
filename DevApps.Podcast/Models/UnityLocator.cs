using Microsoft.Practices.Unity;
using DevApps.Podcast.Data.Models;
using DevApps.Podcast.Data.ViewModels;

namespace DevApps.Podcast.Models
{
    /// <summary>
    /// View Model Locator used by ControllerBase.Locator property
    /// </summary>
    public class UnityLocator
    {
        private UnityContainer _container = new UnityContainer();

        /// <summary>
        /// Initializes a new instance of UnityLocator
        /// </summary>
        public UnityLocator()
        {
            // Self registration to use it later
            _container.RegisterInstance<UnityLocator>(this);

            // Registration of DataService 
            //_container.RegisterType<IDataService, DesignDataService>();
            _container.RegisterType<IDataService, SqlDataService>();

            // Registration of all ViewModels
            _container.RegisterType<HomeViewModel>();
            _container.RegisterType<PodcastViewModel>();
            _container.RegisterType<FeedsViewModel>();
            _container.RegisterType<StatisticViewModel>();
        }

        /// <summary>
        /// Gets the Home ViewModel
        /// </summary>
        public HomeViewModel Home
        {
            get
            {
                return _container.Resolve<HomeViewModel>();
            }
        }

        /// <summary>
        /// Gets the Home ViewModel
        /// </summary>
        public PodcastViewModel Podcast(string shortUrl)
        {
            return _container.Resolve<PodcastViewModel>(new ParameterOverride("shortUrl", shortUrl));
        }

        /// <summary>
        /// Gets the Feeds ViewModel (Audio and Video)
        /// </summary>
        public FeedsViewModel Feeds
        {
            get
            {
                return _container.Resolve<FeedsViewModel>();
            }
        }

        /// <summary>
        /// Gets the Feeds ViewModel (Audio and Video)
        /// </summary>
        public StatisticViewModel Statistics
        {
            get
            {
                return _container.Resolve<StatisticViewModel>();
            }
        }

        /// <summary>
        /// Gets a reference to the DataService
        /// </summary>
        public IDataService DataService
        {
            get
            {
                return _container.Resolve<IDataService>();
            }

        }
        /// <summary>
        /// Gets a reference to the UnityDependencyResolver
        /// </summary>
        public UnityDependencyResolver UnityDependencyResolver
        {
            get
            {
                return new UnityDependencyResolver(_container);
            }
        }
    }
}
