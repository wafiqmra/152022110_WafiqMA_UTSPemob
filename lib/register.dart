import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(); // New email controller
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String _message = '';

  void _register() {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        setState(() {
          globalUsername = username;  // Save the registered username
          globalEmail = email;        // Save the registered email
          globalPassword = password;  // Save the registered password
          _message = 'Registration successful. You can now log in.';
        });
        Navigator.pop(context); // Return to login
      } else {
        setState(() {
          _message = 'Passwords do not match.';
        });
      }
    } else {
      setState(() {
        _message = 'Please fill in all fields.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display GIF above the username field
              Image.asset(
                'assets/images/loading.webp', // Replace with your GIF file path
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 20),

              // Username input field
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 16),

              // Email input field
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Password input field
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 16),

              // Confirm Password input field
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
              ),
              const SizedBox(height: 16),

              // Register button with custom style
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFF10C065),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Message feedback
              Text(
                _message,
                style: const TextStyle(color: Colors.green),
              ),
              const SizedBox(height: 16),

              // Redirect to login link
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Login here',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context); // Navigate back to login page
                        },
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
}
