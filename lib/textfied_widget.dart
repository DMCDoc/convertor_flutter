import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OctetTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String value, String? error) onChanged;

  const OctetTextField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<OctetTextField> createState() => OctetTextFieldState();
}

class OctetTextFieldState extends State<OctetTextField> {
  String? _errorText;

  void _validateInput(String value) {
    int? intValue = int.tryParse(value);
    if (intValue == null || intValue < 0 || intValue > 255) {
      setState(() {
        _errorText = 'La valeur doit être comprise entre 0 et 255';
      });
      widget.onChanged(
          value, _errorText); // Passer l'erreur à la fonction onChanged
    } else {
      setState(() {
        _errorText = null;
      });
      widget.onChanged(value, null); // Aucune erreur
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.2,
      height: height * 0.2,
      child: TextField(
        controller: widget.controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: '0',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 10, color: Colors.black12),
          ),
          errorText: _errorText, // Afficher l'erreur si elle existe
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
        keyboardType: TextInputType.number,
        onChanged: _validateInput, // Valider à chaque changement
      ),
    );
  }
}
