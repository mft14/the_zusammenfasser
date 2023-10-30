# Benutzer zur Eingabe der URL auffordern
$url = Read-Host -Prompt 'Bitte geben Sie die URL ein:'

# Konvertieren der URL in ein System.Uri-Objekt
$uri = New-Object System.Uri($url)

# Extrahieren der Toplevel-Domain
$tld = $uri.Host

# Liste von zugelassenen Top-Level-Domains und zugehörigen Regex-Patterns
$allowedDomains = @{
    "www.heise.de" = '(?s)<p>(.*?)</p>'
    "www.chip.de" = '(?s)<div\sclass="mt-sm">(.*?)</div>'
    # Fügen Sie weitere Domains und Regex-Patterns hinzu
}

# Überprüfen, ob die TLD in der Liste der zugelassenen Domains enthalten ist
if ($allowedDomains.ContainsKey($tld)) {
    $regexPattern = $allowedDomains[$tld]
    Write-Host "Für die Toplevel-Domain $tld wird das Regex-Pattern $regexPattern angewendet."
    # Hier können Sie das entsprechende Regex-Pattern anwenden und den gewünschten Text extrahieren


    $extractedText = "Hier den extrahierten Text einfügen"
    $extractedText | Set-Clipboard
    Write-Host "Der extrahierte Text wurde in die Zwischenablage kopiert."
} else {
    Write-Host "Die Toplevel-Domain $tld ist nicht in der Liste der zugelassenen Domains enthalten."
}
