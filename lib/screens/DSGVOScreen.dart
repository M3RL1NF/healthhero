import 'package:flutter/material.dart';

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
      appBar: AppBar(title: const Text('Datenschutzerklärung')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildSectionTitle("1. Einleitung"),
            buildSectionText([
              "Willkommen bei Healthhero! Wir nehmen den Datenschutz ernst und möchten Sie darüber informieren, wie wir Ihre Daten erfassen, verwenden und schützen. Diese Datenschutzerklärung gilt für die Nutzung unserer App \"Healthhero\"."
            ]),

            buildSectionTitle("2. Verantwortlicher"),
            buildSectionText([
              "Verantwortlich für die Datenverarbeitung im Sinne der Datenschutz-Grundverordnung (DSGVO) ist:\nHealthhero GmbH\nStraße und Hausnummer\nPLZ Ort\nE-Mail-Adresse\nTelefonnummer"
            ]),

            buildSectionTitle("3. Datenverarbeitung in unserer App"),
            buildSectionText([
              "3.1. Zugriffsdaten",
              "Beim Zugriff auf unsere App werden keine personenbezogenen Daten wie IP-Adresse oder Geräte-ID erfasst.",
              "3.2. Registrierungsdaten",
              "Bei der Registrierung in unserer App erheben wir folgende Daten:\n- Vorname\n- Nachname\n- E-Mail-Adresse\n- Geburtsdatum",
              "3.3. Gesundheitsdaten",
              "Sofern Sie in der App Gesundheitsdaten eingeben, wie z.B. Schritte, Herzfrequenz oder andere Gesundheitsinformationen, werden diese Daten verschlüsselt gespeichert und ausschließlich zur Bereitstellung der App-Funktionen verwendet."
            ]),

            buildSectionTitle("4. Zweck der Datenverarbeitung"),
            buildSectionText([
              "Wir verarbeiten Ihre Daten:\n- Zur Erbringung und Optimierung unserer Dienstleistungen\n- Zur Kommunikation mit Ihnen\n- Zur Sicherstellung der technischen Funktionsfähigkeit der App"
            ]),

            buildSectionTitle("5. Weitergabe von Daten"),
            buildSectionText([
              "Ihre personenbezogenen Daten werden nicht an Dritte weitergegeben, es sei denn, es besteht eine gesetzliche Verpflichtung dazu."
            ]),

            buildSectionTitle("6. Datensicherheit"),
            buildSectionText([
              "Wir treffen technische und organisatorische Maßnahmen, um Ihre Daten vor Verlust, Manipulation oder unberechtigtem Zugriff zu schützen."
            ]),

            buildSectionTitle("7. Ihre Rechte"),
            buildSectionText([
              "Gemäß DSGVO haben Sie das Recht auf Auskunft, Berichtigung, Löschung, Einschränkung der Verarbeitung, Datenübertragbarkeit und Widerspruch gegen die Verarbeitung Ihrer Daten."
            ]),

            buildSectionTitle("8. Widerruf von Einwilligungen"),
            buildSectionText([
              "Einwilligungen, die Sie uns für die Verarbeitung Ihrer Daten gegeben haben, können Sie jederzeit mit Wirkung für die Zukunft widerrufen."
            ]),

            buildSectionTitle("9. Änderungen dieser Datenschutzerklärung"),
            buildSectionText([
              "Wir behalten uns vor, diese Datenschutzerklärung zu ändern, um sie an geänderte Rechtslagen oder bei Änderungen des Dienstes sowie der Datenverarbeitung anzupassen."
            ]),

            buildSectionTitle("10. Kontakt"),
            buildSectionText([
              "Bei Fragen zum Datenschutz können Sie sich jederzeit an uns wenden, nutzen Sie hierfür die oben angegebenen Kontaktdaten."
            ]),
          ],
        ),
      ),
    );
  }
}