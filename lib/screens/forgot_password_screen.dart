import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/auth_service.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/fade_slide_in.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final bool isTelugu;
  const ForgotPasswordScreen({super.key, this.isTelugu = false});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _reset() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final error = await AuthService.instance.resetPassword(
      phone: _phone.text,
      newPassword: _password.text,
    );
    if (!mounted) return;
    setState(() => _loading = false);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: ManaText(error)));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: ManaText(
          widget.isTelugu ? 'పాస్‌వర్డ్ అప్‌డేట్ అయింది' : 'Password updated successfully',
        ),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.isTelugu;
    return Scaffold(
      backgroundColor: ManaColors.bg,
      appBar: AppBar(
        backgroundColor: ManaColors.bg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeSlideIn(
                  child: ManaText(
                    t ? 'పాస్‌వర్డ్ రీసెట్' : 'Reset password',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: ManaColors.navy,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                FadeSlideIn(
                  delayMs: 40,
                  child: ManaText(
                    t
                        ? 'మీ ఫోన్ నంబర్‌తో కొత్త పాస్‌వర్డ్ సెట్ చేయండి'
                        : 'Set a new password using your registered phone',
                    style: const TextStyle(color: ManaColors.muted, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 28),
                FadeSlideIn(
                  delayMs: 80,
                  child: AuthTextField(
                    controller: _phone,
                    label: t ? 'ఫోన్ నంబర్' : 'Phone number',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    validator: (v) {
                      if (v == null || v.trim().length < 10) {
                        return t ? 'సరైన ఫోన్ నంబర్ ఇవ్వండి' : 'Enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 14),
                FadeSlideIn(
                  delayMs: 120,
                  child: AuthTextField(
                    controller: _password,
                    label: t ? 'కొత్త పాస్‌వర్డ్' : 'New password',
                    icon: Icons.lock_outline_rounded,
                    obscure: _obscure,
                    onToggleObscure: () => setState(() => _obscure = !_obscure),
                    validator: (v) {
                      if (v == null || v.length < 6) {
                        return t
                            ? 'కనీసం 6 అక్షరాలు ఉండాలి'
                            : 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 28),
                FadeSlideIn(
                  delayMs: 160,
                  child: ManaUI.button(
                    _loading
                        ? (t ? 'అప్‌డేట్ అవుతోంది…' : 'Updating…')
                        : (t ? 'పాస్‌వర్డ్ అప్‌డేట్' : 'Update password'),
                    _loading ? null : _reset,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
