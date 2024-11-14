import 'package:flutter/material.dart';
import 'package:currency_converter/calculator.dart';
import 'package:currency_converter/currencyconverter.dart';
import 'package:currency_converter/login.dart'; // Import your login page here
import 'package:currency_converter/profile.dart'; // Import your Profile page here
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background of the body to white
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFB9EA60), // Light Green
                    Color(0xFFFAE880), // Light Yellow
                    Color(0xFF2CC65A), // Green
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.1, 0.5, 0.9], // Adjusting stops to make the gradient faster
                ),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold, // Making the text bold
          ),
        ),
        backgroundColor: Colors.transparent, // Transparent background for the AppBar
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFB9EA60), // Light Green
                Color(0xFFFAE880), // Light Yellow
                Color(0xFF2CC65A), // Green
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.5, 0.9], // Adjusting stops to make the gradient faster
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome, $globalUsername!",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.logout,
                      color: Colors.indigo,
                    ),
                    onPressed: () {
                      // Navigate to LoginPage on logout
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/people.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Text(
                      'SERVICES',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cardMenu(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CurrencyConverterPage()),
                            );
                          },
                          title: 'CURRENCY CONVERTER',
                          icon: 'assets/images/moneyconvert.jpg',
                          fontColor: const Color.fromARGB(255, 63, 37, 37),
                        ),
                        _cardMenu(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CalculatorPage()),
                            );
                          },
                          title: 'CALCULATOR',
                          icon: 'assets/images/calculator.png',
                          fontColor: const Color.fromARGB(255, 63, 37, 37),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardMenu({
    required String title,
    required String icon,
    VoidCallback? onTap,
    Color color = Colors.white,
    Color fontColor = Colors.grey,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: 156,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.zero, // Removed border radius
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 48,
              height: 48,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: fontColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
