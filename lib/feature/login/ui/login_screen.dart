import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/feature/login/ui/widgets/button.dart';
import 'package:qutoes_app/feature/login/ui/widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    SizedBox(height: 24),

                    Text(
                      'signInTitle'.tr(),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorsApp.textPrimary),
                    ),

                    SizedBox(height: 32),
                    CustomTextField(hint: "emailHint".tr(), controller: TextEditingController(), fieldType: FieldType.email),
                    SizedBox(height: 16),

                    CustomTextField(
                      hint: 'passwordHint'.tr(),
                      controller: TextEditingController(),
                      fieldType: FieldType.password,
                    ),

                    SizedBox(height: 24),
                    CustomButton(
                      text: 'signInButton'.tr(),
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
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
                      onPressed: () => {Navigator.pushNamed(context, '/signup')},
                      child: Text(
                        'signup'.tr(),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: ColorsApp.primary)?.copyWith(fontWeight: FontWeight.bold),
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
