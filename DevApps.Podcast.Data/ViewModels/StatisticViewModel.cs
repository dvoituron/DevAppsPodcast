using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DevApps.Podcast.Data.ViewModels
{
    public class StatisticViewModel : ViewModelBase
    {
        /// <summary>
        /// Initializes a new instance of HomeViewModel
        /// </summary>
        /// <param name="dataService"></
        public StatisticViewModel(Data.Models.IDataService dataService)
        {
            this.Configuration = dataService.Configuration;
            this.Header = dataService.GetSiteHeader();

            this.PodcastSummaries = dataService.GetStatistics();
        }

        /// <summary>
        /// Gets the current podcast
        /// </summary>
        public IEnumerable<Models.PodcastForStatistic> PodcastSummaries { get; private set; }
    }

}
