import 'package:flutter/material.dart';
import 'package:qutoes_app/core/theme/colors.dart';

enum FieldType { name, email, password }

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final FieldType fieldType;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.validator,
    required this.fieldType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  IconData _getPrefixIcon() {
    switch (widget.fieldType) {
      case FieldType.name:
        return Icons.person;
      case FieldType.email:
        return Icons.email;
      case FieldType.password:
        return Icons.lock;
    }
  }

  TextInputType _getKeyboardType() {
    switch (widget.fieldType) {
      case FieldType.name:
        return TextInputType.name;
      case FieldType.email:
        return TextInputType.emailAddress;
      case FieldType.password:
        return TextInputType.visiblePassword;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.fieldType == FieldType.password;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: isPassword ? _obscureText : false,
          validator: widget.validator,
          keyboardType: _getKeyboardType(),
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: Icon(
              _getPrefixIcon(),
              color: ColorsApp.textSecondary.withOpacity(.5),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: ColorsApp.textSecondary.withOpacity(.5),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: ColorsApp.textSecondary.withOpacity(.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: ColorsApp.primary,
                width: 2.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
