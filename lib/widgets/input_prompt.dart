import 'package:cloudinary_midu/widgets/drip_button.dart';
import 'package:flutter/material.dart';

class InputPrompt extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;

  const InputPrompt({
    Key? key,
    required this.controller,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1D2B), // Dark background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      style: TextStyle(color: Colors.white), // White text
                      decoration: InputDecoration(
                        hintText: "Prompt para complementar la historia",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: Color(0xFF2F2B3A), // Darker input background
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Color(0xFF8B5CF6), width: 2),
                        ),
                      ),
                      onSubmitted: onSubmitted,
                    ),
                  ),
                  SizedBox(width: 16),
                  DripButton(
                    riveAssetPath: 'assets/headerslime.riv',
                    text: "Enviar",
                    onPressed: () {
                      onSubmitted(controller.text);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
