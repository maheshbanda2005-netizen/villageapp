import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../models/village_data.dart';

class AnimatedHeader extends StatelessWidget {
  const AnimatedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to",
            style: GoogleFonts.inter(
              fontSize: 16,
              color: const Color(0xFF64748B),
            ),
          ),
          DefaultTextStyle(
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF065F46),
              letterSpacing: -0.5,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  VillageData.villageInfo['name'],
                  speed: const Duration(milliseconds: 60),
                ),
              ],
              isRepeatingAnimation: false,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 4,
            width: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF059669), Color(0xFF34D399)],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
