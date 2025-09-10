// language_dialog.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qutoes_app/core/theme/colors.dart';

class LanguageDialog extends StatefulWidget {
  LanguageDialog({Key? key}) : super(key: key);

  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  late String _selectedLanguage;
  bool _isInit = true; // A flag to ensure initialization happens only once

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // We moved the initialization logic here from initState
    // and will run it only the first time.
    if (_isInit) {
      _selectedLanguage = context.locale.languageCode == 'ar' ? 'Arabic' : 'English';
      _isInit = false; // Set the flag to false so it doesn't run again
    }
  }

  @override
  Widget build(BuildContext context) {
    // The rest of your code remains the same
    return Dialog(
      backgroundColor: ColorsApp.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tr('Choose the app language'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildLanguageOption('Arabic'),
            _buildLanguageOption('English'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.setLocale(Locale(_selectedLanguage == 'Arabic' ? 'ar' : 'en'));
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsApp.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Confirm', style: TextStyle(fontSize: 16, color: ColorsApp.background)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedLanguage = language;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _selectedLanguage == language ? ColorsApp.primary : Colors.grey, width: 2),
              ),
              child: _selectedLanguage == language
                  ? const Center(child: Icon(Icons.circle, size: 12, color: ColorsApp.primary))
                  : null,
            ),
            const SizedBox(width: 16),
            Text(language, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
