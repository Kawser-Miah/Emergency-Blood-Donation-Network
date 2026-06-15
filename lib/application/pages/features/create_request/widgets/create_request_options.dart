import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

const List<String> kBloodGroups = [
  'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-',
];

class UrgencyOption {
  const UrgencyOption({
    required this.id,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.gradient,
    required this.textColor,
  });

  final String id;
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
  final List<Color>? gradient;
  final Color textColor;
}

const List<UrgencyOption> kUrgencyOptions = [
  UrgencyOption(
    id: 'CRITICAL',
    emoji: '🔴',
    title: 'CRITICAL',
    subtitle: 'ICU, life-threatening',
    color: AppColors.primary,
    gradient: [AppColors.primaryDarker, AppColors.primary],
    textColor: Colors.white,
  ),
  UrgencyOption(
    id: 'URGENT',
    emoji: '🟠',
    title: 'URGENT',
    subtitle: 'Emergency surgery',
    color: AppColors.warning,
    gradient: [AppColors.warningDark, AppColors.warning],
    textColor: Colors.white,
  ),
  UrgencyOption(
    id: 'NORMAL',
    emoji: '🔵',
    title: 'NORMAL',
    subtitle: 'Elective / planned',
    color: AppColors.info,
    gradient: null,
    textColor: AppColors.info,
  ),
];
