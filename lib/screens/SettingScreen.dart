import 'package:flutter/material.dart';
import 'package:healthhero/screens/DSGVOScreen.dart';
import 'package:healthhero/screens/AGBScreen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  bool _fitnessAndSport = true;
  bool _nutritionAndHealth = true;
  final TextEditingController _nameController = TextEditingController(text: 'Arne Kreikebaum');
  DateTime _birthday = DateTime.now();
  String _gender = 'Männlich';
  bool _agbAccepted = true;
  bool _dsgvoAccepted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Hero'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          /// Section 1: Persönliche Daten
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Persönliche Daten',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownButtonFormField<String>(
                    value: _gender,
                    items: <String>['Männlich', 'Weiblich', 'Divers'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _gender = newValue!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Geschlecht',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Geburtsdatum: ${_birthday.toLocal().toIso8601String().substring(0, 10)}'),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _birthday,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null && pickedDate != _birthday) {
                        setState(() {
                          _birthday = pickedDate;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Spacer

          // Section 2: Auswahl der Funktionalität
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Auswahl der Funktionalität',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          CheckboxListTile(
            title: const Text('Fitness und Sport'),
            value: _fitnessAndSport,
            onChanged: (bool? value) {
              setState(() {
                _fitnessAndSport = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Ernährung und Gesundheit'),
            value: _nutritionAndHealth,
            onChanged: (bool? value) {
              setState(() {
                _nutritionAndHealth = value!;
              });
            },
          ),
          const SizedBox(height: 20), // Spacer

          // Section 3: Datenschutz
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Datenschutz',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Checkbox(
              value: _agbAccepted,
              onChanged: (bool? value) {
                setState(() {
                  _agbAccepted = value!;
                });
              },
            ),
            title: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AGBScreen()),
                    );
                  },
                  child: const Text(
                    'AGB',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const Text('\'s gelesen und akzeptiert'),
              ],
            ),
          ),
          ListTile(
            leading: Checkbox(
              value: _dsgvoAccepted,
              onChanged: (bool? value) {
                setState(() {
                  _dsgvoAccepted = value!;
                });
              },
            ),
            title: Row(
              children: [
                const Text('Datenverarbeitung gemäß '),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DSGVOScreen()),
                    );
                  },
                  child: const Text(
                    'DSGVO',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Spacer

          // Save Button
          ElevatedButton(
            onPressed: () {
              // TODO: Save the changes to the database
            },
            child: const Text('Speichern'),
          ),
          
          const SizedBox(height: 5), // Spacer

          // Save Button
          ElevatedButton(
            onPressed: () {
              // TODO: Save the changes to the database
            },
            child: const Text('Alle Quizzes und Challenges zurücksetzten'),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: SettingScreen()));