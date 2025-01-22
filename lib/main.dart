import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String display = ''; // Tela de exibição
  String result = ''; // Resultado final

  void buttonPressed(String value) {
    setState(() {
      // Limpa a tela
      if (value == 'C') {
        display = '';
        result = '';
      }
      // Calcula o resultado
      else if (value == '=') {
        try {
          result = _calculateResult(display);
        } catch (e) {
          result = 'Erro';
        }
      } else {
        // Atualiza o valor exibido
        display += value;
      }
    });
  }

  // Função para calcular o resultado
  String _calculateResult(String input) {
    Parser parser = Parser();
    Expression exp = parser.parse(input);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    return eval.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        children: [
          // Tela de exibição
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    display,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    result,
                    style: TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          // Botões da calculadora
          Expanded(
            flex: 8,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.2,
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isOperator(buttons[index]) ? Colors.orange : Colors.blue,
                  ),
                  onPressed: () => buttonPressed(buttons[index]),
                  child: Text(
                    buttons[index],
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Verifica se o botão é um operador
  bool isOperator(String value) {
    return value == '+' || value == '-' || value == '*' || value == '/';
  }
}

// Lista de botões da calculadora
List<String> buttons = [
  '7', '8', '9', '/',
  '4', '5', '6', '*',
  '1', '2', '3', '-',
  'C', '0', '=', '+',
];
