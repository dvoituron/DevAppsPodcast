SET IDENTITY_INSERT dbo.PodcastAuthor ON
INSERT INTO dbo.PodcastAuthor(PodcastAuthorID, Name, EMail, Url)
       VALUES (10, 'Nick Trogh', '', 'https://twitter.com/nicktrog')
SET IDENTITY_INSERT dbo.PodcastAuthor OFF

SET IDENTITY_INSERT dbo.Podcast ON
INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    17, --PodcastID 
    'azure_machine_learning', -- PodcastKey
    '2016-04-15 21:00:00', -- PublicationDate
    'Azure Machine Learning: comment prédire le futur ?', -- SummaryTitle
    'Voulez-vous faire de la reconnaissance faciale ou de la synthèse vocale dans vos Apps ? Voulez-vous prédire le futur ? Dans cet épisode, nous avons invité Nick Trogh de Microsoft Belgique, pour venir nous expliquer ce que sont les services d''apprentissage automatique, comment utiliser les API prêtes à l''emploi pour vos Apps ou comment développer vos propres Machine Learning.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Voici quelques liens sur Azure Machine Learning.
      <ul>
        <li><a href="https://azure.microsoft.com/fr-fr/services/machine-learning/" target="_blank">
            Présentation de Azure Machine Learning.</a></li>
        <li><a href="https://gallery.cortanaintelligence.com/" target="_blank">
            Cortana Intelligence Gallery - La gallerie des services à utiliser.</a></li>
        <li><a href="https://studio.azureml.net" target="_blank">
            Azure ML Studio - Pour créer vos propres machines.</a></li>
		<li><a href="https://twitter.com/nicktrog" target="_blank">
            Pour contacter Nick.</a></li>
      </ul>
      ', -- Notes
    'http://podcastdevapps.blob.core.windows.net/mp3/Podcast-17-MachineLearning.mp3', -- AudioUrl
    77722435, -- AudioSize
    '01:20:57', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-17-MachineLearning.mp4', -- VideoUrl
    213450840, -- VideoSize
    '01:20:57', -- VideoDuration
    'qq5Nfj8ALok' -- VideoYoutubeKey
)
SET IDENTITY_INSERT dbo.Podcast OFF

INSERT INTO PodcastAuthorLink VALUES(17, 1)
INSERT INTO PodcastAuthorLink VALUES(17, 2)
INSERT INTO PodcastAuthorLink VALUES(17, 10)