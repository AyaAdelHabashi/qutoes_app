import 'package:flutter/material.dart';
import 'package:qutoes_app/core/theme/colors.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      //width: double.infinity,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(imageUrl),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                 style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 16,color: 
                ColorsApp.textPrimary)),
                const SizedBox(height: 4),
                Text(email, 
                style: TextStyle(fontSize: 14, 
                  color: ColorsApp.textSecondary)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
