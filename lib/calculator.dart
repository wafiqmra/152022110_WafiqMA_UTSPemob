import 'package:currency_converter/models/advanced.dart';
import 'package:currency_converter/models/basic.dart';
import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage>
    with SingleTickerProviderStateMixin {
  String selectedCalculator = ''; // Track selected calculator mode
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Calculator", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8E5A2F), Color(0xFFFFE680)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calculate, color: Colors.yellow.shade700),
                          const SizedBox(width: 10),
                          const Text(
                            "Select Calculator Mode",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: "Basic",
                                groupValue: selectedCalculator,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCalculator = value.toString();
                                  });
                                },
                              ),
                              const Text("Basic"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: "Advanced",
                                groupValue: selectedCalculator,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCalculator = value.toString();
                                  });
                                },
                              ),
                              const Text("Advanced"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              // Animated "Go to Selected Calculator" button with softer brown color
              ScaleTransition(
                scale: _animation,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: const Color.fromARGB(255, 165, 106, 57), // Softer brown color
                    shadowColor: Colors.brown.shade600,
                    elevation: 10,
                  ),
                  onPressed: () {
                    _navigateToSelectedCalculator();
                  },
                  child: const Text(
                    "Go to Selected Calculator",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToSelectedCalculator() {
    if (selectedCalculator == "Basic") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BasicCalculatorPage()),
      );
    } else if (selectedCalculator == "Advanced") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdvancedCalculatorPage()),
      );
    }
  }
}
