import 'package:flutter/material.dart';

class WideBody extends StatefulWidget {
  const WideBody({super.key});

  @override
  WideBodyState createState() => WideBodyState();
}

class WideBodyState extends State<WideBody> {
  final _dowController = TextEditingController();
  final _paxController = TextEditingController();
  final _cargoController = TextEditingController();
  final _serviceWeightController = TextEditingController();
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
        (paxCount * bagsPerPax).ceil(); // Rounding up the number of bags
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
        title: Text('Wide Body'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // DOW field wrapped in SizedBox
              SizedBox(
                width: 250, // Set desired width here
                child: TextField(
                  controller: _dowController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter DOW (Dry Operating Weight)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _calculateWeights(); // Update calculations when DOW changes
                  },
                ),
              ),
              SizedBox(height: 16),
              // Pax field wrapped in SizedBox
              SizedBox(
                width: 250, // Set desired width here
                child: TextField(
                  controller: _paxController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Number of Pax',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _calculateWeights(); // Update calculations when Pax changes
                  },
                ),
              ),
              SizedBox(height: 16),
              // Total Pax weight field
              Text('Total Pax Weight: ${paxWeight.toStringAsFixed(0)} kg'),
              SizedBox(height: 16),
              // Total Bags field (Rounded up number of bags)
              Text('Total Bag Pcs: $totalBags'),
              SizedBox(height: 16),
              // Total Bags weight field
              Text('Total Bag Weight: ${bagsWeight.toStringAsFixed(0)} kg'),
              SizedBox(height: 16),
              // Cargo weight field wrapped in SizedBox
              SizedBox(
                width: 250, // Set desired width here
                child: TextField(
                  controller: _cargoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Cargo Weight (kg)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _calculateWeights(); // Update calculations when Cargo changes
                  },
                ),
              ),
              SizedBox(height: 16),
              // Service weight field wrapped in SizedBox
              SizedBox(
                width: 250, // Set desired width here
                child: TextField(
                  controller: _serviceWeightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Service Weight (kg)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _calculateWeights(); // Update calculations when Service Weight changes
                  },
                ),
              ),
              SizedBox(height: 20),
              // Total Payload field
              Text(
                'Traffic Load: ${totalTrafficload.toStringAsFixed(0)} kg',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // ZFW field
              Text(
                'EZFW : ${zfw.toStringAsFixed(0)} kg',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Clear button with black background and white text
              Center(
                child: ElevatedButton(
                  onPressed: _clearFields,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Colors.black), // Black background
                    padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20)), // Padding
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Set your desired border radius here
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
