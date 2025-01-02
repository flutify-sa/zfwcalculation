import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'combineddata.dart'; // Import the new CombinedDataPage

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

  // Function to save data to SharedPreferences
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('dow', _dowController.text);
    prefs.setString('pax', _paxController.text);
    prefs.setString('cargo', _cargoController.text);
    prefs.setString('serviceWeight', _serviceWeightController.text);
    prefs.setString('remarks', _remarks.text);
  }

  // Function to load data from SharedPreferences
  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _dowController.text = prefs.getString('dow') ?? '';
    _paxController.text = prefs.getString('pax') ?? '';
    _cargoController.text = prefs.getString('cargo') ?? '';
    _serviceWeightController.text = prefs.getString('serviceWeight') ?? '';
    _remarks.text = prefs.getString('remarks') ?? '';
    _calculateWeights(); // Recalculate after loading the data
  }

  @override
  void initState() {
    super.initState();
    _loadData(); // Load the saved data when the screen initializes
  }

  @override
  void dispose() {
    _saveData(); // Save data when the screen is disposed
    super.dispose();
  }

  // Function to save data and navigate to the CombinedDataPage
  void _saveDataAndNavigate() async {
    await _saveData(); // Save the data
    if (mounted) {
      // Ensure the widget is still mounted
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CombinedDataPage(
            dow: dow, // Pass dow
            paxWeight: paxWeight, // Pass paxWeight
            bagsWeight: bagsWeight, // Pass bagsWeight
            cargoWeight: cargoWeight, // Pass cargoWeight
            serviceWeight: serviceWeight, // Pass serviceWeight
            totalTrafficload: totalTrafficload, // Pass totalTrafficload
            zfw: zfw, // Pass ZFW
          ),
        ),
      );
    }
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
              // Your existing form fields here...
              // (Including TextField for DOW, Pax, Cargo, etc.)

              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: _clearFields,
                  child: Text('Clear All Fields'),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: _saveDataAndNavigate, // Save data and navigate
                  child: Text('Save and View Data'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
