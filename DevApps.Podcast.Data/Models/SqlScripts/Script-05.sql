SET IDENTITY_INSERT dbo.PodcastAuthor ON
INSERT INTO dbo.PodcastAuthor(PodcastAuthorID, Name, EMail, Url)
       VALUES (8, 'Michel Lopez', '', 'https://twitter.com/from_michel')
SET IDENTITY_INSERT dbo.PodcastAuthor OFF

SET IDENTITY_INSERT dbo.Podcast ON
INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    15, --PodcastID 
    'windowsappstudio', -- PodcastKey
    '2016-03-01 22:00:00', -- PublicationDate
    'Windows App Studio - Transformez votre idée en application Windows en un temps record.', -- SummaryTitle
    'Michel Lopez, le Program Manager de Microsoft nous décrit Windows App Studio, Il s''agit d''un outil de création d''application en ligne gratuit qui vous permet de créer rapidement des applications Windows et Windows Mobile que vous pouvez ensuite publier, tester et partager. Et si vous souhaitez utiliser des fonctionnalités de programmation avancées, Windows App Studio génère le code source utilisable dans Visual Studio.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Voici quelques liens sur Windows App Studio.
      <ul>
        <li><a href="http://appstudio.windows.com/fr-fr" target="_blank">
            Windows App Studio - Le site pour commencer et pour créer vos applications.</a></li>
        <li><a href="https://github.com/wasteam/waslibs" target="_blank">
            WAS Libs - Les bibliothèques utilisées par Windows App Studio, pour étendre vos apps dans Visual Studio.</a></li>
		<li><a href="https://www.microsoft.com/store/apps/9nblggh6cplt" target="_blank">
            Windows AppStudio Collections, pour modifier les données de vos collections définis Windows App Studio.</a></li>
        <li><a href="http://appstudio.windows.com/en-us/home/howto#wordPress" target="_blank">
            Documentation - Configurer les sources de données (ex. WordPress).</a></li>
		<li><a href="https://wpdev.uservoice.com/forums/216486-windows-app-studio/filters/top" target="_blank">
            UserVoice - Améliorer Windows App Studio.</a></li>
		<li><a href="https://twitter.com/hashtag/WindowsAppStudio" target="_blank">
            #WindowsAppStudio - Le HashTag pour contacter l''équipe.</a></li>
      </ul>
      ', -- Notes
    'http://podcastdevapps.blob.core.windows.net/mp3/Podcast-15-AppStudio.mp3', -- AudioUrl
    91218755, -- AudioSize
    '01:35:01', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-15-AppStudio.mp4', -- VideoUrl
    237003013, -- VideoSize
    '01:35:01', -- VideoDuration
    'e0vbIOtSwmM' -- VideoYoutubeKey
)
SET IDENTITY_INSERT dbo.Podcast OFF

INSERT INTO PodcastAuthorLink VALUES(15, 1)
INSERT INTO PodcastAuthorLink VALUES(15, 2)
INSERT INTO PodcastAuthorLink VALUES(15, 8)