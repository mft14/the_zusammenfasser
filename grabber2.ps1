# Benutzer zur Eingabe der URL auffordern
$url = Read-Host -Prompt 'Bitte geben Sie die URL ein:'

$outputFileContent = "Webseite_Inhalt.txt"
$outputFileTitle = "Webseite_Titel.txt"


# Die Webseite herunterladen
$response = Invoke-WebRequest -Uri $url
$content = $response.Content

# Funktion zum Extrahieren des Textinhalts aus <p>-Tags
function ExtractTextFromPTags($html) {
    $pattern = '(?s)<p>(.*?)</p>'
    $treffer = [regex]::Matches($html, $pattern)
    $text = foreach ($match in $treffer) {
        $match.Groups[1].Value
    }
    # Entfernen von HTML-Tags und Bereinigen des Textes
    $text = $text -replace "<.*?>", ""
    $text = [System.Web.HttpUtility]::HtmlDecode($text)
    $text = $text -replace "\s{2,}", " "
    return $text
}

# Den Titel der Webseite extrahieren
$title = $response.ParsedHtml.title

# Den Textinhalt aus <p>-Tags extrahieren
$extractedText = ExtractTextFromPTags($content)

# Den Textinhalt und den Titel in separaten Dateien speichern
$extractedText | Out-File -FilePath $outputFileContent -Encoding utf8
$title | Out-File -FilePath $outputFileTitle -Encoding utf8

Write-Host "Der Textinhalt wurde erfolgreich in $outputFileContent gespeichert."
Write-Host "Der Titel wurde erfolgreich in $outputFileTitle gespeichert."
