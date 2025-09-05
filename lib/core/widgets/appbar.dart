import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qutoes_app/core/theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: .5, 
      shadowColor:ColorsApp.textSecondary.withOpacity(0.3),
        centerTitle: true,
        toolbarHeight: 80,
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
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: ColorsApp.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
