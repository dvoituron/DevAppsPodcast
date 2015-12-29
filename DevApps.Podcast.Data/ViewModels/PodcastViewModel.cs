using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DevApps.Podcast.Data.ViewModels
{
    public class PodcastViewModel : ViewModelBase
    {
        /// <summary>
        /// Initializes a new instance of PodcastViewModel
        /// </summary>
        /// <param name="dataService"></
        public PodcastViewModel(Data.Models.IDataService dataService, string shortUrl)
        {
            int id = 0;

            // If the parameter is NOT an numeric ID,
            // Find the #ID associated to this key
            if (!Int32.TryParse(shortUrl, out id))
            {
                int? idFound = dataService.GetPodcastID(shortUrl);
                id = idFound.HasValue ? idFound.Value : 0;
            }

            if (id > 0)
            {
                this.Header = dataService.GetSocialInformation(id);
                this.Configuration = dataService.Configuration;
                this.Podcast = dataService.GetPodcast(id);
            }
        }

        /// <summary>
        /// Gets the current podcast
        /// </summary>
        public Models.Podcast Podcast { get; private set; }
    }
}
