import 'package:flutter/material.dart';
import 'package:zfwcalc/narrowbodypreview.dart';
import 'package:zfwcalc/uppercasetransform.dart';

class NarrowBody extends StatefulWidget {
  const NarrowBody({super.key});

  @override
  NarrowBodyState createState() => NarrowBodyState();
}

class NarrowBodyState extends State<NarrowBody> {
  final _dowController = TextEditingController();
  final _paxController = TextEditingController();
  final _cargoController = TextEditingController();
  final _serviceWeightController = TextEditingController();
  final _remarks = TextEditingController();
  final _flightnumber = TextEditingController();
  final _registration = TextEditingController();
  final _depdate = TextEditingController();
  final _origin = TextEditingController();
  final _std = TextEditingController();

  double paxWeight = 0.0;
  double bagsWeight = 0.0;
  double cargoWeight = 0.0;
  double serviceWeight = 0.0;
  double totalTrafficload = 0.0;
  double dow = 0.0;
  double zfw = 0.0;
  int totalBags = 0;

  static const double paxUnitWeight = 84.0; // Weight per passenger
  static const double bagUnitWeight = 17.0; // Weight per bag
  static const double bagsPerPax = 1.3; // Bags per passenger

  // Function to calculate the weights and ZFW
  void _calculateWeights() {
    final paxCount = int.tryParse(_paxController.text) ?? 0;
    final cargo = double.tryParse(_cargoController.text) ?? 0;
    final service = double.tryParse(_serviceWeightController.text) ?? 0;
    final dowInput = double.tryParse(_dowController.text) ?? 0;

    // Calculate passenger weight
    paxWeight = paxCount * paxUnitWeight;

    // Calculate total number of bags (round up)
    totalBags =
        (paxCount * bagsPerPax).toInt(); // Rounding up the number of bags
    bagsWeight = totalBags * bagUnitWeight;

    // Total Payload
    totalTrafficload = paxWeight + bagsWeight + cargo + service;

    // Calculate ZFW
    zfw = dowInput + totalTrafficload;

    // Set the states to update the UI
    setState(() {
      cargoWeight = cargo;
      serviceWeight = service;
      dow = dowInput;
    });
  }

  // Function to clear all fields
  void _clearFields() {
    _dowController.clear();
    _paxController.clear();
    _cargoController.clear();
    _serviceWeightController.clear();
    setState(() {
      paxWeight = 0.0;
      bagsWeight = 0.0;
      cargoWeight = 0.0;
      serviceWeight = 0.0;
      totalTrafficload = 0.0;
      dow = 0.0;
      zfw = 0.0;
      totalBags = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Narrow Body'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                      const SizedBox(height: 16),
                      TextField(
                        controller: _dowController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Enter DOW ',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          _calculateWeights();
                        },
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _paxController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Enter Number of Pax',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          _calculateWeights();
                        },
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Total Pax Weight: ${paxWeight.toStringAsFixed(0)} kg',
                              ),
                            ),
                            SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Total Bag Pcs: $totalBags',
                              ),
                            ),
                            SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Total Bag Weight: ${bagsWeight.toStringAsFixed(0)} kg',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _cargoController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Enter Cargo Weight (kg)',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          _calculateWeights();
                        },
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _serviceWeightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Enter Service Weight (kg)',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          _calculateWeights();
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Traffic Load: ${totalTrafficload.toStringAsFixed(0)} kg',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'EZFW : ${zfw.toStringAsFixed(0)} kg',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      TextField(
                        controller: _remarks,
                        maxLines: 3,
                        maxLength: 300,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Remarks',
                          counterText: '',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: _clearFields,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.black),
                    padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(vertical: 12, horizontal: 20)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Clear All Fields',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to NarrowBodyPreview screen and pass the data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NarrowBodyPreview(
                          flightNumber: _flightnumber.text,
                          registration: _registration.text,
                          origin: _origin.text,
                          depDate: _depdate.text,
                          std: _std.text,
                          paxWeight: paxWeight,
                          bagsWeight: bagsWeight,
                          cargoWeight: cargoWeight,
                          serviceWeight: serviceWeight,
                          totalTrafficload: totalTrafficload,
                          dow: dow,
                          zfw: zfw,
                          remarks: _remarks.text,
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.black),
                    padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(vertical: 12, horizontal: 20)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Preview Data',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
