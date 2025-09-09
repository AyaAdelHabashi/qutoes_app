import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutoes_app/feature/add_qutoes/controller/add_qutoes_controoler.dart';

class QuoteTextField extends StatelessWidget {
  const QuoteTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AddQuoteController>();

    return TextField(
      controller: provider.quoteController,
      maxLines: 5,
      decoration: const InputDecoration(
        hintText: "اكتب ما تفكر به",
        border: OutlineInputBorder(),
      ),
    );
  }
}
