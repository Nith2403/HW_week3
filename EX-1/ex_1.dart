import 'package:flutter/material.dart';


void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Custom buttons"),
          ),
          body: Column(
            spacing: 20,
            children: [
              ActionButton(),
              ActionButton(),
              ActionButton(),
              ActionButton(),
            ],
          ),
        ),
      ),
    );

class ActionButton extends StatefulWidget {
  const ActionButton({
    super.key,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {

  bool _isSelected = false;
  String get _textLabel => _isSelected ? 'Selected' : 'Not selected';
  Color get _textColor => _isSelected ? Colors.white : Colors.black;
  Color get _bgColor => _isSelected ? Colors.blue.shade500 : Colors.blue.shade50;
 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 100,
        child: ElevatedButton(
          onPressed: ()  {
            setState(() {
              _isSelected =! _isSelected;
            });
          },
          style: ElevatedButton.styleFrom(backgroundColor: _bgColor),
          child:  Center(
            
            child: Text(
              _textLabel,
              style: TextStyle(color: _textColor),
            ),
          ),
        ),
      ),
    );
  }
}