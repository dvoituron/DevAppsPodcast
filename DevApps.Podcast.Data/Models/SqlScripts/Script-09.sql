SET IDENTITY_INSERT dbo.Podcast ON
INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    19, --PodcastID 
    'microsoft_pax_catuhe', -- PodcastKey
    '2016-06-02 13:00:00',  -- PublicationDate
    'Microsoft PAX - Notre avenir est assuré avec David Catuhe', -- SummaryTitle
    'David Catuhe, Principal Program Manager chez Microsoft vient d''intégrer la toute nouvelle équipe PAX (Partner Applications Experiences). Dans cet épisode, David vient nous expliquer quels sont les objectifs de ce département : nous soutenir et nous aider dans nos développements... en parlant de Dev à Dev... Et ce, pour notre plus grand plaisir.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Voici quelques liens sur PAX.
      <ul>
        <li><a href="http://www.windowsphoneaddict.fr/applicationsun-vent-de-fraicheur-semble-souffler-chez-microsoft-avec-pax-et-david-catuhe/" target="_blank">
            Un vent de fraîcheur semble souffler chez Microsoft avec PAX et David Catuhe</a></li>
        <li><a href="http://www.catuhe.com/" target="_blank">
            Blog de Deltakosh - Un petit espace virtuel ou ça cause philo, de la vie et du reste...surtout du reste</a></li>
        <li><a href="https://twitter.com/deltakosh" target="_blank">
            Twitter de David</a></li>
	  </ul>
      ', -- Notes
    'http://podcastdevapps.blob.core.windows.net/mp3/Podcast-19-PAX-DavidCatuhe.mp3', -- AudioUrl
    45743542, -- AudioSize
    '00:47:38', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-19-PAX-DavidCatuhe.mp4', -- VideoUrl
    209732760, -- VideoSize
    '00:47:38', -- VideoDuration
    '0R2IHq1Ztgc' -- VideoYoutubeKey
)
SET IDENTITY_INSERT dbo.Podcast OFF

INSERT INTO PodcastAuthorLink VALUES(19, 1)
INSERT INTO PodcastAuthorLink VALUES(19, 2)
INSERT INTO PodcastAuthorLink VALUES(19, 6)