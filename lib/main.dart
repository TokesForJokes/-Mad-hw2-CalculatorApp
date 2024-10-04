import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nurin Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String display = '';
  double num1 = 0;
  double num2 = 0;
  String operand = '';
  bool isDecimal = false;

  void onNumberClick(String value) {
    setState(() {
      if (value == '.') {
        if (!isDecimal) {
          display += value;
          isDecimal = true;
        }
      } else {
        display += value;
      }
    });
  }

  void onOperandClick(String value) {
    setState(() {
      num1 = double.parse(display);
      operand = value;
      display = '';
      isDecimal = false;
    });
  }

  void onClearClick() {
    setState(() {
      display = '';
      num1 = 0;
      num2 = 0;
      operand = '';
      isDecimal = false;
    });
  }

  void onEqualClick() {
    setState(() {
      num2 = double.parse(display);
      double result = 0;
      switch (operand) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case '*':
          result = num1 * num2;
          break;
        case '/':
          if (num2 != 0) {
            result = num1 / num2;
          } else {
            display = 'Error';
            return;
          }
          break;
      }
      display = result.toString();
      num1 = result;
      num2 = 0;
      operand = '';
      isDecimal = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.grey[300],
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16),
              child: Text(
                display,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          buildButtonRow(['7', '8', '9', '/']),
          buildButtonRow(['4', '5', '6', '*']),
          buildButtonRow(['1', '2', '3', '-']),
          buildButtonRow(['0', '.', 'C', '+']),
          buildButtonRow(['=']),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> values) {
    return Row(
      children: values.map((value) => buildButton(value)).toList(),
    );
  }

  Widget buildButton(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            if (value == 'C') {
              onClearClick();
            } else if (value == '=') {
              onEqualClick();
            } else if (value == '+' || value == '-' || value == '*' || value == '/') {
              onOperandClick(value);
            } else {
              onNumberClick(value);
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20), backgroundColor: Colors.blueAccent,
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}


