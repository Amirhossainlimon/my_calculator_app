import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '0';
  String _input = '';
  String _operator = '';
  double num1 = 0;
  double num2 = 0;
  bool isDarkMode = true;

  void buttonPress(String value) {
    setState(() {
      if (value == 'AC') {
        _output = '0';
        _input = '';
        _operator = '';
        num1 = 0;
        num2 = 0;
      } else if (value == '+/-') {
        if (_input.isEmpty) return;
        if (_input.startsWith('-')) {
          _input = _input.substring(1);
        } else {
          _input = '-$_input';
        }
        _output = _input;
      } else if (value == '=') {
        if (_input.isEmpty || _operator.isEmpty) return;
        num2 = double.parse(_input);
        switch (_operator) {
          case '+':
            _output = (num1 + num2).toString();
            break;
          case '-':
            _output = (num1 - num2).toString();
            break;
          case '×':
            _output = (num1 * num2).toString();
            break;
          case '÷':
            _output = num2 != 0 ? (num1 / num2).toString() : 'Error';
            break;
          case '%':
            _output = (num1 * num2 / 100).toString();
            break;
        }
        _input = _output;
        _operator = '';
      } else if (['+', '-', '×', '÷', '%'].contains(value)) {
        if (_input.isEmpty || _operator.isNotEmpty) return;
        num1 = double.parse(_input);
        _operator = value;
        _input = '';
      } else if (value == '.') {
        if (_input.contains('.')) return;
        _input += value;
        _output = _input;
      } else {
        _input += value;
        _output = _input;
      }
    });
  }

  Widget buildButton(String text,
      {Color? color, Color? textColor, int flex = 1, double? padding}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.all(padding ?? 8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[850],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(20),
            elevation: 3,
          ),
          onPressed: () => buttonPress(text),
          child: FittedBox(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 28,
                color: textColor ?? Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final size = MediaQuery.of(context).size;
    final buttonPadding = size.width * 0.02;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      isDarkMode ? Icons.light_mode : Icons.dark_mode,
                      color: isDarkMode ? Colors.orange : Colors.black,
                    ),
                    onPressed: () => setState(() => isDarkMode = !isDarkMode),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _output,
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    buildButton('AC', color: Colors.grey[400], textColor: Colors.black, padding: buttonPadding),
                    buildButton('+/-', color: Colors.grey[400], textColor: Colors.black, padding: buttonPadding),
                    buildButton('%', color: Colors.grey[400], textColor: Colors.black, padding: buttonPadding),
                    buildButton('÷', color: Colors.orange, padding: buttonPadding),
                  ],
                ),
                Row(
                  children: [
                    buildButton('7', padding: buttonPadding),
                    buildButton('8', padding: buttonPadding),
                    buildButton('9', padding: buttonPadding),
                    buildButton('×', color: Colors.orange, padding: buttonPadding),
                  ],
                ),
                Row(
                  children: [
                    buildButton('4', padding: buttonPadding),
                    buildButton('5', padding: buttonPadding),
                    buildButton('6', padding: buttonPadding),
                    buildButton('-', color: Colors.orange, padding: buttonPadding),
                  ],
                ),
                Row(
                  children: [
                    buildButton('1', padding: buttonPadding),
                    buildButton('2', padding: buttonPadding),
                    buildButton('3', padding: buttonPadding),
                    buildButton('+', color: Colors.orange, padding: buttonPadding),
                  ],
                ),
                Row(
                  children: [
                    buildButton('0', flex: 2, padding: buttonPadding),
                    buildButton('.', padding: buttonPadding),
                    buildButton('=', color: Colors.orange, padding: buttonPadding),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
