import 'package:convertissor/reset_button.dart';
import 'package:flutter/material.dart';
import 'package:convertissor/maskconvert.dart';
import 'package:convertissor/result-widget.dart';
import 'package:convertissor/textfied_widget.dart';
import 'package:convertissor/buttom_widget.dart';

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
  bool _isValid = true; // Ajouter un état pour la validation globale

void _handleOctetChanged(int index, String value, String? error) {
    // Vérifier la validité de chaque champ à chaque modification
    setState(() {
      _isValid = _octetControllers.every((controller) {
        // Vérifier que chaque champ a une valeur correcte (entre 0 et 255)
        int? val = int.tryParse(controller.text);
        return val != null && val >= 0 && val <= 255;
      });
    });

    // Si la validation est correcte et que l'utilisateur a tapé trois chiffres, passe au champ suivant
    if (value.length == 3 && _isValid) {
      if (index < 3) {
        FocusScope.of(context).nextFocus();
      } else {
        FocusScope.of(context).unfocus();
      }
    }
  }


  void _handleSubmit() {
    if (!_isValid) {
      return; // Ne pas soumettre si une erreur existe
    }

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
      _isValid = true; // Réinitialiser l'état de validation
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
                        onChanged: (value, error) =>
                            _handleOctetChanged(i, value, error),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // Affichage du résultat
            ResultWidget(
              wildcardMask: _resultatControllers.map((c) => c.text).join("."),
              onSubmit: _handleSubmit,
            ),

            const SizedBox(height: 20),

            // Boutons Convertir et Réinitialiser
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConvertButton(
                  onPressed: _handleSubmit,
                  enabled: _isValid,
                ),
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
