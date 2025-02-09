import 'package:flutter/material.dart';

class ConvertButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool enabled;

  const ConvertButton({super.key, required this.onPressed, this.enabled=true});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          enabled ? onPressed : null, // Désactiver si "enabled" est false
      child: const Text('Convert to Wildcard'),
    );
  }
}
