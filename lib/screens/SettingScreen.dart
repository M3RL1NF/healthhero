import 'package:flutter/material.dart';

class AGBScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AGB')),
      body: Center(child: Text('AGB content goes here...')),
    );
  }
}

class DSGVOScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DSGVO')),
      body: Center(child: Text('DSGVO content goes here...')),
    );
  }
}

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _fitnessAndSport = false;
  bool _nutritionAndHealth = false;
  TextEditingController _nameController = TextEditingController();
  DateTime _birthday = DateTime.now();
  String _gender = 'Male';
  bool _selectButton1 = false;
  bool _selectButton2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Hero'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            /// Section 1: Persöhnliche Daten
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Persöhnliche Daten',
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
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DropdownButtonFormField<String>(
                      value: _gender,
                      items: <String>['Male', 'Female', 'Other'].map((String value) {
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
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Birthday: ${_birthday.toLocal().toIso8601String().substring(0, 10)}'),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _birthday,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null && pickedDate != _birthday)
                          setState(() {
                            _birthday = pickedDate;
                          });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Spacer

            // Section 2: Auswahl der Funktionalität
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Auswahl der Funktionalität',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CheckboxListTile(
              title: Text('Fitness und Sport'),
              value: _fitnessAndSport,
              onChanged: (bool? value) {
                setState(() {
                  _fitnessAndSport = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Ernährung und Gesundheit'),
              value: _nutritionAndHealth,
              onChanged: (bool? value) {
                setState(() {
                  _nutritionAndHealth = value!;
                });
              },
            ),
            SizedBox(height: 20), // Spacer

            // Section 3: Datenschutz
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Datenschutz',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Checkbox(
                value: _selectButton1,
                onChanged: (bool? value) {
                  setState(() {
                    _selectButton1 = value!;
                  });
                },
              ),
              title: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AGBScreen()),
                      );
                    },
                    child: Text(
                      'AGB',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Text(' gelesen und akzeptiert'),
                ],
              ),
            ),
            ListTile(
              leading: Checkbox(
                value: _selectButton2,
                onChanged: (bool? value) {
                  setState(() {
                    _selectButton2 = value!;
                  });
                },
              ),
              title: Row(
                children: [
                  Text('Datenverarbeitung gemäß '),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DSGVOScreen()),
                      );
                    },
                    child: Text(
                      'DSGVO',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Spacer

            // Save Button
            ElevatedButton(
              onPressed: () {
                // TODO: Save the changes to the database
              },
              child: Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: SettingScreen()));