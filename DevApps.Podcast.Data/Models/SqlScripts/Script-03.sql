-- Definition of Podcast Statistics

IF OBJECT_ID('PodcastStatistic', 'U') IS NOT NULL
  DROP TABLE dbo.PodcastStatistic

CREATE TABLE PodcastStatistic
(
  PodcastStatisticID BIGINT IDENTITY(1,1) NOT NULL,
  PodcastID INT NOT NULL,
  RecordedDate DATETIME DEFAULT(GETDATE()) NOT NULL,
  FileType CHAR(3) NOT NULL,
  UserAgent VARCHAR(2048),
  UserIP VARCHAR(16),
  UserCountry CHAR(3),
  CONSTRAINT PK_PodcastStatisticID PRIMARY KEY (PodcastStatisticID),
  CONSTRAINT FK_PodcastStatistic_PodcastID FOREIGN KEY (PodcastID) REFERENCES dbo.Podcast(PodcastID),
)

ALTER TABLE Podcast
  ADD AudioAlreadyDownloaded INT

ALTER TABLE Podcast
  ADD VideoAlreadyDownloaded INT

UPDATE Podcast SET AudioAlreadyDownloaded = 570, VideoAlreadyDownloaded = 33 WHERE PodcastID =  1
UPDATE Podcast SET AudioAlreadyDownloaded = 431, VideoAlreadyDownloaded = 82 WHERE PodcastID =  2
UPDATE Podcast SET AudioAlreadyDownloaded = 277, VideoAlreadyDownloaded = 119 WHERE PodcastID =  3
UPDATE Podcast SET AudioAlreadyDownloaded = 270, VideoAlreadyDownloaded = 26 WHERE PodcastID =  4
UPDATE Podcast SET AudioAlreadyDownloaded = 196, VideoAlreadyDownloaded = 39 WHERE PodcastID =  5
UPDATE Podcast SET AudioAlreadyDownloaded = 402, VideoAlreadyDownloaded = 91 WHERE PodcastID =  6
UPDATE Podcast SET AudioAlreadyDownloaded = 395, VideoAlreadyDownloaded = 24 WHERE PodcastID =  7
UPDATE Podcast SET AudioAlreadyDownloaded = 1488, VideoAlreadyDownloaded = 134 WHERE PodcastID =  8
UPDATE Podcast SET AudioAlreadyDownloaded = 617, VideoAlreadyDownloaded = 115 WHERE PodcastID =  9
UPDATE Podcast SET AudioAlreadyDownloaded = 428, VideoAlreadyDownloaded = 24 WHERE PodcastID =  10
UPDATE Podcast SET AudioAlreadyDownloaded = 738, VideoAlreadyDownloaded = 42 WHERE PodcastID =  11
UPDATE Podcast SET AudioAlreadyDownloaded = 643, VideoAlreadyDownloaded = 41 WHERE PodcastID =  12
UPDATE Podcast SET AudioAlreadyDownloaded = 358, VideoAlreadyDownloaded = 45 WHERE PodcastID =  13
