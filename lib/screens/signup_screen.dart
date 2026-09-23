import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/auth_service.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/fade_slide_in.dart';
import 'new_home_screen.dart';

class SignupScreen extends StatefulWidget {
  final bool isTelugu;
  const SignupScreen({super.key, this.isTelugu = false});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _village = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscure = true;
  bool _obscureConfirm = true;
  bool _loading = false;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _village.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final error = await AuthService.instance.signUp(
      name: _name.text,
      phone: _phone.text,
      village: _village.text,
      password: _password.text,
    );
    if (!mounted) return;
    setState(() => _loading = false);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: ManaText(error)));
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      manaPageRoute(NewHomeScreen(isTelugu: widget.isTelugu)),
      (_) => false,
    );
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
                    t ? 'ఖాతా సృష్టించండి' : 'Create account',
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
                        ? 'మీ గ్రామ సేవలను ఉపయోగించడానికి నమోదు చేయండి'
                        : 'Join Mana Gramam to use village services',
                    style: const TextStyle(color: ManaColors.muted, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 28),
                FadeSlideIn(
                  delayMs: 80,
                  child: AuthTextField(
                    controller: _name,
                    label: t ? 'పూర్తి పేరు' : 'Full name',
                    icon: Icons.person_outline_rounded,
                    textCapitalization: TextCapitalization.words,
                    validator: (v) {
                      if (v == null || v.trim().length < 2) {
                        return t ? 'పేరు ఇవ్వండి' : 'Enter your full name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 14),
                FadeSlideIn(
                  delayMs: 110,
                  child: AuthTextField(
                    controller: _phone,
                    label: t ? 'ఫోన్ నంబర్' : 'Phone number',
                    hint: '9876543210',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    validator: (v) {
                      if (v == null || v.trim().length < 10) {
                        return t ? 'సరైన ఫోన్ నంబర్ ఇవ్వండి' : 'Enter a valid 10-digit number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 14),
                FadeSlideIn(
                  delayMs: 140,
                  child: AuthTextField(
                    controller: _village,
                    label: t ? 'గ్రామం' : 'Village',
                    icon: Icons.holiday_village_outlined,
                    textCapitalization: TextCapitalization.words,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return t ? 'గ్రామం పేరు ఇవ్వండి' : 'Enter your village name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 14),
                FadeSlideIn(
                  delayMs: 170,
                  child: AuthTextField(
                    controller: _password,
                    label: t ? 'పాస్‌వర్డ్' : 'Password',
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
                const SizedBox(height: 14),
                FadeSlideIn(
                  delayMs: 200,
                  child: AuthTextField(
                    controller: _confirm,
                    label: t ? 'పాస్‌వర్డ్ నిర్ధారించండి' : 'Confirm password',
                    icon: Icons.lock_outline_rounded,
                    obscure: _obscureConfirm,
                    onToggleObscure: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                    validator: (v) {
                      if (v != _password.text) {
                        return t ? 'పాస్‌వర్డ్‌లు సరిపోలడం లేదు' : 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 28),
                FadeSlideIn(
                  delayMs: 230,
                  child: ManaUI.button(
                    _loading
                        ? (t ? 'సృష్టిస్తోంది…' : 'Creating…')
                        : (t ? 'సైన్ అప్' : 'Sign up'),
                    _loading ? null : _signup,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: ManaText(
                      t ? 'ఇప్పటికే ఖాతా ఉందా? లాగిన్' : 'Already have an account? Sign in',
                    ),
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
