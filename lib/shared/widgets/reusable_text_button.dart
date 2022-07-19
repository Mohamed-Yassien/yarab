import 'package:flutter/material.dart';

Widget reusableTextButton({
  required String text,
  required VoidCallback function,
}) {
  return TextButton(
    onPressed: function,
    child: Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  );
}
