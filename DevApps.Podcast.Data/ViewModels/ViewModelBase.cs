using DevApps.Podcast.Data.Models;
using System;
using System.Linq;

namespace DevApps.Podcast.Data.ViewModels
{
    public abstract class ViewModelBase
    {
        /// <summary>
        /// Gets the Header data with Social Informations 
        /// </summary>
        public Models.SocialInformation Header { get; protected set; }

        /// <summary>
        /// Gets the Configuration parameters
        /// </summary>
        public Models.Configuration Configuration { get; protected set; }

    }
}
