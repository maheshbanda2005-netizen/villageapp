import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/auth_service.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/fade_slide_in.dart';
import 'new_home_screen.dart';
import 'signup_screen.dart';

/// Screen 04: LOGIN / SIGNUP
/// Matches the design board with:
/// - Friendly rural community photo
/// - "Welcome Back", "Login to continue"
/// - +91 Mobile Number field
/// - "Get OTP" purple button with interactive OTP modal
/// - "or" divider
/// - "Continue with Google" button
/// - "New user? Sign Up" navigation
class LoginScreen extends StatefulWidget {
  final bool isTelugu;
  const LoginScreen({super.key, this.isTelugu = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _otpControllers = List.generate(4, (_) => TextEditingController());
  bool _loading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    for (final c in _otpControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onGetOtp() {
    final phone = _phoneController.text.trim();
    if (phone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: ManaText(
            widget.isTelugu ? 'దయచేసి 10 అంకెల ఫోన్ నంబర్ నమోదు చేయండి' : 'Please enter a valid 10-digit mobile number',
          ),
          backgroundColor: ManaColors.orange,
        ),
      );
      return;
    }

    // Open OTP Verification Bottom Sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ManaColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(24, 20, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: ManaColors.border,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 18),
              const Icon(Icons.mark_email_read_rounded, color: ManaColors.purple, size: 44),
              const SizedBox(height: 12),
              ManaText(
                widget.isTelugu ? 'ఓటీపీ నమోదు చేయండి' : 'Enter OTP Verification',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: ManaColors.navy),
              ),
              const SizedBox(height: 6),
              Text(
                widget.isTelugu
                    ? '+91 $phone కు 4 అంకెల ఓటీపీ పంపబడింది'
                    : '4-digit verification code sent to +91 $phone',
                style: const TextStyle(fontSize: 13, color: ManaColors.muted),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    width: 54,
                    height: 54,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: ManaColors.bg,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: ManaColors.purple, width: 1.5),
                    ),
                    child: Center(
                      child: TextField(
                        controller: _otpControllers[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: ManaColors.navy),
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                        ),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (val) {
                          if (val.isNotEmpty && index < 3) {
                            FocusScope.of(ctx).nextFocus();
                          }
                        },
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    Navigator.pop(ctx);
                    setState(() => _loading = true);
                    await AuthService.instance.login(phone: phone, password: 'password123');
                    if (!mounted) return;
                    setState(() => _loading = false);
                    Navigator.of(context).pushAndRemoveUntil(
                      manaPageRoute(NewHomeScreen(isTelugu: widget.isTelugu)),
                      (_) => false,
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: ManaColors.purple,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: ManaText(
                    widget.isTelugu ? 'ధృవీకరించండి & లాగిన్ అవ్వండి' : 'Verify & Login',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('New OTP sent to your phone!')),
                  );
                },
                child: ManaText(
                  widget.isTelugu ? 'మళ్లీ ఓటీపీ పంపండి' : 'Resend OTP',
                  style: const TextStyle(color: ManaColors.purple, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _loginWithGoogle() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 600));
    await AuthService.instance.login(phone: '9876543210', password: 'password123');
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.of(context).pushAndRemoveUntil(
      manaPageRoute(NewHomeScreen(isTelugu: widget.isTelugu)),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTe = widget.isTelugu;

    return Scaffold(
      backgroundColor: ManaColors.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: ManaColors.navy),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Friendly Rural Community Image
              FadeSlideIn(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 170,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/images/login_community.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: ManaColors.purpleSoft,
                              child: const Icon(Icons.people_rounded, size: 50, color: ManaColors.purple),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.35),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // Title & Subtitle
              FadeSlideIn(
                delayMs: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ManaText(
                      isTe ? 'మళ్లీ స్వాగతం' : 'Welcome Back',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: ManaColors.navy,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isTe ? 'కొనసాగించడానికి లాగిన్ చేయండి' : 'Login to continue',
                      style: const TextStyle(color: ManaColors.muted, fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Mobile Number Input with +91 prefix
              FadeSlideIn(
                delayMs: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isTe ? 'మొబైల్ నంబర్' : 'Mobile Number',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: ManaColors.navy),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 54,
                      decoration: BoxDecoration(
                        color: ManaColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: ManaColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              border: Border(right: BorderSide(color: ManaColors.border)),
                            ),
                            child: const Text(
                              '+91',
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: ManaColors.navy),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              child: TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                decoration: InputDecoration(
                                  hintText: isTe ? 'మొబైల్ నంబర్ ఇవ్వండి' : 'Enter mobile number',
                                  hintStyle: const TextStyle(color: ManaColors.muted, fontSize: 14),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Primary Purple Button: "Get OTP"
              FadeSlideIn(
                delayMs: 120,
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _loading ? null : _onGetOtp,
                    style: FilledButton.styleFrom(
                      backgroundColor: ManaColors.purple,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 2,
                    ),
                    child: _loading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                          )
                        : ManaText(
                            isTe ? 'ఓటీపీ పొందండి' : 'Get OTP',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Divider "or"
              FadeSlideIn(
                delayMs: 150,
                child: Row(
                  children: [
                    const Expanded(child: Divider(color: ManaColors.border)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        isTe ? 'లేదా' : 'or',
                        style: const TextStyle(color: ManaColors.muted, fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Expanded(child: Divider(color: ManaColors.border)),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Secondary Button: "Continue with Google"
              FadeSlideIn(
                delayMs: 180,
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _loading ? null : _loginWithGoogle,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: ManaColors.surface,
                      foregroundColor: ManaColors.navy,
                      minimumSize: const Size.fromHeight(52),
                      side: const BorderSide(color: ManaColors.border),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFEA4335),
                          ),
                          child: const Center(
                            child: Text(
                              'G',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ManaText(
                          isTe ? 'గూగుల్‌తో కొనసాగించండి' : 'Continue with Google',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Bottom Link: "New user? Sign Up"
              FadeSlideIn(
                delayMs: 210,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        manaPageRoute(SignupScreen(isTelugu: widget.isTelugu)),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 14, color: ManaColors.text),
                        children: [
                          TextSpan(text: isTe ? 'కొత్త వాడుకరా? ' : 'New user? '),
                          TextSpan(
                            text: isTe ? 'ఖాతా తెరవండి (Sign Up)' : 'Sign Up',
                            style: const TextStyle(
                              color: ManaColors.purple,
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
