# # Service_screener ![PowerShell](https://img.shields.io/badge/PowerShell-Script-blue)

Et PowerShell-script, der overvåger og håndterer Windows-services.

Scriptet tjekker, om udvalgte (kritiske) services kører, og forsøger automatisk at genstarte én eller flere, hvis nødvendigt og giver mulighed for manuelt at starte services, der er sat til "Manual".

Der gemmes også en logfil på skrivebordet over hele sessionen.

## Formål med projektet

At anvende (og lære) PowerShell til noget praktisk og realistisk inden for IT-support og drift.

Men også at skrive et script, der sammen med Task Manager/Opgavestyring kan køre automatisk.

## Funktioner

- Tjekker definerede Windows-services
- Giver mulighed for at tjekke en valgfri service manuelt
- Forsøger automatisk at genstarte services, der burde køre
- Spørger brugeren om start af services, der er sat til "Manual"
- Håndterer fejl, hvis en service ikke findes
- Menu-baseret interface
- Logger hele sessionen til skrivebordet (kan ændres)
- Kræver administrator-rettigheder

## Definerede services

Scriptet indeholder en liste over services, der som standard screenes for. Den liste kan ændres i funktionen "Service_Liste", hvor der er angivet en kommentar.

Standardlisten:

- Spooler (Print Spooler)
- Dhcp
- Dnscache
- WinDefend
- LanmanWorkstation

## Mangler du en datatekniker-voksenlærling?

Foruden en stor passion for fodbold, Formula One, litteratur og familieliv, kan du forvente:

- Lærenem og trives med kompleks problemløsning
- Humoristisk og omsorgsfuld kollega
- Møder altid ind med smil og energi

Kontakt:

 - GitHub: https://github.com/RVinther
 - LinkedIn: www.linkedin.com/in/mathias-vinther-ravnholt-nielsen-01048612a
