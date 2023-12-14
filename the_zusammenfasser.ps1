# Benutzer zur Eingabe der URL auffordern
$url = Read-Host -Prompt 'Bitte geben Sie die URL ein:'

# Konvertieren der URL in ein System.Uri-Objekt
$uri = New-Object System.Uri($url)
$tld = $uri.Host
Write-Host "Die Toplevel-Domain ist: $tld"

$outputFileContent = "Inhalt.txt"
$outputFileTitle = "Titel.txt"

# Die Webseite herunterladen
$response = Invoke-WebRequest -Uri $url
$content = $response.Content

# Den Titel der Webseite extrahieren
$title = $response.ParsedHtml.title

# Liste von zugelassenen Top-Level-Domains und zugehörigen Regex-Patterns
$allowedDomains = @{
    "www.bild.de" = '(?s)<p>(.*?)</p>'
    "www.chip.de" = '(?s)<div\sclass="mt-sm">(.*?)</div>'
    "www.computerbild.de" = '(?s)<div\sclass="steam-react"\sdata-component-name="AutomaticConclusionBox"\sdata-component-props="(.*?)"></div>' 
    # bei computerbild werden die Texte mal innerhalb, mal außerhalb von Tag Attributen geschrieben.
    "www.focus.de" = '(?s)<p>(.*?)</p>'
    "www.formel1.de" = '(?s)<p>(.*?)</p>'
    "www.heise.de" = '(?s)<p>(.*?)</p>'
    "www.pcwelt.de" = '(?s)<p>(.*?)</p>' # am Anfang und Ende ungewollte Linkhinweise etc. aber sonst passt
    "www.silicon.de" = '(?s)<p>(.*?)</p>'
    "www.spiegel.de" = '(?s)<p>(.*?)</p>'
    "www.sueddeutsche.de" = '(?s)<p\sclass="\scss-13wylk3"\sdata-manual="paragraph">(.*?)</p>'
    "www.tagesschau.de" = '(?s)<p\sclass="textabsatz\sm-ten\sm-offset-one\sl-eight\sl-offset-two\scolumns\stwelve">(.*?)</p>'
    # mehr Webseiten hier
}

# Überprüfen, ob die TLD in der Liste der zugelassenen Domains enthalten ist
if ($allowedDomains.ContainsKey($tld)) {
    $regexPattern = $allowedDomains[$tld]
    Write-Host "Für die Toplevel-Domain $tld wird das Regex-Pattern $regexPattern angewendet."

    $pattern = "$regexPattern"
    
    # Den Textinhalt aus Tags extrahieren
    $treffer = [regex]::Matches($content, $pattern)
    $quellcode = foreach ($match in $treffer) {
        $match.Groups[1].Value
    }

    # Entfernen von HTML-Tags und Bereinigen des Textes
    $quellcode = $quellcode -replace "<.*?>", ""
    $quellcode = [System.Web.HttpUtility]::HtmlDecode($quellcode)
    $quellcode = $quellcode -replace "\s{2,}", " "
    $extractedText = $quellcode
    # $extractedText = ExtractTextFromTags($content, $regexPattern)

    # Den Textinhalt und den Titel in separaten Dateien speichern
    $extractedText | Out-File -FilePath $outputFileContent -Encoding utf8
    Write-Host "Der Textinhalt wurde erfolgreich in $outputFileContent gespeichert."
    # $title | Out-File -FilePath $outputFileTitle -Encoding utf8
    # Write-Host "Der Titel wurde erfolgreich in $outputFileTitle gespeichert."

    # $extractedText = "Hier den extrahierten Text einfügen"
    # $extractedText | Set-Clipboard
    # Write-Host "Der extrahierte Text wurde in die Zwischenablage kopiert."
    #

    $answer = Read-Host "Möchten Sie den Text jetzt zusammenfassen? (y/n)"
    If ($answer -eq "y" -or $answer -eq "Y") {

        # ChatGPT startet hier
        $apiKey = "" # Key hier einfügen
        $headers = @{
            "Content-Type" = "application/json"
            "Authorization" = "Bearer $apiKey"
        }
        $body = @{
            prompt = "Hallo. Kannst du folgenden Text zusammenfassen: $extractedText"
            # prompt = "Was ist die Bedeutung des Lebens?"
            max_tokens = 50
            model = "text-davinci-003"
        } | ConvertTo-Json
        $baseUrl = "https://api.openai.com/v1/chat/completions"
        $response = Invoke-RestMethod -Uri $baseUrl -Headers $headers -Method Post -Body $body
        $response.choices[0].text
    } Else {
        Write-Host "Okay, dann nicht. Der extrahierte Text befindet sich in der Datei $outputFileContent."

    }

} else {
    Write-Host "Die Toplevel-Domain $tld ist nicht in der Liste der zugelassenen Domains enthalten."
    Exit
}
