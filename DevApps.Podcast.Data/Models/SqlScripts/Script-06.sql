SET IDENTITY_INSERT dbo.PodcastAuthor ON
INSERT INTO dbo.PodcastAuthor(PodcastAuthorID, Name, EMail, Url)
       VALUES (9, 'Isabelle Van Campenhoudt', '', 'https://twitter.com/thesqlgrrrl')
SET IDENTITY_INSERT dbo.PodcastAuthor OFF

SET IDENTITY_INSERT dbo.Podcast ON
INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    16, --PodcastID 
    'azure_sql_database', -- PodcastKey
    '2016-03-18 14:00:00', -- PublicationDate
    'Azure SQL DataBase: Qu''est ce que c''est ? Comment ça fonctionne ? Combien ça coûte ?.', -- SummaryTitle
    'Isabelle Van Campenhoudt, MVP SQL Server, vient nous présenter le service de base de données relationnelle hébergé dans le Cloud de Microsoft. Nous présentons le cloud Azure, les services de stockage de Microsoft, la notion de DTU, le prix d''une base de données et comment créer, sécuriser et monitorer une base de données Azure.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Voici quelques liens sur Azure SQL DataBase.
      <ul>
        <li><a href="https://azure.microsoft.com/fr-fr/services/sql-database/" target="_blank">
            Présentation des bases de données SQL en tant que service.</a></li>
        <li><a href="https://azure.microsoft.com/fr-fr/pricing/calculator/" target="_blank">
            La calculatrice de prix des services Azure.</a></li>
        <li><a href="https://azure.microsoft.com/fr-fr/documentation/articles/sql-database-service-tiers/" target="_blank">
            Comprendre ce qui est disponible dans chaque niveau de service.</a></li>
		<li><a href="https://twitter.com/thesqlgrrrl" target="_blank">
            Pour contacter Isabelle - ivc[at]shareql.com.</a></li>
      </ul>
      ', -- Notes
    'http://podcastdevapps.blob.core.windows.net/mp3/Podcast-16-SqlAzure.mp3', -- AudioUrl
    79300231, -- AudioSize
    '01:22:36', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-16-SqlAzure.mp4', -- VideoUrl
    137169247, -- VideoSize
    '01:22:36', -- VideoDuration
    'QFn7TZ0n2y8' -- VideoYoutubeKey
)
SET IDENTITY_INSERT dbo.Podcast OFF

INSERT INTO PodcastAuthorLink VALUES(16, 1)
INSERT INTO PodcastAuthorLink VALUES(16, 2)
INSERT INTO PodcastAuthorLink VALUES(16, 9)