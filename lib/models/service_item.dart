import 'package:flutter/material.dart';

class ServiceItem {
  final String title;
  final String subtitle;
  final String imageAsset;
  final Color badgeColor;
  final IconData badgeIcon;

  ServiceItem({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.badgeColor,
    required this.badgeIcon,
  });
}