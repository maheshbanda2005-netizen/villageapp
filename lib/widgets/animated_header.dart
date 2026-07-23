import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../models/village_data.dart';
import '../main.dart';

class AnimatedHeader extends StatelessWidget {
  const AnimatedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to",
            style: GoogleFonts.getFont('Geist',
              fontSize: 15,
              color: Colors.grey[500],
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          DefaultTextStyle(
            style: GoogleFonts.getFont('Geist',
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: kDarkBg,
              letterSpacing: -0.5,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  VillageData.villageInfo['name'],
                  speed: const Duration(milliseconds: 80),
                ),
              ],
              isRepeatingAnimation: false,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 3,
            width: 50,
            decoration: BoxDecoration(
              color: kPrimaryRed,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
