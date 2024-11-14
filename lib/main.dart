import 'package:currency_converter/calculator.dart';
import 'package:currency_converter/currencyconverter.dart';
import 'package:currency_converter/homescreen.dart';
import 'package:currency_converter/login.dart';
import 'package:currency_converter/register.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// Global variables for credentials
String? globalUsername;
String? globalPassword;
String? globalEmail; // Add email here

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter and Calculator',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      // Set initial route to SplashScreen
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => HomePage(),
        '/currencyConverter': (context) => const CurrencyConverterPage(),
        '/calculator': (context) => CalculatorPage(),
      },
    );
  }
}

// Splash Screen Widget
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the login page after a 5-second delay
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the image in a circular shape
            ClipOval(
              child: Image.asset(
                'assets/images/profile.jpg', // Replace with your image path
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            // Display name
            const Text(
              'Wafiq Mariatul Azizah', // Replace with your name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Display phone number
            const Text(
              '152022110', // Replace with your phone number
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
