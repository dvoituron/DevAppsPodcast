SET IDENTITY_INSERT dbo.Podcast ON
INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    21, --PodcastID 
    'microsoft_bot_framework_luis', -- PodcastKey
    '2016-07-13 20:00:00', -- PublicationDate
    'Skype, Facebook, Slack... Chat /me Bot.', -- SummaryTitle
    'Les bots sont des agents conversationnels. Ils sont conçus pour interagir avec des services existants tels que Skype, Facebook Messenger ou Slack. Dans cet épisode, Etienne nous explique à quoi ils servent, et comment configurer et développer notre premier Bot. Nous parlerons également de LUIS, le service de compréhension du langage, à connecter aux Bots.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Voici quelques liens sur les Microsoft Bots.
      <ul>
        <li><a href="https://dev.botframework.com" target="_blank">
            Présentation du Microsoft Bot Framework (Anglais)</a></li>
        <li><a href="https://azure.microsoft.com/fr-fr/services/cognitive-services/language-understanding-intelligence-service" target="_blank">
            Comprendre le service LUIS (Language Understanding Intelligence Service)</a></li>
        <li><a href="https://www.luis.ai" target="_blank">
            Développer votre service LUIS</a></li>
        <li><a href="https://experiences.microsoft.fr" target="_blank">
            MS Experience ''16 - Découvrez les tech.days repensés sur deux jours</a></li>
		<li><a href="http://www.devday.be" target="_blank">
            Dev Day 2016 - La journée des développeurs (Belgique)</a></li>
		<li><a href="https://twitter.com/meulta" target="_blank">
            @meulta - Pour contacter Etienne via Twitter</a></li>
	  </ul>
      ', -- Notes
    'http://podcastdevapps.blob.core.windows.net/mp3/Podcast-21-Bots.mp3', -- AudioUrl
    64362370, -- AudioSize
    '01:07:02', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-21-Bots.mp4', -- VideoUrl
    165046832, -- VideoSize
    '01:07:02', -- VideoDuration
    'c_hD3TWfPD4' -- VideoYoutubeKey
)
SET IDENTITY_INSERT dbo.Podcast OFF

INSERT INTO PodcastAuthorLink VALUES(21, 1)
INSERT INTO PodcastAuthorLink VALUES(21, 2)
INSERT INTO PodcastAuthorLink VALUES(21, 7)