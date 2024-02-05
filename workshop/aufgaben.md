# Aufgaben

### 1. Execution möglich machen
Aufgabe: Schaltet die Execution Policy aus, damit sich Powershell Scripts problemlos ausführen lassen.

### 2. Ein-, und Ausgaben zusammenführen
Schreibt ein kleines Programm, wo der Nutzer zwei Werte eingibt und diese Eingaben dann in einer Zeile zusammengeführt werden.
Nutzt dazu die Standard Befehle wie Read und Write-Host

### 3. Zwischenablage
Was ist die Funktion, um einen Text in die Zwischenablage zu kopieren?
Durchstöbert dazu [unser Script](../the_zusammenfasser.ps1)

### 4. Umwandlung
Was könnten die Bedeutung dieser Zeilen sein?

```
$quellcode = $quellcode -replace "<.*?>", ""
$quellcode = [System.Web.HttpUtility]::HtmlDecode($quellcode)
$quellcode = $quellcode -replace "\s{2,}", " "
$extractedText = $quellcode
```

Tipp: In der Variable $quellcode steckt bereits der zusammengefasste Tag mit HTML Zeichen.
Beispiel:
`<p>Große News: Apple hat mit seiner neuen Vision Pro Maßstäbe gesetzt......</p><p>Apple hat usw. etc. ....</p>`
Das wird dann durch die drei Zeilen durchgeführt.

### 5. Regex-Patterns
Schreibt eine Regex, die aus einer Webseite nen Inhalt aus `<div class="article">Test</div>` filtert.
Auch hier findet ihr Hilfestellung im Quellcode. 




