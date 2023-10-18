$url = "https://www.renoise.com/blog/aria-sibbe"
$outputFile = "RSS_Output.txt"

# Feed herunterladen
$webRequest = [System.Net.WebRequest]::Create($url)
$response = $webRequest.GetResponse()
$reader = New-Object System.IO.StreamReader($response.GetResponseStream())
$rssContent = $reader.ReadToEnd()
$reader.Close()
$response.Close()

# Den heruntergeladenen Feed analysieren
[xml]$rss = $rssContent

# Funktion zum Formatieren des Texts
function CleanText($text) {
    $text = [System.Text.RegularExpressions.Regex]::Replace($text, "<.*?>", "")
    $text = [System.Web.HttpUtility]::HtmlDecode($text)
    return $text
}

# Die Titel und Beschreibungen in die Textdatei schreiben
$stream = [System.IO.StreamWriter] $outputFile

foreach ($item in $rss.rss.channel.item) {
    $title = CleanText($item.title)
    $description = CleanText($item.description)

    $stream.WriteLine("Titel: " + $title)
    $stream.WriteLine("Beschreibung: " + $description)
    $stream.WriteLine("")
}

$stream.Close()
Write-Host "RSS-Daten wurden erfolgreich in $outputFile gespeichert."
