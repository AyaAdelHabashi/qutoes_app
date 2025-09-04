import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/feature/add_qutoes/controller/add_qutoes_controoler.dart';

class PublishButton extends StatelessWidget {
  const PublishButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AddQuoteController>();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsApp.primary, // Button color
        foregroundColor: Colors.white, // Text color
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: provider.isLoading
          ? null
          : () async {
              const fakeToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjhiOTcyZTc2YWQ4Mjk5OWZkZjViMDIzIn0sImlhdCI6MTc1Njk4NDExNSwiZXhwIjoxNzU3MDAyMTE1fQ.-hh_yX8XafTdmxCui-1_uwhpt2LE3Fmw_JNQafQNFEQ"; 
              await provider.publishQuote(fakeToken);

              if (provider.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(provider.errorMessage!)),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تمت إضافة الاقتباس بنجاح")),
                );
                Navigator.pop(context);
              }
            },
      child: provider.isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text("نشر"),
    );
  }
}
