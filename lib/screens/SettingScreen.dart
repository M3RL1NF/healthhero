import 'package:flutter/material.dart';
import 'package:healthhero/models/setting.dart';
import 'package:healthhero/theme/custom_themes/color_theme.dart';
import '../data/SettingsHelper.dart';
import 'package:healthhero/screens/DSGVOScreen.dart';
import 'package:healthhero/screens/AGBScreen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {

  bool _fitnessAndSport = false;
  bool _nutritionAndHealth = false;
  final TextEditingController _nameController = TextEditingController();
  DateTime _birthday = DateTime.now();
  String _gender = 'Divers';
  bool _agbAccepted = false;
  bool _dsgvoAccepted = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  _loadSettings() async {
    List<Setting> settings = await SettingHelper.getSettings();
    if (settings.isNotEmpty) {
      Setting setting = settings.first;
      setState(() {
        _fitnessAndSport = setting.categorySport;
        _nutritionAndHealth = setting.categoryNutrition;
        _nameController.text = setting.userName;
        _birthday = setting.userDateOfBirth;
        _gender = setting.userGender;
        _agbAccepted = setting.readAGB;
        _dsgvoAccepted = setting.readDSGVO;
      });
    }
  }

  _saveSettings() async {
    Setting setting = Setting(
      categorySport: _fitnessAndSport,
      categoryNutrition: _nutritionAndHealth,
      userName: _nameController.text,
      userDateOfBirth: _birthday,
      userGender: _gender,
      readAGB: _agbAccepted,
      readDSGVO: _dsgvoAccepted,
      dailyQuizzes: 0, // Placeholder
      dailyChallenges: 0, // Placeholder
    );

    await SettingHelper.updateSetting(setting);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
        ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          /// Section 1: Persönliche Daten
          Text(
            'Persönliche Daten',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          DropdownButtonFormField<String>(
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
              border: OutlineInputBorder(
              ),
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            title: Text('Geburtsdatum: ${_birthday.day}.${_birthday.month}.${_birthday.year}'),
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
          const SizedBox(height: 20),
          // Section 2: Auswahl der Funktionalität
          Text(
            'Auswahl der Funktionalität',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          CheckboxListTile(
            activeColor: lightPrimaryColor400,
            title: const Text('Fitness und Sport'),
            value: _fitnessAndSport,
            onChanged: (bool? value) {
              setState(() {
                _fitnessAndSport = value!;
              });
            },
          ),
          CheckboxListTile(
            activeColor: lightPrimaryColor400,
            title: const Text('Ernährung und Gesundheit'),
            value: _nutritionAndHealth,
            onChanged: (bool? value) {
              setState(() {
                _nutritionAndHealth = value!;
              });
            },
          ),
          const SizedBox(height: 20),
          // Section 3: Datenschutz
          Text(
            'Datenschutz',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          ListTile(
            leading: Checkbox(
              activeColor: lightPrimaryColor400,
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
              activeColor: lightPrimaryColor400,
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
          const SizedBox(height: 20),
          // Save Button
          ElevatedButton(
            onPressed: () {
              _saveSettings();
            },
            child: const Text('Speichern'),
          ),
          

          // Save Button
          TextButton(
            onPressed: () {
              // TODO: Reset all the Quizes and the Challenges
            },
            child: const Text('Alle Quizzes und Challenges zurücksetzten'),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: SettingScreen()));