import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mana_gramam/screens/new_splash_screen.dart';
import 'package:mana_gramam/theme/mana_gramam_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = true;
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const ManaGramamApp());
}

class ManaGramamApp extends StatelessWidget {
  const ManaGramamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mana Gramam',
      debugShowCheckedModeBanner: false,
      // Inter by default; each string picks Inter or Anek Telugu from its content.
      theme: ManaTheme.data(),
      home: const NewSplashScreen(),
    );
  }
}
