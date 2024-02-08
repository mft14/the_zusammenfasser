### Lösung Aufgabe 1.)
`Set-ExecutionPolicy remotesigned`
`Set-ExecutionPolicy unrestricted`

### Lösung Aufgabe 2.)

```
Write-Host -ForegroundColor Green "Dieser Text wird grün dargestellt"
Write-Host -ForegroundColor Red "Dieser Text wird rot dargestellt"
```

### Lösung Aufgabe 3.)
```
Set-Clipboard -Value "Zu kopierender Text"
```

### Lösung Aufgabe 4.)

Die erste Zeile ist ein Regex und entfernt Inhalt von HTML Tags.
Die zweite Zeile schaltet das Übersetzen der HTML Befehle im Klartext aus.
Die letzte Zeile ist ein Regex, welches alle Leerzeichen, die zwei oder mehrmals hintereinanderfolgen, mit nur einem Leerzeichen.

### Lösung Aufgabe 5.)
```
"www.chip.de" = '(?s)<div\sclass="article">(.*?)</div>'
```
