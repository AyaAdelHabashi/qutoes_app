import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/feature/add_qutoes/controller/add_qutoes_controoler.dart';

class PublishButton extends StatelessWidget {
  const PublishButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AddQuoteController>();

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:ColorsApp.primary,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: provider.publishQuote,
        child: const Text(
          "نشر",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
          color: Colors.white),
        ),
      ),
    );
  }
}
