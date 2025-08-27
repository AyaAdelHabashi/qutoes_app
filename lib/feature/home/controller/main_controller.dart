import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qutoes_app/feature/MyQutoes/ui/MyQutoes.dart';
import 'package:qutoes_app/feature/home/ui/home.dart';
import 'package:qutoes_app/feature/home/ui/widgets/bottom_nav.dart';
import 'package:qutoes_app/feature/loves/ui/loves.dart';
import 'package:qutoes_app/feature/profile/ui/profile.dart';

class MainProvider extends ChangeNotifier {
  int currentIndex = 0;

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<Widget> screens = [
    const Home(),
    const MyQutoes(),
    Loves(),
    const Profile(),
  ];
  List<String> title(BuildContext context) => [
    tr('home'),
    tr('my_quotes'),
    tr('loves'),
    tr('profile'),
  ];
  List<BottomNavItemData> items(BuildContext context) => [
    BottomNavItemData(asset: 'assets/images/home.svg',
     label: context.tr('home')),
    BottomNavItemData(asset: 'assets/images/document-text.svg',
     label: context.tr('my_quotes')),
    BottomNavItemData(asset: 'assets/images/heatt.svg',
     label: context.tr('loves')),
    BottomNavItemData(asset: 'assets/images/user.svg',
     label: context.tr('profile')),
  ];
}
