import 'package:flutter/material.dart';

class WideBodyPreview extends StatelessWidget {
  final String flightNumber;
  final String registration;
  final String origin;
  final String depDate;
  final String std;
  final double paxWeight;
  final double bagsWeight;
  final double cargoWeight;
  final double serviceWeight;
  final double totalTareWeight;
  final double trafficLoad;
  final double zfw;
  final double dow; // Add this line
  final String remarks;

  const WideBodyPreview({
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
    required this.totalTareWeight,
    required this.trafficLoad,
    required this.zfw,
    required this.dow, // Include dow in the constructor
    required this.remarks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wide Body Preview'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Flight No: $flightNumber'),
            Text('Registration: $registration'),
            Text('Origin: $origin'),
            Text('Date: $depDate'),
            Text('STD: $std'),
            SizedBox(height: 20),
            Text('DOW: ${dow.toStringAsFixed(0)} kg'), // Display dow

            Text('Total Pax Weight: ${paxWeight.toStringAsFixed(0)} kg'),
            Text('Total Bag Weight: ${bagsWeight.toStringAsFixed(0)} kg'),
            Text('Cargo Weight: ${cargoWeight.toStringAsFixed(0)} kg'),
            Text('Service Weight: ${serviceWeight.toStringAsFixed(0)} kg'),
            Text('Total tare Weight: ${totalTareWeight.toStringAsFixed(0)} kg'),

            Divider(),

            Text(
              'Traffic Load: ${trafficLoad.toStringAsFixed(0)} kg',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'EZFW: ${zfw.toStringAsFixed(0)} kg',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),

            SizedBox(height: 20),
            Text('Remarks: $remarks'),
          ],
        ),
      ),
    );
  }
}
