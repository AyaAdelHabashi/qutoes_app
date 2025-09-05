import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/feature/auth/controller/auth_provider.dart';
import 'package:qutoes_app/feature/auth/ui/widgets/button.dart';
import 'package:qutoes_app/feature/auth/ui/widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsApp.background,
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 80, bottom: 40),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SvgPicture.asset('assets/images/logo.svg', width: 75, height: 75),
                    const SizedBox(height: 24),
                    Text(
                      'signInTitle'.tr(),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorsApp.textPrimary),
                    ),
                    const SizedBox(height: 32),

                    CustomTextField(hint: "emailHint".tr(), controller: emailController, fieldType: FieldType.email),
                    const SizedBox(height: 16),

                    CustomTextField(hint: 'passwordHint'.tr(), controller: passwordController, fieldType: FieldType.password),
                    const SizedBox(height: 24),

                    authProvider.isLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            text: 'signInButton'.tr(),
                            onPressed: () async {
                              await authProvider.login(emailController.text, passwordController.text);

                              if (authProvider.errorMessage != null) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(SnackBar(content: Text(authProvider.errorMessage!), backgroundColor: Colors.red));
                              } else {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(const SnackBar(content: Text("Login successful"), backgroundColor: Colors.green));
                                Navigator.pushNamed(context, '/home');
                              }
                            },
                          ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'no_account'.tr(),
                      style: TextStyle(color: ColorsApp.textSecondary)?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      child: Text(
                        'signup'.tr(),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: ColorsApp.primary, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
