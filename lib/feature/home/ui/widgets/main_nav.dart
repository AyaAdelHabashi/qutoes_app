import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/feature/home/controller/main_controller.dart';
import 'package:qutoes_app/feature/home/ui/widgets/bottom_nav.dart';

class MainNavigation extends StatelessWidget {
  final Widget child;
  final VoidCallback? onBack;

  const MainNavigation({super.key, required this.child, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (BuildContext context, MainProvider value, Widget? child) {
        return Scaffold(
          appBar: (value.currentIndex != 0)
              ? AppBar(
                   centerTitle: true,
                    leading: IconButton(
          icon: context.locale.languageCode == 'ar'
            ? SvgPicture.asset(
                'assets/images/Back.svg',
              )
            : Transform.flip( flipX: true, 
                child: SvgPicture.asset(
                  'assets/images/Back.svg',
                ),
              ),
          onPressed: onBack ?? () => Navigator.pop(context),
        ),
                                  
                  title: Text(
                    value.title(context)[value.currentIndex],
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: ColorsApp.textPrimary, fontWeight: FontWeight.bold),
                  ),
                )
              : null,
          body: value.screens[value.currentIndex],
          bottomNavigationBar: HomeBottomNav(
            currentIndex: value.currentIndex,
            onTap: (index) {
              value.setCurrentIndex(index);
            },
            items: value.items(context),
          ),
        );
      },
    );
  }
}
