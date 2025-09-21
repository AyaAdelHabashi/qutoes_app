import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:qutoes_app/core/di.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/feature/profile/controller/profile_controller.dart';

Widget buildChangePasswordItem(String title, IconData icon, BuildContext context) {
  return Card(
    color: ColorsApp.background,
    margin: const EdgeInsets.symmetric(vertical: 6),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: ListTile(
      leading: Icon(icon, color: ColorsApp.primary),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: ColorsApp.textSecondary),
      onTap: () {},
    ),
  );
}
