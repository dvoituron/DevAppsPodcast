using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DevApps.Podcast.Data.ViewModels
{
    public class LogSummaryViewModel
    {
        public string Filename { get; set; }

        public long Total
        {
            get
            {
                return this.Mp3Views + this.Mp4Views + this.YoutubeViews;
            }
        }

        public long Mp3Views { get; set; }

        public long Mp4Views { get; set; }

        public long YoutubeViews { get; set; }
    }
}
