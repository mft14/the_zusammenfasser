# Antwortvariablen
$zsmkurz = "Kannst du folgenden Text so kurz wie möglich zusammenfassen"
$zsmlang = "Kannst du folgenden Text etwas konkreter zusammenfassen"
# Textdateien Namen
$outputFileContent = "Webseite_Inhalt.txt"
$outputFileTitle = "Webseite_Titel.txt"

# Umlaute richtig darstellen (todo)
$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding =
                    New-Object System.Text.UTF8Encoding

# Liste von zugelassenen Top-Level-Domains und zugehörigen Regex-Patterns
$allowedDomains = @{
    "www.bild.de" = '(?s)<p>(.*?)</p>'
    "www.chip.de" = '(?s)<div\sclass="mt-sm">(.*?)</div>'
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

# alle Funktionen / Methoden hier aufgeführt
Function Open-Website {
    Write-Host -ForegroundColor Green "Der extrahierte Text wurde in die Zwischenablage kopiert."
    Read-Host -Prompt 'Drücke Enter, um die Zusammenfassung von OpenAI zu erhalten.'

    Write-Host "Öffne den Browser und navigiere zu https://chat.openai.com"
    # Start-Process "https://chat.openai.com"

# Python-Skript aufrufen
    $pythonScriptPath = "keyboard.py"
    python3 $pythonScriptPath
}

Function Get-SupportedWebsites {
    Write-Host "Die folgenden Webseiten werden unterstützt:"
    foreach ($domain in $allowedDomains.Keys) {
        Write-Host -ForegroundColor Green $domain
    }
}

Function Get-SummarizedWebsite {
    # URL-Validierung, erlaube nur http und https
    while ($url -notmatch "^(http|https)://") {
        try {
# Benutzer zur Eingabe der URL auffordern
            $url = Read-Host -Prompt 'Bitte geben Sie die URL ein'

# Konvertieren der URL in ein System.Uri-Objekt
            $uri = New-Object System.Uri($url)
            Write-Host = "Die URI ist: $uri"

            # Extrahieren der Toplevel-Domain
            # uri.Host gibt die Host-Adresse zurück, z.B. www.bild.de
            $tld = $uri.Host
            Write-Host -ForegroundColor Green "Die Toplevel-Domain ist: $tld"

# Die Webseite herunterladen
            $response = Invoke-WebRequest -Uri $url
            $content = $response.Content

# Den Titel der Webseite extrahieren
            $title = $response.ParsedHtml.title

        } catch {
            Write-Host -ForegroundColor Red "Die eingegebene URL ist ungültig. Bitte geben Sie eine gültige URL ein."
        }
    }

# Überprüfen, ob die TLD in der Liste der zugelassenen Domains enthalten ist
    if ($allowedDomains.ContainsKey($tld)) {
        $regexPattern = $allowedDomains[$tld]
        Write-Host "Für die Toplevel-Domain $tld wird das Regex-Pattern $regexPattern angewendet."

        $pattern = "$regexPattern" #Regex-Pattern anwenden
        
        # Den Textinhalt aus Tags extrahieren
        $treffer = [regex]::Matches($content, $pattern)
        $quellcode = foreach ($match in $treffer) {
            $match.Groups[1].Value
        }

        # Entfernen von HTML-Tags und Bereinigen des Textes
        $quellcode = $quellcode -replace "<.*?>", "" # Entfernen von HTML-Tags
        $quellcode = [System.Web.HttpUtility]::HtmlDecode($quellcode) # Wandelt HTML-Entitäten in Zeichen um
        $quellcode = $quellcode -replace "\s{2,}", " " # Entfernen von überflüssigen Leerzeichen
        $extractedText = $quellcode
        # $extractedText = ExtractTextFromTags($content, $regexPattern)
        # Den Textinhalt und den Titel in separaten Dateien speichern
        # Read-Host -Prompt 'Drücke Enter, um den Textinhalt in die Zwischenablage zu kopieren.'

        # while ($prompt -ne 1 -and $prompt -ne 2) {
            #Kopiere in Ziwischenablage

        do {

            Write-Host ""
            Write-Host -ForegroundColor Green "Wie möchtest du den Text zusammenfassen?"
            Write-Host "1. So kurz wie möglich"
            Write-Host "2. konkreter und längere Zusammenfassung"
            Write-Host "3. Text nicht zusammenfassen und in Textdatei speichern" 
            Write-Host "4. Text nicht zusammenfassen und in Zwischenablage kopieren" 
            Write-Host "0. Beende Zusammenfasser" 
            $prompt = Read-Host -Prompt 'Wähle eine Option aus:'

            if ($prompt -eq 1) { #kurze Zusammenfassung
                Set-Clipboard -Value "$($zsmkurz):  $($extractedText)"
                Open-Website
            } elseif ($prompt -eq 2) { #lange Zusammenfassung
                Set-Clipboard -Value "$($zsmlang):  $($extractedText)"
                Open-Website
            } elseif ($prompt -eq 3) { # Wenn der Text nicht zusammengefasst werden soll
                $extractedText | Out-File -FilePath $outputFileContent -Encoding utf8
                Write-Host -ForegroundColor Green "Der Textinhalt wurde erfolgreich in $outputFileContent gespeichert."
            } elseif ($prompt -eq 4) { # Unverändert in Zwischenablage kopieren
                Set-Clipboard -Value $extractedText
                Write-Host -ForegroundColor Green "Der Textinhalt wurde erfolgreich in die Zwischenablage gespeichert."
            } elseif ($prompt -eq 0) { # Beenden
                Write-Host -ForegroundColor Red "Der Zusammenfasser wird beendet. Es wurde keine Zusammenfassung erstellt."
                $isRunning = $false
                Exit
            } else {
                Write-Host -ForegroundColor Red "Ungültige Eingabe. Bitte wähle eine Option aus."
            }
        } until ($prompt -eq 1 -or $prompt -eq 2 -or $prompt -eq 3 -or $prompt -eq 4 -or $prompt -eq 0)

        # }

    } else { # TLD nicht in der Liste der zugelassenen Domains enthalten
        Write-Host -ForegroundColor Red "Die Toplevel-Domain $tld ist nicht in der Liste der zugelassenen Domains enthalten."
    }

} # Function Get-SummarizedWebsite endet hier
$isRunning = $true

Function Get-Explanation {
    Write-Host "--------------------"
    Write-Host "Das Skript extrahiert den Textinhalt einer Webseite und kopiert ihn in die Zwischenablage."
    Write-Host "Der Textinhalt wird dann von OpenAI zusammengefasst."
    Write-Host "Die Zusammenfassung wird in der Konsole angezeigt und in die Zwischenablage kopiert."
    Write-Host "Die Zusammenfassung kann dann in einem Texteditor eingefügt werden."
    Write-Host "--------------------"
}

############# Hier startet das Skript
while ($isRunning) {
    Write-Host ""
    Write-Host -ForegroundColor Green "Willkommen beim Zusammenfasser. Was möchtest du tun?"
    Write-Host "1. Zusammenfassung einer Webseite erstellen"
    Write-Host "2. Liste unterstützter Webseiten anzeigen"
    Write-Host "3. Wie funktioniert The Zusammenfasser?"
    Write-Host "4. Programm beenden"
    Write-Host ""

    $prompt = Read-Host -Prompt 'Wähle eine Option aus:'
    Write-Host ""

    if ($prompt -eq 1) {
        Get-SummarizedWebsite
    } elseif ($prompt -eq 2) {
        Get-SupportedWebsites
    } elseif ($prompt -eq 3) {
        Get-Explanation
    } elseif ($prompt -eq 4) {
        Write-Host "Das Programm wird beendet."
        $isRunning = $false
        Exit
    } else {
        Write-Host "Ungültige Eingabe. Bitte wähle eine Option aus."
    }
}

