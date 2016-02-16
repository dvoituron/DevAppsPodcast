SET IDENTITY_INSERT dbo.PodcastAuthor ON
INSERT INTO dbo.PodcastAuthor(PodcastAuthorID, Name, EMail, Url)
       VALUES (7, 'Etienne Margraff', '', 'https://twitter.com/meulta')
SET IDENTITY_INSERT dbo.PodcastAuthor OFF

SET IDENTITY_INSERT dbo.Podcast ON
INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    14, --PodcastID 
    'vorlonjs', -- PodcastKey
    '2016-02-16 22:00:00', -- PublicationDate
    'Vorlon.js - Le debugger Html/JavaScript distant et multiplateforme.', -- SummaryTitle
    'Aujourd''hui, Etienne Margraff, leader de l''équipe de développement vient nous expliquer la genèse de Vorlon.js et répondre à nos questions : a quoi ça sert, comment l''installer, comment l''utiliser et comment l''étendre via les plugins ?', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Voici quelques liens sur Vorlon.js.
      <ul>
        <li><a href="http://vorlonjs.io/" target="_blank">
            Vorlonjs.io - Le site pour commencer (démo, tuto, doc, ...)</a></li>
        <li><a href="http://vorlonjs.io/documentation/" target="_blank">
            La documentation de Vorlon.js</a></li>
		<li><a href="https://channel9.msdn.com/Shows/codechat/046" target="_blank">
            [Vidéo] CodeChat - Use Vorlon.js for Awesome Remote Debugging Webpages (en anglais)</a></li>
        <li><a href="https://github.com/MicrosoftDX/Vorlonjs" target="_blank">
            GirHub - Pour accéder au code source</a></li>
		<li><a href="https://twitter.com/meulta" target="_blank">
            @meulta - Pour contacter Etienne via Twitter</a></li>
      </ul>
      ', -- Notes
    'http://podcastdevapps.blob.core.windows.net/mp3/Podcast-14-VorlonJS.mp3', -- AudioUrl
    60862380, -- AudioSize
    '01:03:23', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-14-VorlonJS.mp4', -- VideoUrl
    169121869, -- VideoSize
    '01:03:23', -- VideoDuration
    'C3MQXQBN7Cc' -- VideoYoutubeKey
)
SET IDENTITY_INSERT dbo.Podcast OFF

INSERT INTO PodcastAuthorLink VALUES(14, 1)
INSERT INTO PodcastAuthorLink VALUES(14, 2)
INSERT INTO PodcastAuthorLink VALUES(14, 7)