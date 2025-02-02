import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OctetTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function onChanged;

  const OctetTextField(
      {super.key, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.2,
      height: height * 0.2,
      
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: '0',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 10, color: Colors.black12),
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
        keyboardType: TextInputType.number,
        onChanged: (value) => onChanged(value),
      ),
    );
  }
}
