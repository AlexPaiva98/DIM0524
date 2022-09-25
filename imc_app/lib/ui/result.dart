import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  String _image;
  String _text;

  Result(this._image, this._text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            _image,
            fit: BoxFit.cover,
            height: 300.0,
          ),
          Center(
            child: Text(
              _text,
              style: TextStyle(
                fontSize: 22.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
