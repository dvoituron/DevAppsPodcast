using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DevApps.Podcast.Data.ViewModels
{
    public class HomeViewModel : ViewModelBase
    {
        /// <summary>
        /// Initializes a new instance of HomeViewModel
        /// </summary>
        /// <param name="dataService"></
        public HomeViewModel(Data.Models.IDataService dataService)
        {
            this.Configuration = dataService.Configuration;
            this.Header = dataService.GetSiteHeader();
            this.Podcasts = dataService.GetLastPodcasts();
        }

        /// <summary>
        /// Gets all last podcasts
        /// </summary>
        public IEnumerable<Models.Podcast> Podcasts { get; private set; }
    }
}
