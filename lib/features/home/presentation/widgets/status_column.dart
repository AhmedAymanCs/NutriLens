import 'package:flutter/material.dart';

class StatusColumn extends StatelessWidget {
  const StatusColumn({super.key, required this.value, required this.label});

  final String value, label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}