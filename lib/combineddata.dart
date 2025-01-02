import 'package:flutter/material.dart';

class CombinedDataPage extends StatelessWidget {
  final double dow;
  final double paxWeight;
  final double bagsWeight;
  final double cargoWeight;
  final double serviceWeight;
  final double totalTrafficload;
  final double zfw;

  // Constructor to accept data
  const CombinedDataPage({
    super.key,
    required this.dow,
    required this.paxWeight,
    required this.bagsWeight,
    required this.cargoWeight,
    required this.serviceWeight,
    required this.totalTrafficload,
    required this.zfw,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Combined Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('DOW: $dow'),
            Text('Passenger Weight: $paxWeight'),
            Text('Bags Weight: $bagsWeight'),
            Text('Cargo Weight: $cargoWeight'),
            Text('Service Weight: $serviceWeight'),
            Text('Total Traffic Load: $totalTrafficload'),
            Text('ZFW: $zfw'),
          ],
        ),
      ),
    );
  }
}
