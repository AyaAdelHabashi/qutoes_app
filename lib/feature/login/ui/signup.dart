
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/feature/login/ui/widgets/button.dart';
import 'package:qutoes_app/feature/login/ui/widgets/text_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsApp.background,
        body: Padding(
          padding: const EdgeInsets.only(
            left: 16, right: 16,top:80 , bottom: 40),
          child: Center(
           child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: 75,
              height: 75,
            ),
            SizedBox(height: 24),

            Text('signUpTitle'.tr(), 
            style: Theme.of(context).textTheme.headlineMedium?.
            copyWith(color: ColorsApp.textPrimary)),

            SizedBox(height: 32),
            CustomTextField(
              hint: "Name".tr(),
              controller: TextEditingController(),
              fieldType: FieldType.name,
            ),
            SizedBox(height: 16,),
             CustomTextField(
              hint: "emailHint".tr(),
              controller: TextEditingController(),
             fieldType: FieldType.email,
            ),

            SizedBox(height: 16),
            CustomTextField(
              hint:'passwordHint'.tr(),
              controller: TextEditingController(),
            fieldType: FieldType.password,
            ),
  SizedBox(height: 16),
            CustomTextField(
              hint:'confirmPasswordHint'.tr(),
              controller: TextEditingController(),
            fieldType: FieldType.password,
            ),
            SizedBox(height: 24),
             CustomButton(
              text: 'signInButton'.tr(),
              onPressed: () {
               
              }),],),

             Row(
               mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                           Text(
                          'have_account'.tr(),
                           style: TextStyle(color: ColorsApp.textSecondary)?.copyWith(fontWeight: FontWeight.bold),
                             ),

                              TextButton(
                               onPressed: () => {
                                Navigator.pushNamed(context, '/login')
                               },
                                  child: Text(
                                    'login'.tr(),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(color: ColorsApp.primary)?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),

                  
              



                
                
           ],)
            
          ),
        ),
      
      ),
    );
  }
}