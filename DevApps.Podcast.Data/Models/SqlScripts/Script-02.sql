SET IDENTITY_INSERT dbo.Podcast ON
INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    13, --PodcastID 
    'intro_linq', -- PodcastKey
    '2016-01-20 21:00:00', -- PublicationDate
    'Linq: En partant des Predicats jusqu''au expressions Lambda.', -- SummaryTitle
    'Dans cet épisode, nous reprenons les concepts introduits dans le Framework 3.5 afin de disposer de la syntaxe Linq. Nous passons ainsi en revue les notions de types anonymes, d''inférence de type, de méthodes d''extension, d''expression Lambda, etc.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Voici quelques liens sur ASP.NET MVC et Arnaud.
      <ul>
        <li><a href="https://msdn.microsoft.com/en-us/library/bb397897.aspx" target="_blank">
            Introduction to LINQ (en anglais)</a></li>
        <li><a href="http://www.peug.net/2015/07/16/test-c-sharp-6-roslyn/" target="_blank">
            Essayer C# 6 avec TryRoslyn</a></li>
        <li><a href="http://linqjs.codeplex.com/" target="_blank">
            LINQ for JavaScript</a></li>
        <li><a href="http://dvoituron.com/2010/04/10/xml-linq/" target="_blank">
            LINQ To XML - un exemple simple</a></li>
      </ul>
      ', -- Notes
    'http://podcastdevapps.blob.core.windows.net/mp3/Podcast-13-Linq.mp3', -- AudioUrl
    46986971, -- AudioSize
    '00:48:56', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-13-Linq.mp4', -- VideoUrl
    127786908, -- VideoSize
    '00:48:56', -- VideoDuration
    'K95LzWcAnWo' -- VideoYoutubeKey
)
SET IDENTITY_INSERT dbo.Podcast OFF