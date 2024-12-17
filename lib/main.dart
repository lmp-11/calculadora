import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String display = "";  // Armazena a expressão digitada

  // Função que atualiza o display quando um botão é pressionado
  void updateDisplay(String text) {
    setState(() {
      display += text;
    });
  }

  // Função para calcular o resultado da expressão
  void calculateResult() {
    try {
      // Usamos a função eval() para calcular a expressão
      final result = _evaluateExpression(display);
      setState(() {
        display = result.toString();
      });
    } catch (e) {
      setState(() {
        display = "Erro!";  // Se ocorrer erro, exibe "Erro!"
      });
    }
  }

  // Função para limpar o display
  void clearDisplay() {
    setState(() {
      display = "";
    });
  }

  // Função para avaliar a expressão
  double _evaluateExpression(String expression) {
    // Remove espaços da expressão
    expression = expression.replaceAll(" ", "");

    // Simples manipulação para avaliação
    // A abordagem que usaremos é de simplesmente suportar operações básicas.
    // Para expressões mais complexas, seria necessário usar uma abordagem mais robusta.
    try {
      return _calculateSimpleExpression(expression);
    } catch (e) {
      throw Exception("Erro ao avaliar a expressão");
    }
  }

  // Função para calcular expressões simples
  double _calculateSimpleExpression(String expression) {
    // Aqui, usamos algumas funções simples para dividir a string e calcular os resultados
    // Simplesmente dividimos por cada operação (isso pode ser melhorado)
    double result = 0;

    if (expression.contains('+')) {
      var parts = expression.split('+');
      result = double.parse(parts[0]) + double.parse(parts[1]);
    } else if (expression.contains('-')) {
      var parts = expression.split('-');
      result = double.parse(parts[0]) - double.parse(parts[1]);
    } else if (expression.contains('*')) {
      var parts = expression.split('*');
      result = double.parse(parts[0]) * double.parse(parts[1]);
    } else if (expression.contains('/')) {
      var parts = expression.split('/');
      result = double.parse(parts[0]) / double.parse(parts[1]);
    } else {
      result = double.parse(expression);  // Caso não haja operação, converte o número
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculadora Flutter'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Display da calculadora
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                color: Colors.black12,
                child: Text(
                  display,
                  style: TextStyle(fontSize: 30, color: Colors.black),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(height: 20),
              // Layout da calculadora
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,  // 4 colunas de botões
                ),
                itemCount: 16,  // Total de 16 botões
                itemBuilder: (context, index) {
                  List<String> buttons = [
                    '7', '8', '9', '/',
                    '4', '5', '6', '*',
                    '1', '2', '3', '-',
                    'C', '0', '=', '+'
                  ];

                  String buttonText = buttons[index];

                  return GestureDetector(
                    onTap: () {
                      if (buttonText == 'C') {
                        clearDisplay();  // Limpar display
                      } else if (buttonText == '=') {
                        calculateResult();  // Calcular resultado
                      } else {
                        updateDisplay(buttonText);  // Atualizar display com o botão pressionado
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      color: Colors.blueAccent,
                      child: Center(
                        child: Text(
                          buttonText,
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
