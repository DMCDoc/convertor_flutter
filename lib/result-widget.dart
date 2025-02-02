import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final String wildcardMask;

  const ResultWidget({super.key, required this.wildcardMask, required void Function() onSubmit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (wildcardMask.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < 4; i++)
                Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: TextEditingController(
                        text: wildcardMask.split('.')[i],
                      ),
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black12),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
