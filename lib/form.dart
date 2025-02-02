import 'package:convertisseur/reset_button.dart';
import 'package:flutter/material.dart';
import 'package:convertisseur/maskconvert.dart';
import 'package:convertisseur/result-widget.dart';
import 'package:convertisseur/textfied_widget.dart';
import 'package:convertisseur/buttom_widget.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _octetControllers =
      List.generate(4, (_) => TextEditingController());
  final List<TextEditingController> _resultatControllers =
      List.generate(4, (_) => TextEditingController());

  final MaskConverter _maskConverter = MaskConverter();

  void _handleOctetChanged(int index, String value) {
    if (value.length == 3) {
      if (index < 3) {
        FocusScope.of(context).nextFocus();
      } else {
        FocusScope.of(context).unfocus();
      }
    }
  }

  void _handleSubmit() {
    
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      final mask = _octetControllers.map((c) => c.text).join('.');
      if (!_maskConverter.isValidMask(mask)) {
        setState(() {
          for (var controller in _resultatControllers) {
            controller.clear();
          }
        });
        return;
      }
      final wildcard = _maskConverter.convertMaskToWildcard(mask);
      setState(() {
        final octets = wildcard.split('.');
        for (int i = 0; i < octets.length; i++) {
          _resultatControllers[i].text = octets[i];
        }
      });
    }
  }

  void _handleReset() {
    setState(() {
      for (var controller in _octetControllers) {
        controller.clear();
      }
      for (var controller in _resultatControllers) {
        controller.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Champs de saisie pour le masque
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < _octetControllers.length; i++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: OctetTextField(
                        controller: _octetControllers[i],
                        onChanged: (value) => _handleOctetChanged(i, value),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // Affichage du résultat
            ResultWidget(
              wildcardMask: _resultatControllers.map((c) => c.text).join("."), onSubmit: _handleSubmit,
            ),

            const SizedBox(height: 20),

            // Boutons Convertir et Réinitialiser
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConvertButton(onPressed: _handleSubmit),
                const SizedBox(width: 10),
                ResetButton(onPressed: _handleReset),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
