import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/core/widgets/appbar.dart';

class MyQutoes extends StatelessWidget {
  const MyQutoes({super.key});

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child:
       Padding(
         padding: const EdgeInsets.only(left: 16, right: 16,top:48 ),
         child: Scaffold(
        
           floatingActionButton: FloatingActionButton(
          onPressed: () {
            // context.push('/add-quote');
          },
          backgroundColor: ColorsApp.primary, 
          shape: const CircleBorder(),
          elevation: 4,
          child: SvgPicture.asset(
            'assets/images/edit.svg',
            width: 52,
            height: 52,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

          body: Center(child: Text("اقتباساتي")),
         ),
       ));
  }}