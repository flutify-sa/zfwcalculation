import 'package:flutter/material.dart';

class NarrowBodyPreview extends StatelessWidget {
  final String flightNumber;
  final String registration;
  final String origin;
  final String depDate;
  final String std;
  final double paxWeight;
  final double bagsWeight;
  final double cargoWeight;
  final double serviceWeight;
  final double totalTrafficload;
  final double dow;
  final double zfw;
  final String remarks;

  const NarrowBodyPreview({
    super.key,
    required this.flightNumber,
    required this.registration,
    required this.origin,
    required this.depDate,
    required this.std,
    required this.paxWeight,
    required this.bagsWeight,
    required this.cargoWeight,
    required this.serviceWeight,
    required this.totalTrafficload,
    required this.dow,
    required this.zfw,
    required this.remarks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Narrow Body ZFW')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Flight Number: $flightNumber'),
              Text('Registration: $registration'),
              Text('Origin: $origin'),
              Text('Date: $depDate'),
              Text('STD: $std'),
              SizedBox(height: 20),
              Text('DOW: ${dow.toStringAsFixed(0)} kg'),
              Text('Total Pax Weight: ${paxWeight.toStringAsFixed(0)} kg'),
              Text('Total Bag Weight: ${bagsWeight.toStringAsFixed(0)} kg'),
              Text('Cargo Weight: ${cargoWeight.toStringAsFixed(0)} kg'),
              Text('Service Weight: ${serviceWeight.toStringAsFixed(0)} kg'),
              Divider(),
              Text(
                'Traffic Load: ${totalTrafficload.toStringAsFixed(0)} kg',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'ZFW: ${zfw.toStringAsFixed(0)} kg',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              Text('Remarks: $remarks'),
            ],
          ),
        ),
      ),
    );
  }
}
