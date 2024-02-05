# Ablauf des Workshops (in Planung)
## Gliederung
- Sobald der Bildschirm angeschlossen ist, dann meinen Link teilen [https://github.com/mft14/the_zusammenfasser](https://github.com/mft14/the_zusammenfasser)
- Sicherheitsvorkehrungen ausstellen

## [Präsentation](https://docs.google.com/presentation/d/1zEBk1-DIqeptbuiET7NPfGqNwOV9pN8XHfc1Cs7KFuQ/edit?usp=sharing)

## Der Zusammenfasser Powershell Script

### Warum und wozu?
- Warum dieses Script
    - Es soll die Schritte des Copy-Paste ersetzen. Vor allem bei Seiten, die mehrere Abschnitte haben, kann dieses Script ein enormer Zeitvorteil sein.
    - Es sollen möglichst wenig native 3rd Party Plugins genutzt werden. Powershell und Python im Terminal sind klein und schlank.

- Was ist der Mehrwert unseres Scripts
    - Es soll Content Creatorn oder Journalisten einen Arbeitsschritt erleichtern, schnell Infos aus Artikeln zu bilden, die sie für ihren Inhalt benötigen.
    - Es soll die Quelle gleich mit angeben
    - Es soll möglichst schnell und nativ verfügbar sein, ohne große Installation.

- Wie viel Zeit spart man
    - Dies kommt immer auf den Aufbau der Webseite an. Grundsätzlich werden Newsartikel ja mit Bildern und Absätzen sowie Werbung unterbrochen. Das filtert unser Script so gut es geht hinaus und den Feinschliff übernimmt die KI.

- Gibt es Kosten?
    - Es ist derzeit kostenlos, solange ChatGPT 3 für jeden kostenlos verfügbar ist
    - Kosten kann es für eine derzeit noch entwickelte Pro-Version geben, die gebraucht wird, um die API von ChatGPT zu nutzen

- Was sind die technischen Voraussetzungen
    - Vorbereitungen aus dem Handout installiert
    - Windows
        - Execution Policy ausstellen
    - Linux Setup
        - Powershell installieren
        - keine GUI, per Terminal starten

- Was bisher nicht klappt
    - Direkte Zusammenfassung als Datei oder in der Zwischenablage (nur mit Pro Version nutzbar)
    - Umlaute werden unter Windows Powershell falsch dargestellt.

### Ablauf des Scriptes
- Definieren von Webseiten und deren Struktur
- Prüfen, wie die Seite aufgebaut ist , dazu Quelltext öffnen
- Text in einer Variable und Clipboard speichern
- Mithilfe von Python die Webseite aufrufen und den Text mit automatisierten Tastaturbefehlen einfügen

### Durchführung
- Für die anderen ein Handout erstellen, wo wichtige Befehle drinstehen
- Github Repo so anpassen, dass sie darin auch schauen können (gleich zu Anfang den Link teilen)

