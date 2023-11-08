import 'package:flutter/material.dart';

final List<String> monthNames = [
  'Januar',
  'Februar',
  'März',
  'April',
  'Mai',
  'Juni',
  'Juli',
  'August',
  'September',
  'Oktober',
  'November',
  'Dezember'
];

class DSGVOScreen extends StatelessWidget {
  const DSGVOScreen({super.key});

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    );
  }

  Widget buildSectionText(List<String> texts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: texts.map((text) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(text),
      )).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
        title: const Text('Datenschutz-Grundverordnung'),
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
            Text("1. Einleitung", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Willkommen bei Healthhero! Wir nehmen den Datenschutz ernst und möchten Sie darüber informieren, wie wir Ihre Daten erfassen, verwenden und schützen. Diese Datenschutzerklärung gilt für die Nutzung unserer App \"Healthhero\"."),
            SizedBox(height: 20),

            Text("2. Verantwortlicher", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Verantwortlich für die Datenverarbeitung im Sinne der Datenschutz-Grundverordnung (DSGVO) ist:"),
            SizedBox(height: 2),
            Text("\nHealthhero GmbH\nStraße und Hausnummer\nPLZ Ort\nE-Mail-Adresse\nTelefonnummer", style: TextStyle(fontWeight: FontWeight.w500),),
            SizedBox(height: 20),

            Text("3. Datenverarbeitung in unserer App", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("3.1. Zugriffsdaten", style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 2),
            
            Text("Beim Zugriff auf unsere App werden keine personenbezogenen Daten wie IP-Adresse oder Geräte-ID erfasst."),
            SizedBox(height: 10),
            Text("3.2. Registrierungsdaten", style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 2),

            Text("Bei der Registrierung in unserer App erheben wir folgende Daten:"),
            Text("\n- Vorname\n- Nachname\n- E-Mail-Adresse\n- Geburtsdatum", style: TextStyle(fontWeight: FontWeight.w500),),
            SizedBox(height: 20),
            
            Text("3.3. Gesundheitsdaten", style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 2),

            Text("Sofern Sie in der App Gesundheitsdaten eingeben, wie z.B. Schritte, Herzfrequenz oder andere Gesundheitsinformationen, werden diese Daten verschlüsselt gespeichert und ausschließlich zur Bereitstellung der App-Funktionen verwendet."),
            SizedBox(height: 20),

            Text("4. Zweck der Datenverarbeitung", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Wir verarbeiten Ihre Daten:"),
            Text("\n- Zur Erbringung und Optimierung unserer Dienstleistungen\n- Zur Kommunikation mit Ihnen\n- Zur Sicherstellung der technischen Funktionsfähigkeit der App", style: TextStyle(fontWeight: FontWeight.w500),),
            SizedBox(height: 20),

            Text("5. Weitergabe von Daten", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Ihre personenbezogenen Daten werden nicht an Dritte weitergegeben, es sei denn, es besteht eine gesetzliche Verpflichtung dazu."),
            SizedBox(height: 20),

            Text("6. Datensicherheit", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Wir treffen technische und organisatorische Maßnahmen, um Ihre Daten vor Verlust, Manipulation oder unberechtigtem Zugriff zu schützen."),
            SizedBox(height: 20),

            Text("7. Ihre Rechte", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Gemäß DSGVO haben Sie das Recht auf Auskunft, Berichtigung, Löschung, Einschränkung der Verarbeitung, Datenübertragbarkeit und Widerspruch gegen die Verarbeitung Ihrer Daten."),
            SizedBox(height: 20),

            Text("8. Widerruf von Einwilligungen", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Einwilligungen, die Sie uns für die Verarbeitung Ihrer Daten gegeben haben, können Sie jederzeit mit Wirkung für die Zukunft widerrufen."),
            SizedBox(height: 20),

            Text("9. Änderungen dieser Datenschutzerklärung", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Wir behalten uns vor, diese Datenschutzerklärung zu ändern, um sie an geänderte Rechtslagen oder bei Änderungen des Dienstes sowie der Datenverarbeitung anzupassen."),
            SizedBox(height: 20),

            Text("10. Kontakt", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Bei Fragen zum Datenschutz können Sie sich jederzeit an uns wenden, nutzen Sie hierfür die oben angegebenen Kontaktdaten."),
          ],
        ),
      ),
    );
  }
}