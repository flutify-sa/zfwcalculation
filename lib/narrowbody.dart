import 'package:flutter/material.dart';

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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
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
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align all children to the left
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
                      )
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
            ],
          ),
        ),
      ),
    );
  }
}
