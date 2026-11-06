# Raspberry Pi 4 as a Parallels RAS 22 client: an experimental Box64 proof of concept

![Raspberry Pi 4 running a remote application through an x86 compatibility layer](../assets/rasclient-pi4-featured.jpg)

> **Editorial status:** experimental, unofficial and laboratory-only. This project is independent from Parallels and is not supported or endorsed by Parallels.

## English

A customer request prompted this investigation: could a Raspberry Pi be used as a lightweight Parallels RAS client for published applications?

The Linux client existed as an amd64 package, but a native ARM64 Linux client is not available for this scenario. We therefore tested the official Parallels RAS Linux amd64 package under Box64 on a Raspberry Pi 4 running Raspberry Pi OS Trixie ARM64. The test target was Parallels RAS 22.

The result is a genuine proof of concept, not a claim of native ARM64 support. Box64 starts the official `appserverclient` binary and the Qt/XCB graphical client. In a private RAS 22 laboratory environment, the client connected to a Gateway over SSL, displayed published resources, and launched a published Windows application. The Pi desktop also exposed a normal application-menu entry, with no terminal window required at launch.

### What happened to the original ARM client?

Parallels previously shipped a dedicated ARM/Raspberry Pi client. Its public RAS 17 transition notes state that ARM and Raspberry Pi support was discontinued as Parallels moved Linux support toward 64-bit/x64 platforms. The same notice refers to the declining support for 32-bit architectures in the wider software ecosystem and to alignment with newer platform and performance requirements. Parallels did not publish a more specific technical or commercial explanation. This project therefore uses the current official Linux amd64 client through Box64; it does not revive or redistribute the old ARM client.

Sources: [RAS 16.5 transition notice](https://download.parallels.com/ras/v16.5/docs/en_US/Parallels-RAS-v16-5-Administrators-Guide.pdf) and [RAS 17 release notes](https://forum.parallels.com/threads/parallels-remote-application-server-v17-0-release-notes.347396/).

![Parallels Client entry in the Raspberry Pi application menu](../assets/menu-entry.jpg)

![Published applications and a launched Windows desktop session](../assets/ras22-published-applications.jpg)

The later capture below shows the same lab session with the published RAS 22 applications visible, alongside a launched Remote Desktop Connection window and a Windows Notepad session.

![Animated Raspberry Pi desktop launch capture](../assets/pi4-desktop-launch.gif)

![RAS 22 published applications with Remote Desktop Connection and Notepad](../assets/ras22-published-applications.jpg)

![RAS Insider Lab desktop used for the test](../assets/ras-insider-lab-desktop.jpg)

The public repository contains only the build scripts, documentation and test record. It does **not** contain the Parallels `.deb`, Parallels libraries or a generated client package. Anyone reproducing the test must obtain the official package under their own Parallels licence and must respect the applicable terms, authentication and certificate checks.

This was validated on one Raspberry Pi 4 profile only. Raspberry Pi 3, Raspberry Pi 5, other boards, production workloads, printing, smart cards, USB redirection, audio, multi-monitor behavior, MFA variants and long-term upgrades remain unvalidated. The result should be treated as an engineering experiment for RAS 22, not as a supported product recommendation.

Project: [RASInsider/rasclient-box64-pi4](https://github.com/RASInsider/rasclient-box64-pi4)

## Français

Cette étude fait suite à une demande client : peut-on utiliser un Raspberry Pi comme client léger Parallels RAS pour accéder à des applications publiées ?

Le client Linux existait sous la forme d’un paquet amd64, mais aucun client Linux ARM64 natif n’est disponible pour ce scénario. Nous avons donc testé le paquet officiel Parallels RAS Linux amd64 sous Box64, sur un Raspberry Pi 4 équipé de Raspberry Pi OS Trixie ARM64. La cible de test était Parallels RAS 22.

Le résultat est un véritable POC, et non une prise en charge ARM64 native. Box64 lance le binaire officiel `appserverclient` ainsi que le client graphique Qt/XCB. Dans un environnement RAS 22 privé de laboratoire, le client s’est connecté à une Gateway en SSL, a affiché les ressources publiées et a lancé une application Windows publiée. Une entrée normale apparaît également dans le menu du Raspberry Pi, sans grande fenêtre de terminal au lancement.

### Que s’est-il passé avec l’ancien client ARM ?

Parallels distribuait auparavant un client ARM/Raspberry Pi dédié. Les notes de transition vers RAS 17 indiquent que le support ARM et Raspberry Pi a été arrêté lors du recentrage du client Linux sur les plateformes 64 bits/x64. Le même document évoque le recul du support des architectures 32 bits dans l’écosystème logiciel et l’alignement sur les exigences récentes de plateforme et de performance. Parallels n’a pas publié d’explication technique ou commerciale plus précise. Ce projet utilise donc le client Linux amd64 officiel actuel via Box64 ; il ne ressuscite pas et ne redistribue pas l’ancien client ARM.

Le dépôt public contient uniquement les scripts de construction, la documentation et le relevé de test. Il ne contient ni le `.deb` Parallels, ni les bibliothèques Parallels, ni un paquet client généré. Toute personne souhaitant reproduire le test doit obtenir le paquet officiel dans le cadre de sa propre licence Parallels et respecter les conditions applicables, l’authentification et les contrôles de certificats.

La validation porte uniquement sur un Raspberry Pi 4. Les autres modèles, les usages de production, l’impression, les cartes à puce, la redirection USB, l’audio, le multi-écran, les variantes MFA et les mises à niveau restent à tester. Il s’agit d’une expérience technique compatible avec un environnement RAS 22 de laboratoire, pas d’un produit supporté.

## Español

Esta investigación responde a una petición de cliente: ¿se puede utilizar una Raspberry Pi como cliente ligero de Parallels RAS para acceder a aplicaciones publicadas?

El cliente Linux existía como paquete amd64, pero no se dispone de un cliente Linux ARM64 nativo para este escenario. Probamos el paquete oficial Parallels RAS Linux amd64 mediante Box64 en una Raspberry Pi 4 con Raspberry Pi OS Trixie ARM64, utilizando Parallels RAS 22 como destino.

El resultado es una prueba de concepto real, no soporte ARM64 nativo. Box64 inicia el binario oficial `appserverclient` y el cliente gráfico Qt/XCB. En un entorno privado de laboratorio RAS 22, el cliente se conectó a una Gateway mediante SSL, mostró los recursos publicados y lanzó una aplicación Windows publicada. También aparece una entrada normal en el menú de aplicaciones, sin abrir una gran ventana de terminal.

### ¿Qué ocurrió con el antiguo cliente ARM?

Parallels distribuía anteriormente un cliente específico para ARM/Raspberry Pi. Las notas de transición a RAS 17 indican que se dejó de ofrecer soporte para ARM y Raspberry Pi al orientar el cliente Linux hacia plataformas de 64 bits/x64. El mismo documento menciona la pérdida de soporte de las arquitecturas de 32 bits en el ecosistema de software y la adaptación a requisitos más recientes de plataforma y rendimiento. Parallels no publicó una explicación técnica o comercial más detallada. Este proyecto utiliza el cliente Linux amd64 oficial actual mediante Box64; no recupera ni redistribuye el antiguo cliente ARM.

El repositorio público contiene únicamente scripts de compilación, documentación y resultados de prueba. No contiene el `.deb` de Parallels, sus bibliotecas ni un paquete de cliente generado. Para reproducir la prueba es necesario obtener el paquete oficial bajo la propia licencia de Parallels y respetar las condiciones aplicables, la autenticación y las comprobaciones de certificados.

La validación se realizó solamente en una Raspberry Pi 4. Otros modelos, producción, impresión, tarjetas inteligentes, redirección USB, audio, varios monitores, variantes MFA y actualizaciones todavía no están validados. Es un experimento técnico para un laboratorio RAS 22, no un producto soportado.

## Deutsch

Diese Untersuchung geht auf eine Kundenanfrage zurück: Kann ein Raspberry Pi als schlanker Parallels-RAS-Client für veröffentlichte Anwendungen eingesetzt werden?

Der Linux-Client war als amd64-Paket verfügbar, jedoch steht für dieses Szenario kein nativer ARM64-Linux-Client zur Verfügung. Deshalb wurde das offizielle Parallels-RAS-Linux-amd64-Paket mit Box64 auf einem Raspberry Pi 4 unter Raspberry Pi OS Trixie ARM64 getestet. Zielumgebung war Parallels RAS 22.

Das Ergebnis ist ein echter Proof of Concept und keine native ARM64-Unterstützung. Box64 startet das offizielle `appserverclient`-Programm und den grafischen Qt/XCB-Client. In einer privaten RAS-22-Laborumgebung stellte der Client über SSL eine Verbindung zu einer Gateway her, zeigte veröffentlichte Ressourcen an und startete eine veröffentlichte Windows-Anwendung. Außerdem erscheint ein normaler Eintrag im Anwendungsmenü, ohne dass beim Start ein großes Terminalfenster geöffnet werden muss.

### Was geschah mit dem früheren ARM-Client?

Parallels bot früher einen eigenen ARM/Raspberry-Pi-Client an. Die Übergangshinweise zu RAS 17 besagen, dass die Unterstützung für ARM und Raspberry Pi beendet wurde, während der Linux-Client auf 64-Bit-/x64-Plattformen ausgerichtet wurde. Dasselbe Dokument verweist auf die sinkende Unterstützung von 32-Bit-Architekturen im Software-Ökosystem sowie auf die Anpassung an neuere Plattform- und Leistungsanforderungen. Eine detailliertere technische oder wirtschaftliche Begründung hat Parallels nicht veröffentlicht. Dieses Projekt verwendet deshalb den aktuellen offiziellen Linux-amd64-Client über Box64; der alte ARM-Client wird weder wiederbelebt noch weiterverteilt.

Das öffentliche Repository enthält ausschließlich Build-Skripte, Dokumentation und Testergebnisse. Es enthält weder das Parallels-`.deb` noch Parallels-Bibliotheken oder ein erzeugtes Client-Paket. Für eine Reproduktion muss das offizielle Paket unter der eigenen Parallels-Lizenz beschafft werden; die geltenden Bedingungen, Authentifizierung und Zertifikatsprüfungen sind einzuhalten.

Validiert wurde ausschließlich ein Raspberry Pi 4. Andere Pi-Modelle, produktive Nutzung, Drucken, Smartcards, USB-Umleitung, Audio, mehrere Monitore, MFA-Varianten und Upgrades sind noch nicht validiert. Das Ergebnis ist ein technisches Experiment für ein RAS-22-Labor und kein unterstütztes Produkt.

## Nederlands

Dit onderzoek begon met een klantvraag: kan een Raspberry Pi worden gebruikt als lichte Parallels RAS-client voor gepubliceerde toepassingen?

De Linux-client bestond als amd64-pakket, maar voor dit scenario is geen native ARM64 Linux-client beschikbaar. Daarom hebben we het officiële Parallels RAS Linux amd64-pakket via Box64 getest op een Raspberry Pi 4 met Raspberry Pi OS Trixie ARM64, met Parallels RAS 22 als doelomgeving.

Het resultaat is een echte proof of concept, geen native ARM64-ondersteuning. Box64 start het officiële `appserverclient`-programma en de grafische Qt/XCB-client. In een private RAS 22-labomgeving maakte de client via SSL verbinding met een Gateway, toonde hij gepubliceerde resources en startte hij een gepubliceerde Windows-toepassing. Er staat ook een normale toepassing in het Raspberry Pi-menu, zonder groot terminalvenster bij het starten.

### Wat gebeurde er met de oude ARM-client?

Parallels leverde vroeger een speciale ARM/Raspberry Pi-client. De overgangsnotities voor RAS 17 vermelden dat de ondersteuning voor ARM en Raspberry Pi werd beëindigd terwijl de Linux-client werd gericht op 64-bits/x64-platformen. Hetzelfde document verwijst naar de afnemende ondersteuning voor 32-bitsarchitecturen in het software-ecosysteem en naar aansluiting bij nieuwere platform- en prestatie-eisen. Parallels heeft geen uitgebreidere technische of commerciële verklaring gepubliceerd. Dit project gebruikt daarom de huidige officiële Linux amd64-client via Box64; de oude ARM-client wordt niet nieuw leven ingeblazen of verspreid.

De openbare repository bevat alleen buildscripts, documentatie en testresultaten. Het Parallels `.deb`-bestand, Parallels-bibliotheken en een gegenereerd clientpakket zijn uitgesloten. Voor reproductie moet het officiële pakket onder de eigen Parallels-licentie worden verkregen en moeten de toepasselijke voorwaarden, authenticatie en certificaatcontroles worden gerespecteerd.

De validatie is uitsluitend uitgevoerd op een Raspberry Pi 4. Andere modellen, productiegebruik, afdrukken, smartcards, USB-omleiding, audio, meerdere monitoren, MFA-varianten en upgrades zijn nog niet gevalideerd. Dit is een technisch experiment voor een RAS 22-lab, geen ondersteund product.

## Legal and attribution note

Parallels, the Parallels logo and Parallels RAS are trademarks and/or copyrighted properties of Parallels International GmbH. This independent project is not affiliated with, sponsored by or endorsed by Parallels. The official client package remains the property of its respective owner and is intentionally excluded from this repository.
