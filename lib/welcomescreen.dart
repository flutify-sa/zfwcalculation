import 'package:flutter/material.dart';
import 'package:zfwcalc/narrowbody.dart';
import 'package:zfwcalc/widebody.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? selectedBodyType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the image
              Image.asset(
                'assets/zfw.png', // Your image path
                height: 250, // Adjust size if needed
                //   width: 200, // Adjust size if needed
              ),
              SizedBox(height: 20),
              // Styled radio buttons section from EntryScreen
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.purple, width: 2),
                    borderRadius: BorderRadius.circular(8.0),
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
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: selectedBodyType != null
                    ? () {
                        // Navigate to the respective screen based on selected body type
                        if (selectedBodyType == 'Wide Body') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WideBody(),
                            ),
                          );
                        } else if (selectedBodyType == 'Narrow Body') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NarrowBody(),
                            ),
                          );
                        }
                      }
                    : null, // Button is disabled if no selection is made
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
