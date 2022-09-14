import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Calculadora IMC',
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _textInfo = '';

  void _resetFields() {
    _formKey.currentState?.reset();
    weightController.clear();
    heightController.clear();
    setState(() {
      _textInfo = '';
    });
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);
    String textInfo = '';
    if (imc < 18.6) {
      textInfo = 'Abaixo do peso (${imc.toStringAsPrecision(4)})';
    } else if (imc >= 18.6 && imc < 24.9) {
      textInfo = 'Peso ideal (${imc.toStringAsPrecision(4)})';
    } else if (imc >= 24.9 && imc < 29.9) {
      textInfo = 'Levemente acima do peso (${imc.toStringAsPrecision(4)})';
    } else if (imc >= 29.9 && imc < 34.9) {
      textInfo = 'Obesidade Grau I (${imc.toStringAsPrecision(4)})';
    } else if (imc >= 34.9 && imc < 39.9) {
      textInfo = 'Obesidade Grau II (${imc.toStringAsPrecision(4)})';
    } else if (imc >= 39.9) {
      textInfo = 'Obesidade Grau III (${imc.toStringAsPrecision(4)})';
    }
    setState(() {
      _textInfo = textInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 120, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira seu peso!';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira sua altura!';
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: ButtonTheme(
                  height: 50.0,
                  highlightColor: Colors.amber,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                ),
              ),
              Text(
                _textInfo,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
