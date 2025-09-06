
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/feature/auth/controller/auth_provider.dart';
import 'package:qutoes_app/feature/auth/ui/widgets/button.dart';
import 'package:qutoes_app/feature/auth/ui/widgets/text_field.dart';
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsApp.background,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // ... باقي التصميم
              CustomTextField(
                hint: "Name".tr(),
                controller: nameController,
                fieldType: FieldType.name,
              ),
              CustomTextField(
                hint: "emailHint".tr(),
                controller: emailController,
                fieldType: FieldType.email,
              ),
              CustomTextField(
                hint: "passwordHint".tr(),
                controller: passwordController,
                fieldType: FieldType.password,
              ),
              CustomTextField(
                hint: "confirmPasswordHint".tr(),
                controller: confirmController,
                fieldType: FieldType.password,
              ),
              const SizedBox(height: 24),

              authProvider.isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      text: 'signInButton'.tr(),
                      onPressed: () async {
                        if (passwordController.text != confirmController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Passwords do not match")),
                          );
                          return;
                        }
                        await authProvider.register(
                          nameController.text,
                          emailController.text,
                          passwordController.text,
                        );

                        if (authProvider.errorMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(authProvider.errorMessage!)),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Registration successful")),
                          );
                          Navigator.pushNamed(context, '/login');
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
