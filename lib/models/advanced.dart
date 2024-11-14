import 'package:flutter/material.dart';
import 'dart:math';  // Standard math library for other functions like sin, cos, etc.

class AdvancedCalculatorPage extends StatefulWidget {
  const AdvancedCalculatorPage({super.key});

  @override
  _AdvancedCalculatorPageState createState() => _AdvancedCalculatorPageState();
}

class _AdvancedCalculatorPageState extends State<AdvancedCalculatorPage> {
  String displayText = "0";
  bool isNewOperation = true;
  double? firstOperand;
  String? operator;

  void _updateDisplay(String text, [bool reset = false]) {
    setState(() {
      displayText = text;
      isNewOperation = reset;
    });
  }

  void _inputNumber(String num) {
    _updateDisplay(isNewOperation || displayText == "0" ? num : displayText + num);
    isNewOperation = false;
  }

  void _applyOperation(double Function(double) operation) {
    double num = double.tryParse(displayText) ?? 0;
    _updateDisplay("${operation(num)}", true);
  }

  void _setOperator(String op) {
    firstOperand = double.tryParse(displayText);
    operator = op;
    _updateDisplay("0", true);
  }

  void _calculateResult() {
    if (firstOperand != null && operator != null) {
      double secondOperand = double.tryParse(displayText) ?? 0;
      double result;

      switch (operator) {
        case "+": result = firstOperand! + secondOperand; break;
        case "-": result = firstOperand! - secondOperand; break;
        case "*": result = firstOperand! * secondOperand; break;
        case "/": result = secondOperand != 0 ? firstOperand! / secondOperand : double.nan; break;
        default: return;
      }
      _updateDisplay("$result", true);
      firstOperand = null;
      operator = null;
    }
  }

  void _clear() => _updateDisplay("0", true);

  // Custom implementations for hyperbolic functions
  double sinh(double x) => (exp(x) - exp(-x)) / 2;
  double cosh(double x) => (exp(x) + exp(-x)) / 2;
  double tanh(double x) => sinh(x) / cosh(x);

  Future<bool> _onWillPop() async {
    // This method will be called when the back button is pressed
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirm"),
            content: const Text("Do you want to go back to the calculator selection?"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), // Tidak kembali, tetap di halaman ini
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true), // Kembali ke halaman sebelumnya
                child: const Text("Yes"),
              ),
            ],
          ),
        )) ?? false; // Kembalikan false jika dialog ditutup tanpa pilihan
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,  // Memanggil fungsi konfirmasi saat back button ditekan
      child: Scaffold(
        appBar: AppBar(title: const Text("Advanced Calculator")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(30),
                child: Text(displayText, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
              ),
            ),
            _buildButtonRow(["sin", "cos", "tan", "C"], Colors.orange), // Keep sin, cos, tan, C orange
            _buildButtonRow(["sinh", "cosh", "tanh", "/"], Colors.orange), // sinh, cosh, tanh also orange, but / stays blue
            _buildButtonRow(["7", "8", "9", "*"], Colors.blue),
            _buildButtonRow(["4", "5", "6", "-"], Colors.blue),
            _buildButtonRow(["1", "2", "3", "+"], Colors.blue),
            _buildButtonRow(["0", ".", "=", "π"], Colors.blue),
            _buildButtonRow(["exp", "ln", "log", "√x"], Colors.orange),
            _buildButtonRow(["x²", "1/x", "%", "x^y"], Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((text) => _buildButton(text, color)).toList(),
    );
  }

  Widget _buildButton(String text, Color color) {
    // Custom button color for sin, cos, tan, C, sinh, cosh, tanh
    Color buttonColor;
    if (["sin", "cos", "tan", "C"].contains(text)) {
      buttonColor = Colors.orange; // Orange for sin, cos, tan, C
    } else if (["sinh", "cosh", "tanh"].contains(text)) {
      buttonColor = Colors.orange; // Orange for sinh, cosh, tanh
    } else if (text == "/") {
      buttonColor = Colors.blue; // Keep the division button blue
    } else {
      buttonColor = color; // Default color
    }

    return ElevatedButton(
      onPressed: () {
        switch (text) {
          case "C": _clear(); break;
          case "=": _calculateResult(); break;
          case "+": case "-": case "*": case "/": _setOperator(text); break;
          case "x²": _applyOperation((num) => num * num); break;
          case "√x": _applyOperation((num) => num >= 0 ? sqrt(num) : double.nan); break;
          case "1/x": _applyOperation((num) => num != 0 ? 1 / num : double.nan); break;
          case "%": _applyOperation((num) => num / 100); break;
          case "sin": _applyOperation((num) => sin(num * pi / 180)); break; // Convert to radians
          case "cos": _applyOperation((num) => cos(num * pi / 180)); break;
          case "tan": _applyOperation((num) => tan(num * pi / 180)); break;
          case "sinh": _applyOperation(sinh); break;  // Hyperbolic sine
          case "cosh": _applyOperation(cosh); break;  // Hyperbolic cosine
          case "tanh": _applyOperation(tanh); break;  // Hyperbolic tangent
          case "log": _applyOperation((num) => num > 0 ? log(num) / log(10) : double.nan); break;
          case "ln": _applyOperation((num) => num > 0 ? log(num) : double.nan); break;
          case "exp": _applyOperation(exp); break;  // Exponential function
          case "π": _updateDisplay("${pi}"); break;
          case "x^y": _applyExponent(); break;  // Exponentiation operation
          default: _inputNumber(text);
        }
      },
      onLongPress: text == "x^y" ? _applyExponent : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor, // Use custom button color
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        shape: const CircleBorder(),
      ),
      child: Text(text, style: const TextStyle(fontSize: 24, color: Colors.white)),
    );
  }

  // Exponentiation calculation (base^exponent)
  void _applyExponent() {
    if (firstOperand != null) {
      double secondOperand = double.tryParse(displayText) ?? 0;
      _updateDisplay("${pow(firstOperand!, secondOperand)}", true);
      firstOperand = null;
    }
  }
}
