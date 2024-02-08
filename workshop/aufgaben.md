# Aufgaben

Durchstöbert zur Hilfestellung [unser Script](../the_zusammenfasser.ps1)

### 1. Execution möglich machen
Wenn ihr das erste Mal eine .ps1 (Powershell Datei) ausführt, wird euer System das blocken, da das Ausführen von Powershell Skripten ausgestellt ist.
Schaltet die Execution Policy aus, damit sich Powershell Scripts problemlos ausführen lassen. Hierzu reichen zwei Befehle.

### 2. Ausgaben färben
Wie lautet der Befehl, um eine Textausgabe mit Write-Host in grüner und roter Farbe einzufärben?

### 3. Zwischenablage
Was ist die Funktion, um einen Text in die Zwischenablage zu kopieren?

### 4. Umwandlung
Was könnten die Bedeutung dieser drei Zeilen sein?

```
$quellcode = $quellcode -replace "<.*?>", ""
$quellcode = [System.Web.HttpUtility]::HtmlDecode($quellcode)
$quellcode = $quellcode -replace "\s{2,}", " "
$extractedText = $quellcode
```

In der Variable $quellcode steckt bereits der zusammengefasste Tag mit HTML Zeichen.

### 5. Regex-Patterns
Schreibt eine Regex, die aus einer Webseite nen Inhalt aus `<div class="article">Test</div>` filtert.




