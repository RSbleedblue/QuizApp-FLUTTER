import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final int index;
  final String answerText;
  final int? selectedAnswerIndex;
  final ValueChanged<int> onSelected;

  const AnswerButton({
    Key? key,
    required this.index,
    required this.answerText,
    required this.selectedAnswerIndex,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onSelected(index),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: selectedAnswerIndex == index
              ? Colors.amber
              : const Color.fromRGBO(241, 234, 226, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          answerText,
          style: const TextStyle(fontSize: 16, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
