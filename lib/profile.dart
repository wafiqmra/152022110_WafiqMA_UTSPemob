import 'package:flutter/material.dart';
import 'package:currency_converter/homescreen.dart';
import 'main.dart'; // Import main to access globalUsername and globalEmail

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Keep the background white
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white, // Set text color to white
            fontWeight: FontWeight.bold, // Make text bold
          ),
        ),
        backgroundColor: Colors.transparent, // Transparent background for AppBar
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
              stops: [0.1, 0.5, 0.9], // Adjusting stops for the gradient
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  "Welcome, $globalUsername!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Profile Information',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.indigo.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              const SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.person, color: Colors.indigo),
                title: Text('Username: $globalUsername'),
              ),
              ListTile(
                leading: Icon(Icons.email, color: Colors.indigo),
                title: Text('Email: $globalEmail'),
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white, // Set text color to white
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: const Text('Back to Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
