SET IDENTITY_INSERT dbo.PodcastAuthor ON
INSERT INTO dbo.PodcastAuthor(PodcastAuthorID, Name, EMail, Url)
       VALUES (12, 'Jonathan Antoine', '', 'https://twitter.com/jmix90')
SET IDENTITY_INSERT dbo.PodcastAuthor OFF

SET IDENTITY_INSERT dbo.Podcast ON
INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    20, --PodcastID 
    'hololens_developpement_du_futur', -- PodcastKey
    '2016-06-23 10:00:00', -- PublicationDate
    'Hololens - Comment développer dans le futur de Microsoft ?', -- SummaryTitle
    'Il y a quelques mois, Microsoft nous présentais ses lunettes de réalité augmentée. Jonathan Antoine, de InfiniteSquare, est venu nous les présenter : réalité virtuelle ou augmentée ? De quoi se compose ce matériel ? Comment y développer des Apps et des hologrammes ? Avec Visual Studio ? Quel est le marché ciblé par Microsoft ? Voilà autant de questions abordées dans ce nouvel épisode.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Voici quelques liens sur les Hololens.
      <ul>
        <li><a href="https://www.microsoft.com/microsoft-hololens" target="_blank">
            Présentation officielle des Hololens</a></li>
        <li><a href="https://www.youtube.com/channel/UCT2rZIAL-zNqeK1OmLLUa6g" target="_blank">
            Microsoft Hololens en vidéo (YouTube)</a></li>
        <li><a href="https://www.microsoft.com/microsoft-hololens/en-us/developers" target="_blank">
            Démarrer vos développements Hololens</a></li>
        <li><a href="https://developer.microsoft.com/en-us/windows/holographic/using_the_hololens_emulator" target="_blank">
            Utiliser l''émulateur Hololens</a></li>
		<li><a href="http://unity3d.com/pages/windows/hololens" target="_blank">
            Unity pour Microsoft Hololens</a></li>
		<li><a href="http://blogs.infinitesquare.com/b/jonathan" target="_blank">
            Blog InfiniteSquare de Jonathan (français)</a></li>
	  </ul>
      ', -- Notes
    'http://podcastdevapps.blob.core.windows.net/mp3/Podcast-20-Hololens.mp3', -- AudioUrl
    58730788, -- AudioSize
    '01:01:10', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-20-Hololens.mp4', -- VideoUrl
    360182512, -- VideoSize
    '01:01:10', -- VideoDuration
    '8z5pxK9ewq0' -- VideoYoutubeKey
)
SET IDENTITY_INSERT dbo.Podcast OFF

INSERT INTO PodcastAuthorLink VALUES(20, 1)
INSERT INTO PodcastAuthorLink VALUES(20, 2)
INSERT INTO PodcastAuthorLink VALUES(20, 12)