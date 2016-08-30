SET IDENTITY_INSERT dbo.PodcastAuthor ON
INSERT INTO dbo.PodcastAuthor(PodcastAuthorID, Name, EMail, Url)
       VALUES (13, 'Maxime Frappat', '', 'https://twitter.com/maximefrappat')
SET IDENTITY_INSERT dbo.PodcastAuthor OFF

SET IDENTITY_INSERT dbo.Podcast ON
INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    22, --PodcastID 
    'unity_3d_maxime_frappat', -- PodcastKey
    '2016-08-11 21:00:00', -- PublicationDate
    'Créer vos jeux avec Unity3D et C#', -- SummaryTitle
    'Après un précédent podcast sur les hologrammes de Hololens, il nous semblait indispensable d''interroger un spécialiste de Unity3D pour nous présenter ce framework de jeux vidéo. En moins de 1h15, Maxime Frappat nous présente Unity et fait même courir et sauter, un personnage virtuel.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Voici quelques liens sur Unity3D.
      <ul>
        <li><a href="http://unity3d.com/" target="_blank">
            Pour commencer avec Unity: téléchargement et exemples</a></li>
        <li><a href="http://www.amazon.fr/dp/2746099047" target="_blank">
            Le livre écrit par Maxime et Jonathan : Unity3D - Développer en C# des applications 2/3D multiplateformes</a></li>
        <li><a href="http://lordinaire.fr" target="_blank">
            lordinaire.fr - Le blog de Maxime</a></li>
		<li><a href="https://twitter.com/maximefrappat" target="_blank">
            @maximefrappat - Pour contacter Maxime via Twitter</a></li>
		<li><a href="http://www.devday.be" target="_blank">
            Dev Day 2016 - La journée des développeurs (Belgique)</a></li>
	  </ul>
      ', -- Notes
    'http://podcastdevapps.blob.core.windows.net/mp3/Podcast-22-Unity.mp3', -- AudioUrl
    70017358, -- AudioSize
    '01:12:56', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-22-Unity.mp4', -- VideoUrl
    248414199, -- VideoSize
    '01:12:56', -- VideoDuration
    'v5Gp_qHFUMQ' -- VideoYoutubeKey
)
SET IDENTITY_INSERT dbo.Podcast OFF

INSERT INTO PodcastAuthorLink VALUES(22, 1)
INSERT INTO PodcastAuthorLink VALUES(22, 2)
INSERT INTO PodcastAuthorLink VALUES(22, 13)