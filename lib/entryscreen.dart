import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zfwcalc/narrowbody.dart';
import 'package:zfwcalc/widebody.dart';
import 'package:zfwcalc/uppercasetransform.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  // Controllers for the text fields
  final _flightnumber = TextEditingController();
  final _registration = TextEditingController();
  final _depdate = TextEditingController();
  final _origin = TextEditingController();
  final _std = TextEditingController();

  // State variable for the radio buttons
  String? selectedBodyType;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Load data from SharedPreferences
  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _flightnumber.text = prefs.getString('flightnumber') ?? '';
      _registration.text = prefs.getString('registration') ?? '';
      _depdate.text = prefs.getString('depdate') ?? '';
      _origin.text = prefs.getString('origin') ?? '';
      _std.text = prefs.getString('std') ?? '';
      selectedBodyType = prefs.getString('bodyType');
    });
  }

  // Save data to SharedPreferences
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('flightnumber', _flightnumber.text);
    prefs.setString('registration', _registration.text);
    prefs.setString('depdate', _depdate.text);
    prefs.setString('origin', _origin.text);
    prefs.setString('std', _std.text);
    prefs.setString('bodyType', selectedBodyType ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Entry Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Welcome to the ZFW calculation App.',
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _flightnumber,
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                              decoration: InputDecoration(
                                labelText: 'Flt No.',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: _registration,
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                              decoration: InputDecoration(
                                labelText: 'Reg.',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _origin,
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                              decoration: InputDecoration(
                                labelText: 'Orig.',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: _depdate,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Date',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              onTap: () async {
                                DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2101),
                                );
                                if (selectedDate != null) {
                                  _depdate.text =
                                      "${selectedDate.toLocal()}".split(' ')[0];
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _std,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'STD',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.access_time),
                              ),
                              onTap: () async {
                                TimeOfDay? selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (selectedTime != null) {
                                  final time24HourFormat =
                                      '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
                                  _std.text = time24HourFormat;
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.black),
                              ),
                              height: 50.0,
                              child: Center(
                                child: Text(
                                  'Time: Zulu',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.purple, width: 2),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Radio<String>(
                            value: 'Wide Body',
                            groupValue: selectedBodyType,
                            onChanged: (value) {
                              setState(() {
                                selectedBodyType = value;
                              });
                            },
                          ),
                          Text('Wide Body'),
                          Radio<String>(
                            value: 'Narrow Body',
                            groupValue: selectedBodyType,
                            onChanged: (value) {
                              setState(() {
                                selectedBodyType = value;
                              });
                            },
                          ),
                          Text('Narrow Body'),
                        ],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _saveData(); // Save data before navigation
                          if (selectedBodyType == 'Wide Body') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WideBody()),
                            );
                          } else if (selectedBodyType == 'Narrow Body') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NarrowBody()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 32.0),
                        ),
                        child: Text('Continue'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
