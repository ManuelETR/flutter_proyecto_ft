import 'package:flutter/material.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onTextInput;
  final Function() onBackspace;

  const CustomKeyboard({
    super.key,
    required this.onTextInput,
    required this.onBackspace,
  });

  void _textInputHandler(String text) {
    onTextInput(text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildRow(['1', '2', '3']),
        const SizedBox(height: 8),
        _buildRow(['4', '5', '6']),
        const SizedBox(height: 8),
        _buildRow(['7', '8', '9']),
        const SizedBox(height: 8),
        _buildRow(['.', '0', '<']),
      ],
    );
  }

  Widget _buildRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keys.map((key) {
        return _buildKey(key);
      }).toList(),
    );
  }

  Widget _buildKey(String key) {
    return GestureDetector(
      onTap: () {
        if (key == '<') {
          onBackspace();
        } else {
          _textInputHandler(key);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            key,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
