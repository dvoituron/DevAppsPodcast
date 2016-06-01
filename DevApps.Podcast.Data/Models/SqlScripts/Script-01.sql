-- =========================================
-- Create tables
-- =========================================

IF OBJECT_ID('PodcastAuthorLink', 'U') IS NOT NULL
  DROP TABLE dbo.PodcastAuthorLink

IF OBJECT_ID('PodcastAuthor', 'U') IS NOT NULL
  DROP TABLE dbo.PodcastAuthor

IF OBJECT_ID('Podcast', 'U') IS NOT NULL
  DROP TABLE dbo.Podcast

IF OBJECT_ID('Configuration', 'U') IS NOT NULL
  DROP TABLE dbo.Configuration

GO

CREATE TABLE Configuration
(
    ConfigurationID INT IDENTITY(1,1) NOT NULL,
    Name VARCHAR(64) NOT NULL,
    Value VARCHAR(256),
    CONSTRAINT PK_Configuration PRIMARY KEY (ConfigurationID)
)

CREATE TABLE Podcast
(
    PodcastID INT IDENTITY(1,1) NOT NULL,
    PodcastKey VARCHAR(128) NOT NULL,
    PublicationDate DATE NOT NULL,
    SummaryTitle VARCHAR(256),
    SummaryDescription VARCHAR(4096),
    Notes VARCHAR(MAX),
    AudioUrl VARCHAR(256),
    AudioSize INT,
    AudioDuration TIME,
    VideoUrl VARCHAR(256),
    VideoSize INT,
    VideoDuration TIME,
    VideoYoutubeKey VARCHAR(16),
    CONSTRAINT PK_PodcastID PRIMARY KEY (PodcastID),
    CONSTRAINT UK_PodcastKey UNIQUE (PodcastKey),
    CONSTRAINT CK_PodcastKey CHECK	(PodcastKey NOT LIKE '%[^A-Za-z0-9\_]%')
)

ALTER TABLE Podcast
  ADD ImageUrl VARCHAR(256)

CREATE TABLE PodcastAuthor
(
    PodcastAuthorID INT IDENTITY(1,1) NOT NULL,
    Name VARCHAR(256) NOT NULL,
    Email VARCHAR(512),
    Url VARCHAR(512),
    CONSTRAINT PK_PodcastAuthorID PRIMARY KEY (PodcastAuthorID),
)

CREATE TABLE PodcastAuthorLink
(
    PodcastID INT NOT NULL,
    PodcastAuthorID INT NOT NULL,
    CONSTRAINT FK_PodcastAuthorLink_PodcastID FOREIGN KEY (PodcastID) REFERENCES dbo.Podcast(PodcastID),
    CONSTRAINT FK_PodcastAuthorLink_PodcastAuthorID FOREIGN KEY (PodcastAuthorID) REFERENCES dbo.PodcastAuthor(PodcastAuthorID)
)

GO
-- =========================================
-- Insert Sample Data
-- =========================================

SET IDENTITY_INSERT dbo.Configuration ON
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES( 1, 'Version',                     '1.0.0')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES( 2, 'MaximumOfPodcastsOnHomePage', '30')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES( 3, 'DisqusShortnameKey',          'devapps')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES( 4, 'SiteUrl',                     'http://devapps.be')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES( 5, 'SiteName',                    'DevApps Podcasts')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES( 6, 'SiteDescription',             'DevApps - Actualité, Développement et Architecture en technologies .NET. Présenté par Denis Voituron et Christophe Peugnet, ce podcast ce veut technique et convivial.')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES( 7, 'SiteAuthor',                  'Denis Voituron / Christophe Peugnet')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES( 8, 'SiteLanguage',                'fr-fr')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES( 9, 'GoogleAnalyticsKey',          'XXXX')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES(10, 'TwitterUrl',		           'https://twitter.com/DevAppsPodcast')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES(11, 'TwitterAccount',              '@DevAppsPodcast')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES(12, 'CopyrightName',               'Denis Voituron')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES(13, 'CopyrightUrl',                'http://www.dvoituron.be')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES(14, 'CopyrightEmail',              'dvoituron@outlook.com')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES(15, 'CategoriesKeywords',          'Programming;Talk;Français;Podcast;Microsoft;Technology=Software How-To;Technology=Gadgets')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES(16, 'ImageUrl',                    'http://devapps.be/images/logo1400.png')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES(17, 'Creator',                     '@DevAppsPodcast')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES(18, 'FeedAudioUrl',                'http://devapps.be/feed')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES(19, 'FeedVideoUrl',                'http://devapps.be/video')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES(20, 'FeedTitle',                   'DevApps Podcasts, par Denis Voituron et Christophe Peugnet')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES(21, 'AzureStorageCredentials',     'AccountName;KeyCrypted')
INSERT INTO dbo.Configuration (ConfigurationID, Name, Value) VALUES(22, 'YoutubeStatisticsApiKey',     'GoogleKey')
SET IDENTITY_INSERT dbo.Configuration OFF

SET IDENTITY_INSERT dbo.PodcastAuthor ON
INSERT INTO dbo.PodcastAuthor(PodcastAuthorID, Name, EMail, Url) VALUES(1, 'Denis Voituron',     'dvoituron@outlook.com',  'https://twitter.com/denisvoituron')
INSERT INTO dbo.PodcastAuthor(PodcastAuthorID, Name, EMail, Url) VALUES(2, 'Christophe Peugnet', 'tossnetapp@outlook.com', 'https://twitter.com/tossnet1')
INSERT INTO dbo.PodcastAuthor(PodcastAuthorID, Name, EMail, Url) VALUES(3, 'Arnaud Weil',		 '',                       'https://twitter.com/epo')
INSERT INTO dbo.PodcastAuthor(PodcastAuthorID, Name, EMail, Url) VALUES(4, 'Laurent Bugnion',	 '',                       'https://twitter.com/lbugnion')
INSERT INTO dbo.PodcastAuthor(PodcastAuthorID, Name, EMail, Url) VALUES(5, 'Adrien Clerbois',	 '',                       'https://twitter.com/aclerbois')
INSERT INTO dbo.PodcastAuthor(PodcastAuthorID, Name, EMail, Url) VALUES(6, 'David Catuhe',		 '',                       'https://twitter.com/deltakosh')

SET IDENTITY_INSERT dbo.PodcastAuthor OFF

SET IDENTITY_INSERT dbo.Podcast ON

INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    1, --PodcastID 
    'nouvelles_fonctionnalites_du_CSharp_6_0', -- PodcastKey
    '2015-07-07 21:00:00', -- PublicationDate
    'Nouvelles fonctionnalités du C# 6.0', -- SummaryTitle
    'Le 20 juillet prochain, Microsoft lancera la nouvelle version de Visual Studio. Elle intègre nativement les nouvelles fonctionnalités du C# 6.0 : Dans ce premier podcast, je présente ces nouvelles syntaxes et nouvelles commandes du C# 6.0.', -- SummaryDescription
    '', -- Notes
    'http://podcastdevapps.blob.core.windows.net/mp3/Podcast-01-NewFeaturesCSharp6.mp3', -- AudioUrl
    15031484, -- AudioSize
    '00:15:39', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-01-NewFeaturesCSharp6.mp4', -- VideoUrl
    42212019, -- VideoSize
    '00:15:39', -- VideoDuration
    'yAieIX4-V4s' -- VideoYoutubeKey
)

INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    2, --PodcastID 
    'le_guide_scrum_resume', -- PodcastKey
    '2015-07-19 12:00:00', -- PublicationDate
    'Le guide Scrum (résumé)', -- SummaryTitle
    'Ce second podcast présente la méthodologie Agile/Scrum telle que décrite dans le guide officiel. J''ajoute également mon expérience en tant que Scrum Master... ainsi qu''une nouvelle rubrique en fin de podcast (les 15 dernières minutes).', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Dans la nouvelle rubrique actualités, voici les liens présentés :
      <ul>
        <li><a href="http://bit.ly/1fIxkrO" target="_blank">Five more COOL features we noticed on Visual Studio Online (Visual Studio ALM Rangers</a></li>
        <li><a href="http://bit.ly/1RyJ4hf" target="_blank">A Complete List of Microsoft SDKs for Download (Scott Ge - Microsoft)</a></li>
        <li><a href="http://bit.ly/1fXexsZ" target="_blank">Visual Studio 2015 Final Release Event </a></li>
        <li><a href="http://bit.ly/1LmjRDb" target="_blank">XAML Styler - 1.6 has been released (Nico Vermeir)</a></li>
        <li><a href="http://bit.ly/1gBJLpo" target="_blank">Microsoft n’a clairement pas l’intention d’abandonner le mobile, au contraire ! (Zdnet.com)</a></li>
        <li><a href="http://bit.ly/1SmLgUm" target="_blank">Windows 10 SDK Preview Build 10166 Released (Windows.com - Clint Rutkas)</a></li>
        <li><a href="http://bit.ly/1NLXrsv" target="_blank">FREE Microsoft eBooks (Eric Ligman)</a></li>
        <li><a href="http://bit.ly/1MfbSH2" target="_blank">The TypeScript Team is Hiring</a></li>
        <li><a href="http://bit.ly/1I53bJr" target="_blank">The Glimpse Team Joins Microsoft</a></li>
      </ul>
      ', -- Notes
    'http://podcastdevapps.blob.core.windows.net/mp3/Podcast-02-ScrumGuides.mp3', -- AudioUrl
    59649880, -- AudioSize
    '01:02:08', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-02-ScumGuides.mp4', -- VideoUrl
    173075123, -- VideoSize
    '01:02:08', -- VideoDuration
    '2wRGhYQAnOc' -- VideoYoutubeKey
)

INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    3, --PodcastID 
    'comment_tracer_via_nlog', -- PodcastKey
    '2015-08-04 23:00:00', -- PublicationDate
    'Comment tracer via NLog ?', -- SummaryTitle
    'Ce podcast #3 introduit une présentation de la bibliothèque de traçage NLog... ainsi que la nouvelle rubrique d''Actualités, en fin de podcast.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Dans la rubrique actualités, voici les liens présentés :
      <ul>
        <li><a href="	http://blogs.msdn.com/b/somasegar/archive/2015/07/20/visual-studio-2015-and-net-4-6-available-for-download.aspx" target="_blank">
               Visual Studio 2015 and .NET 4.6 Available for Download (S. Somasegar)</a></li>
        <li><a href="	http://scottge.net/2015/07/20/a-summary-of-things-that-microsoft-released-today-for-developers-vs2015-net-4-6-etc/" target="_blank">
               A Summary of Things that Microsoft Released Today for Developers: VS2015, .NET 4.6, etc (Scott Ge)</a></li>
        <li><a href="	http://blogs.msdn.com/b/visualstudio/archive/2015/07/20/visual-studio-2015-and-visual-studio-2013-update-5-released.aspx" target="_blank">
               What’s New since Visual Studio 2015 RC (Visual Studio Blog)</a></li>
        <li><a href="https://github.com/aspnet/Home/wiki/Roadmap" target="_blank">
               ASP.NET 5 disponible en Q1 2016 (Damian Edwards).</a></li>
        <li><a href="http://blogs.msdn.com/b/visualstudioalm/archive/2015/07/20/you-can-now-acquire-the-visual-studio-emulator-for-android-on-its-own.aspx" target="_blank">
               Visual Studio Emulator for Android from Android Studio or Eclipse (Visual Studio ALM).</a></li>
        <li><a href="http://blogs.msdn.com/b/typescript/archive/2015/07/20/announcing-typescript-1-5.aspx" target="_blank">
               Announcing TypeScript 1.5 (Jonathan Turner)</a></li>
        <li><a href="http://www.slideshare.net/yquenechdu/rdiger-des-user-stories" target="_blank">
               Comment rédiger des Users Stories (Yannick Quenec''hdu)</a></li>
        <li><a href="http://blogs.msdn.com/b/dotnet/archive/2014/11/12/the-roadmap-for-wpf.aspx" target="_blank">
               The Roadmap for WPF (The WPF Team).</a></li>
        <li><a href="http://blogs.msdn.com/b/visualstudioalm/archive/2015/07/23/code-metrics-powertool-for-visual-studio-2015-available-on-microsoft-download-center.aspx" target="_blank">
               Code Metrics PowerTool for VS2015 Available on Microsoft Download Center (Charles Willis).</a></li>
        <li><a href="https://channel9.msdn.com/Events/Visual-Studio/Visual-Studio-2015-Final-Release-Event/In-the-Code-Building-the-Web-Site-in-Azure" target="_blank">
               Video In the Code - Building the Web Site in the Cloud (Channel 9).</a></li>
        <li><a href="http://blogs.msdn.com/b/powerbi/archive/2015/07/22/monitoring-your-visual-studio-online-work-items-with-power-bi.aspx" target="_blank">
               Monitoring and Exploring your Visual Studio Online Work Items with Power BI (Theresa Palmer).</a></li>
      </ul>
      ', -- Notes
    'http://podcastdevapps.blob.core.windows.net/mp3/Podcast-03-NLog.mp3', -- AudioUrl
    44691121, -- AudioSize
    '00:46:33', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-03-NLog.mp4', -- VideoUrl
    150696372, -- VideoSize
    '00:46:33', -- VideoDuration
    'bWsdfQn0X-8' -- VideoYoutubeKey
)

INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    4, --PodcastID 
    'le_pattern_mvvm_pourquoi_comment', -- PodcastKey
    '2015-08-24 23:00:00', -- PublicationDate
    'Le pattern MVVM : Pourquoi, Comment ?', -- SummaryTitle
    'Ce podcast #4 présente les bases du modèle MVVM : faut-il l''utiliser ? Comment bien l''appliquer ? ... Ainsi que les quelques actualités Dev de ce mois d''Août.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Le code source utilisé dans ce Podcast est <a href="https://podcastdevapps.blob.core.windows.net/files/04-MvvmSample.zip" target="_blank">téléchargeable ici</a>.
      <br />
      Un exemple de projet MVVM Light est disponible sur <a href="https://github.com/dvoituron/SampleMvvmLight" target="_blank">https://github.com/dvoituron/SampleMvvmLight</a>
      <br /><br />      
      Dans la rubrique actualités, voici les liens présentés :
      <ul>
        <li><a href="http://blogs.msdn.com/b/visualstudioalm/archive/2015/07/24/visual-studio-2015-and-codelens.aspx" target="_blank">
            Visual Studio 2015 and CodeLens</a></li>
        <li><a href="https://www.visualstudio.com/news/tfs2015-vs" target="_blank">
            TFS 2015 RTM nouveautés</a></li>
        <li><a href="https://www.visualstudio.com/en-us/news/2015-aug-7-vso" target="_blank">
            Visual Studio Online News</a></li>
        <li><a href="http://blogs.msdn.com/b/visualstudio/archive/2015/08/07/visual-studio-2015-faq.aspx  " target="_blank">
            Visual Studio 2015 - FAQ</a></li>
        <li><a href="http://www.monwindowsphone.com/installer-des-applications-android-sur-windows-10-mobile-encore-plus-facilement-t107987.html" target="_blank">
            Andoid sur Windows Mobile 10 ?</a></li>
        <li><a href="http://blogs.msdn.com/b/bharry/archive/2015/08/12/smartoffice4tfs-and-integreat4tfs-available-for-visual-studio-enterprise-with-msdn-subscribers.aspx" target="_blank">
            Téléchargement de SmartOffice4TFS pour les abonnés MSDN Enterprise</a></li>
        <li><a href="http://blogs.msdn.com/b/buckh/archive/2015/08/10/nuget-packages-for-tfs-and-visual-studio-online-net-client-object-model.aspx" target="_blank">
            .NET client libraries for Visual Studio Online et TFS</a></li>
        <li><a href="http://www.monwindowsphone.com/surface-pro-4-lumia-950-xl-microsoft-band-2-wm10-pour-octobre-t108309.html" target="_blank">
            [Rumeur] : Surface Pro 4, Lumia 950 (XL), Microsoft Band 2, WM10 pour octobre</a></li>
        <li><a href="http://accord-framework.net" target="_blank">
            Accord Framework</a></li>
        <li><a href="https://visualstudiogallery.msdn.microsoft.com/03ead7e5-3680-4834-a4cb-271a2b189108" target="_blank">
            TFS Productivity Pack (Visual Studio 2015)</a></li>
      </ul>
      ', -- Notes
    'http://podcastdevapps.blob.core.windows.net/mp3/Podcast-04-Mvvm.mp3', -- AudioUrl
    53178200, -- AudioSize
    '00:55:23', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-04-Mvvm.mp4', -- VideoUrl
    221777265, -- VideoSize
    '00:55:23', -- VideoDuration
    'B8Oa4eBKZzQ' -- VideoYoutubeKey
)

INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    5, --PodcastID 
    'les_tests_unitaires_dans_visualstudio_facile_christophe', -- PodcastKey
    '2015-09-07 15:00:00', -- PublicationDate
    'Les tests unitaires dans Visual Studio : c''est facile, Christophe ?', -- SummaryTitle
    'Ce podcast #5 présente les concepts associés aux tests unitaires : pourquoi, quoi et comment tester ... Ainsi que les quelques actualités Microsoft Dev.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Dans la rubrique actualités, voici les liens présentés :
      <ul>
        <li><a href="http://blogs.msdn.com/b/visualstudio/archive/2015/08/25/a-day-in-the-life-of-visual-studio-send-a-smile-feedback.aspx" target="_blank">
            A Day in the Life of Visual Studio Send a Smile Feedback</a></li>
        <li><a href="http://blogs.windows.com/buildingapps/2015/08/20/net-native-what-it-means-for-universal-windows-platform-uwp-developers/" target="_blank">
            .NET Native – What it means for Universal Windows Platform (UWP) developers</a></li>
        <li><a href="https://azure.microsoft.com/en-us/azurecon/" target="_blank">
            AzureConf - 29 septembre 2015</a></li>
        <li><a href="http://azure.microsoft.com/fr-fr/blog/update-on-net-framework-4-6-and-azure/" target="_blank">
            Update on .NET Framework 4.6 and Azure</a></li>
        <li><a href="http://blogs.msdn.com/b/webdev/archive/2015/09/02/announcing-availability-of-asp-net-5-beta7.aspx" target="_blank">
            Disponibilité de ASP.NET 5 Beta 7</a></li>
        <li><a href="http://blogs.msdn.com/b/typescript/archive/2015/09/02/announcing-typescript-1-6-beta-react-jsx-better-error-checking-and-more.aspx" target="_blank">
            Disponibilité de TypeScript 1.6 Beta</a></li>
      </ul>
      ', -- Notes
    'https://podcastdevapps.blob.core.windows.net/mp3/Podcast-05-UnitTests.mp3', -- AudioUrl
    55036539, -- AudioSize
    '00:57:19', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-05-UnitTests.mp4', -- VideoUrl
    159241734, -- VideoSize
    '00:57:19', -- VideoDuration
    'F-0p6foTN4o' -- VideoYoutubeKey
)

INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    6, --PodcastID 
    'de_javascript_typescript_vers_un_monde_meilleur', -- PodcastKey
    '2015-09-22 22:00:00', -- PublicationDate
    'De JavaScript à TypeScript, vers un monde meilleur', -- SummaryTitle
    'Ce podcast #6 présente les concepts de base de TypeScript, ce langage de programmation libre et open-source développé par Microsoft, et qui a pour but de simplifier la création d''applications web... Ainsi que les quelques actualités Microsoft Dev.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      
      Pour approfondir le sujet TypeScript :
      
      <ul>
        <li><a href="http://www.TypeScriptLang.org" target="_blank">
            Pour découvrir, tester et approfondir : TypeScriptLang.org</a></li>
        <li><a href="http://TypeScript.codeplex.com" target="_blank">
            TS est Open Source.</a></li>
        <li><a href="http://www.typescriptlang.org/#Download" target="_blank">
            Node.js	- NPM package</a></li>
        <li><a href="https://marketplace.eclipse.org/content/typescript" target="_blank">
            Eclipse - Plugin </a></li>
        <li><a href="https://github.com/Railk/T3S" target="_blank">
            Sublime Text Plugin </a></li>
        <li><a href="http://blog.jetbrains.com/webide/2013/02/typescript-support-in-webstorm-6" target="_blank">
            WebStorm - support since v6.0 </a></li>
        <li><a href="http://www.emacswiki.org/emacs/TypeScript" target="_blank">
            Emacs Plugin </a></li>
        <li><a href="https://github.com/leafgarland/typescript-vim" target="_blank">
            VIM Plugin </a></li>
        <li><a href="http://go.microsoft.com/fwlink/?LinkID=266563" target="_blank">
            Visual Studio 2012</a> (par défaut dans VS 2013 et 2015)</li>
      </ul>
      
      Dans la rubrique actualités, voici les liens présentés :
      <ul>
        <li><a href="http://blogs.msdn.com/b/typescript/archive/2015/09/16/announcing-typescript-1-6.aspx" target="_blank">
            Announcing TypeScript 1.6</a></li>
        <li><a href="https://nodejs.org/en/blog/release/v4.0.0/" target="_blank">
            Node v4.0.0 (Stable)</a></li>
        <li><a href="https://blogs.windows.com/bloggingwindows/2015/09/14/announcing-windows-10-mobile-insider-preview-build-10536/" target="_blank">
            Announcing Windows 10 Mobile Insider Preview Build 10536</a></li>
        <li><a href="http://blogs.windows.com/bloggingwindows/2015/09/18/announcing-windows-10-insider-preview-build-10547/" target="_blank">
            Announcing Windows 10 Insider Preview Build 10547</a></li>        
        <li><a href="https://msdn.microsoft.com/en-us/library/mt598502.aspx?_ts=1442841660" target="_blank">
            Lumia Imaging SDK 3.0</a></li>
        <li><a href="https://msdn.microsoft.com/en-us/library/mt598508.aspx" target="_blank">
            How to upgrade from Lumia Imaging SDK 2.0 to 3.0</a></li>
        <li><a href="https://dev.windows.com/en-us/design/assets" target="_blank">
            Design templates for Universal Windows Platform (UWP) apps</a></li>
        <li><a href="http://www.minimachines.net/actu/raspberry-pi-annonce-un-ecran-tactile-7-pouces-pour-60-33357" target="_blank">
            Raspberry Pi annonce un écran tactile 7 pouces pour 60$</a></li>
        <li><a href="https://code.visualstudio.com/updates" target="_blank">
            VS Code v0.8.0</a></li>
      </ul>
      ', -- Notes
    'https://podcastdevapps.blob.core.windows.net/mp3/Podcast-06-TypeScript.mp3', -- AudioUrl
    70123102, -- AudioSize
    '01:13:02', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-06-TypeScript.mp4', -- VideoUrl
    207832132, -- VideoSize
    '01:13:02', -- VideoDuration
    'Y7LxovU12CU' -- VideoYoutubeKey
)

INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    7, --PodcastID 
    'ajoutez_votre_assistante_visualstudio', -- PodcastKey
    '2015-10-07 22:00:00', -- PublicationDate
    'Ajoutez votre assistante dans Visual Studio', -- SummaryTitle
    'Ce podcast #7 présente une extension Visual Studio que tout développeur doit absolument installer afin d''améliorer ses performances de coding... Ainsi que les quelques actualités Microsoft Dev.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Dans la rubrique actualités, voici les liens présentés :
      <ul>
        <li><a href="http://blogs.msdn.com/b/visualstudio/archive/2015/09/16/wintools-1-1-typescript-1-6-rtm-and-tools-for-apache-cordova-updates.aspx" target="_blank">
            Tools for Universal Windows apps (v1.1)</a></li>
        <li><a href="http://devday.be" target="_blank">
            DevDay.be</a></li>
        <li><a href="http://www.mobilize.net/uwp-bridge" target="_blank">
            Application Mobilize  UWP Bridge</a></li>
        <li><a href="https://modernizr.com/news/" target="_blank">
            Modernizr 3</a></li>
        <li><a href="https://www.visualstudio.com/news/2015-sep-18-vso" target="_blank">
            Visual Studio Online</a></li>
        <li><a href="https://www.visualstudio.com/en-us/get-started/report/connect-vso-pbi-vs" target="_blank">
            Visual Studio Online et Power BI</a></li>
        <li><a href="http://themes.getbootstrap.com/" target="_blank">
            Bootstrap</a></li>
      </ul>
      ', -- Notes
    'https://podcastdevapps.blob.core.windows.net/mp3/Podcast-07-DeveloperAssistant.mp3', -- AudioUrl
    54664463, -- AudioSize
    '00:56:56', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-07-DeveloperAssistant.mp4', -- VideoUrl
    153427357, -- VideoSize
    '00:56:56', -- VideoDuration
    'rWpOjqKAIqU' -- VideoYoutubeKey
)

INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    8, --PodcastID 
    'david_comment_developper_chez_microsoft', -- PodcastKey
    '2015-10-22 10:00:00', -- PublicationDate
    'David, mais comment développe-t-on chez Microsoft Corp ?', -- SummaryTitle
    'Dans ce podcast #8, David Catuhe (Principal Program Manager chez Microsoft) vient nous expliquer comment sont organisés les projets de développements chez Microsoft Corp... En passant de l''analyse des besoins, de la méthodologie, du coding, des tests et pour finir par les déploiements, l''organisation des projets MS n''aura plus de secret pour vous.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Exceptionnellement, les actualités sont reportées au prochain Podcast.
      <ul>
        <li><a href="https://www.linkedin.com/in/dcatuhe" target="_blank">
            Plus d''informations sur David ?</a></li>
        <li><a href="https://twitter.com/deltakosh" target="_blank">
            Suivez David sur Twitter</a></li>
        <li><a href="https://twitter.com/tossnet1" target="_blank">
            Suivez Christophe sur Twitter</a></li>
        <li><a href="https://twitter.com/denisvoituron" target="_blank">
            Suivez Denis sur Twitter</a></li>
      </ul>
      ', -- Notes
    'https://podcastdevapps.blob.core.windows.net/mp3/Podcast-08-DavidCatuhe.mp3', -- AudioUrl
    68416574, -- AudioSize
    '01:11:17', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-08-DavidCatuhe.mp4', -- VideoUrl
    457412799, -- VideoSize
    '01:11:17', -- VideoDuration
    'Mtus2fNBjSQ' -- VideoYoutubeKey
)

INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    10, --PodcastID 
    'centennial_vos_applications_win32_dans_windows_store', -- PodcastKey
    '2015-11-03 18:00:00', -- PublicationDate
    'Centennial: vos applications Win32 dans le Windows Store.', -- SummaryTitle
    'Dans cet épisode nous vous présentons le projet Centennial. Microsoft a annoncé ce projet, pendant la //Build 2015. Il devrait nous permettre de déployer des applications Windows en passant par le Store. En fin de podcast, nous revisitons les quelques actualités Microsoft Dev des dernières semaines.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Voici quelques liens au sujet de Centennial.
      <ul>
        <li><a href="https://channel9.msdn.com/Events/Build/2015/2-692" target="_blank">
            Channel9 - Converting your Classic Windows App to a Universal Windows App for Distribution in the Windows Store</a></li>
        <li><a href="http://www.brianmadden.com/blogs/timmangan/archive/2015/05/29/Breaking-down-Microsoft-Project-Centennial-Microsoft-s-App-V-spinoff-for-Win32-and-Universal-Apps.aspx" target="_blank">
            Breaking down Microsoft Project Centennial–Microsoft''s App-V spinoff for Win32 and Universal Apps</a></li>
        <li><a href="http://blogs.infinitesquare.com/b/build2015/archives/projet-centennial-vos-applications-win32-dans-le-windows-store#.VldzF_mrSM9" target="_blank">
            Projet Centennial : vos applications Win32 dans le Windows Store</a></li>
        <li><a href="http://www.windowscentral.com/microsoft-investigating-win32-support-continuum-windows-10-mobile" target="_blank">
            Microsoft investigating Win32 app support for Continuum on Windows 10 Mobile</a></li>
      </ul>
      Dans la rubrique actualités, voici les liens présentés :
      <ul>
        <li><a href="http://blogs.msdn.com/b/visualstudio/archive/2015/11/18/news-and-announcements-from-connect-2015.aspx" target="_blank">
            Nouveautés et annonces de Connect(); //2015</a></li>
        <li><a href="http://blogs.msdn.com/b/wpf/archive/2015/10/29/wpf-community-projects.aspx" target="_blank">
            WPF Community Projects</a></li>
        <li><a href="http://frawin.com/windows-10/windows-10-mobile/2015/32167_windows-10-mobile-permet-diagnostique-simple-smartphone-lordinateur.html" target="_blank">
            Windows 10 Mobile permet un diagnostic simple d’un smartphone depuis un ordinateur</a></li>
      </ul>
      ', -- Notes
    'https://podcastdevapps.blob.core.windows.net/mp3/Podcast-10-Centennial.mp3', -- AudioUrl
    56197537, -- AudioSize
    '00:58:32', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-10-Centennial.mp4', -- VideoUrl
    158646307, -- VideoSize
    '00:58:32', -- VideoDuration
    'u4isUR-Ip38' -- VideoYoutubeKey
)

INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    9, --PodcastID 
    'signalr_sourire_sur_toutes_les_bouches', -- PodcastKey
    '2015-11-03 18:00:00', -- PublicationDate
    'SignalR, un sourire sur toutes les bouches.', -- SummaryTitle
    'Adrien Clerbois (Développeur Web et .NET) nous présente un framework pour communiquer en temps réel, entre le serveur et les clients Web ou Mobiles. En fin de podcast, nous revisitons les quelques actualités Microsoft Dev des dernières semaines.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Dans la rubrique actualités, voici les liens présentés :
      <ul>
        <li><a href="http://blogs.msdn.com/b/visualstudio/archive/2015/09/28/introducing-u-sql.aspx" target="_blank">
            U-SQL le langage pour gérer facilement les grandes sources de données Azure Data Lake BigData.</a></li>
        <li><a href="http://blogs.msdn.com/b/eternalcoding/archive/2015/10/21/using-javascript-frameworks-from-your-c-uwp-application.aspx" target="_blank">
            JsBridge pour vos application UWP, par David Catuhe.</a></li>
        <li><a href="https://www.visualstudio.com/connect2015" target="_blank">
            Connecte 2015 - 18 et 19 novembre, en direct de NY.</a></li>
        <li><a href="http://blog.galasoft.ch/posts/2015/10/one-million-downloads/" target="_blank">
            MvvmLight a atteint le million de téléchargement.
        </a></li>
        <li><a href="http://developer.xamarin.com/guides/cross-platform/xamarin-forms/creating-mobile-apps-xamarin-forms/" target="_blank">
            Xamarin Forms - Charle Petzol a publié un nouveau chapitre sur Xamarin Forms Navigations.</a></li>
        <li><a href="http://www.meetup.com/fr/micbelgique/" target="_blank">
            DevFM #18 : Xamarin, Retour d’expérience sur un projet mobile d’entreprise.</a></li>
        <li><a href="http://vorlonjs.com/" target="_blank">
            Vorlon.JS est disponible en version 0.1.0.</a></li>
      </ul>
      ', -- Notes
    'https://podcastdevapps.blob.core.windows.net/mp3/Podcast-09-SignalR.mp3', -- AudioUrl
    53372969, -- AudioSize
    '00:55:35', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-09-SignalR.mp4', -- VideoUrl
    156954590, -- VideoSize
    '00:55:35', -- VideoDuration
    'J9mgoop1nug' -- VideoYoutubeKey
)

INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    11, --PodcastID 
    'mvvm_Light_explique_par_son_pere', -- PodcastKey
    '2015-12-08 10:00:00', -- PublicationDate
    'MVVM Light expliqué par son père.', -- SummaryTitle
    'Nous avons eu la chance de discuter une heure avec Laurent Bugnion, créateur du Toolkit MVVM Light. Avec lui, nous passons en revue les principaux modules de cette bibiothèque devenue incontournable aux développeurs XAML... Pourquoi et comment ces modules sont-ils nés ?', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Voici quelques liens sur MVVM Light.
      <ul>
        <li><a href="http://www.mvvmlight.net" target="_blank">
            Introduction, Documentation, Release notes, comment utiliser MVVM Light</a></li>
        <li><a href="http://mvvmlight.codeplex.com" target="_blank">
            Le code source de MVVM Light</a></li>
        <li><a href="http://www.galasoft.ch/" target="_blank">
            Blog et articles de Laurent</a></li>
        <li><a href="https://www.pluralsight.com/courses/mvvm-light-toolkit-fundamentals" target="_blank">
            Pluralsight - MVVM Light Toolkit Fundamentals</a></li>
        <li><a href="https://www.facebook.com/VisualStudioTalkShow" target="_blank">
            Visual Studio Talk Show... Un podcast en français sur le développement logiciel.</a></li>
        </ul>
      ', -- Notes
    'https://podcastdevapps.blob.core.windows.net/mp3/Podcast-11-MvvmLight-LaurentBugnion.mp3', -- AudioUrl
    71932029, -- AudioSize
    '01:14:55', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-11-MvvmLight-LaurentBugnion.mp4', -- VideoUrl
    219701361, -- VideoSize
    '01:14:55', -- VideoDuration
    'H-OdwQ5AeOI' -- VideoYoutubeKey
)

INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    12, --PodcastID 
    'apprendre_aspnet_mvc_tour_horizon', -- PodcastKey
    '2015-12-22 10:00:00', -- PublicationDate
    'Apprendre ASP.NET MVC - Tour d''horizon.', -- SummaryTitle
    'Dans cet épisode, Arnaud Weil vient nous présenter le contenu de son nouveau livre [Learn ASP.NET MVC]. Ensemble, nous discutons d''ASP.NET MVC et de ses principales caractéristiques : qu''est ce que ASP.NET MVC, comment créer une View ou un Controller, etc.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Voici quelques liens sur ASP.NET MVC et Arnaud.
      <ul>
        <li><a href="https://leanpub.com/aspnetmvc" target="_blank">
            Learn ASP.NET MVC - Livre d''Arnaud sur Leanpub.com</a></li>
        <li><a href="http://www.amazon.fr/dp/132648303X" target="_blank">
            Learn ASP.NET MVC - Livre d''Arnaud sur Amazon.fr</a></li>
        <li><a href="http://www.asp.net/mvc" target="_blank">
            Le site de référence ASP.NET/MVC (en anglais)</a></li>
        <li><a href="http://www.aweil.fr/" target="_blank">
            Arnaud Weil - Présentation et Blog</a></li>
        <li><a href="http://leanpub.com/aspnetmvc/c/cL5qQhIOO2Ec" target="_blank">
            Offre spéciale: version ebook à 4,5$ seulement jusqu''au 30 janvier 2016 pour les auditeurs de DevApps.be</a></li>
	    </ul>
      ', -- Notes
    'http://podcastdevapps.blob.core.windows.net/mp3/Podcast-12-ASPNET-MVC.mp3', -- AudioUrl
    57354866, -- AudioSize
    '00:59:44', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-12-ASPNET-MVC.mp4', -- VideoUrl
    146051218, -- VideoSize
    '00:59:44', -- VideoDuration
    'sCBQUGLOXNg' -- VideoYoutubeKey
)


SET IDENTITY_INSERT dbo.Podcast OFF

INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(1, 1)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(2, 1)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(3, 1)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(4, 1)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(5, 1)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(5, 2)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(6, 1)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(6, 2)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(7, 1)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(7, 2)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(8, 1)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(8, 2)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(8, 6)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(9, 1)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(9, 2)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(9, 5)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(10, 1)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(10, 2)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(11, 1)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(11, 2)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(11, 4)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(12, 1)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(12, 2)
INSERT INTO dbo.PodcastAuthorLink(PodcastID, PodcastAuthorID) VALUES(12, 3)
