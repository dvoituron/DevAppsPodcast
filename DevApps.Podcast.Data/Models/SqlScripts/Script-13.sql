SET IDENTITY_INSERT dbo.PodcastAuthor ON
INSERT INTO dbo.PodcastAuthor(PodcastAuthorID, Name, EMail, Url)
       VALUES (14, 'Richard Clark', '', 'https://twitter.com/c2iclark')
SET IDENTITY_INSERT dbo.PodcastAuthor OFF

SET IDENTITY_INSERT dbo.Podcast ON
INSERT INTO dbo.Podcast (PodcastID, PodcastKey, PublicationDate, SummaryTitle, SummaryDescription, Notes, AudioUrl, AudioSize, AudioDuration, VideoUrl, VideoSize, VideoDuration, VideoYoutubeKey)
VALUES
(
    23, --PodcastID 
    'uwp_community_toolkit', -- PodcastKey
    '2016-08-30 20:00:00', -- PublicationDate
    'Microsoft UWP Community Toolkit', -- SummaryTitle
    'Avec ce toolkit, Microsoft veut nous fournir un max de contrôles et de services, pour éviter de se casser la tête à rechercher des exemples à droite ou à gauche. Disponible en open source sur GitHub, ce toolkit se veut communautaire et évolutif avec nous les développeurs et pourquoi pas selon l''évolution, les intégrer directement dans les futurs SDK de Windows 10.', -- SummaryDescription
    '
      <h3>Podcast Notes</h3>
      Voici quelques liens sur Microsoft UWP Community Toolkit.
      <ul>
        <li><a href="http://aka.ms/UWPToolkit" target="_blank">
            Microsoft UWP Community Toolkit</a></li>
        <li><a href="http://aka.ms/uwptoolkitapp" target="_blank">
            UWP Community Toolkit Sample App</a></li>
        <li><a href="http://aka.ms/uwptoolkitdocs" target="_blank">
            La documentation</a></li>
        <li><a href="http://aka.ms/uwptoolkitbug" target="_blank">
            Si vous avez un bug à faire remonter</a></li>
		<li><a href="https://aka.ms/uwpcommunitytoolkituservoice" target="_blank">
            Le UserVoice pour soumettre vos idées</a></li>
		<li><a href="https://appstudio.windows.com" target="_blank">
            Windows App Studio UWP Samples</a></li>
		<li><a href="http://phmatray.net" target="_blank">
            Philippe Matray</a></li>
	  </ul>

	  <br/><br/><b>Erratum</b>
	  <img src="https://podcastdevapps.blob.core.windows.net:443/images/David.PNG" />

	  <h3>Les Zactus</h3>
      Voici les News présentées par Richard.
      <ul>
        <li><a href="https://msdn.microsoft.com/en-us/windows/uwp/whats-new/windows-10-version-1607" target="_blank">
            Windows 10 v 1607 new APIs</a></li>
        <li><a href="https://blogs.msdn.microsoft.com/dotnet/2016/08/24/whats-new-in-csharp-7-0" target="_blank">
            Nouveautés de C# 7</a></li>
        <li><a href="https://developer.microsoft.com/en-us/windows/iot/Docs/WhatsNew" target="_blank">
            Mise à jour de Windows 10 IoT</a></li>
        <li><a href="https://blogs.msdn.microsoft.com/visualstudio/2016/08/22/visual-studio-15-preview-4/" target="_blank">
            Visual Studio 15 Preview 4</a></li>
        <li><a href="https://code.visualstudio.com/updates/July_2016" target="_blank">
            Visual Studio Code 1.4 (Juillet 2016)</a></li>
        <li><a href="https://blogs.msdn.microsoft.com/webdiagnostics/2016/08/22/introducing-ios-web-debugging-for-vs-code-on-windows-and-mac/" target="_blank">
            VS Code permet le debug dans des appareils iOs</a></li>
        <li><a href="https://www.jetbrains.com/resharper/whatsnew" target="_blank">
            Resharper 2016.2</a></li>
        <li><a href="https://visualstudiogallery.msdn.microsoft.com/d92fd742-bab3-4314-b866-50b871d679ee" target="_blank">
            Visual Studio Language Pack</a></li>
        <li><a href="https://github.com/ratishphilip/CompositionProToolkit" target="_blank">
            CompositionProToolkit</a></li>
        <li><a href="https://blogs.msdn.microsoft.com/bharry/2016/08/18/team-services-update-aug-17" target="_blank">
            Team Services Update</a></li>
        <li><a href="http://www.e-naxos.com/Blog/post/Xamarin-Forms-ENFIN-LE-LIVRE-EN-FRANCAIS-!.aspx" target="_blank">
            Livre sur Xamarin Forms de Olivier Dahan </a></li>
		<li><a href="http://www.programmez.com/" target="_blank">
            Le magazine des développeurs</a></li>
		<li><a href="http://www.devday.be" target="_blank">
            Dev Day 2016 - La journée des développeurs (Belgique)</a></li>
		</ul>
      ', -- Notes
    'http://podcastdevapps.blob.core.windows.net/mp3/Podcast-23-UWPCommunityToolkit.mp3', -- AudioUrl
    83235317, -- AudioSize
    '01:26:42', -- AudioDuration
    'http://podcastdevapps.blob.core.windows.net/mp4/Podcast-23-UWPCommunityToolkit.mp4', -- VideoUrl
    237993756, -- VideoSize
    '01:26:42', -- VideoDuration
    'rQLqk4V4VSs' -- VideoYoutubeKey
)
SET IDENTITY_INSERT dbo.Podcast OFF

INSERT INTO PodcastAuthorLink VALUES(21, 1)
INSERT INTO PodcastAuthorLink VALUES(21, 2)
INSERT INTO PodcastAuthorLink VALUES(21, 14)