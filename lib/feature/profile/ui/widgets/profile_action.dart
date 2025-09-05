import 'package:flutter/material.dart';
import 'package:qutoes_app/core/theme/colors.dart';

class ProfileActions extends StatelessWidget {
  const ProfileActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildActionItem("تعديل الملف الشخصي", Icons.person),
        _buildActionItem("اللغة", Icons.language),
        _buildActionItem("تغيير كلمة المرور", Icons.lock),
        _buildActionItem("تسجيل الخروج", Icons.logout),
      ],
    );
  }

  Widget _buildActionItem(String title, IconData icon) {
    return Card(
      color: ColorsApp.background,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color:ColorsApp.primary),
        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color:ColorsApp.textSecondary),
        onTap: () {},
      ),
    );
  }
}
