# Handout
### Installationsanleitung
- Python 3 ([hier herunterladbar](https://www.python.org/downloads/))
- PyAutoGUI Library herunterladen mit Python Befehl `pip3 install pyautogui`
- Powershell Skripte ausführbar machen (Aufgabe)
- Kostenlosen ChatGPT Account erstellen und sich vorher einloggen


### Simple Variable
` $zsmkurz = "Kannst du folgenden Text so kurz wie möglich zusammenfassen" `

### Schleifen
```
foreach ($domain in $allowedDomains.Keys) {
    Write-Host -ForegroundColor Green $domain
}
```

### Webscraping
` $webseiteninhalt = Invoke-WebRequest -Uri $url `

### Regex
Regex steht für Regular Expression.
Hier mit werden mit bestimmten Symbole ganze Zeichenblöcke angesprochen.
Die wichtigsten Regex Befehle für unser Projekt:

[Hier ein Online Regex Live-Übersetzer zum Testen](https://regexr.com)

