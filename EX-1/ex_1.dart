import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Custom buttons"),
        ),
        body: Column(
          spacing: 10,
          children: const[
            ActionButton(),
            ActionButton(),
            ActionButton(),
            ActionButton(),
          ],
        )
      ),
    ));



  class ActionButton extends StatefulWidget {
  const ActionButton({super.key});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _isSelected = false;

  String get _buttonText => _isSelected ? 'Selected' : 'Not Selected';
  Color get _textColor => _isSelected ? Colors.white : Colors.black;
  Color get _backgroundColor =>
      _isSelected ? Colors.blue.shade500 : Colors.blue.shade50;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 100,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _isSelected = !_isSelected;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _backgroundColor,
          ),
          child: Text(
            _buttonText,
            style: TextStyle(color: _textColor),
          ),
        ),
      ),
    );
  }
}