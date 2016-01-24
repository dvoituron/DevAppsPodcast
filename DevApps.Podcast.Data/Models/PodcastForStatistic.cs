using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DevApps.Podcast.Data.Models
{
    public class PodcastForStatistic
    {
        public string SummaryTitle { get; set; }
        public int PodcastID { get; set; }
        public string FileType { get; set; }
        public long Downloaded { get; set; }
    }
}
