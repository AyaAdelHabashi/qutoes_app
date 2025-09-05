import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/core/widgets/appbar.dart';
import 'package:qutoes_app/feature/home/ui/widgets/card_quotes.dart';

class Loves extends StatelessWidget {
  const Loves({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
       Padding(
         padding: const EdgeInsets.only(left: 16, right: 16,top:48 ),
         child: Scaffold(
        backgroundColor: ColorsApp.background,

          body: Column(
            children: [
              SizedBox(height: 24,),
              CardQuotes(
                qutoes: "لا تحزن ان الله معنا",
                 auther: "محمد صلى الله عليه وسلم",),
         ]  ),
         ),
       ));
  }}