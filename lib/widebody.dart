import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final _remarks = TextEditingController();

  double paxWeight = 0.0;
  double bagsWeight = 0.0;
  double cargoWeight = 0.0;
  double serviceWeight = 0.0;
  double totalTrafficload = 0.0;
  double dow = 0.0;
  double zfw = 0.0;
  int totalBags = 0;
  int totalULDs = 0;
  double totalTareWeight = 0.0;

  static const double paxUnitWeight = 84.0;
  static const double bagUnitWeight = 17.0;
  static const double bagsPerPax = 1.3;
  static const double tareWeightPerULD = 84.0;
  static const int bagsPerULD = 37;

  // Load saved data from SharedPreferences
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _dowController.text = prefs.getString('dow') ?? '';
      _paxController.text = prefs.getString('pax') ?? '';
      _cargoController.text = prefs.getString('cargo') ?? '';
      _serviceWeightController.text = prefs.getString('serviceWeight') ?? '';
      _remarks.text = prefs.getString('remarks') ?? '';
    });
  }

  // Save data to SharedPreferences
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('dow', _dowController.text);
    prefs.setString('pax', _paxController.text);
    prefs.setString('cargo', _cargoController.text);
    prefs.setString('serviceWeight', _serviceWeightController.text);
    prefs.setString('remarks', _remarks.text);
  }

  void _calculateWeights() {
    final paxCount = int.tryParse(_paxController.text) ?? 0;
    final cargo = double.tryParse(_cargoController.text) ?? 0;
    final service = double.tryParse(_serviceWeightController.text) ?? 0;
    final dowInput = double.tryParse(_dowController.text) ?? 0;

    paxWeight = paxCount * paxUnitWeight;
    totalBags = (paxCount * bagsPerPax).toInt();
    bagsWeight = totalBags * bagUnitWeight;

    totalULDs = (totalBags / bagsPerULD).ceil();
    totalTareWeight = totalULDs * tareWeightPerULD;

    totalTrafficload =
        paxWeight + bagsWeight + cargo + service + totalTareWeight;
    zfw = dowInput + totalTrafficload;

    setState(() {
      cargoWeight = cargo;
      serviceWeight = service;
      dow = dowInput;
    });

    _saveData(); // Save data when calculations are done
  }

  void _clearFields() {
    _dowController.clear();
    _paxController.clear();
    _cargoController.clear();
    _serviceWeightController.clear();
    _remarks.clear();
    setState(() {
      paxWeight = 0.0;
      bagsWeight = 0.0;
      cargoWeight = 0.0;
      serviceWeight = 0.0;
      totalTrafficload = 0.0;
      dow = 0.0;
      zfw = 0.0;
      totalBags = 0;
      totalULDs = 0;
      totalTareWeight = 0.0;
    });
    _saveData(); // Save empty data after clearing fields
  }

  @override
  void initState() {
    super.initState();
    _loadData(); // Load saved data when the widget is initialized
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Total Pax Weight: ${paxWeight.toStringAsFixed(0)} kg'),
                            SizedBox(height: 8),
                            Text('Total Bag Pcs: $totalBags'),
                            SizedBox(height: 8),
                            Text(
                                'Total Bag Weight: ${bagsWeight.toStringAsFixed(0)} kg'),
                            SizedBox(height: 8),
                            Text('Total ULDs: $totalULDs'),
                            SizedBox(height: 8),
                            Text(
                                'Total Tare Weight: ${totalTareWeight.toStringAsFixed(0)} kg'),
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
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _clearFields,
                        child: Text('Clear Fields'),
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
