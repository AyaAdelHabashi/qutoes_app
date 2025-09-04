import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/core/widgets/appbar.dart';
import 'package:qutoes_app/feature/profile/ui/widgets/lang_dialog.dart';
import 'package:qutoes_app/feature/profile/ui/widgets/logout.dart';
import 'package:qutoes_app/feature/profile/ui/widgets/profile_action.dart';
import 'package:qutoes_app/feature/profile/ui/widgets/profile_header.dart';
import 'package:qutoes_app/feature/profile/ui/widgets/profile_tile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      
      child:
       Padding(
         padding: const EdgeInsets.only(left: 16, right: 16,top:24
          ),
         child: Scaffold(
       backgroundColor: ColorsApp.background,
       

          body: SingleChildScrollView(
            
        padding:  EdgeInsets.all(16),
        child: Column(
          children:  [
            ProfileHeader(
              name: "ندى ايهاب خالد",
              email: "nada@gmail.com",
              imageUrl: "https://i.pravatar.cc/300",
            ),
            SizedBox(height: 16),
          //  ProfileActions(),
             ProfileOptionTile(
                  icon: 'assets/images/edit_profile.svg',
                  title: tr("edit_profile"),
                  onTap: () {
                   
                  },
                ),
                SizedBox(height: 8,),
                  ProfileOptionTile(
                  icon: 'assets/images/translate.svg',
                  title: tr('language'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return LanguageDialog();
                      },
                    );
                  },
                ),
                 SizedBox(height: 8,),
                 ProfileOptionTile(
                  icon: 'assets/images/change_password.svg',
                   title: tr('change+password'),
                    onTap: (){}
                ),
                SizedBox(height:8 ,),
                  ProfileOptionTile(
                  icon: 'assets/images/logout.svg',
                  title: tr('logout'),
                  iconColor: Colors.red,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return LogoutDialog();
                      },
                    );
                  },
                ),
          


          ],
        ),
      ),
         ))
    );
  }
}