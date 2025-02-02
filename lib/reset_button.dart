import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ResetButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Colors.red, // Couleur rouge pour signaler la réinitialisation
      ),
      child: const Text('Reset', style: TextStyle(color: Colors.white)),
    );
  }
}
