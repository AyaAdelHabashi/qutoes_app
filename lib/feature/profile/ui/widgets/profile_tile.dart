import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qutoes_app/core/theme/colors.dart';

class ProfileOptionTile extends StatelessWidget {
  final String icon;
  final String title;
  final Color? iconColor;
  final Widget? trailing;
  final VoidCallback onTap;

  const ProfileOptionTile({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4), // مسافة بين العناصر
      decoration: BoxDecoration(
        color: Colors.white, // أو ColorsApp.background
        border: Border.all(
          color:ColorsApp.textSecondary.withOpacity(.5), 
          width: .5, 
        ),
        borderRadius: BorderRadius.circular(12), 
      ),
      child: ListTile(
        onTap: onTap,
        leading: SvgPicture.asset(
          icon,
          color: iconColor ?? ColorsApp.textPrimary,
        ),
        title: Text(
          title,
          style: TextStyle(color: ColorsApp.textPrimary),
        ),
        trailing: trailing ??
            const Icon(Icons.arrow_forward_ios, size: 16, color: ColorsApp.textSecondary),
      ),
    );
  }
}
