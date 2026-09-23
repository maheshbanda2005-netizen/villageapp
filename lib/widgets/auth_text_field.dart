import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/mana_gramam_theme.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData icon;
  final bool obscure;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final VoidCallback? onToggleObscure;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.hint,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onToggleObscure,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ManaText(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: ManaColors.text,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          validator: validator,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          style: AppTypography.forText(
            controller.text.isEmpty ? (hint ?? label) : controller.text,
            const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          decoration: InputDecoration(
            hintText: hint ?? label,
            hintStyle: AppTypography.forText(
              hint ?? label,
              const TextStyle(color: ManaColors.muted, fontSize: 15),
            ),
            prefixIcon: Icon(icon, color: ManaColors.muted, size: 22),
            suffixIcon: onToggleObscure == null
                ? null
                : IconButton(
                    onPressed: onToggleObscure,
                    icon: Icon(
                      obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: ManaColors.muted,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
