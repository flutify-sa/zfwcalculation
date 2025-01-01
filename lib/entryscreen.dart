import 'package:flutter/material.dart';
import 'package:zfwcalc/narrowbody.dart';
import 'package:zfwcalc/widebody.dart'; // Make sure to import the WideBody page
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
                elevation: 4.0, // Shadow effect
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Border radius
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0), // Padding around the text
                  child: Text(
                    'Welcome to the ZFW calculation App.',
                    style: TextStyle(fontSize: 14.0), // Customize text style
                    textAlign: TextAlign.center, // Center align the text
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Combined Card for Flight Number, Registration, Origin, Date, and STD
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
                                  _depdate.text = "${selectedDate.toLocal()}"
                                      .split(' ')[0]; // Format as YYYY-MM-DD
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
                              readOnly: true, // Prevent manual typing
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

              // Card for Radio Buttons and Continue Button
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    border: Border.all(
                        color: Colors.purple,
                        width: 2), // Border color and width
                    borderRadius: BorderRadius.circular(12.0), // Border radius
                  ),
                  padding: EdgeInsets.all(16.0), // Padding inside the container
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
                          backgroundColor: Colors.purple, // Text color
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
