import 'package:flutter/material.dart';

class AGBScreen extends StatelessWidget {
  const AGBScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
        title: const Text('Allgemeine Geschäftsbedingungen'),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Text("1. Geltungsbereich", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Die folgenden Allgemeinen Geschäftsbedingungen (nachfolgend \"AGB\") gelten für alle Verträge, die ein Nutzer (nachfolgend \"Kunde\") mit dem Betreiber der Flutter Handyapp \"Healthhero\" (nachfolgend \"Anbieter\") hinsichtlich der App und deren Dienstleistungen abschließt."),
            SizedBox(height: 20),

            Text("2. Vertragsgegenstand", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Durch die \"Healthhero\" App bietet der Anbieter Dienstleistungen im Bereich Gesundheit und Wohlbefinden an. Genauere Informationen sind in der Beschreibung der App im jeweiligen App Store zu finden."),
            SizedBox(height: 20),

            Text("3. Vertragsschluss", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Der Vertrag zwischen Kunde und Anbieter kommt durch das Herunterladen und Installieren der App und die Zustimmung zu diesen AGB zustande."),
            SizedBox(height: 20),

            Text("4. Nutzungsrechte", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Die App ist urheberrechtlich geschützt. Der Kunde erhält ein einfaches, nicht übertragbares Nutzungsrecht ausschließlich für den eigenen, privaten Gebrauch."),
            SizedBox(height: 20),

            Text("5. Datenschutz", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Der Anbieter nimmt den Schutz der persönlichen Daten seiner Kunden ernst und hält sich strikt an die gesetzlichen Datenschutzvorschriften. Weitere Informationen finden Sie in der Datenschutzerklärung der App."),
            SizedBox(height: 20),

            Text("6. Gewährleistung", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Der Anbieter gewährleistet, dass die App im Wesentlichen so funktioniert, wie in der App-Beschreibung angegeben. Bei Fehlern oder Störungen hat der Kunde das Recht auf Nachbesserung. Es wird keine Gewähr für die ständige und unterbrechungsfreie Verfügbarkeit der App übernommen."),
            SizedBox(height: 20),

            Text("7. Haftungsbeschränkung", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Der Anbieter haftet nicht für Schäden, die durch unsachgemäße Nutzung der App oder durch Nichtbeachtung von Anweisungen oder Empfehlungen entstehen. Die App ersetzt keinen medizinischen Rat oder Behandlung."),
            SizedBox(height: 20),

            Text("8. Beendigung", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Der Anbieter hat das Recht, den Vertrag mit dem Kunden zu kündigen, wenn dieser gegen diese AGB verstößt. Bei Kündigung müssen alle Kopien der App vom Kunden deinstalliert und alle gespeicherten Daten gelöscht werden."),
            SizedBox(height: 20),

            Text("9. Änderungen der AGB", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Der Anbieter behält sich vor, diese AGB zu ändern. Über Änderungen wird der Kunde rechtzeitig informiert."),
            SizedBox(height: 20),

            Text("10. Schlussbestimmungen", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Sollte eine Bestimmung dieser AGB unwirksam sein, bleibt die Wirksamkeit der übrigen Bestimmungen hiervon unberührt. Es gilt das Recht des Landes, in dem der Anbieter seinen Sitz hat."),
            SizedBox(height: 20),

            Text("11. Kontakt", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Bei Fragen oder Anliegen können sich Kunden an den Support des Anbieters wenden, dessen Kontaktdaten in der App angegeben sind."),
          ],
        ),
      ),
    );
  }
}