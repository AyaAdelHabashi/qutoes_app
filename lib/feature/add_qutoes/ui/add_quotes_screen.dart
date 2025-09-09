import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/feature/add_qutoes/controller/add_qutoes_controoler.dart';
import 'package:qutoes_app/feature/add_qutoes/ui/widgets/drop_down_menu.dart';
import 'package:qutoes_app/feature/add_qutoes/ui/widgets/publish_buttom.dart';
import 'package:qutoes_app/feature/add_qutoes/ui/widgets/quotes_text_field.dart';


class AddQuoteScreen extends StatelessWidget {
  const AddQuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddQuoteController(),
      child: Scaffold(
       backgroundColor: ColorsApp.background,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: ColorsApp.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "إضافة اقتباس",
            style: TextStyle(color: ColorsApp.textPrimary),
          ),
          centerTitle: true,
          backgroundColor:ColorsApp.background,
          elevation: .5,
        ),
        body: Padding(
         
          padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              QuoteTypeDropdown(),
              SizedBox(height: 16),
              QuoteTextField(),
              SizedBox(height: 24),
              PublishButton(),
            ],
          ),
        ),
      ),
    );
  }
}
