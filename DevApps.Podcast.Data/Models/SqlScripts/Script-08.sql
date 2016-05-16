SET IDENTITY_INSERT dbo.PodcastAuthor ON
INSERT INTO dbo.PodcastAuthor(PodcastAuthorID, Name, EMail, Url)
       VALUES (11, 'Thomas Lebrun', '', 'https://twitter.com/thomas_lebrun')
SET IDENTITY_INSERT dbo.PodcastAuthor OFF

SET IDENTITY_INSERT dbo.Podcast ON
INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    18, --PodcastID 
    'intro_xamarin_win_ios_android', -- PodcastKey
    '2016-05-16 19:00:00', -- PublicationDate
    'Xamarin - Créer vos Apps Windows, iOS et Android en C#', -- SummaryTitle
    'Il y a quelques semaines, Microsoft a racheté la société Xamarin et son écosystème. Nous avons pensé que c''était le bon moment pour présenter ce qu''est Xamarin et comment mettre en place un premier projet multi-plateforme (iOS, Android et Windows). Pendant plus d''une heure, Thomas Lebrun nous apporte sa connaissance et son expérience dans la création de projets Xamarin.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Voici quelques liens sur Xamarin.
      <ul>
        <li><a href="https://www.xamarin.com" target="_blank">
            La société Xamarin</a></li>
        <li><a href="https://www.xamarin.com/microsoft/" target="_blank">
            Xamarin et Microsoft.</a></li>
        <li><a href="https://developer.xamarin.com" target="_blank">
            Apprendre avec Xamarin University</a></li>
		<li><a href="https://store.xamarin.com/" target="_blank">
            Xamarin est gratuit</a></li>
		<li><a href="http://blog.thomaslebrun.net/" target="_blank">
            Blog personnel de Thomas (anglais)</a></li>
		<li><a href="http://blogs.infinitesquare.com/b/tom" target="_blank">
            Blog InfiniteSquare de Thomas (français)</a></li>
	  </ul>
      ', -- Notes
    'http://podcastdevapps.blob.core.windows.net/mp3/Podcast-18-Xamarin.mp3', -- AudioUrl
    76291761, -- AudioSize
    '01:19:28', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-18-Xamarin.mp4', -- VideoUrl
    205229582, -- VideoSize
    '01:19:28', -- VideoDuration
    'YmCoJdNNWNg' -- VideoYoutubeKey
)
SET IDENTITY_INSERT dbo.Podcast OFF

INSERT INTO PodcastAuthorLink VALUES(18, 1)
INSERT INTO PodcastAuthorLink VALUES(18, 2)
INSERT INTO PodcastAuthorLink VALUES(18, 11)