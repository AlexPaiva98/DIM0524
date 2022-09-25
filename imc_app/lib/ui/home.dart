import 'package:flutter/material.dart';
import 'package:imc_app/ui/result.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void _resetFields() {
    weightController.clear();
    heightController.clear();
    _formKey.currentState!.reset();
  }

  void _calculate() {
    String text = '';
    String image = '';
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);
    if (imc < 18.6) {
      text = 'Abaixo do peso (${imc.toStringAsPrecision(4)})';
      image = 'images/thin.png';
    } else if (imc >= 18.6 && imc < 24.9) {
      text = 'Peso ideal (${imc.toStringAsPrecision(4)})';
      image = 'images/shape.png';
    } else if (imc >= 24.9 && imc < 29.9) {
      text = 'Levemente acima do peso (${imc.toStringAsPrecision(4)})';
      image = 'images/fat.png';
    } else if (imc >= 29.9 && imc < 34.9) {
      text = 'Obesidade Grau I (${imc.toStringAsPrecision(4)})';
      image = 'images/fat.png';
    } else if (imc >= 34.9 && imc < 39.9) {
      text = 'Obesidade Grau II (${imc.toStringAsPrecision(4)})';
      image = 'images/fat.png';
    } else if (imc >= 39.9) {
      text = 'Obesidade Grau III (${imc.toStringAsPrecision(4)})';
      image = 'images/fat.png';
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Result(image, text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 120, color: Colors.blueAccent),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(color: Colors.blueAccent)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
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
                    labelStyle: TextStyle(color: Colors.blueAccent)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
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
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
