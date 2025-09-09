import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutoes_app/feature/add_qutoes/controller/add_qutoes_controoler.dart';

class QuoteTypeDropdown extends StatelessWidget {
  const QuoteTypeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AddQuoteController>();

    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "نوع الاقتباس",
      ),
      value: provider.selectedType,
      items: const [
        DropdownMenuItem(value: "ادب", child: Text("ادب")),
        DropdownMenuItem(value: "فلسفة", child: Text("فلسفة")),
        DropdownMenuItem(value: "تحفيز", child: Text("تحفيز")),
        DropdownMenuItem(value: "حكم", child: Text("حكم")),
      ],
      onChanged: provider.selectType,
    );
  }
}
