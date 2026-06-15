import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

const _quotes = [
  (
    text:
        'The blood you donate gives someone another chance at life. One day that someone may be a relative, a friend, or you.',
    author: 'World Health Organization',
  ),
  (
    text:
        'Donating blood is one of the most generous things one person can do for another. You give the gift of life.',
    author: 'American Red Cross',
  ),
  (
    text:
        'Every two seconds someone needs blood. Be the reason someone survives today.',
    author: 'Blood Setu',
  ),
  (
    text:
        'One donation can save up to three lives. It costs nothing but a little of your time.',
    author: 'WHO Blood Safety',
  ),
  (
    text:
        'Safe blood saves lives. Be a hero — roll up your sleeve and donate.',
    author: 'Global Blood Fund',
  ),
  (
    text:
        'You are someone\'s type. Your blood group matches someone waiting right now.',
    author: 'Blood Setu',
  ),
  (
    text:
        'Blood is the most precious gift that anyone can give to another person — the gift of life.',
    author: 'World Health Organization',
  ),
  (
    text:
        'No one has ever become poor by giving. But many have become alive because someone gave blood.',
    author: 'Blood Setu',
  ),
  (
    text:
        'Every heartbeat is a reminder that someone out there needs your help. Donate blood.',
    author: 'National Blood Authority',
  ),
  (
    text:
        'Be someone\'s miracle today. Blood cannot be manufactured — it can only come from generous donors like you.',
    author: 'Blood Setu',
  ),
];

class HomeQuoteCard extends StatelessWidget {
  const HomeQuoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dayIndex = DateTime.now().dayOfYear % _quotes.length;
    final quote = _quotes[dayIndex];

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7B0000), AppColors.primaryDark, AppColors.primary],
          stops: [0.0, 0.4, 1.0],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative large quote mark — top left
          Positioned(
            top: -8,
            left: 12,
            child: Text(
              '“',
              style: TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.w900,
                color: Colors.white.withValues(alpha: 0.08),
                height: 1,
              ),
            ),
          ),
          // Decorative water drop — bottom right
          Positioned(
            bottom: -10,
            right: 16,
            child: Icon(
              Icons.water_drop,
              size: 80,
              color: Colors.white.withValues(alpha: 0.07),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.format_quote,
                              size: 13, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            'Daily Inspiration',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  '“${quote.text}”',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.95),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      quote.author,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.75),
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension on DateTime {
  int get dayOfYear {
    return difference(DateTime(year, 1, 1)).inDays;
  }
}
