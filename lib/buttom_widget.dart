import 'package:flutter/material.dart';

class ConvertButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool enabled;

  const ConvertButton({super.key, required this.onPressed, this.enabled=true});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Convert to Wildcard'),
    );
  }
}
