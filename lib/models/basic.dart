import 'package:flutter/material.dart';

class BasicCalculatorPage extends StatefulWidget {
  const BasicCalculatorPage({super.key});

  @override
  _BasicCalculatorPageState createState() => _BasicCalculatorPageState();
}

class _BasicCalculatorPageState extends State<BasicCalculatorPage> {
  String displayText = "0";
  String calculationSteps = "";
  double firstNum = 0;
  String operation = '';
  bool isNewOperation = true;

  void _inputNumber(String num) {
    setState(() {
      if (isNewOperation || displayText == "0") {
        displayText = num;
        isNewOperation = false;
      } else {
        displayText += num;
      }
    });
  }

  void _performOperation(String newOperation) {
    setState(() {
      firstNum = double.tryParse(displayText) ?? 0;
      operation = newOperation;
      isNewOperation = true;
      calculationSteps = "$firstNum $operation ";
    });
  }

  void _calculate() {
    double secondNum = double.tryParse(displayText) ?? 0;
    double? result;

    switch (operation) {
      case '+':
        result = firstNum + secondNum;
        break;
      case '-':
        result = firstNum - secondNum;
        break;
      case '*':
        result = firstNum * secondNum;
        break;
      case '/':
        result = secondNum != 0 ? firstNum / secondNum : double.nan;
        break;
      default:
        result = secondNum;
    }

    setState(() {
      displayText = "$result";
      calculationSteps += "$secondNum = $result";
      isNewOperation = true;
    });
  }

  void _clear() {
    setState(() {
      displayText = "0";
      firstNum = 0;
      operation = '';
      isNewOperation = true;
      calculationSteps = "";
    });
  }

  void _deleteLastCharacter() {
    setState(() {
      if (displayText.length > 1) {
        displayText = displayText.substring(0, displayText.length - 1);
      } else {
        displayText = "0";
      }
    });
  }

  Future<bool> _onWillPop() async {
    // This method will be called when the back button is pressed
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirm"),
            content: const Text("Do you want to go back to the calculator selection?"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), // Stay on the page
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true), // Go back
                child: const Text("Yes"),
              ),
            ],
          ),
        )) ??
        false; // Return true if the dialog is closed with a "Yes"
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(title: const Text("Basic Calculator")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(30),
              child: Text(
                calculationSteps,
                style: const TextStyle(fontSize: 28, color: Colors.grey),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(30),
                child: Text(
                  displayText,
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            _buildButtonRow(["7", "8", "9", "/"]),
            _buildButtonRow(["4", "5", "6", "*"]),
            _buildButtonRow(["1", "2", "3", "-"]),
            _buildButtonRow(["0", ".", "=", "+"]),
            _buildButtonRow(["DEL", "C"]),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((button) {
        return _buildButton(button);
      }).toList(),
    );
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () {
        if (text == "C") {
          _clear();
        } else if (text == "DEL") {
          _deleteLastCharacter();
        } else if (text == "=") {
          _calculate();
        } else if (["+", "-", "*", "/"].contains(text)) {
          _performOperation(text);
        } else {
          _inputNumber(text);
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 36),
        shape: const CircleBorder(),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 28),
      ),
    );
  }
}
