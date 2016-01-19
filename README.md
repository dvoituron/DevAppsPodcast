# DevAppsPodcast

To use this code, you must:

1. Create a SQL Database (in your Dev environment or in Azure)

2. Execute the SQL Script to create all tables (may be updating all sample data).
   See [Script-01.sql](/DevApps.Podcast.Data/Models/SqlScripts/Script-01.sql)

3. Configure the SQL Connection String in [Web.Config](/DevApps.Podcast/Web.config) file.

<code>
connectionString="Server=xxx;Database=xxx;User ID=xxx;Password=xxx;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
</code>

A live demo is on : http://www.devapps.be
